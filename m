From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 May 2018 16:35:42 -0700
Subject: [PATCH 4/4] omap4-droid4: Use software debounce for gpio-keys
In-Reply-To: <20180517233542.30629-1-tony@atomide.com>
References: <20180517233542.30629-1-tony@atomide.com>
Message-ID: <20180517233542.30629-5-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default value of 5ms will use GPIO hardware based debounce clocks
that will keep L4PER from idling consuming about extra 30mW.

Use a value of 10ms that is above the hardware debounce maximum of
7.95ms forcing software based debouncing.

This allows droid4 to enter PER retention during idle as long as UARTs
are idled and USB modules unloaded or unbound.

Note that there seems to be a pending issue with having droid 4 enter core
retention during idle where GPIO bank 1 needs to be reset late after init
for some reason to not block core retention. In addition to that, we are
also missing GPIO related PM runtime calls for omap4 that will be posted
separately.

Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -128,6 +128,7 @@
 			gpios = <&gpio5 26 GPIO_ACTIVE_LOW>; /* gpio154 */
 			linux,code = <KEY_VOLUMEDOWN>;
 			linux,can-disable;
+			debounce-interval = <10>;
 		};
 
 		slider {
@@ -136,7 +137,7 @@
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_KEYPAD_SLIDE>;
 			linux,can-disable;
-
+			debounce-interval = <10>;
 		};
 	};
 
-- 
2.17.0
