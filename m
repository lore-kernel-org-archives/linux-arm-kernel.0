From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 17 Nov 2011 18:19:23 +0200
Subject: [PATCH 09/10] arm/tegra: implement support for tegra30
In-Reply-To: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1321546766-26770-10-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for tegra30 SoC. This includes a device tree compatible type for
this SoC ("nvidia,tegra30") and adds L2 cache initialization for this new SoC.
The clock framework is still missing, which prevents most drivers from working.
The basic IRQs are the same, so remove the dependency on
CONFIG_ARCH_TEGRA_2x_SOC.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig             |   18 +++++++++++++-----
 arch/arm/mach-tegra/board-dt.c          |    8 ++++++++
 arch/arm/mach-tegra/board.h             |    1 +
 arch/arm/mach-tegra/common.c            |    7 +++++++
 arch/arm/mach-tegra/include/mach/irqs.h |    2 --
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 2b1d49b..aad54ca 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -2,11 +2,8 @@ if ARCH_TEGRA
 
 comment "NVIDIA Tegra options"
 
-choice
-	prompt "Select Tegra processor family for target system"
-
 config ARCH_TEGRA_2x_SOC
-	bool "Tegra 2 family"
+	bool "Enable support for Tegra20 family"
 	select CPU_V7
 	select ARM_GIC
 	select ARCH_REQUIRE_GPIOLIB
@@ -17,7 +14,18 @@ config ARCH_TEGRA_2x_SOC
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
 
-endchoice
+config ARCH_TEGRA_3x_SOC
+	bool "Enable support for Tegra30 family"
+	select CPU_V7
+	select ARM_GIC
+	select ARCH_REQUIRE_GPIOLIB
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
+	select USB_ULPI if USB_SUPPORT
+	select USB_ULPI_VIEWPORT if USB_SUPPORT
+	select USE_OF
+	help
+	  Support for NVIDIA Tegra T30 processor family, based on the
+	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
 
 config TEGRA_PCI
 	bool "PCI Express support"
diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index 416446b..0b9d184 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -149,3 +149,11 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
 	.init_machine	= tegra_dt_init,
 	.dt_compat	= tegra20_dt_board_compat,
 MACHINE_END
+DT_MACHINE_START(TEGRA30_DT, "nVidia Tegra30 (Flattened Device Tree)")
+	.map_io		= tegra_map_common_io,
+	.init_early	= tegra30_init_early,
+	.init_irq	= tegra_init_irq,
+	.timer		= &tegra_timer,
+	.init_machine	= tegra_dt_init,
+	.dt_compat	= tegra30_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index b86cdab..708b330a 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 
 void __init tegra20_init_early(void);
+void __init tegra30_init_early(void);
 void __init tegra_map_common_io(void);
 void __init tegra_init_irq(void);
 void __init tegra_init_clock(void);
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 896a6c7..b6d1fe5 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -98,3 +98,10 @@ void __init tegra20_init_early(void)
 	tegra_common_init();
 }
 #endif
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+void __init tegra30_init_early(void)
+{
+	tegra_init_cache(0x441, 0x551);
+	tegra_common_init();
+}
+#endif
diff --git a/arch/arm/mach-tegra/include/mach/irqs.h b/arch/arm/mach-tegra/include/mach/irqs.h
index 73265af..a2146cd 100644
--- a/arch/arm/mach-tegra/include/mach/irqs.h
+++ b/arch/arm/mach-tegra/include/mach/irqs.h
@@ -25,7 +25,6 @@
 
 #define IRQ_LOCALTIMER                  29
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
 /* Primary Interrupt Controller */
 #define INT_PRI_BASE			(INT_GIC_BASE + 32)
 #define INT_TMR1			(INT_PRI_BASE + 0)
@@ -178,6 +177,5 @@
 #define NR_BOARD_IRQS			32
 
 #define NR_IRQS				(INT_BOARD_BASE + NR_BOARD_IRQS)
-#endif
 
 #endif
-- 
1.7.7.rc0.72.g4b5ea.dirty
