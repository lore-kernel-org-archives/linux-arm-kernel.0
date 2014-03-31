From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 31 Mar 2014 17:18:04 +0200
Subject: [PATCH V2 03/19] mmc: mmci: Update DT documentation
In-Reply-To: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1396279100-2920-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document how to configure the regulator supplies and add an example of
a typical mmci DT node.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt |   39 ++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 2b584ca..ff233d1 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -8,8 +8,41 @@ by mmc.txt and the properties used by the mmci driver.
 
 Required properties:
 - compatible             : contains "arm,pl18x", "arm,primecell".
-- arm,primecell-periphid : contains the PrimeCell Peripheral ID.
+- vmmc-supply            : phandle to the regulator device tree node, mentioned
+                           as the VCC/VDD supply in the eMMC/SD specs.
 
 Optional properties:
-- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable
-- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable
+- arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
+                           the ID provided by the HW
+- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
+- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
+- vqmmc-supply           : phandle to the regulator device tree node, mentioned
+                           as the VCCQ/VDD_IO supply in the eMMC/SD specs.
+
+Example:
+
+sdi0_per1 at 80126000 {
+	compatible = "arm,pl18x", "arm,primecell";
+	reg = <0x80126000 0x1000>;
+	interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+
+	dmas = <&dma 29 0 0x2>, /* Logical - DevToMem */
+	       <&dma 29 0 0x0>; /* Logical - MemToDev */
+	dma-names = "rx", "tx";
+
+	clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
+	clock-names = "sdi", "apb_pclk";
+
+	max-frequency = <100000000>;
+	bus-width = <4>;
+	mmc-cap-sd-highspeed;
+	mmc-cap-mmc-highspeed;
+	cd-gpios  = <&gpio2 31 0x4>; // 95
+
+	vmmc-supply = <&ab8500_ldo_aux3_reg>;
+	vqmmc-supply = <&vmmci>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdi0_default_mode>;
+	pinctrl-1 = <&sdi0_sleep_mode>;
+};
-- 
1.7.9.5
