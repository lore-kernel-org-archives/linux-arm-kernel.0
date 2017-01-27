From: james.morse@arm.com (James Morse)
Date: Fri, 27 Jan 2017 11:19:32 +0000
Subject: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170126112811.GG23406@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-4-takahiro.akashi@linaro.org> <5888E262.4050208@arm.com>
 <20170126112811.GG23406@linaro.org>
Message-ID: <588B2CC4.70904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 26/01/17 11:28, AKASHI Takahiro wrote:
> On Wed, Jan 25, 2017 at 05:37:38PM +0000, James Morse wrote:
>> On 24/01/17 08:49, AKASHI Takahiro wrote:
>>> To protect the memory reserved for crash dump kernel once after loaded,
>>> arch_kexec_protect_crashres/unprotect_crashres() are meant to deal with
>>> permissions of the corresponding kernel mappings.
>>>
>>> We also have to
>>> - put the region in an isolated mapping, and
>>> - move copying kexec's control_code_page to machine_kexec_prepare()
>>> so that the region will be completely read-only after loading.
>>
>>
>>> Note that the region must reside in linear mapping and have corresponding
>>> page structures in order to be potentially freed by shrinking it through
>>> /sys/kernel/kexec_crash_size.
>>
>> Nasty! Presumably you have to build the crash region out of individual page
>> mappings,
> 
> This might be an alternative, but
> 
>> so that they can be returned to the slab-allocator one page at a time,
>> and still be able to set/clear the valid bits on the remaining chunk.
>> (I don't see how that happens in this patch)
> 
> As far as shrinking feature is concerned, I believe, crash_shrink_memory(),
> which eventually calls free_reserved_page(), will take care of all the things
> to do. I can see increased number of "MemFree" in /proc/meminfo.

Except for arch specific stuff like reformatting the page tables. Maybe I've
overlooked the way out this. What happens with this scenario:

We boot with crashkernel=1G on the commandline.
Memblock_reserve allocates a naturally aligned 1GB block of memory for the crash
region.
Your code in __map_memblock() calls __create_pgd_mapping() ->
alloc_init_pud() which decides use_1G_block() looks like a good idea.

Some time later, the user decides to free half of this region,
free_reserved_page() does its thing and half of those struct page's now belong
to the memory allocator.

Now we load a kdump kernel, which causes arch_kexec_protect_crashkres() to be
called for the 512MB region that was left.

create_mapping_late() needs to split the 1GB mapping it originally made into a
smaller table, with the first half using PAGE_KERNEL_INVALID, and the second
half using PAGE_KERNEL. It can't do break-before-make because these pages may be
in-use by another CPU because we gave them back to the memory allocator. (in the
worst-possible world, that second half contains our stack!)


Making this behave more like debug_pagealloc where the region is only built of
page-size mappings should avoid this. The smallest change to what you have is to
always pass page_mappings_only for the kdump region.

Ideally we just disable this resize feature for ARM64 and support it with some
later kernel version, but I can't see a way of doing this without adding Kconfig
symbols to other architectures.


> (Please note that the region is memblock_reserve()'d at boot time.)

And free_reserved_page() does nothing to update memblock, so
memblock_is_reserved() says these pages are reserved, but in reality they
are in use by the memory allocator. This doesn't feel right.

(Fortunately we can override crash_free_reserved_phys_range() so this can
 probably be fixed)


>> This secretly-unmapped is the sort of thing that breaks hibernate, it blindly
>> assumes pfn_valid() means it can access the page if it wants to. Setting
>> PG_Reserved is a quick way to trick it out of doing this, but that would leave
>> the crash kernel region un-initialised after resume, while kexec_crash_image
>> still has a value.
> 
> Ouch, I didn't notice this issue.
> 
>> I think the best fix for this is to forbid hibernate if kexec_crash_loaded()
>> arguing these are mutually-exclusive features, and the protect crash-dump
>> feature exists to prevent things like hibernate corrupting the crash region.
> 
> This restriction is really painful.
> Is there any hibernation hook that will be invoked before suspending and
> after resuming? If so, arch_kexec_unprotect_crashkres()/protect_crashkres()
> will be able to be called.

Those calls could go in swsusp_arch_suspend() in /arch/arm64/kernel/hibernate.c,
but isn't this protect feature supposed to stop things like hibernate from
meddling with the region?

(I haven't tested what hibernate does with the crash region as its only just
occurred to me)

I think to avoid holding kdump up we should disable any possible interaction,
(forbid hibernate if a kdump kernel is loaded), and sort it out later!


>>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>>> index bc96c8a7fc79..f7938fecf3ff 100644
>>> --- a/arch/arm64/kernel/machine_kexec.c
>>> +++ b/arch/arm64/kernel/machine_kexec.c
>>> @@ -159,32 +171,20 @@ void machine_kexec(struct kimage *kimage)

>>> -	/* Flush the kimage list and its buffers. */
>>> -	kexec_list_flush(kimage);
>>> +	if (kimage != kexec_crash_image) {
>>> +		/* Flush the kimage list and its buffers. */
>>> +		kexec_list_flush(kimage);
>>>  
>>> -	/* Flush the new image if already in place. */
>>> -	if (kimage->head & IND_DONE)
>>> -		kexec_segment_flush(kimage);
>>> +		/* Flush the new image if already in place. */
>>> +		if (kimage->head & IND_DONE)
>>> +			kexec_segment_flush(kimage);
>>> +	}
>>
>> So for kdump we cleaned the kimage->segment[i].mem regions in
>> arch_kexec_protect_crashkres(), so don't need to do it here.
> 
> Correct.
> 
>> What about the kimage->head[i] array of list entries that were cleaned by
>> kexec_list_flush()? Now we don't clean that for kdump either, but we do pass it
>> arm64_relocate_new_kernel() at the end of this function:
>>> cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head, kimage_start, 0);
> 
> Kimage->head holds a list of memory regions that are overlapped
> between the primary kernel and the secondary kernel, but in kedump case,
> the whole memory is isolated and the list should be empty.

The asm code will still try to walk the list with MMU and caches turned off, so
even its "I'm empty" values need cleaning to the PoC.

(it looks like the first value is passed by value, so we could try and be clever
by testing for that DONE flag in the first value, but I don't think its worth
the effort)


Thanks,

James
