From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 8 Apr 2014 11:39:23 -0700
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140408161910.GJ16119@n2100.arm.linux.org.uk>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
 <20140408082444.GA3598@e103592.cambridge.arm.com>
 <20140408114619.GE16119@n2100.arm.linux.org.uk>
 <5343F42D.5090205@linaro.org>
 <20140408133039.GH16119@n2100.arm.linux.org.uk>
 <CAA3XUr2kxKXpPwy8vqF1+CjcRsu86tGir-NuC7AXYiJVi4TuGw@mail.gmail.com>
 <CAA3XUr1Bj4CD2fhZkWAHx+9W8eGz755OvnE+-3sxaAcQNV6Q-Q@mail.gmail.com>
 <20140408161910.GJ16119@n2100.arm.linux.org.uk>
Message-ID: <CAA3XUr2sF7kfveTs6+m45bR6_8419TU8PBaEHuoVzscVGu-e8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2014 09:19, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Apr 08, 2014 at 08:35:01AM -0700, Victor Kamensky wrote:
>> Looking at flush_ptrace_access more closely. Now I am not sure that
>> ptrace write code could easily reused.
>>
>> 1) flush_ptrace_access seems to handle both data and text segments
>> write. In case of xol write we always know that it is code write
>
> Of course it has to, but writing code is the harder of the two
> problems.  With writes to data segments, the only thing that has to
> be dealt with is the data cache.  With code, not only do you need to
> deal with the data cache, but you also need to deal with the instruction
> cache too.
>
>> 2) as I pointed before flush_ptrace_access handles smp case whereas
>> xol write does not need to do that
>
> Are you sure about that?
>
> If I'm reading the code correctly, uprobes inserts a trapping instruction
> into the userspace program.  When that instruction is hit, it checks
> whether the thread is the desired one, and may request a slot in this
> magic page, which is when the write happens.
>
> The uprobes special page is shared across all threads which share the
> mm_struct, so in the case of a multi-threaded program running on a SMP
> machine, this page is visible to multiple CPUs.
>
> Is it possible for uprobes to be active on more than one thread at a
> time?  If so, because that page is shared, you could end up writing
> to a partial cache line from two threads.  From what I can see, ixol[]
> is two words, and there's normally 8 works per cache line on ARM, or
> occasionally 16.
>
> So, the question now is: is it possible to have uprobes active on more
> than one thread, and for two threads to hit the uprobes processing, both
> needing a slot in the page, hitting the same cache line?
>
> Now, what happens if thread 1 on CPU1 gets there first with its write.
> Then thread 2 on CPU2 gets there, causing the cache line to migrate to
> CPU2.  Then CPU1 does it's (non-broadcasted) flush, meanwhile CPU2 then
> gets preempted and goes off and does something else.
>
> Please tell me that can't happen. :)
>
>> 3) flush_ptrace_access needs vma, which uprobe code does not have on
>> layer where xol is installed. That is probably most critical issue that
>> could stop suggested code sharing. And note that vma in
>> flush_ptrace_access is needed only for cases cases 1) and 2) above,
>> about which xol write does not really care. If we take only required
>> pieces from flush_ptrace_access would not xol cache flush look like
>> this:
>>
>> void arch_uprobe_xol_sync_dcache_icache(struct page *page,
>>                     unsigned long addr, unsigned long size)
>> {
>>     if (icache_is_vipt_aliasing())
>>         flush_icache_alias(page_to_pfn(page), addr, size);
>>     else
>>         __cpuc_coherent_user_range(addr, size);
>> }
>
> And this is only half the story.
>
> What you're saying above is:
>
> - if the *instruction* cache is an aliasing VIPT cache, then we can
>   map the user page at the same colour and flush the data and instruction
>   caches according to that colour.
>         Problem: if you have a VIPT aliasing data cache, and you wrote
>                 to the page via a mapping which had a different colour
>                 (which is highly likely given you're using kmap_atomic())
>                 then you are not flushing the new instructions out of
>                 the data cache.
> - if the *instruction* cache is not an aliasing VIPT cache, then we
>   flush using the userspace mapping directly.
>         Problem: what if the data cache is aliasing... same problem
>                 as the above case.
>
> This is why we have the check for cache_is_vipt_aliasing() in there -
> that's not _just_ to deal with ptrace data modification, it's there for
> text modification as well.

Thanks! I got it now. Did not fully understand flush_ptrace_access code.
And did not catch (misread) difference between cache_is_vipt_aliasing
and icache_is_vipt_aliasing().

Probably some technique that retrieves required information from
vma like
  1) is_exec = vma->vm_flags & VM_EXEC
  2) core_in_mm = cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))
  3) broadcast = cache_ops_need_broadcast()
and passes it to common function would allow to share common
code and relieve need to search for vma after xol write call. After
xol write will call common function will be called with is_exec = 1,
core_in_mm = 1, broadcast = 0.

Although that common function will have seven parameters and
will look a bit ugly and unnatural. It could be compensated by
making it inline so flush_ptrace_access and flush_uprobe_xol_access
function would effectively have its own copy and correctly optimized.

Other option is to have flush_ptrace_access that takes vma and
flush_uprobe_xol_access function side by side in the same file
with comment that begs to keep common logic between two functions.
But not sure how that would work in long term.

Comments? Preferences? Any other suggestions how to deal with
lack of vma in uprobe xol write case?

Thanks,
Victor

>> Note on the side: flush_ptrace_access works with user-land memory
>> but it still uses __cpuc_coherent_kern_range. I think it should use
>> __cpuc_coherent_user_range.
>
> No, because __cpuc_coherent_kern_range() there is used on the *kernel*
> mapping of the page, not on the *user* mapping (which may fault).  The
> kernel mapping will never fault.
>
>> It looks like implementation wise it is
>> the same but user variant seems more appropriate in given situation.
>> Or am I missing something here?
>
> They do seem to be the same for both cases, so we could probably remove
> the distinction.  It's unlikely we'll ever see an implementation needing
> a difference between the two now.
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
