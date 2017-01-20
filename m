From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 10:50:57 -0800
Subject: [PATCH v7 5/5] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <20170120185057.16206-1-stephen.boyd@linaro.org>
References: <20170120185057.16206-1-stephen.boyd@linaro.org>
Message-ID: <20170120185057.16206-6-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The high-speed phy on qcom SoCs is controlled via the ULPI
viewport.

Cc: <devicetree@vger.kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

phy_set_mode() hook split up to toggle two bits independently
with new set_vbus() hook.

 .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |  78 +++++++
 drivers/phy/Kconfig                                |   8 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-qcom-usb-hs.c                      | 256 +++++++++++++++++++++
 4 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
 create mode 100644 drivers/phy/phy-qcom-usb-hs.c

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
new file mode 100644
index 000000000000..bec77a74bd39
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
@@ -0,0 +1,78 @@
+Qualcomm's USB HS PHY
+
+PROPERTIES
+
+- compatible:
+    Usage: required
+    Value type: <string>
+    Definition: Should contain "qcom,usb-hs-phy" and more specifically one of the
+                following:
+
+                        "qcom,usb-hs-phy-apq8064"
+                        "qcom,usb-hs-phy-msm8916"
+                        "qcom,usb-hs-phy-msm8974"
+
+- #phy-cells:
+    Usage: required
+    Value type: <u32>
+    Definition: Should contain 0
+
+- clocks:
+    Usage: required
+    Value type: <prop-encoded-array>
+    Definition: Should contain clock specifier for the reference and sleep
+                clocks
+
+- clock-names:
+    Usage: required
+    Value type: <stringlist>
+    Definition: Should contain "ref" and "sleep" for the reference and sleep
+                clocks respectively
+
+- resets:
+    Usage: required
+    Value type: <prop-encoded-array>
+    Definition: Should contain the phy and POR resets
+
+- reset-names:
+    Usage: required
+    Value type: <stringlist>
+    Definition: Should contain "phy" and "por" for the phy and POR resets
+                respectively
+
+- v3p3-supply:
+    Usage: required
+    Value type: <phandle>
+    Definition: Should contain a reference to the 3.3V supply
+
+- v1p8-supply:
+    Usage: required
+    Value type: <phandle>
+    Definition: Should contain a reference to the 1.8V supply
+
+- qcom,init-seq:
+    Usage: optional
+    Value type: <u8 array>
+    Definition: Should contain a sequence of ULPI address and value pairs to
+                program into the ULPI_EXT_VENDOR_SPECIFIC area. This is related
+                to Device Mode Eye Diagram test. The addresses are offsets
+		from the ULPI_EXT_VENDOR_SPECIFIC address, for example,
+		<0x1 0x53> would mean "write the value 0x53 to address 0x81".
+
+EXAMPLE
+
+otg: usb-controller {
+	ulpi {
+		phy {
+			compatible = "qcom,usb-hs-phy-msm8974", "qcom,usb-hs-phy";
+			#phy-cells = <0>;
+			clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+			clock-names = "ref", "sleep";
+			resets = <&gcc GCC_USB2A_PHY_BCR>, <&otg 0>;
+			reset-names = "phy", "por";
+			v3p3-supply = <&pm8941_l24>;
+			v1p8-supply = <&pm8941_l6>;
+			qcom,init-seq = /bits/ 8 <0x1 0x63>;
+		};
+	};
+};
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index a430a64981d5..61a22e985831 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -437,6 +437,14 @@ config PHY_QCOM_UFS
 	help
 	  Support for UFS PHY on QCOM chipsets.
 
+config PHY_QCOM_USB_HS
+	tristate "Qualcomm USB HS PHY module"
+	depends on USB_ULPI_BUS
+	select GENERIC_PHY
+	help
+	  Support for the USB high-speed ULPI compliant phy on Qualcomm
+	  chipsets.
+
 config PHY_QCOM_USB_HSIC
 	tristate "Qualcomm USB HSIC ULPI PHY module"
 	depends on USB_ULPI_BUS
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c43c9df5d301..0e4259473d28 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_PHY_STIH407_USB)		+= phy-stih407-usb.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+= phy-qcom-ufs-qmp-14nm.o
+obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
 obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
 obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
