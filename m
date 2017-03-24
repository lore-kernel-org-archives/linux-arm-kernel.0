From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 24 Mar 2017 14:24:51 +0800
Subject: [PATCH v7 2/2] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <20170321145004.21265-3-andrew.smirnov@gmail.com>
References: <20170321145004.21265-1-andrew.smirnov@gmail.com>
 <20170321145004.21265-3-andrew.smirnov@gmail.com>
Message-ID: <20170324062451.GB12604@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 07:50:04AM -0700, Andrey Smirnov wrote:
> Add code allowing for control of various power domains managed by GPCv2
> IP block found in i.MX7 series of SoCs. Power domains covered by this
> patch are:
> 
>     - PCIE PHY
>     - MIPI PHY
>     - USB HSIC PHY
>     - USB OTG1/2 PHY
> 

You probably may need drop USB OTG which is not claimed in current RM.
See the PGC definition in 5.5.10 GPC Memory Map section.

Each PGC (CPU type, MIX type, PU type) will occupy 64 Bytes address space,
the specific base address of each PGC are listed as below.
? 0x800 ~ 0x83F : PGC for A7 core0
? 0x840 ~ 0x87F: PGC for A7 core1
? 0x880 ~ 0x8BF: PGC for A7 SCU
? 0xA00 ~ 0xA3F: PGC for fastmix/megamix
? 0xC00 ~ 0xC3F: PGC for MIPI PHY
? 0xC40 ~ 0xC7F: PGC for PCIE_PHY
? 0xC80 ~ 0xCBF: Reserved
? 0xCC0 ~ 0xCFF: Reserved
? 0xD00 ~ 0xD3F: PGC for USB HSIC PHY

And in 5.4 Power Management Unit (PMU) chapter,
you will find the USB OTG phy power is directly supplied by
VDD_USB_OTG1_3P3_IN/VDD_USB_OTG2_3P3_IN.

http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX7DRM.pdf

I understand that there's also some USB OTG code exist in NXP internal
tree, but that's legacy for early doc implementation and may be deprecated.
so i assume it should be gone.

Hopefully i will double confirm with our IC designer tomorrow.

