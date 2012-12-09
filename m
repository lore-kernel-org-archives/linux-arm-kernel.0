From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon, 10 Dec 2012 08:59:17 +0900
Subject: [PATCH 2/3] ARM: MM: Add the workaround of Errata 773022
Message-ID: <001801cdd669$331c3850$9954a8f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the workaround of Errata 773022 that disables loop buffer.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/Kconfig             |   10 ++++++++++
 arch/arm/mach-exynos/Kconfig |    1 +
 arch/arm/mm/proc-v7.S        |    6 ++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 11a57e2..93397da 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1417,6 +1417,16 @@ config ARM_ERRATA_775420
 	 to deadlock. This workaround puts DSB before executing ISB if
 	 an abort may occur on cache maintenance.

+config ARM_ERRATA_773022
+	bool "ARM errata: incorrect instructions may be executed from loop buffer"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the erratum 773022 affecting
+	  Cortex-A15 (r0p4).
+	  In certain rare sequences of code, the loop buffer may deliver
+	  incorrect instructions.
+	  This workaround is to disable loop buffer.
+
 config ARM_ERRATA_774769
 	bool "ARM errata: data corruption may occur with store streaming in a system"
 	depends on CPU_V7
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e1168fb..bb92f4c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -22,6 +22,7 @@ config ARCH_EXYNOS4
 config ARCH_EXYNOS5
 	bool "SAMSUNG EXYNOS5"
 	select HAVE_SMP
+	select ARM_ERRATA_773022
 	select ARM_ERRATA_774769
 	help
 	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 06cbdfa..0b4c518 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -249,6 +249,12 @@ __v7_setup:
 3:	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
 	teq	r0, r10
 	bne	4f
+#ifdef CONFIG_ARM_ERRATA_773022
+	teq	r6, #0x4			@ present in r0p4
+	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
+	orreq	r10, r10, #1 << 1		@ set bit #1
+	mcreq	p15, 0, r10, c1, c0, 1		@ write aux control register
+#endif
 #ifdef CONFIG_ARM_ERRATA_774769
 	teq	r6, #0x4			@ present in r0p4
 	mrceq	p15, 0, r10, c1, c0, 1		@ read aux control register
--
1.7.5.4
