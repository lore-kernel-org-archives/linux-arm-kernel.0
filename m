From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2015 16:52:15 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <5653387A.2000101@redhat.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej>
 <20151123155132.GC32300@e104818-lin.cambridge.arm.com>
 <5653387A.2000101@redhat.com>
Message-ID: <20151123165214.GD32300@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 10:02:02AM -0600, Jeremy Linton wrote:
> On 11/23/2015 09:51 AM, Catalin Marinas wrote:
> >Call trace:
> >[<ffffffc0000952b8>] __create_mapping.isra.5+0x360/0x530
> >[<ffffffc0000954ec>] fixup_init+0x64/0x80
> >[<ffffffc0000945a4>] free_initmem+0xc/0x38
> >[<ffffffc0005eb9f8>] kernel_init+0x20/0xe0
> >[<ffffffc000085c50>] ret_from_fork+0x10/0x40
> >
> >What I don't get is why we have fixup_init() even when
> >!CONFIG_DEBUG_RODATA. It probably breaks the initial mapping just to get
> >a non-executable init section. However, the other sections are left
> >executable when this config option is disabled. The patch below fixes
> >the warnings above:
> 
> 	Well the kernel permissions are a bit of a mess, and not at all "secure" in
> their current state. But I guess the thought must have been that turning off
> execute on the init sections was a good way to find functions incorrectly
> marked _init(). Which is different from RO.

fixup_executable() is non-empty only with DEBUG_RODATA, even though it
is done early. I was assuming we should have done the same with
fixup_init() but I've seen Laura's reply that it was deliberate.

> Frankly, I expect someone will push to cleanup the kernel permissions
> at some point (I've got it on my "spare time todo, list"), but this
> will of course make the create_mapping_late a lot more popular as I
> see it being called during module load/unload.
> 	Anyway, I've been saying the problem is create_mapping_late()
> all along, as you notice there isn't any TLB flushes in fixup_init()
> and that is the core of the problem, not all this other discussion.

The problem here is not changing permissions, we do this all the time
with fork() and a single TLB at the end. While the __create_mapping()
path seems to have TLB invalidation when changing a non-empty entry on
higher levels (though without break-before-make), it assumes that the
PTE was always none and no further TLB done. Your patch in this thread
indeed fixes this part (though without a check for pte_none(old_pte) but
that's an optimisation).

However, the problem you are seeing is not some permission change being
ignored (like a stale entry) but a TLB conflict which means that the
same VA has two entries in the TLB. We need better clarification in the
ARM ARM (a ticket about to be raised) but what makes this very likely is
going from a small block mapping to a bigger one. In this case, a
non-contiguous PTE overlapping with a contiguous one loaded via a
different address in the same contiguous range. Adding the TLB flush in
__populate_init_pte() hides this by reducing the window.

We have other cases where we go for smaller to larger block like the 1GB
section. I think until MarkR finishes his code to go via a temporary
TTBR1 + idmap, we should prevent all those. We can hope that going the
other direction (from bigger to smaller block mapping) is fine but we
don't have a clear answer yet.

Your original patch with a better description of the use cases and
potentially a check for pte_none() is still useful, though not a fix for
the TLB conflict. Something like:

----------------8<--------------------
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index abb66f84d4ac..d110313e58e9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -113,14 +113,20 @@ static void __populate_init_pte(pte_t *pte, unsigned long addr,
 				pgprot_t prot)
 {
 	unsigned long pfn = __phys_to_pfn(phys);
+	bool need_flush = false;
 
 	do {
+		if (!pte_none(*pte))
+			need_flush = true;
 		/* clear all the bits except the pfn, then apply the prot */
 		set_pte(pte, pfn_pte(pfn, prot));
 		pte++;
 		pfn++;
 		addr += PAGE_SIZE;
 	} while (addr != end);
+
+	if (need_flush)
+		flush_tlb_all();
 }
 
 static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
----------------8<--------------------

-- 
Catalin
