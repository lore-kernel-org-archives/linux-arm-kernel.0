From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Apr 2016 16:16:40 +0100
Subject: [PATCH 1/5] regulator: st-flashss: Add DT binding documentation for
 flashss regulator.
In-Reply-To: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1460474204-5351-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DT doc for the flashss regulator driver which is
found in stih407 based silicon.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/regulator/st-flashss.txt   | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st-flashss.txt

diff --git a/Documentation/devicetree/bindings/regulator/st-flashss.txt b/Documentation/devicetree/bindings/regulator/st-flashss.txt
new file mode 100644
index 0000000..04324d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st-flashss.txt
@@ -0,0 +1,43 @@
+ST Voltage regulator for FlashSS vsense
+
+This documents the voltage regulator driver which manages the vsense inside the ST flash
+sub-system that is used for configuring MMC, NAND, SPI voltages.
+
+Required properties:
+- compatible:		Can be "st,vqmmc", "st,vnand" or "st,vspi" because it is shared
+			among these devices inside the ST FlashSS.
+- regulator-name:	Regulator name.
+- reg:			The vsense top config base address in the flashSS hardware.
+
+Any property defined as part of the core regulator binding, in
+Documentation/devicetree/bindings/regulator/regulator.txt can also be used.
+
+Example:
+
+vqmmc_reg: voltage-regulator {
+	compatible = "st,vqmmc";
+	regulator-name = "vqmmc0";
+	/* Control register for the VSENSE Module */
+	reg = <0x9061004 0x4>;
+	status = "disabled";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-always-on;
+};
+
+mmc0: sdhci at 09060000 {
+	compatible = "st,sdhci-stih407", "st,sdhci";
+	status = "disabled";
+	reg = <0x09060000 0x7ff>, <0x9061008 0x20>;
+	reg-names = "mmc", "top-mmc-delay";
+	interrupts = <GIC_SPI 92 IRQ_TYPE_NONE>;
+	interrupt-names = "mmcirq";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mmc0>;
+	clock-names = "mmc";
+	clocks = <&clk_s_c0_flexgen CLK_MMC_0>;
+	bus-width = <8>;
+	non-removable;
+	vqmmc-supply = <&vqmmc_reg>;
+};
+
-- 
1.9.1
