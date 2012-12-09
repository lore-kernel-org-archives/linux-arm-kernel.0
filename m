From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 10 Dec 2012 08:58:35 +0900
Subject: [PATCH 1/3] ARM: MM: Add the workaround of Errata 774769
Message-ID: <001701cdd669$19e8cdd0$4dba6970$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the workaround of Errata 774769 that configures write streaming
on versions of A15 affected by this erratum such that no streaming-write ever
allocates into the L2 cache.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/Kconfig             |   11 +++++++++++
 arch/arm/mach-exynos/Kconfig |    1 +
 arch/arm/mm/proc-v7.S        |   16 ++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9759fec..11a57e2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1417,6 +1417,17 @@ config ARM_ERRATA_775420
 	 to deadlock. This workaround puts DSB before executing ISB if
 	 an abort may occur on cache maintenance.

+config ARM_ERRATA_774769
+	bool "ARM errata: data corruption may occur with store streaming in a system"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the erratum 774769 affecting
+	  Cortex-A15 (r0p4).
+	  External memory may be corrupted on erratum 774769.
+	  The workaround is to configure write streaming on versions of A15
+	  affected by this erratum such that no streaming-write ever allocates
+	  into the L2 cache.
+
 endmenu

 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index da55107..e1168fb 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -22,6 +22,7 @@ config ARCH_EXYNOS4
 config ARCH_EXYNOS5
 	bool "SAMSUNG EXYNOS5"
 	select HAVE_SMP
+	select ARM_ERRATA_774769
 	help
 	  Samsung EXYNOS5 (Cortex-A15) SoC based systems

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 846d279..06cbdfa 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -208,7 +208,7 @@ __v7_setup:
 	orreq	r10, r10, #(1 << 22)		@ set the Write Allocate disable bit
 	mcreq	p15, 1, r10, c9, c0, 2		@ write the L2 cache aux ctrl register
 #endif
-	b	3f
+	b	4f

 	/* Cortex-A9 Errata */
 2:	ldr	r10, =0x00000c09		@ Cortex-A9 primary part number
@@ -243,8 +243,20 @@ __v7_setup:
 	mcrlt	p15, 0, r10, c15, c0, 1		@ write diagnostic register
 1:
 #endif
+	b	4f

-3:	mov	r10, #0
+	/* Cortex-A15 Errata */
+3:	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
+	teq	r0, r10
+	bne	4f
+#ifdef CONFIG_ARM_ERRATA_774769
+	teq	r6, #0x4			@ present in r0p4
+	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
+	orreq	r10, r10, #1 << 25		@ set bit #25
+	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
+#endif
+
+4:	mov	r10, #0
 	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
 	dsb
 #ifdef CONFIG_MMU
--
1.7.5.4
