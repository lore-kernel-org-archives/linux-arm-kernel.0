From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu,  8 Oct 2015 15:31:12 +0200
Subject: [PATCH v4 1/8] ASoC: dt-bindings: add rockchip tranceiver bindings
In-Reply-To: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1444311079-2892-2-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree bindings for the spdif tranceiver found on
found on rk3066, rk3188 and rk3288 SoCs

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

Changes in v4:
- Require rockchip,grf on RK3288 as the 8 channel solution has to be
  selected on that SoC
- Make the compatibility string one of a known list rather then
  requiring a precise list of options.
- Change the clock names to hclk and mclk instead of spdif_hclk and
  spdif_mclk to better match the implementation and data sheets.

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/sound/rockchip-spdif.txt   | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
new file mode 100644
index 0000000..33dd82c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -0,0 +1,44 @@
+* Rockchip SPDIF transceiver
+
+The S/PDIF audio block is a stereo transceiver that allows the
+processor to receive and transmit digital audio via an coaxial cable or
+a fibre cable.
+
+Required properties:
+
+- compatible: should be one of the following:
+   - "rockchip,rk3288-spdif", "rockchip,rk3188-spdif" or
+     "rockchip,rk3066-spdif"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: should contain the SPDIF interrupt.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+- dmas: DMA specifiers for tx dma. See the DMA client binding,
+  Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should be "tx"
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: should contain following:
+   - "hclk": clock for SPDIF controller
+   - "mclk" : clock for SPDIF bus
+
+Required properties on RK3288:
+  - rockchip,grf: the phandle of the syscon node for the general register
+                   file (GRF)
+
+Example for the rk3188 SPDIF controller:
+
+spdif: spdif at 0x1011e000 {
+	compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
+	reg = <0x1011e000 0x2000>;
+	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	dmas = <&dmac1_s 8>;
+	dma-names = "tx";
+	clock-names = "hclk", "mclk";
+	clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
+	status = "disabled";
+	#sound-dai-cells = <0>;
+};
-- 
2.6.1
