From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 30 Jun 2015 09:45:22 +0200
Subject: [PATCH 2/7] ARM: shmobile: r8a7740 dtsi: Add missing "gpio-ranges" to
 gpio node
In-Reply-To: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
References: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1435650327-2542-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a GPIO driver uses gpiochip_add_pin_range() (which is usually the
case for GPIO/PFC combos), the GPIO hogging mechanism configured from DT
doesn't work:

    requesting hog GPIO lcd0 (chip r8a7740_pfc, offset 176) failed

The actual error code is -517 == -EPROBE_DEFER.

The problem is that PFC+GPIO registration is handled in multiple steps:
  1. pinctrl_register(),
  2. gpiochip_add(),
  3. gpiochip_add_pin_range().

Configuration of the hogs is handled in gpiochip_add():

    gpiochip_add
        of_gpiochip_add
            of_gpiochip_scan_hogs
                gpiod_hog
                    gpiochip_request_own_desc
                        __gpiod_request
                            chip->request
                                pinctrl_request_gpio
                                    pinctrl_get_device_gpio_range

However, at this point the GPIO controller hasn't been added to
pinctrldev_list yet, so the range can't be found, and the operation fails
with -EPROBE_DEFER.

To fix this, add a "gpio-ranges" property to the gpio device node, so
the range is added by of_gpiochip_add_pin_range(), which is called by
of_gpiochip_add() before the call to of_gpiochip_scan_hogs().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 3aaab195132bfc2c..15977b5834de9579 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -316,6 +316,7 @@
 		      <0xe605800c 0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		gpio-ranges = <&pfc 0 0 212>;
 		interrupts-extended =
 			<&irqpin0 0 0>, <&irqpin0 1 0>, <&irqpin0 2 0>, <&irqpin0 3 0>,
 			<&irqpin0 4 0>, <&irqpin0 5 0>, <&irqpin0 6 0>, <&irqpin0 7 0>,
-- 
1.9.1
