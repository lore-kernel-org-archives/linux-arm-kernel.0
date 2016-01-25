From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Jan 2016 09:30:56 +0100
Subject: [PATCH 2/2] ARM: versatile: move restart to the device tree
Message-ID: <1453710656-14280-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a power/reset driver for the Versatile family
in drivers/power/reset so let's just activate that driver
and use it and get rid of some non-DT remnants.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-versatile/Kconfig        |  3 +++
 arch/arm/mach-versatile/versatile_dt.c | 13 -------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index e40f777ccf7d..b0cc26284fc9 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -8,8 +8,11 @@ config ARCH_VERSATILE
 	select COMMON_CLK_VERSATILE
 	select CPU_ARM926T
 	select ICST
+	select MFD_SYSCON
 	select MIGHT_HAVE_PCI
 	select PLAT_VERSATILE
+	select POWER_RESET
+	select POWER_RESET_VERSATILE
 	select VERSATILE_FPGA_IRQ
 	help
 	  This enables support for ARM Ltd Versatile board.
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index c44871851255..cf8a4ea6311a 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -345,18 +345,6 @@ static void __init versatile_init_early(void)
 	       __io_address(VERSATILE_SCTL_BASE));
 }
 
-static void versatile_restart(enum reboot_mode mode, const char *cmd)
-{
-	u32 val;
-
-	val = readl(versatile_sys_base + VERSATILE_SYS_RESETCTL_OFFSET);
-	val |= 0x105;
-
-	writel(0xa05f, versatile_sys_base + VERSATILE_SYS_LOCK_OFFSET);
-	writel(val, versatile_sys_base + VERSATILE_SYS_RESETCTL_OFFSET);
-	writel(0, versatile_sys_base + VERSATILE_SYS_LOCK_OFFSET);
-}
-
 static void __init versatile_dt_pci_init(void)
 {
 	u32 val;
@@ -420,5 +408,4 @@ DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
 	.init_early	= versatile_init_early,
 	.init_machine	= versatile_dt_init,
 	.dt_compat	= versatile_dt_match,
-	.restart	= versatile_restart,
 MACHINE_END
-- 
2.4.3
