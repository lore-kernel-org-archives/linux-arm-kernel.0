From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 May 2018 16:35:41 -0700
Subject: [PATCH 3/4] ARM: dts: Configure duovero for to allow core retention
 during idle
In-Reply-To: <20180517233542.30629-1-tony@atomide.com>
References: <20180517233542.30629-1-tony@atomide.com>
Message-ID: <20180517233542.30629-4-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By reconfiguring few GPIOs in the dts file we can make duovero parlor
hit retention during idle:

1. Let's a larger debounce value for gpio-keys

This will then make gpio-keys use software debounce and the GPIO
debounce clock is not enabled.

2. Let's allow WLAN suspend for mwifiex

This can be done just by adding keep-power-in-suspend.

3. Let's reconfigure smsc911x driver to use GPIO edge interrupt

This will allow using NFSroot while the system idles, and the kernel
has quite a few dts files with "smsc,lan9115" compatible using edge
interrupts.

Then to have the system hit core retention during idle, the UARTs
needs to be idled and USB modules need to be unloaded or unbound.

Cc: Ash Charles <ash@gumstix.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 3 ++-
 arch/arm/boot/dts/omap4-duovero.dtsi       | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -36,6 +36,7 @@
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;	/* gpio_121 */
+			debounce-interval = <10>;
 			wakeup-source;
 		};
 	};
@@ -140,7 +141,7 @@
 	ethernet at gpmc {
 		reg = <5 0 0xff>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;		/* gpio_44 */
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;	/* gpio_44 */
 
 		phy-mode = "mii";
 
diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -248,6 +248,7 @@
 	ti,bus-width = <4>;
 	ti,non-removable;
 	cap-power-off-card;
+	keep-power-in-suspend;
 };
 
 &twl_usb_comparator {
-- 
2.17.0
