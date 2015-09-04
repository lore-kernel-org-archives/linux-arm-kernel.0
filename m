From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri,  4 Sep 2015 10:33:37 +0000
Subject: [PATCH] ARM: dt: bcm2835: set mmc clock to the correct value of 250MHz
Message-ID: <1441362818-4323-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This patch sets the clock speed to 250MHz to make the SD card
work at the correct clock speed without overclocking by 2.5.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Analysis with a logic-analyzer found that the current setting
of the mmc clock at 100MHz is wrong and results in overclocking
the SD-card and eMMC on the Compute Module.

Exact measurements show that when 25Mhz are selected by the sdhci
driver effectively 62.5MHz are used (so 2.5 times faster), which is
what is expected when the clock is configured to a fixed 100MHz
instead of the 250MHz that the clock is actually running at.

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..591f202 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -170,7 +170,7 @@
 			reg = <0>;
 			#clock-cells = <0>;
 			clock-output-names = "mmc";
-			clock-frequency = <100000000>;
+			clock-frequency = <250000000>;
 		};
 
 		clk_i2c: clock at 1 {
-- 
1.7.10.4
