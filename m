From: tony@atomide.com (Tony Lindgren)
Date: Tue,  1 Dec 2015 15:38:22 -0800
Subject: [PATCH 09/10] ARM: dts: Fix dm8148 control modules ranges
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Message-ID: <1449013103-23238-10-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The control module is at offset 0x14000 with size 0x20000, not 0x16000.
This causes the pinctrl driver to not work.

Let's also fix the comments related to the TRM "L4LS Instance Summary"
table as that's what's causing the bad entries.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 5c8de19..68b156b 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -58,8 +58,10 @@
 		ti,hwmods = "l3_main";
 
 		/*
-		 * See TRM "Table 1-317. L4LS Instance Summary", just deduct
-		 * 0x1000 from the 1-317 addresses to get the device address
+		 * See TRM "Table 1-317. L4LS Instance Summary" for hints.
+		 * It shows the module target agent registers though, so the
+		 * actual device is typically 0x1000 before the target agent
+		 * except in cases where the module is larger than 0x1000.
 		 */
 		l4ls: l4ls at 48000000 {
 			compatible = "ti,dm814-l4ls", "simple-bus";
@@ -183,10 +185,10 @@
 
 			control: control at 140000 {
 				compatible = "ti,dm814-scm", "simple-bus";
-				reg = <0x140000 0x16d000>;
+				reg = <0x140000 0x20000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 0x160000 0x16d000>;
+				ranges = <0 0x140000 0x20000>;
 
 				scm_conf: scm_conf at 0 {
 					compatible = "syscon";
-- 
2.6.2
