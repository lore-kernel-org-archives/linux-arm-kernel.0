From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Tue, 27 Mar 2012 15:54:01 +0800
Subject: [PATCH] Regulator: anatop-regulator: patching to device-tree property
 "reg".
Message-ID: <1332834841-13925-1-git-send-email-paul.liu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

Change "reg" to "anatop-reg-offset" due to there is a warning of handling no
size field in reg.

This patch also adds the missing device-tree binding documentation.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 .../bindings/regulator/anatop-regulator.txt        |   29 ++++++++++++++++++++
 drivers/regulator/anatop-regulator.c               |    5 ++-
 2 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/anatop-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
new file mode 100644
index 0000000..357758c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
@@ -0,0 +1,29 @@
+Anatop Voltage regulators
+
+Required properties:
+- compatible: Must be "fsl,anatop-regulator"
+- anatop-reg-offset: Anatop MFD register offset
+- anatop-vol-bit-shift: Bit shift for the register
+- anatop-vol-bit-width: Number of bits used in the register
+- anatop-min-bit-val: Minimum value of this register
+- anatop-min-voltage: Minimum voltage of this regulator
+- anatop-max-voltage: Maximum voltage of this regulator
+
+Any property defined as part of the core regulator
+binding, defined in regulator.txt, can also be used.
+
+Example:
+
+	regulator-vddpu {
+		compatible = "fsl,anatop-regulator";
+		regulator-name = "vddpu";
+		regulator-min-microvolt = <725000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-always-on;
+		anatop-reg-offset = <0x140>;
+		anatop-vol-bit-shift = <9>;
+		anatop-vol-bit-width = <5>;
+		anatop-min-bit-val = <1>;
+		anatop-min-voltage = <725000>;
+		anatop-max-voltage = <1300000>;
+	};
diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 17499a5..53969af 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -138,9 +138,10 @@ static int __devinit anatop_regulator_probe(struct platform_device *pdev)
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->owner = THIS_MODULE;
 	sreg->mfd = anatopmfd;
-	ret = of_property_read_u32(np, "reg", &sreg->control_reg);
+	ret = of_property_read_u32(np, "anatop-reg-offset",
+				   &sreg->control_reg);
 	if (ret) {
-		dev_err(dev, "no reg property set\n");
+		dev_err(dev, "no anatop-reg-offset property set\n");
 		goto anatop_probe_end;
 	}
 	ret = of_property_read_u32(np, "anatop-vol-bit-width",
-- 
1.7.9.1
