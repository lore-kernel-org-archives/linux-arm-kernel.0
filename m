From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Dec 2011 14:49:37 +0000
Subject: Oops in guest after ioremap() on ARMv7
In-Reply-To: <4EF31DA7.9030407@citrix.com>
References: <4EF31DA7.9030407@citrix.com>
Message-ID: <20111222144937.GE20635@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 12:08:07PM +0000, David Vrabel wrote:
> When running the linux kernel on the ARMv7 envelope model as a guest
> under the Xen hypervisor there is a oops (see below for an example of
> the page translation fault) when trying to access ioremap()'d memory.
> 
> The same kernel works fine when not running under the hypervisor.
> 
> It's a 3.2.0-rc5+ kernel with the two additional linux-arch-arm
> branches: arm-arch/vexpress and arm-arch/arm-lpae.
> 
> Calling flush_cache_all() in flush_cache_vmap() makes it work.  What
> isn't being correctly flushed?  I see that flush_pmd_entry() and
> cpu_v7_set_pte_ext() already flush the L1 and L2 translation table
> entries and I can't think of anything else that would need to be flushed
> (unless the mapped virtual addresses need to be flushed as well?)
> 
> The "Barrier Litmus Tests and Cookbook" says that a TLB flush and a
> branch predictor flush are required after a translation table entry
> update.  This seems not to be done but adding this didn't seem to help
> (and using local_flush_tlb_all()) in flush_cache_vmap() didn't help either).
> 
> I don't see anything in the hypervisor that could be causing this as the
> fault is occurring at stage 1 and not stage 2 translation.

Interesting error, I don't have an immediate idea of what might be
wrong, just some questions.

What's the value of the VTCR register for this guest? Are the
translation table walks marked as cacheable? Also, are the page table
attributes Normal Cacheable in the stage 2 translation? The processor
chooses the more restrictive attribute between stage 1 and stage 2.

-- 
Catalin
