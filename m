From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Jan 2013 23:56:20 +0100
Subject: [PATCH 05/11] ARM: nomadik: add FSMC NAND
Message-ID: <1357599380-7490-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the FSMC NAND driver and flash partitions to the Nomadik
device tree.

The only compatible string accepted by this driver is currently
"st,spear600-fsmc-nand" which is inappropriate for this system, so
this patch adds the compatible value "stericsson,fsmc-nand" as
well.

Cc: linux-mtd at vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm requesting an ACK from the MTD maintainers to be able to apply
this patch through the ARM SoC tree.
---
 .../devicetree/bindings/mtd/fsmc-nand.txt          |  2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 38 ++++++++++++++++++++++
 arch/arm/mach-nomadik/cpu-8815.c                   | 15 +++++++++
 drivers/mtd/nand/fsmc_nand.c                       |  1 +
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
index e3ea32e..2240ac0 100644
--- a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
@@ -1,7 +1,7 @@
 * FSMC NAND
 
 Required properties:
-- compatible : "st,spear600-fsmc-nand"
+- compatible : "st,spear600-fsmc-nand", "stericsson,fsmc-nand"
 - reg : Address range of the mtd chip
 - reg-names: Should contain the reg names "fsmc_regs", "nand_data", "nand_addr" and "nand_cmd"
 
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 29986ea..8369eb0 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -32,6 +32,44 @@
 		interrupts = <5>;
 	};
 
+	/* A NAND flash of 128 MiB */
+	fsmc: flash at 40000000 {
+		compatible = "stericsson,fsmc-nand";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x10100000 0x1000	/* FSMC Register*/
+		       0x40000000 0x2000	/* NAND Base DATA */
+		       0x41000000 0x2000	/* NAND Base ADDR */
+		       0x40800000 0x2000>;	/* NAND Base CMD */
+		reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
+		status = "okay";
+
+		partition at 0 {
+		label = "X-Loader(NAND)";
+			reg = <0x0 0x40000>;
+		};
+		partition at 40000 {
+			label = "MemInit(NAND)";
+			reg = <0x40000 0x40000>;
+		};
+		partition at 80000 {
+			label = "BootLoader(NAND)";
+			reg = <0x80000 0x200000>;
+		};
+		partition at 280000 {
+			label = "Kernel zImage(NAND)";
+			reg = <0x280000 0x300000>;
+		};
+		partition at 580000 {
+			label = "Root Filesystem(NAND)";
+			reg = <0x580000 0x1600000>;
+		};
+		partition at 1b80000 {
+			label = "User Filesystem(NAND)";
+			reg = <0x1b80000 0x6480000>;
+		};
+	};
+
 	amba {
 		compatible = "arm,amba-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 10b9f20..6bec72f 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -32,6 +32,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/mtd/fsmc.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -262,6 +263,17 @@ struct sys_timer cpu8815_of_timer = {
 	.init	= cpu8815_timer_init_of,
 };
 
+static struct fsmc_nand_timings cpu8815_nand_timings = {
+	.thiz	= 0,
+	.thold	= 0x10,
+	.twait	= 0x0A,
+	.tset	= 0,
+};
+
+static struct fsmc_nand_platform_data cpu8815_nand_data = {
+	.nand_timings = &cpu8815_nand_timings,
+};
+
 /* These are mostly to get the right device names for the clock lookups */
 static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART0_BASE,
@@ -272,6 +284,9 @@ static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
 		"rng", NULL),
 	OF_DEV_AUXDATA("arm,primecell", NOMADIK_RTC_BASE,
 		"rtc-pl031", NULL),
+	OF_DEV_AUXDATA("stericsson,fsmc-nand", NOMADIK_FSMC_BASE,
+		"fsmc-nand", &cpu8815_nand_data),
+
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 1d74464..dda07c6 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -1218,6 +1218,7 @@ static SIMPLE_DEV_PM_OPS(fsmc_nand_pm_ops, fsmc_nand_suspend, fsmc_nand_resume);
 #ifdef CONFIG_OF
 static const struct of_device_id fsmc_nand_id_table[] = {
 	{ .compatible = "st,spear600-fsmc-nand" },
+	{ .compatible = "stericsson,fsmc-nand" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsmc_nand_id_table);
-- 
1.7.11.7
