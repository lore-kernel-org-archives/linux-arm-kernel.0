From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  7 Feb 2012 18:27:53 -0200
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
Message-ID: <1328646473-11828-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit c7e963f6 (net/smsc911x: Add regulator support) requires that regulator are provided 
to smsc911x chip.

Provide regulator support to 3ds_debugboard so that mx31pdk/mx27pdk boards can have
ethernet working again.

Tested on a mx31pdk board. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Sascha,

If you think this patch is OK, then I can submit patches for fixing
the other i.MX boards that have smsc911x.

 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 arch/arm/plat-mxc/3ds_debugboard.c   |   42 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a4fb2e..0b437d1 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -126,6 +126,7 @@ CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_MC13XXX=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
index f0ba072..37c9160 100644
--- a/arch/arm/plat-mxc/3ds_debugboard.c
+++ b/arch/arm/plat-mxc/3ds_debugboard.c
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <mach/hardware.h>
 
@@ -61,6 +63,44 @@
 
 static void __iomem *brd_io;
 
+#if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
+static struct regulator_consumer_supply debugboard_smsc_supplies[] = {
+	REGULATOR_SUPPLY("vdd33a", NULL),
+	REGULATOR_SUPPLY("vddvario", NULL),
+};
+
+static struct regulator_init_data debugboard_smsc_init_data = {
+	.constraints	= {
+		.name	= "3V3",
+		.always_on = 1,
+	},
+	.consumer_supplies = debugboard_smsc_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(debugboard_smsc_supplies),
+};
+
+static struct fixed_voltage_config debugboard_smsc_pdata = {
+	.supply_name	= "board-3V3",
+	.microvolts	= 3300000,
+	.gpio		= -EINVAL,
+	.enabled_at_boot = 1,
+	.init_data	= &debugboard_smsc_init_data,
+};
+static struct platform_device debugboard_voltage_regulator = {
+	.name		= "reg-fixed-voltage",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &debugboard_smsc_pdata,
+	},
+};
+static void __init debugboard_add_regulators(void)
+{
+	platform_device_register(&debugboard_voltage_regulator);
+}
+#else
+static void __init debugboard_add_regulators(void) {}
+#endif
+
 static struct resource smsc911x_resources[] = {
 	{
 		.flags = IORESOURCE_MEM,
@@ -187,6 +227,8 @@ int __init mxc_expio_init(u32 base, u32 p_irq)
 	irq_set_irq_type(p_irq, IRQF_TRIGGER_LOW);
 	irq_set_chained_handler(p_irq, mxc_expio_irq_handler);
 
+	debugboard_add_regulators();
+
 	/* Register Lan device on the debugboard */
 	smsc911x_resources[0].start = LAN9217_BASE_ADDR(base);
 	smsc911x_resources[0].end = LAN9217_BASE_ADDR(base) + 0x100 - 1;
-- 
1.7.1
