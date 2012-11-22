From: xiechao.mail@gmail.com (Chao Xie)
Date: Wed, 21 Nov 2012 21:05:10 -0500
Subject: [PATCH 29/29] arm: mmp: devicetree: add usb support for pxa910_dkb
In-Reply-To: <1353549910-988-1-git-send-email-xiechao.mail@gmail.com>
References: <1353549910-988-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1353549910-988-29-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/boot/dts/pxa910.dtsi |   30 ++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/mmp-dt.c    |    5 +++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 825aaca..ea6c71a 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -44,6 +44,36 @@
 				reg = <0xd4282000 0x1000>;
 				mrvl,intc-nr-irqs = <64>;
 			};
+			usbphy: usbphy at d4207000 {
+				compatible = "mrvl,pxa910-usb-phy";
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
 
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index 033cc31..5044552 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -45,6 +45,11 @@ static const struct of_dev_auxdata pxa910_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4037000, "pxa2xx-i2c.1", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
+	OF_DEV_AUXDATA("mrvl,pxa910-usb-phy", 0xd4207000, "pxa910-usb-phy", NULL),
+	OF_DEV_AUXDATA("mrvl,mv-udc", 0xd4208100, "mv-udc", NULL),
+	OF_DEV_AUXDATA("mrvl,mv-otg", 0xd4208100, "mv-otg", NULL),
+	OF_DEV_AUXDATA("mrvl,mv-udc", 0xd4208100, "mv-ehci", NULL),
+
 	{}
 };
 
-- 
1.7.4.1