diff --git a/drivers/phy/phy-qcom-usb-hs.c b/drivers/phy/phy-qcom-usb-hs.c
new file mode 100644
index 000000000000..50cb40977737
--- /dev/null
+++ b/drivers/phy/phy-qcom-usb-hs.c
@@ -0,0 +1,256 @@
+/**
+ * Copyright (C) 2016 Linaro Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/ulpi/driver.h>
+#include <linux/ulpi/regs.h>
+#include <linux/clk.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of_device.h>
+#include <linux/reset.h>
+#include <linux/usb/of.h>
+
+#include "ulpi_phy.h"
+
+#define ULPI_PWR_CLK_MNG_REG		0x88
+# define ULPI_PWR_OTG_COMP_DISABLE	BIT(0)
+
+#define ULPI_MISC_A			0x96
+# define ULPI_MISC_A_VBUSVLDEXTSEL	BIT(1)
+# define ULPI_MISC_A_VBUSVLDEXT		BIT(0)
+
+
+struct ulpi_seq {
+	u8 addr;
+	u8 val;
+};
+
+struct qcom_usb_hs_phy {
+	struct ulpi *ulpi;
+	struct phy *phy;
+	struct clk *ref_clk;
+	struct clk *sleep_clk;
+	struct regulator *v1p8;
+	struct regulator *v3p3;
+	struct reset_control *reset;
+	struct ulpi_seq *init_seq;
+	enum usb_dr_mode dr_mode;
+};
+
+static int qcom_usb_hs_phy_set_mode(struct phy *phy, enum phy_mode mode)
+{
+	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
+	u8 addr, val = 0;
+	int ret;
+
+	switch (mode) {
+	case PHY_MODE_USB_OTG:
+		switch (uphy->dr_mode) {
+		case USB_DR_MODE_OTG:
+			val |= ULPI_INT_IDGRD;
+		case USB_DR_MODE_PERIPHERAL:
+			val |= ULPI_INT_SESS_VALID;
+		default:
+			break;
+		}
+
+		ret = ulpi_write(uphy->ulpi, ULPI_USB_INT_EN_RISE, val);
+		if (ret)
+			return ret;
+		return ulpi_write(uphy->ulpi, ULPI_USB_INT_EN_FALL, val);
+	case PHY_MODE_USB_DEVICE:
+		addr = ULPI_SET(ULPI_MISC_A);
+		break;
+	case PHY_MODE_USB_HOST:
+		addr = ULPI_CLR(ULPI_MISC_A);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ulpi_write(uphy->ulpi, ULPI_SET(ULPI_PWR_CLK_MNG_REG),
+		   ULPI_PWR_OTG_COMP_DISABLE);
+	return ulpi_write(uphy->ulpi, addr, ULPI_MISC_A_VBUSVLDEXTSEL);
+}
+
+static int qcom_usb_hs_phy_set_vbus(struct phy *phy, int on)
+{
+	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
+	u8 addr, val;
+	int ret;
+
+	if (on)
+		addr = ULPI_SET(ULPI_MISC_A);
+	else
+		addr = ULPI_CLR(ULPI_MISC_A);
+
+	return ulpi_write(uphy->ulpi, addr, ULPI_MISC_A_VBUSVLDEXT);
+}
+
+static int qcom_usb_hs_phy_power_on(struct phy *phy)
+{
+	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
+	struct ulpi *ulpi = uphy->ulpi;
+	const struct ulpi_seq *seq;
+	int ret;
+
+	ret = clk_prepare_enable(uphy->ref_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(uphy->sleep_clk);
+	if (ret)
+		goto err_sleep;
+
+	ret = regulator_set_load(uphy->v1p8, 50000);
+	if (ret < 0)
+		goto err_1p8;
+
+	ret = regulator_enable(uphy->v1p8);
+	if (ret)
+		goto err_1p8;
+
+	ret = regulator_set_voltage_triplet(uphy->v3p3, 3050000, 3300000,
+					    3300000);
+	if (ret)
+		goto err_3p3;
+
+	ret = regulator_set_load(uphy->v3p3, 50000);
+	if (ret < 0)
+		goto err_3p3;
+
+	ret = regulator_enable(uphy->v3p3);
+	if (ret)
+		goto err_3p3;
+
+	for (seq = uphy->init_seq; seq->addr; seq++) {
+		ret = ulpi_write(ulpi, ULPI_EXT_VENDOR_SPECIFIC + seq->addr,
+				 seq->val);
+		if (ret)
+			goto err_ulpi;
+	}
+
+	if (uphy->reset) {
+		ret = reset_control_reset(uphy->reset);
+		if (ret)
+			goto err_ulpi;
+	}
+
+	return 0;
+err_ulpi:
+	regulator_disable(uphy->v3p3);
+err_3p3:
+	regulator_disable(uphy->v1p8);
+err_1p8:
+	clk_disable_unprepare(uphy->sleep_clk);
+err_sleep:
+	clk_disable_unprepare(uphy->ref_clk);
+	return ret;
+}
+
+static int qcom_usb_hs_phy_power_off(struct phy *phy)
+{
+	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
+
+	regulator_disable(uphy->v3p3);
+	regulator_disable(uphy->v1p8);
+	clk_disable_unprepare(uphy->sleep_clk);
+	clk_disable_unprepare(uphy->ref_clk);
+
+	return 0;
+}
+
+static const struct phy_ops qcom_usb_hs_phy_ops = {
+	.power_on = qcom_usb_hs_phy_power_on,
+	.power_off = qcom_usb_hs_phy_power_off,
+	.set_mode = qcom_usb_hs_phy_set_mode,
+	.set_vbus = qcom_usb_hs_phy_set_vbus,
+	.owner = THIS_MODULE,
+};
+
+static int qcom_usb_hs_phy_probe(struct ulpi *ulpi)
+{
+	struct qcom_usb_hs_phy *uphy;
+	struct phy_provider *p;
+	struct clk *clk;
+	struct regulator *reg;
+	struct reset_control *reset;
+	int size;
+	int ret;
+
+	uphy = devm_kzalloc(&ulpi->dev, sizeof(*uphy), GFP_KERNEL);
+	if (!uphy)
+		return -ENOMEM;
+	ulpi_set_drvdata(ulpi, uphy);
+	uphy->ulpi = ulpi;
+	uphy->dr_mode = of_usb_get_dr_mode_by_phy(ulpi->dev.of_node, -1);
+
+	size = of_property_count_u8_elems(ulpi->dev.of_node, "qcom,init-seq");
+	if (size < 0)
+		size = 0;
+	uphy->init_seq = devm_kmalloc_array(&ulpi->dev, (size / 2) + 1,
+					   sizeof(*uphy->init_seq), GFP_KERNEL);
+	if (!uphy->init_seq)
+		return -ENOMEM;
+	ret = of_property_read_u8_array(ulpi->dev.of_node, "qcom,init-seq",
+					(u8 *)uphy->init_seq, size);
+	if (ret && size)
+		return ret;
+	/* NUL terminate */
+	uphy->init_seq[size / 2].addr = uphy->init_seq[size / 2].val = 0;
+
+	uphy->ref_clk = clk = devm_clk_get(&ulpi->dev, "ref");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	uphy->sleep_clk = clk = devm_clk_get(&ulpi->dev, "sleep");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	uphy->v1p8 = reg = devm_regulator_get(&ulpi->dev, "v1p8");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	uphy->v3p3 = reg = devm_regulator_get(&ulpi->dev, "v3p3");
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	uphy->reset = reset = devm_reset_control_get(&ulpi->dev, "por");
+	if (IS_ERR(reset)) {
+		if (PTR_ERR(reset) == -EPROBE_DEFER)
+			return PTR_ERR(reset);
+		uphy->reset = NULL;
+	}
+
+	uphy->phy = devm_phy_create(&ulpi->dev, ulpi->dev.of_node,
+				    &qcom_usb_hs_phy_ops);
+	if (IS_ERR(uphy->phy))
+		return PTR_ERR(uphy->phy);
+
+	phy_set_drvdata(uphy->phy, uphy);
+
+	p = devm_of_phy_provider_register(&ulpi->dev, of_phy_simple_xlate);
+	return PTR_ERR_OR_ZERO(p);
+}
+
+static const struct of_device_id qcom_usb_hs_phy_match[] = {
+	{ .compatible = "qcom,usb-hs-phy", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_usb_hs_phy_match);
+
+static struct ulpi_driver qcom_usb_hs_phy_driver = {
+	.probe = qcom_usb_hs_phy_probe,
+	.driver = {
+		.name = "qcom_usb_hs_phy",
+		.of_match_table = qcom_usb_hs_phy_match,
+	},
+};
+module_ulpi_driver(qcom_usb_hs_phy_driver);
+
+MODULE_DESCRIPTION("Qualcomm USB HS phy");
+MODULE_LICENSE("GPL v2");
-- 
2.10.0.297.gf6727b0
