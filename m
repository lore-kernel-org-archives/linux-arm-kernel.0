From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 21 Jun 2010 14:40:22 -0700
Subject: [RFC PATCH] smp: parallel smp boot option
Message-ID: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

Some SMP configurations start all available cores in parallel
through the kernel entrypoint, rather than secondary CPUs waiting to be
brought out of reset into machine specific startup code.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
---
 arch/arm/Kconfig       |    9 +++++++++
 arch/arm/kernel/head.S |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 021b1d5..39103d2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1020,6 +1020,15 @@ config NR_CPUS
 	depends on SMP
 	default "4"
 
+config SMP_PARALLEL_START
+	bool "Parallel start of SMP cores"
+	depends on SMP
+	default n
+	help
+	  Say Y here if all CPUs boot to the kernel entrypoint in
+	  parallel, rather than non-master CPUs waiting to be brought
+	  out of reset into machine specific startup code.
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && HOTPLUG && EXPERIMENTAL
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 4946c72..9730b7a 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -78,6 +78,9 @@
 ENTRY(stext)
 	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
 						@ and irqs disabled
+#ifdef CONFIG_SMP_PARALLEL_START
+	bl	__smp_secondary_spin
+#endif
 	mrc	p15, 0, r9, c0, c0		@ get processor id
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?
-- 
1.7.1

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