> Support for any other power domain controlled by GPC is not present, and
> can be added at some later point.
> 
> Testing of this code was done against a PCIe driver.
> 
> Cc: yurovsky at gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Dong Aisheng <dongas86@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/soc/Kconfig      |   1 +
>  drivers/soc/imx/Kconfig  |  10 ++
>  drivers/soc/imx/Makefile |   1 +
>  drivers/soc/imx/gpcv2.c  | 365 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 377 insertions(+)
>  create mode 100644 drivers/soc/imx/Kconfig
>  create mode 100644 drivers/soc/imx/gpcv2.c
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index f09023f..8943543 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
>  
>  source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
> +source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/mediatek/Kconfig"
>  source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> new file mode 100644
> index 0000000..bc7f0ee0
> --- /dev/null
> +++ b/drivers/soc/imx/Kconfig
> @@ -0,0 +1,10 @@
> +menu "i.MX SoC drivers"
> +
> +config IMX7_PM_DOMAINS
> +	bool "i.MX7 PM domains"
> +	select PM_GENERIC_DOMAINS
> +	depends on SOC_IMX7D || (COMPILE_TEST && OF)
> +	default y if SOC_IMX7D
> +
> +endmenu
> +
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 35861f5..5b6e396 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -1 +1,2 @@
>  obj-y += gpc.o
> +obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> new file mode 100644
> index 0000000..a27c5f8
> --- /dev/null
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -0,0 +1,365 @@
> +/*
> + * Copyright 2017 Impinj, Inc
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * Based on the code of analogus driver:
> + *
> + * Copyright 2015-2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <dt-bindings/power/imx7-power.h>
> +
> +#define GPC_PGC_CPU_MAPPING	0xec
> +#define USB_HSIC_PHY_A7_DOMAIN	BIT(6)
> +#define USB_OTG2_PHY_A7_DOMAIN	BIT(5)
> +#define USB_OTG1_PHY_A7_DOMAIN	BIT(4)
> +#define PCIE_PHY_A7_DOMAIN	BIT(3)
> +#define MIPI_PHY_A7_DOMAIN	BIT(2)
> +
> +#define GPC_PU_PGC_SW_PUP_REQ	0xf8
> +#define GPC_PU_PGC_SW_PDN_REQ	0x104
> +#define USB_HSIC_PHY_SW_Pxx_REQ	BIT(4)
> +#define USB_OTG2_PHY_SW_Pxx_REQ	BIT(3)
> +#define USB_OTG1_PHY_SW_Pxx_REQ	BIT(2)
> +#define PCIE_PHY_SW_Pxx_REQ	BIT(1)
> +#define MIPI_PHY_SW_Pxx_REQ	BIT(0)
> +

After apply, what i see is:
#define GPC_PU_PGC_SW_PUP_REQ   0xf8
#define GPC_PU_PGC_SW_PDN_REQ   0x104
#define USB_HSIC_PHY_SW_Pxx_REQ BIT(4)
#define USB_OTG2_PHY_SW_Pxx_REQ BIT(3)
#define USB_OTG1_PHY_SW_Pxx_REQ BIT(2)
#define PCIE_PHY_SW_Pxx_REQ     BIT(1)
#define MIPI_PHY_SW_Pxx_REQ     BIT(0)

Looks quite tight,
Can we have one more TAB for the definition?
Like:
#define GPC_PU_PGC_SW_PUP_REQ 		0xf8

> +#define GPC_MAX_REGISTER	0x1000
> +
> +#define GPC_PGC_nCTRL_PCR	BIT(0)
> +
> +struct imx7_pgc_domain {
> +	struct generic_pm_domain genpd;
> +	struct regmap *regmap;
> +	struct regulator *regulator;
> +
> +	unsigned int pgc_nctrl;
> +
> +	const struct {
> +		u32 pxx;
> +		u32 map;
> +	} bits;
> +
> +	const int voltage;
> +	struct device *dev;
> +};
> +
> +static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
> +				      bool on)
> +{
> +	struct imx7_pgc_domain *domain = container_of(genpd,
> +						      struct imx7_pgc_domain,
> +						      genpd);
> +	unsigned int offset = on ?
> +		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
> +	const bool enable_power_control = domain->pgc_nctrl && !on;
> +	const bool has_regulator = !IS_ERR(domain->regulator);
> +	unsigned long deadline;
> +	int ret = 0;
> +
> +	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +			   domain->bits.map, domain->bits.map);
> +
> +	if (has_regulator && on) {
> +		ret = regulator_enable(domain->regulator);
> +		if (ret) {
> +			dev_err(domain->dev, "failed to enable regulator\n");
> +			goto unmap;
> +		}
> +	}
> +
> +	if (enable_power_control)
> +		regmap_update_bits(domain->regmap, domain->pgc_nctrl,
> +				   GPC_PGC_nCTRL_PCR, GPC_PGC_nCTRL_PCR);
> +
> +	regmap_update_bits(domain->regmap, offset,
> +			   domain->bits.pxx, domain->bits.pxx);
> +
> +	/*
> +	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> +	 * for PUP_REQ/PDN_REQ bit to be cleared
> +	 */
> +	deadline = jiffies + msecs_to_jiffies(1);
> +	while (true) {
> +		u32 pxx_req;
> +
> +		regmap_read(domain->regmap, offset, &pxx_req);
> +
> +		if (!(pxx_req & domain->bits.pxx))
> +			break;
> +
> +		if (time_after(jiffies, deadline)) {
> +			dev_err(domain->dev, "falied to command PGC\n");
> +			ret = -ETIMEDOUT;
> +			/*
> +			 * If we were in a process of enabling a
> +			 * domain and failed we might as well disable
> +			 * the regulator we just enabled. And if it
> +			 * was the opposite situation and we failed to
> +			 * power down -- keep the regulator on
> +			 */
> +			on = !on;
> +			break;
> +		}
> +
> +		cpu_relax();
> +	}
> +
> +	if (enable_power_control)
> +		regmap_update_bits(domain->regmap, domain->pgc_nctrl,
> +				   GPC_PGC_nCTRL_PCR, 0);
> +
> +	if (has_regulator && !on) {
> +		int err;
> +
> +		err = regulator_disable(domain->regulator);
> +		if (err)
> +			dev_err(domain->dev,
> +				"failed to disable regulator: %d\n", ret);
> +		/* Preserve earlier error code */
> +		ret = ret ?: err;
> +	}
> +unmap:
> +	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +			   domain->bits.map, 0);
> +	return ret;
> +}
> +
> +static int imx7_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
> +{
> +	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, true);
> +}
> +
> +static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
> +{
> +	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
> +}
> +
> +static struct imx7_pgc_domain imx7_pgc_domains[] = {
> +	[IMX7_POWER_DOMAIN_USB_HSIC_PHY] = {
> +		.genpd = {
> +			.name      = "usb-hsic-phy",
> +		},
> +		.bits  = {
> +			.pxx = USB_HSIC_PHY_SW_Pxx_REQ,
> +			.map = USB_HSIC_PHY_A7_DOMAIN,
> +		},
> +		.voltage   = 1200000,
> +		.pgc_nctrl = 0x0d00,
> +	},
> +
> +	[IMX7_POWER_DOMAIN_USB_OTG2_PHY] = {
> +		.genpd = {
> +			.name      = "usb-otg2-phy",
> +		},
> +		.bits  = {
> +			.pxx = USB_OTG2_PHY_SW_Pxx_REQ,
> +			.map = USB_OTG2_PHY_A7_DOMAIN,
> +		},
> +	},
> +
> +	[IMX7_POWER_DOMAIN_USB_OTG1_PHY] = {
> +		.genpd = {
> +			.name      = "usb-otg1-phy",
> +		},
> +		.bits  = {
> +			.pxx = USB_OTG1_PHY_SW_Pxx_REQ,
> +			.map = USB_OTG1_PHY_A7_DOMAIN,
> +		},
> +	},
> +
> +	[IMX7_POWER_DOMAIN_PCIE_PHY] = {
> +		.genpd = {
> +			.name      = "pcie-phy",
> +		},
> +		.bits  = {
> +			.pxx = PCIE_PHY_SW_Pxx_REQ,
> +			.map = PCIE_PHY_A7_DOMAIN,
> +		},
> +		.voltage   = 1000000,
> +		.pgc_nctrl = 0x0c40,
> +	},
> +
> +	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
> +		.genpd = {
> +			.name      = "mipi-phy",
> +		},
> +		.bits  = {
> +			.pxx = MIPI_PHY_SW_Pxx_REQ,
> +			.map = MIPI_PHY_A7_DOMAIN,
> +		},
> +		.voltage   = 1000000,
> +		.pgc_nctrl = 0x0c00,
> +	},
> +};
> +
> +static int imx7_pgc_domain_probe(struct platform_device *pdev)
> +{
> +	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
> +	int ret;
> +
> +	domain->dev = &pdev->dev;
> +
> +	ret = pm_genpd_init(&domain->genpd, NULL, true);
> +	if (ret) {
> +		dev_err(domain->dev, "Failed to init power domain\n");
> +		return ret;
> +	}
> +
> +	domain->regulator = devm_regulator_get_optional(domain->dev, "power");
> +	if (IS_ERR(domain->regulator) &&
> +	    PTR_ERR(domain->regulator) != -ENODEV) {
> +		dev_err(domain->dev, "Failed to get domain's regulator\n");
> +		return PTR_ERR(domain->regulator);
> +	}
> +
> +	if (!IS_ERR(domain->regulator)) {
> +		if (!domain->voltage) {
> +			WARN(1, "No voltage configured for domain's regulator");
> +			return -EINVAL;
> +		}
> +
> +		regulator_set_voltage(domain->regulator,
> +				      domain->voltage, domain->voltage);
> +	}
> +
> +	ret = of_genpd_add_provider_simple(domain->dev->of_node,
> +					   &domain->genpd);
> +	if (ret) {
> +		dev_err(domain->dev, "Failed to add genpd provider\n");
> +		pm_genpd_remove(&domain->genpd);
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx7_pgc_domain_remove(struct platform_device *pdev)
> +{
> +	struct imx7_pgc_domain *domain = pdev->dev.platform_data;
> +
> +	of_genpd_del_provider(domain->dev->of_node);
> +	pm_genpd_remove(&domain->genpd);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id imx7_pgc_domain_id[] = {
> +	{ "imx7-pgc-domain", },
> +	{ },
> +};
> +
> +static struct platform_driver imx7_pgc_domain_driver = {
> +	.driver = {
> +		.name = "imx7-pgc",
> +	},
> +	.probe    = imx7_pgc_domain_probe,
> +	.remove   = imx7_pgc_domain_remove,
> +	.id_table = imx7_pgc_domain_id,
> +};
> +builtin_platform_driver(imx7_pgc_domain_driver)

Again, i have a fundamental question about this patch implementation
that why we choose above way to register the power domain?

I'm sorry that i did not know too much history.
Would you guys please help share some information?

Because AFAIK this way will register each domain as a power domain
provider which is a bit violate the real HW and current power domain
framework design. And it is a bit more complicated to use than before.

IMHO i would rather prefer the old traditional and simpler way that one
provider (GPC) supplies multiple domains (PCIE/MIPI/HSIC PHY domain)
than this patch does.

However, i might be wrong. Please help to clear.

> +
> +static int imx_gpcv2_probe(struct platform_device *pdev)
> +{
> +	static const struct regmap_config regmap_config = {
> +		.cache_type	= REGCACHE_NONE,

You could drop it as GPC does.

> +		.reg_bits	= 32,
> +		.val_bits	= 32,
> +		.reg_stride	= 4,
> +		.max_register	= GPC_MAX_REGISTER,

Do you need add some readable/writeable reg?

There seems to be some reserved regs in your range.
I can easily got the below crash:

root at imx6ul7d:/sys/kernel/debug/regmap/303a0000.gpc# cat registers 
[   54.985395] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf08511c0
[   54.993166] pgd = ed02c000
[   54.995894] [f08511c0] *pgd=af00c811, *pte=303a0653, *ppte=303a0453
[   55.002215] Internal error: : 1008 [#1] SMP ARM
[   55.006756] Modules linked in:
[   55.009830] CPU: 0 PID: 750 Comm: cat Not tainted 4.11.0-rc1-00057-g2d60158-dirty #1169
[   55.017842] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   55.023598] task: ee20ee40 task.stack: ed0f8000
[   55.028146] PC is at regmap_mmio_read32le+0x14/0x24
[   55.033035] LR is at regmap_mmio_read+0x40/0x60
[   55.037577] pc : [<c054f160>]    lr : [<c054f348>]    psr: 20070093
[   55.037577] sp : ed0f9dc8  ip : ed0f9dd8  fp : ed0f9dd4
[   55.049064] r10: ed160000  r9 : ef341000  r8 : ed0f9f80
[   55.054299] r7 : ed0f9e5c  r6 : ed0f9e5c  r5 : 000001c0  r4 : ef3bb900
[   55.060836] r3 : f0851000  r2 : ed0f9e5c  r1 : f08511c0  r0 : ef3bb900
[   55.067374] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   55.074606] Control: 10c5387d  Table: ad02c06a  DAC: 00000051
[   55.080361] Process cat (pid: 750, stack limit = 0xed0f8210)
....

> +	};
> +	struct device *dev = &pdev->dev;
> +	struct device_node *pgc_np, *np;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	pgc_np = of_get_child_by_name(dev->of_node, "pgc");
> +	if (!pgc_np) {
> +		dev_err(dev, "No power domains specified in DT\n");
> +		return -EINVAL;
> +	}
> +
> +	res  = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "failed to init regmap (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	for_each_child_of_node(pgc_np, np) {
> +		struct platform_device *pd_pdev;
> +		struct imx7_pgc_domain *domain;
> +		u32 domain_index;
> +
> +		ret = of_property_read_u32(np, "reg", &domain_index);
> +		if (ret) {
> +			dev_err(dev, "Failed to read 'reg' property\n");
> +			of_node_put(np);
> +			return ret;
> +		}
> +
> +		if (domain_index >= ARRAY_SIZE(imx7_pgc_domains)) {
> +			dev_warn(dev,
> +				 "Domain index %d is out of bounds\n",
> +				 domain_index);
> +			continue;
> +		}
> +
> +		domain = &imx7_pgc_domains[domain_index];
> +		domain->regmap = regmap;
> +		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
> +		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
> +
> +		pd_pdev = platform_device_alloc("imx7-pgc-domain",
> +						domain_index);
> +		if (!pd_pdev) {
> +			dev_err(dev, "Failed to allocate platform device\n");
> +			of_node_put(np);
> +			return -ENOMEM;
> +		}
> +
> +		pd_pdev->dev.platform_data = domain;
> +		pd_pdev->dev.parent = dev;
> +		pd_pdev->dev.of_node = np;
> +
> +		ret = platform_device_add(pd_pdev);
> +		if (ret) {
> +			platform_device_put(pd_pdev);
> +			of_node_put(np);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_gpcv2_dt_ids[] = {
> +	{ .compatible = "fsl,imx7d-gpc" },
> +	{ }
> +};
> +
> +static struct platform_driver imx_gpc_driver = {
> +	.driver = {
> +		.name = "imx-gpcv2",
> +		.of_match_table = imx_gpcv2_dt_ids,
> +	},
> +	.probe = imx_gpcv2_probe,
> +};
> +builtin_platform_driver(imx_gpc_driver)
> -- 
> 2.9.3
> 

Regards
Dong Aisheng
