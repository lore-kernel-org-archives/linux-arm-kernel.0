From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 16:24:32 -0700
Subject: [PATCH 2/3] ARM: dts: add rk3288 ehci usb devices
In-Reply-To: <1406676273-20701-1-git-send-email-dianders@chromium.org>
References: <1406676273-20701-1-git-send-email-dianders@chromium.org>
Message-ID: <1406676273-20701-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3288 has two kind of usb controller; this adds the ehci variant for
host0 and hsic.

At the moment we don't add any phys for these controllers, but the
default settings seem to work OK.

There is a hardware problem in ohci controller which make it
unavailable and host0 controller can only support high-speed devices.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 3ef8951..0bb4480 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -251,6 +251,26 @@
 		status = "disabled";
 	};
 
+	usb_host0_ehci: ehci at ff500000 {
+		compatible = "generic-ehci";
+		reg = <0xff500000 0x100>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USBHOST0>;
+		clock-names = "usbhost";
+		status = "disabled";
+	};
+
+	/* NOTE: ohci at ff520000 doesn't actually work on hardware */
+
+	usb_hsic: ehci at ff5c0000 {
+		compatible = "generic-ehci";
+		reg = <0xff5c0000 0x100>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HSIC>;
+		clock-names = "usbhost";
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at ffc01000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.0.0.526.g5318336
