From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2015 15:51:32 +0000
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151118162932.GA13355@leverpostej>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej>
Message-ID: <20151123155132.GC32300@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 04:29:32PM +0000, Mark Rutland wrote:
> FWIW, Will had a patch [1] for detecting PTE level break-before-make
> violations. I gave this a go on Juno with v4.4-rc1, and saw an issue in
> the EFI virtmap code that I'm currently investigating.
[...]
> [1] https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=aarch64/devel&id=372f39220ad35fa39a75419f2221ffeb6ffd78d3

I thought about adding a check for when we change from contiguous to
non-contiguous or vice-versa, on top of Will's patch:

--------------8<--------------------
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index defbfde43a43..70e02e3b1a78 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -240,6 +240,10 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	if (WARN_ON((old & PTE_ATTRINDX_MASK) != (new & PTE_ATTRINDX_MASK)))
 		goto pte_bad;
 
+	/* Changing contiguity may lead to a TLB conflict */
+	if (WARN_ON((old & PTE_CONT) != (new & PTE_CONT)))
+		goto pte_bad;
+
 	/* Change of OA is only an issue if one mapping is writable */
 	if (!(old & new & PTE_RDONLY) &&
 	    WARN_ON(pte_pfn(*ptep) != pte_pfn(pte)))
--------------8<--------------------

But it doesn't look nice afterwards. It's the fixup_init() trying to
re-write the entries and we start changing the PTE_CONT bit:

Call trace:
[<ffffffc0000952b8>] __create_mapping.isra.5+0x360/0x530
[<ffffffc0000954ec>] fixup_init+0x64/0x80
[<ffffffc0000945a4>] free_initmem+0xc/0x38
[<ffffffc0005eb9f8>] kernel_init+0x20/0xe0
[<ffffffc000085c50>] ret_from_fork+0x10/0x40

What I don't get is why we have fixup_init() even when
!CONFIG_DEBUG_RODATA. It probably breaks the initial mapping just to get
a non-executable init section. However, the other sections are left
executable when this config option is disabled. The patch below fixes
the warnings above:

--------------8<--------------------
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index abb66f84d4ac..e0f82e1a1c09 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -482,9 +482,11 @@ void mark_rodata_ro(void)
 
 void fixup_init(void)
 {
+#ifdef CONFIG_DEBUG_RODATA
 	create_mapping_late(__pa(__init_begin), (unsigned long)__init_begin,
 			(unsigned long)__init_end - (unsigned long)__init_begin,
 			PAGE_KERNEL);
+#endif
 }
 
 /*
--------------8<--------------------

Jeremy, can you give this fixup_init() patch a try, see whether it makes
any difference (it's just a temporary hack which may prevent us from
reverting the PTE_CONT patches until we have a better solution).

Anyway, I think we should merge Will's patch since it's a handy debug
tool.

-- 
Catalin
