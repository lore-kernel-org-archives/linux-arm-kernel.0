From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 28 Feb 2017 16:09:16 -0800
Subject: [PATCH v4] soc/imx: Add GPCv2 power gating driver
Message-ID: <20170301000916.32412-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code allowing for control of various power domains managed by GPCv2
IP block found in i.MX7 series of SoCs. Power domains covered by this
patch are:

    - PCIE PHY
    - MIPI PHY
    - USB HSIC PHY
    - USB OTG1/2 PHY

Support for any other power domain controlled by GPC is not present, and
can be added at some later point.

Testing of this code was done against a PCIe driver.

Cc: yurovsky at gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since v3 (see [v3]):

	- Minor device tree bindings documentation fixes as per
          feedback from Rob Herring
	- Collect Acked-by from Rob

Changes since v2 (see [v2]):

	- Fix a critical bug where incorrect state of a bit was
          expected in a busy wait loop (bit set instead of bit
          cleared) imx7_gpc_pu_pgc_sw_pxx_req()

	- Add missing step (setting of PCR in GPC_PGC_nCTRL) in power
          down procedure

Changes since v1 (see [v1]):

	- Various small DT bindings description fixes as per feedback
          from Rob Herring


[v1] https://lkml.org/lkml/2017/2/6/554
[v2] https://lkml.org/lkml/2017/2/13/489
[v3] https://lkml.org/lkml/2017/2/20/338

 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  71 ++++
 drivers/soc/imx/Makefile                           |   2 +-
 drivers/soc/imx/gpcv2.c                            | 397 +++++++++++++++++++++
 include/dt-bindings/power/imx7-power.h             |  18 +
 4 files changed, 487 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
 create mode 100644 drivers/soc/imx/gpcv2.c
 create mode 100644 include/dt-bindings/power/imx7-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
