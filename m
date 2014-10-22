From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 22 Oct 2014 14:07:39 -0500
Subject: [PATCHv4 2/3] ARM: dts: socfpga: Fix SD card detect
In-Reply-To: <1414004860-17645-1-git-send-email-dinguyen@opensource.altera.com>
References: <1414004860-17645-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1414004860-17645-3-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Without this patch, the booting the SOCFPGA platform would hang at the
SDMMC driver loading. The issue, debugged by Doug Anderson, turned out
to be that the GPIO bank used by the SD card-detect was not set to
status="okay".

Also update the cd-gpios to point to portb of the &gpio1 GPIO IP.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v4: Use &gpio1 to set status="okay" and update cd-gpio=&portb
v3: Correctly degugged the issue to be a gpio node not having status="okay"
---
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index d7296a5..d91c943 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -53,6 +53,10 @@
 	rxc-skew-ps = <2000>;
 };
 
+&gpio1 {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -69,7 +73,7 @@
 };
 
 &mmc0 {
-	cd-gpios = <&gpio1 18 0>;
+	cd-gpios = <&portb 18 0>;
 };
 
 &usb1 {
-- 
2.0.3
