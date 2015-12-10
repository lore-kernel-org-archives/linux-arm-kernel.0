From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 15:14:26 +0100
Subject: [PATCH 2/2] ARM: realview: set up cache correctly on the PB11MPCore
Message-ID: <1449756866-19520-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2 cache comes up in a "safe mode" on the PB11MPCore, as
it has several issues. This sets it up properly with the right
size and associativity, also requiring the outer sync to be
disabled for the machine to boot properly.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 28bd5aea285f..3d9b1b0f4ffc 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -99,6 +99,19 @@
 			     <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		cache-unified;
 		cache-level = <2>;
+		/*
+		 * Override default cache size, sets and
+		 * associativity as these may be erroneously set
+		 * up by boot loader(s), probably for safety
+		 * since th outer sync operation can cause the
+		 * cache to hang unless disabled.
+		 */
+		cache-size = <1048576>; // 1MB
+		cache-sets = <4096>;
+		cache-line-size = <32>;
+		arm,shared-override;
+		arm,parity-enable;
+		arm,outer-sync-disable;
 	};
 
 	scu at 1f000000 {
-- 
2.4.3
