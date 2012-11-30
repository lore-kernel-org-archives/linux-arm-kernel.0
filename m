From: horms@verge.net.au (Simon Horman)
Date: Fri, 30 Nov 2012 17:44:42 +0900
Subject: [PATCH 2/5] ARM: mach-shmobile: sh73a0: Minimal setup using DT
In-Reply-To: <1354265085-2444-1-git-send-email-horms@verge.net.au>
References: <1354265085-2444-1-git-send-email-horms@verge.net.au>
Message-ID: <1354265085-2444-3-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Horman <horms+renesas@verge.net.au>

Allow a minimal setup of the sh73a0 SoC using a flattened device tree.

* Configure the i2c controllers using a flattened device tree.

SCI serial controller and CMT clock source, whose drivers do not yet
support configuration using a flattened device tree, are still configured
using C code in order to allow booting of a board with this SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v2
* Add extra entries to clock-sh73a0.c:lookups[] and
  remove auxdata. Ultimtely the clocks will be described
  in DT, but the code isn't there yet.
* Use shmobile_setup_delay() and perform late initialisation of clocks
---
 arch/arm/boot/dts/sh73a0.dtsi                |   60 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c        |    5 +++
 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 arch/arm/mach-shmobile/setup-sh73a0.c        |   39 ++++++++++++++++-
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 77c8e43..fc7f0fd 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -38,4 +38,64 @@
 		reg = <0xf0001000 0x1000>,
 		      <0xf0000100 0x100>;
 	};
+
+	i2c0: i2c at 0xe6820000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6820000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 0x4
+			      0 168 0x4
+			      0 169 0x4
+			      0 170 0x4>;
+	};
+
+	i2c1: i2c at 0xe6822000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6822000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 51 0x4
+			      0 52 0x4
+			      0 53 0x4
+			      0 54 0x4>;
+	};
+
+	i2c2: i2c at 0xe6824000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6824000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 171 0x4
+			      0 172 0x4
+			      0 173 0x4
+			      0 174 0x4>;
+	};
+
+	i2c3: i2c at 0xe6826000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6826000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 183 0x4
+			      0 184 0x4
+			      0 185 0x4
+			      0 186 0x4>;
+	};
+
+	i2c4: i2c at 0xe6828000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6828000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 187 0x4
+			      0 188 0x4
+			      0 189 0x4
+			      0 190 0x4>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 516ff7f..8bc7a2b 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -545,6 +545,7 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
+	CLKDEV_DEV_ID("e6824000.i2c", &mstp_clks[MSTP001]), /* I2C2 */
 	CLKDEV_DEV_ID("sh_mobile_ceu.1", &mstp_clks[MSTP129]), /* CEU1 */
 	CLKDEV_DEV_ID("sh-mobile-csi2.1", &mstp_clks[MSTP128]), /* CSI2-RX1 */
 	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[MSTP127]), /* CEU0 */
@@ -553,6 +554,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP125]), /* TMU01 */
 	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
+	CLKDEV_DEV_ID("e6820000.i2c", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]), /* SY-DMAC */
@@ -569,6 +571,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI */
 	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
+	CLKDEV_DEV_ID("e6822000.i2c", &mstp_clks[MSTP323]), /* I2C1 */
 	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP322]), /* USB */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
@@ -579,7 +582,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("leds-renesas-tpu.30", &mstp_clks[MSTP301]), /* TPU3 */
 	CLKDEV_DEV_ID("leds-renesas-tpu.41", &mstp_clks[MSTP300]), /* TPU4 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
+	CLKDEV_DEV_ID("e6826000.i2c", &mstp_clks[MSTP411]), /* I2C3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
+	CLKDEV_DEV_ID("e6828000.i2c", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
 };
 
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index b50447e..06b905e 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -52,7 +52,9 @@ extern void sh73a0_init_irq(void);
 extern void sh73a0_init_irq_dt(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_add_early_devices(void);
+extern void sh73a0_add_early_devices_dt(void);
 extern void sh73a0_add_standard_devices(void);
+extern void sh73a0_add_standard_devices_dt(void);
 extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
 extern struct clk sh73a0_extal1_clk;
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index eab1bae..f8bdac4 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
@@ -35,6 +36,7 @@
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
@@ -779,7 +781,7 @@ static struct platform_device pmu_device = {
 	.resource	= pmu_resources,
 };
 
-static struct platform_device *sh73a0_early_devices[] __initdata = {
+static struct platform_device *sh73a0_early_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
@@ -790,6 +792,9 @@ static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif7_device,
 	&scif8_device,
 	&cmt10_device,
+};
+
+static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&tmu00_device,
 	&tmu01_device,
 };
@@ -812,6 +817,8 @@ void __init sh73a0_add_standard_devices(void)
 	/* Clear software reset bit on SY-DMAC module */
 	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
 
+	platform_add_devices(sh73a0_early_devices_dt,
+			    ARRAY_SIZE(sh73a0_early_devices_dt));
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
 	platform_add_devices(sh73a0_late_devices,
@@ -830,6 +837,8 @@ static void __init sh73a0_earlytimer_init(void)
 
 void __init sh73a0_add_early_devices(void)
 {
+	early_platform_add_devices(sh73a0_early_devices_dt,
+				   ARRAY_SIZE(sh73a0_early_devices_dt));
 	early_platform_add_devices(sh73a0_early_devices,
 				   ARRAY_SIZE(sh73a0_early_devices));
 
@@ -839,3 +848,31 @@ void __init sh73a0_add_early_devices(void)
 	/* override timer setup with soc-specific code */
 	shmobile_timer.init = sh73a0_earlytimer_init;
 }
+
+#ifdef CONFIG_USE_OF
+static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
+	{},
+};
+
+void __init sh73a0_add_early_devices_dt(void)
+{
+	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
+
+	early_platform_add_devices(sh73a0_early_devices_dt,
+				   ARRAY_SIZE(sh73a0_early_devices_dt));
+
+	/* setup early console here as well */
+	shmobile_setup_console();
+}
+
+void __init sh73a0_add_standard_devices_dt(void)
+{
+	/* clocks are setup late during boot in the case of DT */
+	sh73a0_clock_init();
+
+	platform_add_devices(sh73a0_early_devices_dt,
+			     ARRAY_SIZE(sh73a0_early_devices_dt));
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     sh73a0_auxdata_lookup, NULL);
+}
+#endif /* CONFIG_USE_OF */
-- 
1.7.10.4
