From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Apr 2013 11:53:20 +0200
Subject: [PATCH 08/23] ARM: u300: register I2C bus drivers from device tree
Message-ID: <1366624400-6364-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds the two I2C busses to the device tree so these
probe properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 18 ++++++++++++++++++
 arch/arm/mach-u300/core.c      |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 80f963c..9c08d5e 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -49,6 +49,24 @@
 		reg = <0xc0011000 0x1000>;
 	};
 
+	i2c0: i2c at c0004000 {
+		compatible = "st,ddci2c";
+		reg = <0xc0004000 0x1000>;
+		interrupt-parent = <&vicb>;
+		interrupts = <8>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	i2c1: i2c at c0005000 {
+		compatible = "st,ddci2c";
+		reg = <0xc0005000 0x1000>;
+		interrupt-parent = <&vicb>;
+		interrupts = <9>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	amba {
 		compatible = "arm,amba-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 5b42983..fedad38 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -713,6 +713,10 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 		"uart0", &uart0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", U300_UART1_BASE,
 		"uart1", &uart1_plat_data),
+	OF_DEV_AUXDATA("st,ddci2c", U300_I2C0_BASE,
+		"stu300.0", NULL),
+	OF_DEV_AUXDATA("st,ddci2c", U300_I2C1_BASE,
+		"stu300.1", NULL),
 	OF_DEV_AUXDATA("arm,primecell", U300_MMCSD_BASE,
 		"mmci", &mmcsd_platform_data),
 	{ /* sentinel */ },
-- 
1.7.11.3
