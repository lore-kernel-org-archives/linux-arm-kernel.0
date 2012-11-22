From: xiechao.mail@gmail.com (Chao Xie)
Date: Wed, 21 Nov 2012 21:05:09 -0500
Subject: [PATCH 28/29] arm: mmp: devicetree: add usb support for mmp2
In-Reply-To: <1353549910-988-1-git-send-email-xiechao.mail@gmail.com>
References: <1353549910-988-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1353549910-988-28-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Enable usb devices for mmp2 device tree.

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/boot/dts/mmp2.dtsi |   30 ++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/mmp2-dt.c |    4 ++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 0514fb4..a645bd3 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -116,6 +116,36 @@
 				reg-names = "mux status", "mux mask";
 				mrvl,intc-nr-irqs = <2>;
 			};
+			usbphy: usbphy at d4207000 {
+				compatible = "mrvl,mmp2-usb-phy";
+				clocks = "usb_clk";
+				reg = <0xd4207000 0x1ff>;
+			};
+			udc: udc at d4208100 {
+				compatible = "mrvl,mv-udc";
+				clocks = "usb_clk";
+				extern_attr = <0>;
+				mode = <0>;
+				reg = <0xd4208100 0x1ff>;
+				interrupts = <44>;
+			};
+			otg: otg at d4208100 {
+				compatible = "mrvl,mv-otg";
+				clocks = "usb_clk";
+				extern_attr = <0>;
+				mode = <0>;
+				force_a_bus_req = <1>;
+				disable_clock_gating = <1>;
+				reg = <0xd4208100 0x1ff>;
+				interrupts = <44>;
+			};
+			ehci: ehci at d4208100 {
+				compatible = "mrvl,mv-ehci";
+				clocks = "usb_clk";
+				mode = <0>;
+				reg = <0xd4208100 0x1ff>;
+				interrupts = <44>;
+			};
 		};
 
 		apb at d4000000 {	/* APB */
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 535a5ed..17ec2c4 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -37,6 +37,10 @@ static const struct of_dev_auxdata mmp2_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4025000, "pxa2xx-i2c.1", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp2-usb-phy", 0xd4207000, "mmp2-usb-phy", NULL),
+	OF_DEV_AUXDATA("mrvl,mv-udc", 0xd4208100, "mv-udc", NULL),
+	OF_DEV_AUXDATA("mrvl,mv-otg", 0xd4208100, "mv-otg", NULL),
+	OF_DEV_AUXDATA("mrvl,mv-udc", 0xd4208100, "mv-ehci", NULL),
 	{}
 };
 
-- 
1.7.4.1
