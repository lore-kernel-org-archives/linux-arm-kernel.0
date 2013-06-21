From: gsi@denx.de (Gerhard Sittig)
Date: Fri, 21 Jun 2013 20:09:57 +0200
Subject: [PATCH v1 11/12] input: keypad-matrix: AC14xx device tree update
In-Reply-To: <1371838198-7327-1-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
Message-ID: <1371838198-7327-12-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- catchup in the 'ifm AC14xx' board's device tree with recently added
  keypad-matrix driver features: individual pin polarity for rows and
  columns, push/pull pin operation for columns
- slight re-ordering of keypad-matrix related settings, and tuning of
  timing specs for more reliable detection of short lived key presses
  (including a range spec to reduce timer management overhead) as well
  as a slightly increased overall matrix poll frequency
- fix keymap comments, make the names match the codes

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/ac14xx.dts |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index a27a460..502cc37 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -350,13 +350,14 @@
 		matrix_keypad at 0 {
 			compatible = "gpio-matrix-keypad";
 			debounce-delay-ms = <5>;
-			col-scan-delay-us = <1>;
-			gpio-activelow;
-			col-gpios-binary;
-			col-switch-delay-ms = <200>;
+			col-scan-delay-us = <5 100>;
+			col-switch-delay-ms = <15>;
 
+			col-gpios-binary;
+			col-gpios-pushpull;
 			col-gpios = <&gpio_pic 1 0>;	/* pin1 */
 
+			row-gpios-activelow;
 			row-gpios = <&gpio_pic 2 0	/* pin2 */
 				     &gpio_pic 3 0	/* pin3 */
 				     &gpio_pic 4 0>;	/* pin4 */
@@ -365,8 +366,8 @@
 					0x01000067	/* UP */
 					0x02000066	/* FN RIGHT */
 					0x00010069	/* LEFT */
-					0x0101006a	/* DOWN */
-					0x0201006c>;	/* RIGHT */
+					0x0101006a	/* RIGHT */
+					0x0201006c>;	/* DOWN */
 		};
 	};
 
-- 
1.7.10.4