new file mode 100644
index 0000000..02f45c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
@@ -0,0 +1,71 @@
+Freescale i.MX General Power Controller v2
+==========================================
+
+The i.MX7S/D General Power Control (GPC) block contains Power Gating
+Control (PGC) for various power domains.
+
+Required properties:
+
+- compatible: Should be "fsl,imx7d-gpc"
+
+- reg: should be register base and length as documented in the
+  datasheet
+
+- interrupts: Should contain GPC interrupt request 1
+
+Power domains contained within GPC node are generic power domain
+providers, documented in
+Documentation/devicetree/bindings/power/power_domain.txt, which are
+described as subnodes of the power gating controller 'pgc' node,
+which, in turn, is expected to contain the following:
+
+Required properties:
+
+- reg: Power domain index. Valid values are defined in
+  include/dt-bindings/power/imx7-power.h
+
+- #power-domain-cells: Should be 0
+
+Optional properties:
+
+- power-supply: Power supply used to power the domain
+
+Example:
+
+	gpc: gpc at 303a0000 {
+		compatible = "fsl,imx7d-gpc";
+		reg = <0x303a0000 0x1000>;
+		interrupt-controller;
+		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+
+		pgc {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pgc_pcie_phy: power-domain at 3 {
+				#power-domain-cells = <0>;
+
+				reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
+				power-supply = <&reg_1p0d>;
+			};
+		};
+	};
+
+
+Specifying power domain for IP modules
+======================================
+
+IP cores belonging to a power domain should contain a 'power-domains'
+property that is a phandle for PGC node representing the domain.
+
+Example of a device that is part of the PCIE_PHY power domain:
+
+	pcie: pcie at 33800000 {
+	      reg = <0x33800000 0x4000>,
+	            <0x4ff00000 0x80000>;
+		/* ... */
+		power-domains = <&pgc_pcie_phy>;
+		/* ... */
+	};
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 35861f5..7bcc933 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1 +1 @@
-obj-y += gpc.o
+obj-y += gpc.o gpcv2.o
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
new file mode 100644
index 0000000..20f0515
--- /dev/null
+++ b/drivers/soc/imx/gpcv2.c
@@ -0,0 +1,397 @@
+/*
+ * Copyright 2017 Impinj, Inc
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * Based on the code of analogus driver:
+ *
+ * Copyright 2015-2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <dt-bindings/power/imx7-power.h>
+
+#define GPC_PGC_CPU_MAPPING	0xec
+#define USB_HSIC_PHY_A7_DOMAIN	BIT(6)
+#define USB_OTG2_PHY_A7_DOMAIN	BIT(5)
+#define USB_OTG1_PHY_A7_DOMAIN	BIT(4)
+#define PCIE_PHY_A7_DOMAIN	BIT(3)
+#define MIPI_PHY_A7_DOMAIN	BIT(2)
+
+#define GPC_PU_PGC_SW_PUP_REQ	0xf8
+#define GPC_PU_PGC_SW_PDN_REQ	0x104
+#define USB_HSIC_PHY_SW_Pxx_REQ	BIT(4)
+#define USB_OTG2_PHY_SW_Pxx_REQ	BIT(3)
+#define USB_OTG1_PHY_SW_Pxx_REQ	BIT(2)
+#define PCIE_PHY_SW_Pxx_REQ	BIT(1)
+#define MIPI_PHY_SW_Pxx_REQ	BIT(0)
+
+#define GPC_MAX_REGISTER	0x1000
+
+#define GPC_PGC_nCTRL_PCR	BIT(0)
+
+struct imx7_pgc_domain {
+	struct generic_pm_domain genpd;
+	struct regmap *regmap;
+	struct regulator *regulator;
+
+	unsigned int pgc_nctrl;
+
+	const struct {
+		u32 pxx;
+		u32 map;
+	} bits;
+
+	const int voltage;
+	struct device *dev;
+};
+
+static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
+				      bool on)
+{
+	int ret = 0;
+	unsigned long deadline;
+	struct imx7_pgc_domain *domain = container_of(genpd,
+						      struct imx7_pgc_domain,
+						      genpd);
+	unsigned int offset = (on) ?
+		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
+
+	const bool has_regulator = !IS_ERR(domain->regulator);
+	const bool enable_power_control = domain->pgc_nctrl && !on;
+
+	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+			   domain->bits.map, domain->bits.map);
+	if (has_regulator && on) {
+		ret = regulator_enable(domain->regulator);
+		if (ret) {
+			dev_err(domain->dev, "failed to enable regulator\n");
+			goto unmap;
+		}
+	}
+
+	if (enable_power_control)
+		regmap_update_bits(domain->regmap, domain->pgc_nctrl,
+				   GPC_PGC_nCTRL_PCR, GPC_PGC_nCTRL_PCR);
+
+
+	regmap_update_bits(domain->regmap, offset,
+			   domain->bits.pxx, domain->bits.pxx);
+	/*
+	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
+	 * for PUP_REQ/PDN_REQ bit to be cleared
+	 */
+	deadline = jiffies + msecs_to_jiffies(1);
+	while (true) {
+		u32 pxx_req;
+
+		regmap_read(domain->regmap, offset, &pxx_req);
+
+		if (!(pxx_req & domain->bits.pxx))
+			break;
+
+		if (time_after(jiffies, deadline)) {
+			dev_err(domain->dev, "falied to command PGC\n");
+			ret = -ETIMEDOUT;
+			/*
+			 * If we were in a process of enabling a
+			 * domain and failed we might as well disable
+			 * the regulator we just enabled. And if it
+			 * was the opposite situation and we failed to
+			 * power down -- keep the regulator on
+			 */
+			on  = !on;
+			break;
+		}
+
+		cpu_relax();
+	}
+
+	if (enable_power_control)
+		regmap_update_bits(domain->regmap, domain->pgc_nctrl,
+				   GPC_PGC_nCTRL_PCR, 0);
+
+	if (has_regulator && !on) {
+		int err;
+
+		err = regulator_disable(domain->regulator);
+		if (err)
+			dev_err(domain->dev,
+				"failed to disable regulator: %d\n", ret);
+		/*
+		 * Preserve earlier error code
+		 */
+		ret = ret ?: err;
+	}
+unmap:
+	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
+			   domain->bits.map, 0);
+	return ret;
+}
+
+static int imx7_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
+{
+	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, true);
+}
+
+static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
+{
+	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
+}
+
+static struct imx7_pgc_domain imx7_pgc_domains[] = {
+	[IMX7_POWER_DOMAIN_USB_HSIC_PHY] = {
+		.genpd = {
+			.name      = "usb-hsic-phy",
+			.power_on  = imx7_gpc_pu_pgc_sw_pup_req,
+			.power_off = imx7_gpc_pu_pgc_sw_pdn_req,
+		},
+		.bits  = {
+			.pxx = USB_HSIC_PHY_SW_Pxx_REQ,
+			.map = USB_HSIC_PHY_A7_DOMAIN,
+		},
+		.voltage   = 1200000,
+		.pgc_nctrl = 0x0d00,
+	},
+
+	[IMX7_POWER_DOMAIN_USB_OTG2_PHY] = {
+		.genpd = {
+			.name      = "usb-otg2-phy",
+			.power_on  = imx7_gpc_pu_pgc_sw_pup_req,
+			.power_off = imx7_gpc_pu_pgc_sw_pdn_req,
+		},
+		.bits  = {
+			.pxx = USB_OTG2_PHY_SW_Pxx_REQ,
+			.map = USB_OTG2_PHY_A7_DOMAIN,
+		},
+	},
+
+	[IMX7_POWER_DOMAIN_USB_OTG1_PHY] = {
+		.genpd = {
+			.name      = "usb-otg1-phy",
+			.power_on  = imx7_gpc_pu_pgc_sw_pup_req,
+			.power_off = imx7_gpc_pu_pgc_sw_pdn_req,
+		},
+		.bits  = {
+			.pxx = USB_OTG1_PHY_SW_Pxx_REQ,
+			.map = USB_OTG1_PHY_A7_DOMAIN,
+		},
+	},
+
+	[IMX7_POWER_DOMAIN_PCIE_PHY] = {
+		.genpd = {
+			.name      = "pcie-phy",
+			.power_on  = imx7_gpc_pu_pgc_sw_pup_req,
+			.power_off = imx7_gpc_pu_pgc_sw_pdn_req,
+		},
+		.bits  = {
+			.pxx = PCIE_PHY_SW_Pxx_REQ,
+			.map = PCIE_PHY_A7_DOMAIN,
+		},
+		.voltage   = 1000000,
+		.pgc_nctrl = 0x0c40,
+	},
+
+	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
+		.genpd = {
+			.name      = "mipi-phy",
+			.power_on  = imx7_gpc_pu_pgc_sw_pup_req,
+			.power_off = imx7_gpc_pu_pgc_sw_pdn_req,
+		},
+		.bits  = {
+			.pxx = MIPI_PHY_SW_Pxx_REQ,
+			.map = MIPI_PHY_A7_DOMAIN,
+		},
+		.voltage   = 1000000,
+		.pgc_nctrl = 0x0c00,
+	},
+};
+
+static int imx7_pgc_domain_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
+
+	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
+		return 0;
+
+	domain->dev = &pdev->dev;
+
+	ret = pm_genpd_init(&domain->genpd, NULL, true);
+	if (ret) {
+		dev_err(domain->dev, "Failed to init power domain\n");
+		return ret;
+	}
+
+	domain->regulator = devm_regulator_get_optional(domain->dev, "power");
+	if (IS_ERR(domain->regulator)  &&
+	    PTR_ERR(domain->regulator) != -ENODEV) {
+		dev_err(domain->dev, "Failed to get domain's regulator\n");
+		return PTR_ERR(domain->regulator);
+	}
+
+	if (!IS_ERR(domain->regulator)) {
+		WARN_ON(!domain->voltage);
+		regulator_set_voltage(domain->regulator,
+				      domain->voltage, domain->voltage);
+	}
+
+	ret = of_genpd_add_provider_simple(domain->dev->of_node,
+					   &domain->genpd);
+	if (ret) {
+		dev_err(domain->dev, "Failed to add genpd provider\n");
+		pm_genpd_remove(&domain->genpd);
+	}
+
+	return ret;
+}
+
+static int imx7_pgc_domain_remove(struct platform_device *pdev)
+{
+	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
+
+	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
+		of_genpd_del_provider(domain->dev->of_node);
+		pm_genpd_remove(&domain->genpd);
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id imx7_pgc_domain_id[] = {
+	{ "imx7-pgc-domain", },
+	{ },
+};
+
+static struct platform_driver imx7_pgc_domain_driver = {
+	.driver = {
+		.name = "imx7-pgc",
+	},
+	.probe    = imx7_pgc_domain_probe,
+	.remove   = imx7_pgc_domain_remove,
+	.id_table = imx7_pgc_domain_id,
+};
+builtin_platform_driver(imx7_pgc_domain_driver)
+
+static bool imx_gpcv2_readable_reg(struct device *dev, unsigned int reg)
+{
+	return reg % 4 == 0 &&
+	       reg <= GPC_MAX_REGISTER;
+}
+
+static bool imx_gpcv2_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == GPC_PU_PGC_SW_PUP_REQ ||
+	       reg == GPC_PU_PGC_SW_PDN_REQ;
+}
+
+static int imx_gpcv2_probe(struct platform_device *pdev)
+{
+	int ret;
+	void __iomem *base;
+	struct resource *res;
+	struct regmap *regmap;
+	struct device *dev = &pdev->dev;
+	struct device_node *pgc_np, *np;
+
+	static const struct regmap_config regmap_config = {
+		.cache_type	= REGCACHE_FLAT,
+		.reg_bits	= 32,
+		.val_bits	= 32,
+		.reg_stride	= 4,
+
+		.readable_reg	= imx_gpcv2_readable_reg,
+		.volatile_reg	= imx_gpcv2_volatile_reg,
+
+		.max_register	= GPC_MAX_REGISTER,
+	};
+
+	pgc_np = of_get_child_by_name(dev->of_node, "pgc");
+	if (!pgc_np) {
+		dev_err(dev, "No power domains specified in DT\n");
+		return -EINVAL;
+	}
+
+	res  = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "failed to init regmap\n");
+		return ret;
+	}
+
+	for_each_child_of_node(pgc_np, np) {
+		u32 domain_index;
+		struct platform_device *pd_pdev;
+		struct imx7_pgc_domain *domain;
+
+		ret = of_property_read_u32(np, "reg", &domain_index);
+		if (ret) {
+			dev_err(dev, "Failed to read 'reg' property\n");
+			of_node_put(np);
+			return ret;
+		}
+
+		if (domain_index >= ARRAY_SIZE(imx7_pgc_domains)) {
+			dev_warn(dev,
+				 "Domain index %d is out of bounds\n",
+				 domain_index);
+			continue;
+		}
+
+		domain = &imx7_pgc_domains[domain_index];
+		domain->regmap = regmap;
+
+		pd_pdev = platform_device_alloc("imx7-pgc-domain",
+						domain_index);
+		if (!pd_pdev) {
+			dev_err(dev, "Failed to allocate platform device\n");
+			of_node_put(np);
+			return -ENOMEM;
+		}
+
+		pd_pdev->dev.platform_data = domain;
+		pd_pdev->dev.parent = dev;
+		pd_pdev->dev.of_node = np;
+
+		ret = platform_device_add(pd_pdev);
+		if (ret) {
+			platform_device_put(pd_pdev);
+			of_node_put(np);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id imx_gpcv2_dt_ids[] = {
+	{ .compatible = "fsl,imx7d-gpc" },
+	{ }
+};
+
+static struct platform_driver imx_gpc_driver = {
+	.driver = {
+		.name = "imx-gpcv2",
+		.of_match_table = imx_gpcv2_dt_ids,
+	},
+	.probe = imx_gpcv2_probe,
+};
+builtin_platform_driver(imx_gpc_driver)
diff --git a/include/dt-bindings/power/imx7-power.h b/include/dt-bindings/power/imx7-power.h
new file mode 100644
index 0000000..24dde62
--- /dev/null
+++ b/include/dt-bindings/power/imx7-power.h
@@ -0,0 +1,18 @@
+/*
+ *  Copyright ? 2017 Impinj
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DT_BINDINGS_ARM_IMX7_POWER_H__
+#define __DT_BINDINGS_ARM_IMX7_POWER_H__
+
+#define IMX7_POWER_DOMAIN_USB_HSIC_PHY	0
+#define IMX7_POWER_DOMAIN_USB_OTG2_PHY	1
+#define IMX7_POWER_DOMAIN_USB_OTG1_PHY	2
+#define IMX7_POWER_DOMAIN_PCIE_PHY	3
+#define IMX7_POWER_DOMAIN_MIPI_PHY	4
+
+#endif
-- 
2.9.3
