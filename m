From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:18:55 +0200
Subject: [PATCH 20/39] ARM: u300: add FSMC flash into the device tree
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-21-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This registers the U300 FSMC flash controller from the
device tree, and defines the three partitions. Skip the
BBT scan as in the current platform data.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 26 ++++++++++++++++++++++++++
 arch/arm/mach-u300/core.c      |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 1b20769..b8a8ddb 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -77,6 +77,32 @@
 		dma-channels = <40>;
 	};
 
+	/* A NAND flash of 128 MiB */
+	fsmc: flash at 40000000 {
+		compatible = "stericsson,fsmc-nand";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x9f800000 0x1000>,	/* FSMC Register*/
+			<0x80000000 0x4000>,	/* NAND Base DATA */
+			<0x80020000 0x4000>,	/* NAND Base ADDR */
+			<0x80010000 0x4000>;	/* NAND Base CMD */
+		reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
+		nand-skip-bbtscan;
+
+		partition at 0 {
+		label = "boot records";
+			reg = <0x0 0x20000>;
+		};
+		partition at 20000 {
+			label = "free";
+			reg = <0x20000 0x7e0000>;
+		};
+		partition at 800000 {
+			label = "platform";
+			reg = <0x800000 0xf800000>;
+		};
+	};
+
 	i2c0: i2c at c0004000 {
 		compatible = "st,ddci2c";
 		reg = <0xc0004000 0x1000>;
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index d102cb5..8f9e77a 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -733,6 +733,8 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 		"rtc-coh901331", NULL),
 	OF_DEV_AUXDATA("stericsson,coh901318", U300_DMAC_BASE,
 		"coh901318", NULL),
+	OF_DEV_AUXDATA("stericsson,fsmc-nand", U300_NAND_IF_PHYS_BASE,
+		"fsmc-nand", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART0_BASE,
 		"uart0", &uart0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
-- 
1.7.11.3
