From: will.deacon@arm.com (Will Deacon)
Date: Sun, 13 Nov 2011 12:20:32 +0000
Subject: [PATCH v5 3/8] ARM: idmap: populate identity map pgd at init time
In-Reply-To: <20111112111414.GA27746@n2100.arm.linux.org.uk>
References: <1320767583-21162-1-git-send-email-will.deacon@arm.com>
 <1320767583-21162-4-git-send-email-will.deacon@arm.com>
 <20111112111414.GA27746@n2100.arm.linux.org.uk>
Message-ID: <20111113122032.GA20833@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Nov 12, 2011 at 11:14:14AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 08, 2011 at 03:52:58PM +0000, Will Deacon wrote:
> > When disabling the MMU, it is necessary to take out an identity mapping
> > for as much of the address space as possible so that the reset path can
> > be executed using its physical address. This is useful for softbooting
> > and entering low power states.
> > 
> > This patch allocates a set of pagetables during boot and populates them
> > with an identity mapping for all of memory apart from a small window
> > containing the kernel image.
> 
> I'd like to suggest a slightly different approach, now that we have the
> 'soft_restart()' thing which is guaranteed to be handling all of the
> soft-restart stuff.

Sure, it's nice to have some feedback for the kexec stuff.

> First, what does the soft-restart code need to do?  It needs to:
> 1. Perform an orderly shutdown of caches.
> 2. Perform an orderly shutdown of the MMU.
> 3. Jump to the supplied physical address with the caches and MMU off,
>    IRQs disabled, etc.
> 
> And for (3) to work across the range of processors with ease, we need
> the code to run in a 1:1 mapping so turning off the MMU doesn't leads
> to unpredictable results.
> 
> We can achieve most of this in the way that we're already doing, so:
> 1. calling local_irq_disable() and local_fiq_disable() to disable interrupts
> 2. cpu_proc_fin() to disable caches
> 3. flush_cache_all() (and outer_flush_all()).

Agreed. This is what I currently do and it works nicely.

> So far, that's very much what the new soft_restart() function already
> does.  But - can we be smarter about the 1:1 mapping like we are with
> the CPU suspend code?  Or, to put it another way, can we use the CPU
> suspend code's page table which it allocated, and setup a mapping to
> cover just the cpu_reset() code itself.

Hmm, interesting idea, although we'll still need the code for changing stack
so that the C code between changing page tables and calling cpu_reset can
execute properly (to protect against the case where the physical address
of cpu_reset aliases with the virtual address of the stack). If we're going
to use the same page table for suspend and reset, should we move that into
idmap.c?

One possible advantage of only remapping cpu_reset would be that if we
could place all functions that require an identity mapping into a separate
linker section then the idmap code could simply remap that area.

> We'd need to reorganize the cpu_reset() code to ensure that the MMU
> is actually turned off before we do the final jump, but that shouldn't
> be too hard to achieve.

This is already taken care of by the isbs for v6 and v7. For older platforms,
I think we should be ok (Ye Olde ARM ARM second edition doesn't mention any
synchronisation requirements) but it would be worth testing it if possible.

> This should fix the concerns people have had with kexec and kdump, as
> well as fixing up the (broken) v6 and v7 cpu_reset() code.

Yes, we just have to make sure it doesn't break any older platforms.

Will
