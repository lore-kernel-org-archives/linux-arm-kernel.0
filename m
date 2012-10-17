From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:35:58 +0100
Subject: [RESEND PATCH 4/4] ARM: mm: introduce present,
 faulting entries for PAGE_NONE
In-Reply-To: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
References: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488158-3399-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PROT_NONE mappings apply the page protection attributes defined by _P000
which translate to PAGE_NONE for ARM. These attributes specify an XN,
RDONLY pte that is inaccessible to userspace. However, on kernels
configured without support for domains, such a pte *is* accessible to
the kernel and can be read via get_user, allowing tasks to read
PROT_NONE pages via syscalls such as read/write over a pipe.

This patch introduces a new software pte flag, L_PTE_NONE, that is set
to identify faulting, present entries.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h |    1 +
 arch/arm/include/asm/pgtable-3level.h |    1 +
 arch/arm/include/asm/pgtable.h        |    6 +++---
 arch/arm/mm/proc-macros.S             |    4 ++++
 arch/arm/mm/proc-v7-2level.S          |    4 ++++
 arch/arm/mm/proc-v7-3level.S          |    3 +++
 6 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index c44a1ec..f97ee02 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -124,6 +124,7 @@
 #define L_PTE_USER		(_AT(pteval_t, 1) << 8)
 #define L_PTE_XN		(_AT(pteval_t, 1) << 9)
 #define L_PTE_SHARED		(_AT(pteval_t, 1) << 10)	/* shared(v6), coherent(xsc3) */
+#define L_PTE_NONE		(_AT(pteval_t, 1) << 11)
 
 /*
  * These are the memory types, defined to be compatible with
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index e32311a..a3f3792 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -77,6 +77,7 @@
 #define L_PTE_XN		(_AT(pteval_t, 1) << 54)	/* XN */
 #define L_PTE_DIRTY		(_AT(pteval_t, 1) << 55)	/* unused */
 #define L_PTE_SPECIAL		(_AT(pteval_t, 1) << 56)	/* unused */
+#define L_PTE_NONE		(_AT(pteval_t, 1) << 57)	/* PROT_NONE */
 
 /*
  * To be used in assembly code with the upper page attributes.
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ccf34b6..9c82f98 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -73,7 +73,7 @@ extern pgprot_t		pgprot_kernel;
 
 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))
 
-#define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN | L_PTE_RDONLY)
+#define PAGE_NONE		_MOD_PROT(pgprot_user, L_PTE_XN | L_PTE_RDONLY | L_PTE_NONE)
 #define PAGE_SHARED		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_XN)
 #define PAGE_SHARED_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER)
 #define PAGE_COPY		_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
@@ -83,7 +83,7 @@ extern pgprot_t		pgprot_kernel;
 #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
 #define PAGE_KERNEL_EXEC	pgprot_kernel
 
-#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN)
+#define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN | L_PTE_NONE)
 #define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
 #define __PAGE_SHARED_EXEC	__pgprot(_L_PTE_DEFAULT | L_PTE_USER)
 #define __PAGE_COPY		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_RDONLY | L_PTE_XN)
@@ -240,7 +240,7 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER;
+	const pteval_t mask = L_PTE_XN | L_PTE_RDONLY | L_PTE_USER | L_PTE_NONE;
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index b29a226..eb6aa73 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -167,6 +167,10 @@
 	tst	r1, #L_PTE_YOUNG
 	tstne	r1, #L_PTE_PRESENT
 	moveq	r3, #0
+#ifndef CONFIG_CPU_USE_DOMAINS
+	tstne	r1, #L_PTE_NONE
+	movne	r3, #0
+#endif
 
 	str	r3, [r0]
 	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index e755e9f..6d98c13 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -101,6 +101,10 @@ ENTRY(cpu_v7_set_pte_ext)
 
 	tst	r1, #L_PTE_YOUNG
 	tstne	r1, #L_PTE_VALID
+#ifndef CONFIG_CPU_USE_DOMAINS
+	eorne	r1, r1, #L_PTE_NONE
+	tstne	r1, #L_PTE_NONE
+#endif
 	moveq	r3, #0
 
  ARM(	str	r3, [r0, #2048]! )
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index d23d067..7b56386 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -67,6 +67,9 @@ ENTRY(cpu_v7_set_pte_ext)
 #ifdef CONFIG_MMU
 	tst	r2, #L_PTE_VALID
 	beq	1f
+	tst	r3, #1 << (57 - 32)		@ L_PTE_NONE
+	bicne	r2, #L_PTE_VALID
+	bne	1f
 	tst	r3, #1 << (55 - 32)		@ L_PTE_DIRTY
 	orreq	r2, #L_PTE_RDONLY
 1:	strd	r2, r3, [r0]
-- 
1.7.4.1
