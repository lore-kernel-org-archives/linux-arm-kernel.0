From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 18:21:31 +0100
Subject: [PATCH 14/14] ARM: dts: imx6: make audmux optional for i.MX6UL sound
 driver
In-Reply-To: <1452619291-13625-14-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-7-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-8-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-9-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-10-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-11-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-12-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-13-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-14-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452619291-13625-15-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6UL does not have the audio multiplexer (AUDMUX) like the other
i.MX6 SoCs, but apart from that can use the same audio driver. Make
audmux optional for the imx-sgtl5000 driver, so it can be used on
i.MX6UL too. Furthermore i.MX6UL requires use of the SAI interface
rather than SSI. Change the DTS documentation accordingly.

The patch with the corresponding changes to the imx-sgtl5000 driver
will be sent separately.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 .../bindings/sound/imx-audio-sgtl5000.txt          | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
index 2f89db8..fd46671 100644
--- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
@@ -6,7 +6,7 @@ Required properties:
 
   - model		: The user-visible name of this sound complex
 
-  - ssi-controller	: The phandle of the i.MX SSI controller
+  - ssi-controller	: The phandle of the i.MX SSI (or SAI) controller
 
   - audio-codec		: The phandle of the SGTL5000 audio codec
 
@@ -39,6 +39,16 @@ Required properties:
 Note: The AUDMUX port numbering should start at 1, which is consistent with
 hardware manual.
 
+Optional properties:
+  - fsl,no-audmux	: boolean
+    			  Required for i.MX6UL (and maybe other SoCs)
+    			  which don't have an AUDMUX, but still
+			  feature the same audio subsystem otherwise.
+
+Note: Setting this property will make mux-int-port and mux-ext-port
+obsolete.
+
+
 Example:
 
 sound {
@@ -54,3 +64,17 @@ sound {
 	mux-int-port = <1>;
 	mux-ext-port = <3>;
 };
+
+or (e.g. for i.MX6UL):
+sound {
+	compatible = "karo,imx6ul-tx6ul-sgtl5000",
+		     "fsl,imx-audio-sgtl5000";
+	model = "imx6ul-tx6ul-sgtl5000";
+	ssi-controller = <&sai2>;
+	audio-codec = <&sgtl5000>;
+	audio-routing =
+		"MIC_IN", "Mic Jack",
+		"Mic Jack", "Mic Bias",
+		"Headphone Jack", "HP_OUT";
+	fsl,no-audmux;
+};
-- 
2.1.4
