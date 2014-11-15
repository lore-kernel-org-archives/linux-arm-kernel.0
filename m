From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sat, 15 Nov 2014 19:49:17 +0200
Subject: [PATCH 1/3] staging: imx-drm: document internal HDMI I2C master
 controller DT binding
In-Reply-To: <1416073759-19939-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1416073759-19939-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1416073759-19939-2-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide information about how to bind internal iMX6Q/DL HDMI DDC I2C
master controller. The property is set as optional one, because iMX6
HDMI DDC bus may be represented by one of general purpose I2C busses
found on SoC.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: linux-media at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-i2c at vger.kernel.org
---
 Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt b/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
index 1b756cf..43c8924 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
@@ -10,6 +10,8 @@ Required properties:
  - #address-cells : should be <1>
  - #size-cells : should be <0>
  - compatible : should be "fsl,imx6q-hdmi" or "fsl,imx6dl-hdmi".
+   If internal HDMI DDC I2C master controller is supposed to be used,
+   then "simple-bus" should be added to compatible value.
  - gpr : should be <&gpr>.
    The phandle points to the iomuxc-gpr region containing the HDMI
    multiplexer control register.
@@ -22,6 +24,7 @@ Required properties:
 
 Optional properties:
  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
+ - ddc: internal HDMI DDC I2C master controller
 
 example:
 
@@ -32,7 +35,7 @@ example:
         hdmi: hdmi at 0120000 {
                 #address-cells = <1>;
                 #size-cells = <0>;
-                compatible = "fsl,imx6q-hdmi";
+                compatible = "fsl,imx6q-hdmi", "simple-bus";
                 reg = <0x00120000 0x9000>;
                 interrupts = <0 115 0x04>;
                 gpr = <&gpr>;
@@ -40,6 +43,11 @@ example:
                 clock-names = "iahb", "isfr";
                 ddc-i2c-bus = <&i2c2>;
 
+                hdmi_ddc: ddc {
+                        compatible = "fsl,imx6q-hdmi-ddc";
+                        status = "disabled";
+                };
+
                 port at 0 {
                         reg = <0>;
 
-- 
1.7.10.4
