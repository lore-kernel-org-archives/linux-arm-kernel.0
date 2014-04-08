From: dave.long@linaro.org (David Long)
Date: Tue, 08 Apr 2014 09:05:49 -0400
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140408114619.GE16119@n2100.arm.linux.org.uk>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
 <20140408082444.GA3598@e103592.cambridge.arm.com>
 <20140408114619.GE16119@n2100.arm.linux.org.uk>
Message-ID: <5343F42D.5090205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/14 07:46, Russell King - ARM Linux wrote:
> On Tue, Apr 08, 2014 at 09:24:50AM +0100, Dave Martin wrote:
>> You're right that something is needed.
>>
>> Would flush_icache_range() not be the correct thing to call here?
>>
>> Sync'ing the I and D sides for a whole page seems excessive to
>> install a probe.
>>
>> I believe __cpuc_coherent_kern_range() is not intended as an API,
>> and should only be used in special situations in arch-specific code.
>> It's the correct operation, but arm provides flush_icache_range as a
>> wrapper to call.
>>
>> flush_icache_range() is documented, with the correct effect, in
>> Documentation/cachetlb.txt, so I believe that all arches should
>> provide it, even if it's a no-op.
>
> The real question is, what is this code in xol_get_insn_slot() trying
> to do?
>
> 1. area->page is an anonymous page - it was allocated by
>     alloc_page(GFP_HIGHUSER).  This makes use of flush_dcache_page()
>     questionable at best.
>
> 2. xol_get_insn_slot() appears to want to copy instructions into this
>     page via the kernel mapping such that they're visible to userspace.
>
> So, the first thing that we need to do is to push the written data out to
> a point where the instruction stream can see it.  Then we need to ensure
> that the instruction stream can see the new instructions.
>
> Practically for ARM, that means pushing it out of the D-cache and then
> making sure that there are no I-cache lines associated with the new
> instructions.
>
> With VIVT instruction caches (yes, we still have them on ARMv7), we have
> to flush the I-cache lines associated with the userspace addresses -
> flushing the I-cache lines for the kernel mapping doesn't do anything for
> the stale lines in the userspace mapping.
>
> copy_to_page() kmap_atomic()'s the page - this doesn't take account of
> VIPT aliasing caches, and so the writes may be in an alias of the user
> page.  Plus, when the page is kunmap_atomic()'d, there's no guarantee that
> the written lines will be flushed out.
>
> copy_from_page() suffers from a similar problem, though its saving grace
> is that the user mapping is execute-only (iow, read+execute only) so
> should never end up with any dirty cache lines associated with it.
>
> flush_dcache_page() will ensure that the D-cache lines are flushed out on
> ARM (even though it's only defined to have an effect for page cache pages)
> but it does nothing for the I-cache.  So, although it seems to partially
> work, it's definitely the wrong interface here.
>
> However... the normal way we do this (for example, in the case of ptrace)
> is via copy_to_user_page() / copy_from_user_page(), and we have some
> pretty complex handling via those functions to deal with writing to the
> page and having the affected thread running on a different CPU to the
> one we wrote the new instructions.  I'd recommend that uprobes looks at
> trying to re-use some of this infrastructure rather than re-inventing
> this wheel.
>

Conincentally I ran into this same problem last weekend while testing my 
future thumb extensions to the uprobes code.  I too tried a couple 
cache-flushing changes, and found most any change fixed the problem and 
the past intermittent systemtap failures I had seen (although I was 
unsure how much of that was due to happy side-effects from any 
particular flush operation).  I found flush_icache_user_range() but I 
was scratching my head on how to use it instead of a heavy-weight flush 
as the uprobes code deliberately does not hang onto a copy of the user 
vma pointer.  I tried a patch storing the mm struct pointer in the 
uprobes xol struct and looking up the vma info using it and the user 
virtual address, but I'm not sure that's any better than just hanging 
onto the vma pointer.

I also would not necessarily have assumed the kernel dcache flush was 
still needed, but I now see how this makes sense.  Thanks for the 
explanation Russell, it answered several questions I had.

Unfortunately copy_to_user_page() also needs a pointer to a vma struct 
so, while it presumably provides the model to follow, it can't simply be 
dropped in.

Victor, do you want to own the action of coming up with a patch?  If not 
I'm OK with taking this forward, although I suspect both of us will need 
help testing for anything other than ARM.

-dl
