From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 24 Mar 2017 13:11:32 -0700
Subject: [RFT PATCH 0/6] pinctrl: meson: Fix gpio-ranged for GPIO Hog
In-Reply-To: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 23 Mar 2017 17:27:23 +0100")
References: <1490286449-19448-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2poh6h1u3.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Whem trying to add a gpio hog to enable the USB Hub on the Odroid-C2, I
> encountered a strange bug where when calling gpiochip_add_data() the gpiolib
> code was trying to add the Hog but failed because the gpio ranges were missing.
>
> In the meson-pinctrl driver, the gpio ranges are added manually /after/ the
> call to gpiochip_add_data().
> The arch/arm meson8 and meson8b patches has not been tested, this is why this
> patchset is an RFT.
>
> So this patchset uses the DT gpio-ranges attribute instead and solves the issue.
>
> The final patch is the actual GPIO Hog for the Odroid-C2 board, which is an ugly
> hack but is necessary to have USB Ports working on the board until the generic
> power sequence framework is merged.
>
> Neil Armstrong (6):
>   ARM64: dts: meson-gxbb: Add gpio-ranges properties
>   ARM64: dts: meson-gxl: Add gpio-ranges properties
>   ARM: dts: meson8: Add gpio-ranges properties
>   ARM: dts: meson8b: Add gpio-ranges properties
>   pinctrl: meson: use gpio-ranges from DT
>   ARM64: dts: meson-gxbb: Add USB Hub GPIO hog

Not sure what kind of extra testing is needed on meson8*, but I tested
on meson8b-odroidc1 by replacing the heartbeat LED GPIO with a GPIO
hog[1] and see the LED turn on and stay on, so it seems good to me.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

[1]
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index e50f1a1fdbc7..d750d6b4c9f1 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -60,6 +60,7 @@
 		reg = <0x40000000 0x40000000>;
 	};
 
+/*
 	leds {
 		compatible = "gpio-leds";
 		blue {
@@ -69,10 +70,18 @@
 			default-state = "off";
 		};
 	};
+*/
 };
 
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
+
+       usb-hub {
+               gpio-hog;
+               gpios = <GPIOAO_13 GPIO_ACTIVE_HIGH>;
+               output-high;
+               line-name = "usb-hub-reset";
+       };
 };
