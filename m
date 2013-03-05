From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  4 Mar 2013 17:05:56 -0700
Subject: [PATCH 1/2] ARM: tegra: add CPU errata WARs to Tegra reset handler
Message-ID: <1362441957-22050-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The CPU cores in Tegra contain some errata. Workarounds must be applied
for these every time a CPU boots. Implement those workarounds directly
in the Tegra-specific CPU reset vector.

Many of these workarounds duplicate code in the core ARM kernel.

However, the core ARM kernel cannot enable those workarounds when
building a multi-platform kernel, since they require writing to secure-
only registers, and a multi-platform kernel often does not run in secure
mode, and also cannot generically/architecturally detect whether it is
running in secure mode, and hence cannot either unconditionally or
conditionally apply these workarounds.

Instead, the workarounds must be applied in architecture-specific reset
code, which is able to have more direct knowledge of the secure/normal
state. On Tegra, we will be able to detect this using a non-architected
register in the future, although we currently assume the kernel runs only
in secure mode. Other SoCs may never run the kernel in secure mode, and
hence always rely on a secure monitor to enable the workarounds, and
hence never implement them in the kernel.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/reset-handler.S |   45 ++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 54382ce..ff7b45c 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -99,6 +99,8 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *
  * Register usage within the reset handler:
  *
+ *      Others: scratch
+ *      R6  = SoC ID << 8
  *      R7  = CPU present (to the OS) mask
  *      R8  = CPU in LP1 state mask
  *      R9  = CPU in LP2 state mask
@@ -114,6 +116,40 @@ ENTRY(__tegra_cpu_reset_handler_start)
 ENTRY(__tegra_cpu_reset_handler)
 
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
+
+	mov32	r6, TEGRA_APB_MISC_BASE
+	ldr	r6, [r6, #APB_MISC_GP_HIDREV]
+	and	r6, r6, #0xff00
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+t20_check:
+	cmp	r6, #(0x20 << 8)
+	bne	after_t20_check
+t20_errata:
+	# Tegra20 is a Cortex-A9 r1p1
+	mrc	p15, 0, r0, c1, c0, 0   @ read system control register
+	orr	r0, r0, #1 << 14        @ erratum 716044
+	mcr	p15, 0, r0, c1, c0, 0   @ write system control register
+	mrc	p15, 0, r0, c15, c0, 1  @ read diagnostic register
+	orr	r0, r0, #1 << 4         @ erratum 742230
+	orr	r0, r0, #1 << 11        @ erratum 751472
+	mcr	p15, 0, r0, c15, c0, 1  @ write diagnostic register
+	b	after_errata
+after_t20_check:
+#endif
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+t30_check:
+	cmp	r6, #(0x30 << 8)
+	bne	after_t30_check
+t30_errata:
+	# Tegra30 is a Cortex-A9 r2p9
+	mrc	p15, 0, r0, c15, c0, 1  @ read diagnostic register
+	orr	r0, r0, #1 << 6         @ erratum 743622
+	orr	r0, r0, #1 << 11        @ erratum 751472
+	mcr	p15, 0, r0, c15, c0, 1  @ write diagnostic register
+	b	after_errata
+after_t30_check:
+#endif
+after_errata:
 	mrc	p15, 0, r10, c0, c0, 5		@ MPIDR
 	and	r10, r10, #0x3			@ R10 = CPU number
 	mov	r11, #1
@@ -129,16 +165,13 @@ ENTRY(__tegra_cpu_reset_handler)
 
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	/* Are we on Tegra20? */
-	mov32	r6, TEGRA_APB_MISC_BASE
-	ldr	r0, [r6, #APB_MISC_GP_HIDREV]
-	and	r0, r0, #0xff00
-	cmp	r0, #(0x20 << 8)
+	cmp	r6, #(0x20 << 8)
 	bne	1f
 	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
-	mov32	r6, TEGRA_PMC_BASE
+	mov32	r5, TEGRA_PMC_BASE
 	mov	r0, #0
 	cmp	r10, #0
-	strne	r0, [r6, #PMC_SCRATCH41]
+	strne	r0, [r5, #PMC_SCRATCH41]
 1:
 #endif
 
-- 
1.7.10.4
