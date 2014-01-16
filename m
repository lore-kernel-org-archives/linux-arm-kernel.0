From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 16 Jan 2014 10:03:24 +0100
Subject: [PATCH 1/2] usb: chipidea: usbmisc: Add support for
 i.MX27/i.MX31 CPUs
In-Reply-To: <52D5E9D4.2050405@gtsys.com.hk>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <1389448908.753471404@f40.i.mail.ru>
 <20140113213146.GM29475@pengutronix.de>
 <1389670245.433347746@f385.i.mail.ru>
 <52D4B4CB.6050609@gtsys.com.hk>
 <20140114134942.GY29475@pengutronix.de>
 <52D5E9D4.2050405@gtsys.com.hk>
Message-ID: <20140116090324.GA25911@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chris,

On Wed, Jan 15, 2014 at 09:52:20AM +0800, Chris Ruehl wrote:
> I have a customized board running OTG/host and USB2/host (USB1 not connected)
> Both ports are connected to a ISP1504 ULPI
Similar for me here, my board has usb2 only with an ISP1504.
> a) I need a rs-gpio to reset in addition to the cs-gpio the ISP1504 (done)
I see there are several new chipidea patches in next-20140116 compared
to next-20140110 what I am using. Is there explicit support for a
cs-gpios property? If so, it's not obvious.

> b) Implement UPLI viewport (IORESOURCE_MEM) and logic to set the
> external power supply.
> The code (b) was rejected and needs rework.
The patch I'm currently using is appended below. It doesn't work yet,
but I think that's because CS isn't set yet. In my machine's dts I'm
using:

&usbphy2 {
        reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
};

&usbh2 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_usbh2>;
        status = "okay";
};

Does this look ok?

I'm out of time currently for this project, but I will search the
mailing list for your patches. If you Cc: on new attempts for b) I will
try to test it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

 arch/arm/boot/dts/imx27-pingrp.h | 14 +++++++++
 arch/arm/boot/dts/imx27.dtsi     | 67 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pingrp.h b/arch/arm/boot/dts/imx27-pingrp.h
index 57ca02f89dff..c4d698fddbc9 100644
--- a/arch/arm/boot/dts/imx27-pingrp.h
+++ b/arch/arm/boot/dts/imx27-pingrp.h
@@ -148,4 +148,18 @@
 	MX27_PAD_UART3_CTS__UART3_CTS 0x0 \
 	MX27_PAD_UART3_RTS__UART3_RTS 0x0
 
+#define MX27_USBH2_PINGRP1 \
+	MX27_PAD_USBH2_CLK__USBH2_CLK 0x0 \
+	MX27_PAD_USBH2_DIR__USBH2_DIR 0x0 \
+	MX27_PAD_USBH2_DATA7__USBH2_DATA7 0x0 \
+	MX27_PAD_USBH2_NXT__USBH2_NXT 0x0 \
+	MX27_PAD_USBH2_STP__USBH2_STP 0x0 \
+	MX27_PAD_CSPI2_SS2__USBH2_DATA4 0x0 \
+	MX27_PAD_CSPI2_SS1__USBH2_DATA3 0x0 \
+	MX27_PAD_CSPI2_SS0__USBH2_DATA6 0x0 \
+	MX27_PAD_CSPI2_SCLK__USBH2_DATA0 0x0 \
+	MX27_PAD_CSPI2_MISO__USBH2_DATA2 0x0 \
+	MX27_PAD_CSPI2_MOSI__USBH2_DATA1 0x0 \
+	MX27_PAD_CSPI1_SS2__USBH2_DATA5 0x0
+
 #endif /* __DTS_IMX27_PINGRP_H */
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 7e98966b1834..391769fb291e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -33,6 +33,9 @@
 		spi0 = &cspi1;
 		spi1 = &cspi2;
 		spi2 = &cspi3;
+		usb0 = &usbotg;
+		usb1 = &usbh1;
+		usb2 = &usbh2;
 	};
 
 	aitc: aitc-interrupt-controller at e0000000 {
@@ -70,6 +73,33 @@
 		};
 	};
 
+	usbphy {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usbphy at 0 {
+			compatible = "usb-nop-xceiv";
+			reg = <0>;
+			clocks = <&clks 75>;
+			clock-names = "main_clk";
+		};
+
+		usbphy1: usbphy at 1 {
+			compatible = "usb-nop-xceiv";
+			reg = <1>;
+			clocks = <&clks 75>;
+			clock-names = "main_clk";
+		};
+
+		usbphy2: usbphy at 2 {
+			compatible = "usb-nop-xceiv";
+			reg = <2>;
+			clocks = <&clks 75>;
+			clock-names = "main_clk";
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -439,6 +469,43 @@
 				iram = <&iram>;
 			};
 
+			usbotg: usb at 10024000 {
+				compatible = "fsl,imx27-usb";
+				reg = <0x10024000 0x200>;
+				interrupts = <56>;
+				clocks = <&clks 15>;
+				fsl,usbmisc = <&usbmisc 0>;
+				fsl,usbphy = <&usbphy0>;
+				status = "disabled";
+			};
+
+			usbh1: usb at 10024200 {
+				compatible = "fsl,imx27-usb";
+				reg = <0x10024200 0x200>;
+				interrupts = <54>;
+				clocks = <&clks 15>;
+				fsl,usbmisc = <&usbmisc 1>;
+				fsl,usbphy = <&usbphy1>;
+				status = "disabled";
+			};
+
+			usbh2: usb at 10024400 {
+				compatible = "fsl,imx27-usb";
+				reg = <0x10024400 0x200>;
+				interrupts = <55>;
+				clocks = <&clks 15>;
+				fsl,usbmisc = <&usbmisc 2>;
+				fsl,usbphy = <&usbphy2>;
+				status = "disabled";
+			};
+
+			usbmisc: usbmisc at 10024600 {
+				#index-cells = <1>;
+				compatible = "fsl,imx27-usbmisc";
+				reg = <0x10024600 0x200>;
+				clocks = <&clks 62>;
+			};
+
 			sahara2: sahara at 10025000 {
 				compatible = "fsl,imx27-sahara";
 				reg = <0x10025000 0x1000>;
-- 
1.8.5.2
