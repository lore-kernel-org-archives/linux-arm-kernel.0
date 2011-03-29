From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Tue, 29 Mar 2011 12:30:48 +0200
Subject: [PATCH v4 02/10] lpc2k: Exception vector handling
In-Reply-To: <1301394656-24853-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1301394656-24853-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1301394656-24853-3-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPC2K optionally remaps the first 64 bytes of SRAM to address 0, to facilitate
writable low vectors. However, since it only remaps the first 64 bytes the stubs
can't be copied there and end up too far away from the vectors, requiring the
vectors to use an indirect jump instead of branch to get to the stubs.

Since now VECTOR_BASE is below PHYS_OFFSET, do not try to reserve the vector
page, as it will fail (and prevent the kernel from booting).

Also, commit 247055aa (6384/1: Remove the domain switching on ARMv6k/v7 CPUs) broke
the placement of vectors in the !MMU case, so fix this too.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
no changes since v3.

changes since v2:
        * reworded reason for vector branch changes.

changes since v1:
        * added comment to entry-armv.S vector #ifdef.
---
 arch/arm/Kconfig             |    1 +
 arch/arm/kernel/entry-armv.S |   23 +++++++++++++++++++++++
 arch/arm/kernel/traps.c      |    2 +-
 arch/arm/mm/nommu.c          |    2 ++
 4 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ff6e18..c96908e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -186,6 +186,7 @@ config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
 	default DRAM_BASE if REMAP_VECTORS_TO_RAM
+	default 0x40000000 if ARCH_LPC2K
 	default 0x00000000
 	help
 	  The base address of exception vectors.
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e8d8856..65be7b1 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1208,6 +1208,7 @@ __stubs_end:
 
 	.globl	__vectors_start
 __vectors_start:
+#ifndef CONFIG_ARCH_LPC2K
  ARM(	swi	SYS_ERROR0	)
  THUMB(	svc	#0		)
  THUMB(	nop			)
@@ -1218,6 +1219,28 @@ __vectors_start:
 	W(b)	vector_addrexcptn + stubs_offset
 	W(b)	vector_irq + stubs_offset
 	W(b)	vector_fiq + stubs_offset
+#else /* CONFIG_ARCH_LPC2K */
+	/*
+	 * The LPC2K remaps 64 bytes of SRAM to address 0 for vectors. This
+	 * means that the stubs can't be in the same page, and end up too far
+	 * away from the vectors to use a branch instruction.
+	 */
+	swi	SYS_ERROR0
+	ldr	pc, .vector_und
+	ldr	pc, .vector_swi
+	ldr	pc, .vector_pabt
+	ldr	pc, .vector_dabt
+	ldr	pc, .vector_addrexcptn
+	ldr	pc, .vector_irq
+	ldr	pc, .vector_fiq
+.vector_und:		.word   vector_und
+.vector_swi:		.word   vector_swi
+.vector_pabt:		.word   vector_pabt
+.vector_dabt:		.word   vector_dabt
+.vector_addrexcptn:	.word   vector_addrexcptn
+.vector_irq:		.word   vector_irq
+.vector_fiq:		.word   vector_fiq
+#endif
 
 	.globl	__vectors_end
 __vectors_end:
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index f0000e1..db101fc 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -758,7 +758,7 @@ static void __init kuser_get_tls_init(unsigned long vectors)
 
 void __init early_trap_init(void)
 {
-#if defined(CONFIG_CPU_USE_DOMAINS)
+#if defined(CONFIG_CPU_USE_DOMAINS) || !defined(CONFIG_MMU)
 	unsigned long vectors = CONFIG_VECTORS_BASE;
 #else
 	unsigned long vectors = (unsigned long)vectors_page;
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 687d023..e3bec02 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -24,7 +24,9 @@ void __init arm_mm_memblock_reserve(void)
 	 * some architectures which the DRAM is the exception vector to trap,
 	 * alloc_page breaks with error, although it is not NULL, but "0."
 	 */
+#if PHYS_OFFSET <= CONFIG_VECTORS_BASE
 	memblock_reserve(CONFIG_VECTORS_BASE, PAGE_SIZE);
+#endif
 }
 
 /*
-- 
1.7.1
