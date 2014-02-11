From: jasbirm66@gmail.com (Jasbir Matharu)
Date: Tue, 11 Feb 2014 19:33:11 +0000
Subject: Toggling gpio pins while powering down
Message-ID: <CAFXY0108eWG_zZKb9TYGKEF6dpXhY9QuPfQpP0VnF4O4n-YFog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to determine the correct way of toggling gpio pins when the
soc is powering down to enter low power mode. My current crude
implementation is perform these within a pm_power_off function however
this is currently done within the board file by checking for a
compatible board type (ugly). The alternative would be create a driver
and implement the pm_power_off function within. However given there
could many drivers implementing a pm_power_off functions there's no
guarantee mine will be called? Another requirement is that the gpio
need to be set in the correct order.

diff --git a/arch/arm/boot/dts/imx6q-udoo.dts b/arch/arm/boot/dts/imx6q-udoo.dts
index 0ce92cd..e5e2af9 100644
--- a/arch/arm/boot/dts/imx6q-udoo.dts
+++ b/arch/arm/boot/dts/imx6q-udoo.dts
@@ -62,6 +62,13 @@
  compatible = "fsl,mxc_v4l2_output";
  status = "okay";
  };
+
+ poweroff {
+ compatible = "udoo,poweroff";
+ sam3x_rst_gpio = <&gpio1 0 0>;
+ pwr_5v_gpio = <&gpio2 4 0>;
+ };
+
 };

 &hdmi_audio {
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index f24c231..3fea3fd 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -34,6 +34,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/of_net.h>
+#include <linux/delay.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
@@ -336,6 +337,55 @@ static const struct of_dev_auxdata
imx6q_auxdata_lookup[] __initconst = {
  { /* sentinel */ }
 };

+#define SNVS_LPCR 0x04
+static void imx6q_poweroff(void)
+{
+ struct device_node *snvs_np, *pwr_off_np;
+ void __iomem *mx6_snvs_base;
+ u32 value;
+ int sam3x_rst_gpio,pwr_5v_gpio;
+
+ snvs_np = of_find_compatible_node(NULL, NULL, "fsl,sec-v4.0-mon-rtc-lp");
+ if (!snvs_np) {
+ pr_warn("failed to find sec-v4.0-mon-rtc-lp node\n");
+ return;
+ }
+
+ mx6_snvs_base = of_iomap(snvs_np, 0);
+ if (!mx6_snvs_base) {
+ pr_warn("failed to map sec-v4.0-mon-rtc-lp\n");
+ goto put_snvs_node;
+ }
+
+    value = readl(mx6_snvs_base + SNVS_LPCR);
+    /*set TOP and DP_EN bit*/
+    writel(value | 0x60, mx6_snvs_base + SNVS_LPCR);
+
+ if (of_machine_is_compatible("udoo,imx6q-udoo")) {
+ // Power down SAM3X and UDOO
+ pwr_off_np = of_find_compatible_node(NULL, NULL, "udoo,poweroff");
+ if (!pwr_off_np) {
+ pr_warn("failed to find udoo,poweroff node\n");
+ goto put_snvs_node;
+ }
+
+ sam3x_rst_gpio = of_get_named_gpio(pwr_off_np, "sam3x_rst_gpio", 0);
+ pwr_5v_gpio = of_get_named_gpio(pwr_off_np, "pwr_5v_gpio", 0);
+ if (gpio_is_valid(sam3x_rst_gpio) && gpio_is_valid(pwr_5v_gpio)) {
+ gpio_request_one(sam3x_rst_gpio, GPIOF_OUT_INIT_LOW,"sam3x_rst_gpio"),
+ msleep(5);
+ gpio_request_one(pwr_5v_gpio, GPIOF_OUT_INIT_HIGH,"pwr_5v_gpio");
+ } else {
+ pr_warn("failed to find sam3x_rst_gpio or pwr_5v_gpio property\n");
+ }
+
+ }
+
+ of_node_put(pwr_off_np);
+put_snvs_node:
+ of_node_put(snvs_np);
+}
+
 static void __init imx6q_init_machine(void)
 {
  struct device *parent;
@@ -353,6 +403,8 @@ static void __init imx6q_init_machine(void)
  imx6_pm_init();
  imx6q_csi_mux_init();
  imx6q_lvds_cabc_init();
+
+ pm_power_off = imx6q_poweroff;
 }
