From: petr@barix.com (Petr Kulhavy)
Date: Mon,  9 May 2016 16:35:19 +0200
Subject: [PATCH v5 1/4] ASoC: davinci-mcbsp: add binding for McBSP
In-Reply-To: <1462804522-29544-1-git-send-email-petr@barix.com>
References: <1462804522-29544-1-git-send-email-petr@barix.com>
Message-ID: <1462804522-29544-2-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree binding for the TI DA850/OMAP-L138/AM18xx
MultiChannel Buffered Serial Port (McBSP)

The optional register range "dat" is not implemented at the moment.
The current driver supports only DMA into RX/TX registers but no FIFO.
Once the FIFO is implemented in the driver the "dat" range will be used.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
v1: initial
v2: add missing TC channel in dmas properties (for compatibility with the new EDMA3 binding)
    remove "-audio" postfix from the compatible string
    remove "channel-combine" property
v3: remove the index note from the "mpu" property.
    specify exactly the supported platforms in compatible string
v4: minor correction in the example ("interrupt names"), re-added index note to the "mpu" property.
v5: example updated to match da850.dtsi: using "sound@" and removed leading zeros from the reg property

 .../devicetree/bindings/sound/davinci-mcbsp.txt    | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
new file mode 100644
index 000000000000..e9184ff3c2fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
@@ -0,0 +1,52 @@
+Texas Instruments DaVinci McBSP module
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
+audio interface found in some TI DaVinci processors like the OMAP-L138 or AM180x.
+
+
+Required properties:
+~~~~~~~~~~~~~~~~~~~~
+- compatible :
+        "ti,da850-mcbsp" : for DA850, AM180x and OPAM-L138 platforms
+
+- reg : physical base address and length of the controller memory mapped
+        region(s).
+- reg-names : Should contain:
+        * "mpu" for the main registers (required). For compatibility
+          with the existing software, this is required to be the first entry.
+        * "dat" for the data FIFO (optional).
+
+- dmas: three element list of DMA controller phandles, DMA request line and
+	TC channel ordered triplets.
+- dma-names: identifier string for each DMA request line in the dmas property.
+	These strings correspond 1:1 with the ordered pairs in dmas. The dma
+	identifiers must be "rx" and "tx".
+
+Optional properties:
+~~~~~~~~~~~~~~~~~~~~
+- interrupts : Interrupt numbers for McBSP
+- interrupt-names : Known interrupt names are "rx" and "tx"
+
+- pinctrl-0: Should specify pin control group used for this controller.
+- pinctrl-names: Should contain only one value - "default", for more details
+        please refer to pinctrl-bindings.txt
+
+Example (AM1808):
+~~~~~~~~~~~~~~~~~
+
+mcbsp0: sound at 110000 {
+	compatible = "ti,da850-mcbsp";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp0_pins>;
+
+	reg = 	<0x110000 0x1000>,
+		<0x310000 0x1000>;
+	reg-names = "mpu", "dat";
+	interrupts = <97 98>;
+	interrupt-names = "rx", "tx";
+	dmas = <&edma0 3 1
+		&edma0 2 1>;
+	dma-names = "tx", "rx";
+	status = "okay";
+};
-- 
1.9.1
