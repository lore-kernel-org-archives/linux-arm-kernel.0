From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:55 +0100
Subject: [PATCH v5 04/11] staging: imx-drm: Document imx-hdmi device tree
 bindings
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree binding documentation for the HDMI transmitter
on i.MX6.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v4:
 - Fixed copy&paste documentation error
 - Added optional 'ddc-i2c-bus' property
---
 .../devicetree/bindings/staging/imx-drm/hdmi.txt   | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt b/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
new file mode 100644
index 0000000..1b756cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
@@ -0,0 +1,58 @@
+Device-Tree bindings for HDMI Transmitter
+
+HDMI Transmitter
+================
+
+The HDMI Transmitter is a Synopsys DesignWare HDMI 1.4 TX controller IP
+with accompanying PHY IP.
+
+Required properties:
+ - #address-cells : should be <1>
+ - #size-cells : should be <0>
+ - compatible : should be "fsl,imx6q-hdmi" or "fsl,imx6dl-hdmi".
+ - gpr : should be <&gpr>.
+   The phandle points to the iomuxc-gpr region containing the HDMI
+   multiplexer control register.
+ - clocks, clock-names : phandles to the HDMI iahb and isrf clocks, as described
+   in Documentation/devicetree/bindings/clock/clock-bindings.txt and
+   Documentation/devicetree/bindings/clock/imx6q-clock.txt.
+ - port@[0-4]: Up to four port nodes with endpoint definitions as defined in
+   Documentation/devicetree/bindings/media/video-interfaces.txt,
+   corresponding to the four inputs to the HDMI multiplexer.
+
+Optional properties:
+ - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
+
+example:
+
+	gpr: iomuxc-gpr at 020e0000 {
+		/* ... */
+	};
+
+        hdmi: hdmi at 0120000 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                compatible = "fsl,imx6q-hdmi";
+                reg = <0x00120000 0x9000>;
+                interrupts = <0 115 0x04>;
+                gpr = <&gpr>;
+                clocks = <&clks 123>, <&clks 124>;
+                clock-names = "iahb", "isfr";
+                ddc-i2c-bus = <&i2c2>;
+
+                port at 0 {
+                        reg = <0>;
+
+                        hdmi_mux_0: endpoint {
+                                remote-endpoint = <&ipu1_di0_hdmi>;
+                        };
+                };
+
+                port at 1 {
+                        reg = <1>;
+
+                        hdmi_mux_1: endpoint {
+                                remote-endpoint = <&ipu1_di1_hdmi>;
+                        };
+                };
+        };
-- 
1.9.0.rc3
