From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 May 2011 11:04:49 +0100
Subject: [RFC PATCH v5 08/13] ARM: tegra: use remapped PPI interrupts for
	local timer
In-Reply-To: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>
References: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1306749894-28749-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal interrupt scheme for the local timers by using
a remapped PPI interrupt.

Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/Kconfig      |    1 +
 arch/arm/mach-tegra/localtimer.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 5ec1846..eabdd90 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -9,6 +9,7 @@ config ARCH_TEGRA_2x_SOC
 	bool "Tegra 2 family"
 	select CPU_V7
 	select ARM_GIC
+	select ARM_GIC_VPPI
 	select ARCH_REQUIRE_GPIOLIB
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
diff --git a/arch/arm/mach-tegra/localtimer.c b/arch/arm/mach-tegra/localtimer.c
index e91d681..97cd0a9 100644
--- a/arch/arm/mach-tegra/localtimer.c
+++ b/arch/arm/mach-tegra/localtimer.c
@@ -14,13 +14,14 @@
 #include <asm/irq.h>
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
+#include <asm/hardware/gic.h>
 
 /*
  * Setup the local clock events for a CPU.
  */
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
-	evt->irq = IRQ_LOCALTIMER;
+	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
 	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.5.2
