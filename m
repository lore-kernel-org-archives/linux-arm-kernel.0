From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 30 Mar 2015 20:16:23 -0700
Subject: [PATCH 1/2] ASoC: cygnus-audio: adding device tree bindings
In-Reply-To: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lori Hikichi <lhikichi@broadcom.com>

Add device tree binding documentation for the Cygnus SOC audio block

Reviewed-by: Jonathan Richardson <jonathar@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Lori Hikichi <lhikichi@broadcom.com>
---
 .../bindings/sound/brcm,cygnus-audio.txt           | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
new file mode 100644
index 0000000..5358cc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
@@ -0,0 +1,68 @@
+BROADCOM Cygnus Audio I2S/TDM/SPDIF controller
+
+Required properties:
+	- compatible : "brcm,cygnus-audio"
+	- #address-cells: 32bit valued, 1 cell. <1>
+	- #size-cells:  32bit valued, 1 cell. <1>
+	- reg : Should contain audio registers location and length
+	- interrupts: audio DMA interrupt number
+
+SSP Subnode properties:
+- dai-name: The name of the DAI registered with ASOC
+- ssp-port-id: The ssp port interface to use
+	Valid value are 0, 1, 2, or 3 (for spdif)
+- mode: Controls if this port should be configured as I2S or TDM mode.
+	Valid values are: "tdm" or "i2s"
+- tdm-bits-per-frame:  only if mode is "tdm" then this property must set.
+	Valid values are (128/256/512)
+- port-status: Controls if port is enabled or not
+	Valid values "enabled" or "disabled"
+- channel-group: Control grouping of serial port
+	Valid values are "2_0", "3_1", or "5_1"
+
+Example:
+	cygnus_audio: audio at 0x180ae000 {
+		compatible = "brcm,cygnus-audio";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x180ae000 0x1000>;
+
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+
+		ssp0: ssp_port at 0 {
+			dai-name = "cygnus-ssp0";
+			ssp-port-id = <0>;
+
+			mode = "i2s"; /* "i2s" or "tdm" */
+			channel-group = "2_0"; /* Use 2_0, 3_1, 5_1 */
+			port-status = "enabled";
+		};
+
+		ssp1: ssp_port at 1 {
+			dai-name = "cygnus-ssp1";
+			ssp-port-id = <1>;
+
+			mode = "i2s"; /* "i2s" or "tdm" */
+			channel-group = "2_0"; /* Use 2_0, 3_1, 5_1 */
+			port-status = "disabled";
+		};
+
+		ssp2: ssp_port at 2 {
+			dai-name = "cygnus-ssp2";
+			ssp-port-id = <2>;
+
+			mode = "tdm"; /* "i2s" or "tdm" */
+			tdm-bits-per-frame = <256>;
+			channel-group = "2_0"; /* Use 2_0, 3_1, 5_1 */
+			port-status = "disabled";
+		};
+
+		spdif: spdif_port at 3 {
+			dai-name = "cygnus-spdif";
+			ssp-port-id = <3>;
+
+			mode = "i2s"; /* "i2s" or "tdm" */
+			channel-group = "2_0"; /* Use 2_0, 3_1, 5_1 */
+			port-status = "disabled";
+		};
+	};
-- 
2.3.3
