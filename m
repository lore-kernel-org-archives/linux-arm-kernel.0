From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 May 2011 11:33:09 +0100
Subject: [RFC PATCH v2 04/12] ARM: versatile: use remapped PPI interrupts for
	local timer
In-Reply-To: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1304677997-26947-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal interrupt scheme for the local timers by using
a remapped PPI interrupt.

Tested on VExpress and PB-11MP.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/Kconfig       |    2 ++
 arch/arm/mach-vexpress/Kconfig       |    1 +
 arch/arm/plat-versatile/localtimer.c |    3 ++-
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index b9a9805..12c7c56 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -38,6 +38,7 @@ config MACH_REALVIEW_PB11MP
 	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
 	select CPU_V6K
 	select ARM_GIC
+	select ARM_GIC_VPPI
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
 	help
@@ -76,6 +77,7 @@ config MACH_REALVIEW_PBA8
 config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore"
 	select ARM_GIC
+	select ARM_GIC_VPPI
 	select HAVE_PATA_PLATFORM
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 9311484..07a53aa 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,6 +5,7 @@ config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
 	select ARM_GIC
+	select ARM_GIC_VPPI
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
diff --git a/arch/arm/plat-versatile/localtimer.c b/arch/arm/plat-versatile/localtimer.c
index 0fb3961..a76daf4 100644
--- a/arch/arm/plat-versatile/localtimer.c
+++ b/arch/arm/plat-versatile/localtimer.c
@@ -14,6 +14,7 @@
 
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
+#include <asm/hardware/gic.h>
 #include <mach/irqs.h>
 
 /*
@@ -21,7 +22,7 @@
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
-	evt->irq = IRQ_LOCALTIMER;
+	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
 	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4
