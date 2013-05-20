From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 20 May 2013 18:39:25 +0800
Subject: [PATCH V2 2/6] ARM: tegra: skip SCU and PL310 code when CPU is not
 Cortex-A9
In-Reply-To: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
References: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
Message-ID: <1369046369-12489-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For supporting single image on all Tegra series, we need to skip some HW
support code for Cortex-A9 only.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change; but double confirmed the patch is OK with THUMB2_KERNEL
---
 arch/arm/mach-tegra/sleep.S |  8 +++++---
 arch/arm/mach-tegra/sleep.h | 24 ++++++++++++++++++------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 364d845..9daaef2 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -106,9 +106,11 @@ ENTRY(tegra_shut_off_mmu)
 	isb
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
-	mov32	r4, TEGRA_ARM_PERIF_BASE + 0x3000
-	mov	r5, #0
-	str	r5, [r4, #L2X0_CTRL]
+	check_cpu_part_num 0xc09, r9, r10
+	movweq	r4, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
+	movteq	r4, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
+	moveq	r5, #0
+	streq	r5, [r4, #L2X0_CTRL]
 #endif
 	mov	pc, r0
 ENDPROC(tegra_shut_off_mmu)
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index f9f2164..2269c0d 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -70,19 +70,31 @@
 	movt	\reg, #:upper16:\val
 .endm
 
+/* Marco to check CPU part num */
+.macro check_cpu_part_num part_num, tmp1, tmp2
+	mrc	p15, 0, \tmp1, c0, c0, 0
+	ubfx	\tmp1, \tmp1, #4, #12
+	mov32	\tmp2, \part_num
+	cmp	\tmp1, \tmp2
+.endm
+
 /* Macro to exit SMP coherency. */
 .macro exit_smp, tmp1, tmp2
 	mrc	p15, 0, \tmp1, c1, c0, 1	@ ACTLR
 	bic	\tmp1, \tmp1, #(1<<6) | (1<<0)	@ clear ACTLR.SMP | ACTLR.FW
 	mcr	p15, 0, \tmp1, c1, c0, 1	@ ACTLR
 	isb
-	cpu_id	\tmp1
-	mov	\tmp1, \tmp1, lsl #2
-	mov	\tmp2, #0xf
-	mov	\tmp2, \tmp2, lsl \tmp1
-	mov32	\tmp1, TEGRA_ARM_PERIF_VIRT + 0xC
-	str	\tmp2, [\tmp1]			@ invalidate SCU tags for CPU
+#ifdef CONFIG_HAVE_ARM_SCU
+	check_cpu_part_num 0xc09, \tmp1, \tmp2
+	mrceq	p15, 0, \tmp1, c0, c0, 5
+	andeq	\tmp1, \tmp1, #0xF
+	moveq	\tmp1, \tmp1, lsl #2
+	moveq	\tmp2, #0xf
+	moveq	\tmp2, \tmp2, lsl \tmp1
+	ldreq	\tmp1, =(TEGRA_ARM_PERIF_VIRT + 0xC)
+	streq	\tmp2, [\tmp1]			@ invalidate SCU tags for CPU
 	dsb
+#endif
 .endm
 
 /* Macro to check Tegra revision */
-- 
1.8.2.2
