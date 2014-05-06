From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 06 May 2014 17:51:17 +0900
Subject: [PATCH v2 1/6] i2c: s3c2410: Moving I2C interrupt re-configuration
 code into i2c driver
In-Reply-To: <1399366282-4191-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399366282-4191-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399366282-4191-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's move I2C interrupt re-configuration code from machine
file exynos.c to I2C driver. Since only Exynos5250, and
Exynos5420 need to do this, added syscon based phandle to
i2c device nodes of respective SoC DT files.

CC: Rob Herring <robh+dt@kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>
CC: Wolfram Sang <wsa@the-dreams.de>
CC: Russell King <linux@arm.linux.org.uk>
CC: devicetree at vger.kernel.org
CC: linux-doc at vger.kernel.org
CC: linux-i2c at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 .../devicetree/bindings/arm/samsung/sysreg.txt     |    1 +
 arch/arm/boot/dts/exynos5.dtsi                     |    5 ++++
 arch/arm/boot/dts/exynos5250.dtsi                  |    4 +++
 arch/arm/boot/dts/exynos5420.dtsi                  |    4 +++
 arch/arm/mach-exynos/exynos.c                      |   26 -------------------
 drivers/i2c/busses/i2c-s3c2410.c                   |   27 ++++++++++++++++++++
 6 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/sysreg.txt b/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
index 0ab3251..fd71581 100644
--- a/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/sysreg.txt
@@ -3,6 +3,7 @@ SAMSUNG S5P/Exynos SoC series System Registers (SYSREG)
 Properties:
  - compatible : should contain "samsung,<chip name>-sysreg", "syscon";
    For Exynos4 SoC series it should be "samsung,exynos4-sysreg", "syscon";
+   For Exynos5 SoC series it should be "samsung,exynos5-sysreg", "syscon";
  - reg : offset and length of the register set.
 
 Example:
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 79d0608..3027e37 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -99,4 +99,9 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	sys_reg: syscon at 10050000 {
+		compatible = "samsung,exynos5-sysreg", "syscon";
+		reg = <0x10050000 0x400>;
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 8d724d5..46f0233 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -285,6 +285,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_bus>;
+		samsung,syscon-phandle = <&sys_reg>;
 		status = "disabled";
 	};
 
@@ -298,6 +299,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c1_bus>;
+		samsung,syscon-phandle = <&sys_reg>;
 		status = "disabled";
 	};
 
@@ -311,6 +313,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_bus>;
+		samsung,syscon-phandle = <&sys_reg>;
 		status = "disabled";
 	};
 
@@ -324,6 +327,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
+		samsung,syscon-phandle = <&sys_reg>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ff496ad..762128c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -517,6 +517,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_bus>;
+		samsung,syscon-phandle = <&sys_reg>;
 		status = "disabled";
 	};
 
@@ -530,6 +531,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c1_bus>;
+		samsung,syscon-phandle = <&sys_reg>;
 		status = "disabled";
 	};
 
@@ -543,6 +545,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_bus>;
+		samsung,syscon-phandle = <&sys_reg>;
 		status = "disabled";
 	};
 
@@ -556,6 +559,7 @@
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
+		samsung,syscon-phandle = <&sys_reg>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 59eb1f1..54ae2e1 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -293,32 +293,6 @@ void __init exynos_map_pmu(void)
 
 static void __init exynos_dt_machine_init(void)
 {
-	struct device_node *i2c_np;
-	const char *i2c_compat = "samsung,s3c2440-i2c";
-	unsigned int tmp;
-	int id;
-
-	/*
-	 * Exynos5's legacy i2c controller and new high speed i2c
-	 * controller have muxed interrupt sources. By default the
-	 * interrupts for 4-channel HS-I2C controller are enabled.
-	 * If node for first four channels of legacy i2c controller
-	 * are available then re-configure the interrupts via the
-	 * system register.
-	 */
-	if (soc_is_exynos5()) {
-		for_each_compatible_node(i2c_np, NULL, i2c_compat) {
-			if (of_device_is_available(i2c_np)) {
-				id = of_alias_get_id(i2c_np, "i2c");
-				if (id < 4) {
-					tmp = readl(EXYNOS5_SYS_I2C_CFG);
-					writel(tmp & ~(0x1 << id),
-							EXYNOS5_SYS_I2C_CFG);
-				}
-			}
-		}
-	}
-
 	exynos_map_pmu();
 
 	if (!soc_is_exynos5440())
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index ae44910..0420150 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -39,6 +39,8 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include <asm/irq.h>
 
@@ -91,6 +93,9 @@
 /* Max time to wait for bus to become idle after a xfer (in us) */
 #define S3C2410_IDLE_TIMEOUT	5000
 
+/* Exynos5 Sysreg offset */
+#define EXYNOS5_SYS_I2C_CFG	0x0234
+
 /* i2c controller state */
 enum s3c24xx_i2c_state {
 	STATE_IDLE,
@@ -127,6 +132,7 @@ struct s3c24xx_i2c {
 #if defined(CONFIG_ARM_S3C24XX_CPUFREQ)
 	struct notifier_block	freq_transition;
 #endif
+	struct regmap		*sysreg;
 };
 
 static struct platform_device_id s3c24xx_driver_ids[] = {
@@ -1075,6 +1081,8 @@ static void
 s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 {
 	struct s3c2410_platform_i2c *pdata = i2c->pdata;
+	unsigned int tmp;
+	int id;
 
 	if (!np)
 		return;
@@ -1084,6 +1092,25 @@ s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 	of_property_read_u32(np, "samsung,i2c-slave-addr", &pdata->slave_addr);
 	of_property_read_u32(np, "samsung,i2c-max-bus-freq",
 				(u32 *)&pdata->frequency);
+	/*
+	 * Exynos5's legacy i2c controller and new high speed i2c
+	 * controller have muxed interrupt sources. By default the
+	 * interrupts for 4-channel HS-I2C controller are enabled.
+	 * If node for first four channels of legacy i2c controller
+	 * are available then re-configure the interrupts via the
+	 * system register.
+	 */
+	id = of_alias_get_id(np, "i2c");
+	i2c->sysreg = syscon_regmap_lookup_by_phandle(np,
+			"samsung,syscon-phandle");
+	if (IS_ERR(i2c->sysreg)) {
+		i2c->sysreg = NULL;
+		/* As this is not compulsary do not return error */
+		pr_info("i2c-%d skipping re-configuration of interrutps\n", id);
+		return;
+	}
+	regmap_read(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, &tmp);
+	regmap_write(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, tmp & ~(0x1 << id));
 }
 #else
 static void
-- 
1.7.10.4
