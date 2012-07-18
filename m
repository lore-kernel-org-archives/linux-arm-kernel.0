From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 18 Jul 2012 18:29:07 +0800
Subject: [PATCH v2 2/2] ARM: dts: imx6q-sabrelite: add usbmisc device
In-Reply-To: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342607348-8587-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi          |   19 +++++++++++++++----
 arch/arm/mach-imx/clk-imx6q.c         |    1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index d42e851..c66ff9d 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -62,12 +62,16 @@
 		aips-bus at 02100000 { /* AIPS2 */
 			usb at 02184000 { /* USB OTG */
 				vbus-supply = <&reg_usb_otg_vbus>;
+				disable-over-current;
 				status = "okay";
 			};
 
 			usb at 02184200 { /* USB1 */
 				status = "okay";
 			};
+			usbmisc at 02184800 {
+				status = "okay";
+			};
 
 			ethernet at 02188000 {
 				phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index c25d495..42b0c39 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -19,6 +19,11 @@
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+
+		usb0 = &usbotg;
+		usb1 = &usbhost1;
+		usb2 = &usbhost2;
+		usb3 = &usbhost3;
 	};
 
 	cpus {
@@ -624,7 +629,7 @@
 				reg = <0x0217c000 0x4000>;
 			};
 
-			usb at 02184000 { /* USB OTG */
+			usbotg: usb at 02184000 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184000 0x200>;
 				interrupts = <0 43 0x04>;
@@ -632,7 +637,7 @@
 				status = "disabled";
 			};
 
-			usb at 02184200 { /* USB1 */
+			usbhost1: usb at 02184200 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 0x04>;
@@ -640,20 +645,26 @@
 				status = "disabled";
 			};
 
-			usb at 02184400 { /* USB2 */
+			usbhost2: usb at 02184400 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 0x04>;
 				status = "disabled";
 			};
 
-			usb at 02184600 { /* USB3 */
+			usbhost3: usb at 02184600 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 0x04>;
 				status = "disabled";
 			};
 
+			usbmisc at 02184800 {
+				compatible = "fsl,imx6q-usbmisc";
+				reg = <0x02184800 0x200>;
+				status = "disabled";
+			};
+
 			ethernet at 02188000 {
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index ea89520..660fcbb 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -405,6 +405,7 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[usboh3], NULL, "2184200.usb");
 	clk_register_clkdev(clk[usboh3], NULL, "2184400.usb");
 	clk_register_clkdev(clk[usboh3], NULL, "2184600.usb");
+	clk_register_clkdev(clk[usboh3], NULL, "2184800.usbmisc");
 	clk_register_clkdev(clk[usbphy1], NULL, "20c9000.usbphy");
 	clk_register_clkdev(clk[usbphy2], NULL, "20ca000.usbphy");
 	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
-- 
1.7.9.5
