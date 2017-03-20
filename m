From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 20 Mar 2017 13:34:19 -0700
Subject: [PATCH v6 2/2] soc/imx: Add GPCv2 power gating driver
In-Reply-To: <20170320070351.GA11325@b29396-OptiPlex-7040>
References: <20170316133050.28471-1-andrew.smirnov@gmail.com>
 <20170316133050.28471-3-andrew.smirnov@gmail.com>
 <20170320070351.GA11325@b29396-OptiPlex-7040>
Message-ID: <CAHQ1cqFkJDWjVZFzXPxCg6unS_v-zFr7XVhnT-Y7FR1Ju6N5ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:03 AM, Dong Aisheng <dongas86@gmail.com> wrote:
> On Thu, Mar 16, 2017 at 06:30:50AM -0700, Andrey Smirnov wrote:
>> Add code allowing for control of various power domains managed by GPCv2
>> IP block found in i.MX7 series of SoCs. Power domains covered by this
>> patch are:
>>
>>     - PCIE PHY
>>     - MIPI PHY
>>     - USB HSIC PHY
>>     - USB OTG1/2 PHY
>>
>> Support for any other power domain controlled by GPC is not present, and
>> can be added at some later point.
>>
>> Testing of this code was done against a PCIe driver.
>>
>> Cc: yurovsky at gmail.com
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  drivers/soc/Kconfig      |   1 +
>>  drivers/soc/imx/Kconfig  |  10 ++
>>  drivers/soc/imx/Makefile |   1 +
>>  drivers/soc/imx/gpcv2.c  | 385 +++++++++++++++++++++++++++++++++++++++++++++++
>
> Personally i'd like more naming gpc-imx7.c since gpcv2 is too generic,
> and actually you also mix using imx7d name below.
>

This IP block is already referenced as GPCv2 in
drivers/irqchip/irq-imx-gpcv2.c, so IMHO re-naming it to gpc-imx7
would be confusing.

> And AFAIK only MX7 will use this new driver.
>
> Probably should also change the exist gpc to gpc-imx6.
>
>>  4 files changed, 397 insertions(+)
>>  create mode 100644 drivers/soc/imx/Kconfig
>>  create mode 100644 drivers/soc/imx/gpcv2.c
>>
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>> index f31bceb..55a4eb8 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
>>
>>  source "drivers/soc/bcm/Kconfig"
>>  source "drivers/soc/fsl/Kconfig"
>> +source "drivers/soc/imx/Kconfig"
>>  source "drivers/soc/mediatek/Kconfig"
>>  source "drivers/soc/qcom/Kconfig"
>>  source "drivers/soc/rockchip/Kconfig"
>> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
>> new file mode 100644
>> index 0000000..bc7f0ee0
>> --- /dev/null
>> +++ b/drivers/soc/imx/Kconfig
>> @@ -0,0 +1,10 @@
>> +menu "i.MX SoC drivers"
>> +
>> +config IMX7_PM_DOMAINS
>> +     bool "i.MX7 PM domains"
>> +     select PM_GENERIC_DOMAINS
>> +     depends on SOC_IMX7D || (COMPILE_TEST && OF)
>> +     default y if SOC_IMX7D
>> +
>> +endmenu
>> +
>> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
>> index 35861f5..5b6e396 100644
>> --- a/drivers/soc/imx/Makefile
>> +++ b/drivers/soc/imx/Makefile
>> @@ -1 +1,2 @@
>>  obj-y += gpc.o
>> +obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
>> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
>> new file mode 100644
>> index 0000000..73c58ca
>> --- /dev/null
>> +++ b/drivers/soc/imx/gpcv2.c
>> @@ -0,0 +1,385 @@
>> +/*
>> + * Copyright 2017 Impinj, Inc
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * Based on the code of analogus driver:
>> + *
>> + * Copyright 2015-2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#include <linux/clk.h>
>
> Where did you use it?

Not sure, I'll double check and drop it if it's unused.

>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <dt-bindings/power/imx7-power.h>
>> +
>> +#define GPC_PGC_CPU_MAPPING  0xec
>> +#define USB_HSIC_PHY_A7_DOMAIN       BIT(6)
>> +#define USB_OTG2_PHY_A7_DOMAIN       BIT(5)
>> +#define USB_OTG1_PHY_A7_DOMAIN       BIT(4)
>> +#define PCIE_PHY_A7_DOMAIN   BIT(3)
>> +#define MIPI_PHY_A7_DOMAIN   BIT(2)
>> +
>> +#define GPC_PU_PGC_SW_PUP_REQ        0xf8
>> +#define GPC_PU_PGC_SW_PDN_REQ        0x104
>> +#define USB_HSIC_PHY_SW_Pxx_REQ      BIT(4)
>> +#define USB_OTG2_PHY_SW_Pxx_REQ      BIT(3)
>> +#define USB_OTG1_PHY_SW_Pxx_REQ      BIT(2)
>> +#define PCIE_PHY_SW_Pxx_REQ  BIT(1)
>> +#define MIPI_PHY_SW_Pxx_REQ  BIT(0)
>> +
>> +#define GPC_MAX_REGISTER     0x1000
>> +
>> +#define GPC_PGC_nCTRL_PCR    BIT(0)
>> +
>> +struct imx7_pgc_domain {
>> +     struct generic_pm_domain genpd;
>> +     struct regmap *regmap;
>> +     struct regulator *regulator;
>> +
>> +     unsigned int pgc_nctrl;
>> +
>> +     const struct {
>> +             u32 pxx;
>> +             u32 map;
>> +     } bits;
>> +
>> +     const int voltage;
>> +     struct device *dev;
>> +};
>> +
>> +static int imx7_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>> +                                   bool on)
>> +{
>> +     struct imx7_pgc_domain *domain = container_of(genpd,
>> +                                                   struct imx7_pgc_domain,
>> +                                                   genpd);
>> +     unsigned int offset = on ?
>> +             GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
>> +     const bool enable_power_control = domain->pgc_nctrl && !on;
>> +     const bool has_regulator = !IS_ERR(domain->regulator);
>> +     unsigned long deadline;
>> +     int ret = 0;
>> +
>> +     regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>> +                        domain->bits.map, domain->bits.map);
>> +
>> +     if (has_regulator && on) {
>> +             ret = regulator_enable(domain->regulator);
>> +             if (ret) {
>> +                     dev_err(domain->dev, "failed to enable regulator\n");
>> +                     goto unmap;
>> +             }
>> +     }
>> +
>> +     if (enable_power_control)
>> +             regmap_update_bits(domain->regmap, domain->pgc_nctrl,
>> +                                GPC_PGC_nCTRL_PCR, GPC_PGC_nCTRL_PCR);
>> +
>> +     regmap_update_bits(domain->regmap, offset,
>> +                        domain->bits.pxx, domain->bits.pxx);
>> +
>> +     /*
>> +      * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
>> +      * for PUP_REQ/PDN_REQ bit to be cleared
>> +      */
>> +     deadline = jiffies + msecs_to_jiffies(1);
>> +     while (true) {
>> +             u32 pxx_req;
>> +
>> +             regmap_read(domain->regmap, offset, &pxx_req);
>> +
>> +             if (!(pxx_req & domain->bits.pxx))
>> +                     break;
>> +
>> +             if (time_after(jiffies, deadline)) {
>> +                     dev_err(domain->dev, "falied to command PGC\n");
>> +                     ret = -ETIMEDOUT;
>> +                     /*
>> +                      * If we were in a process of enabling a
>> +                      * domain and failed we might as well disable
>> +                      * the regulator we just enabled. And if it
>> +                      * was the opposite situation and we failed to
>> +                      * power down -- keep the regulator on
>> +                      */
>> +                     on = !on;
>> +                     break;
>> +             }
>> +
>> +             cpu_relax();
>> +     }
>> +
>> +     if (enable_power_control)
>> +             regmap_update_bits(domain->regmap, domain->pgc_nctrl,
>> +                                GPC_PGC_nCTRL_PCR, 0);
>> +
>> +     if (has_regulator && !on) {
>> +             int err;
>> +
>> +             err = regulator_disable(domain->regulator);
>> +             if (err)
>> +                     dev_err(domain->dev,
>> +                             "failed to disable regulator: %d\n", ret);
>> +             /* Preserve earlier error code */
>> +             ret = ret ?: err;
>> +     }
>> +unmap:
>> +     regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>> +                        domain->bits.map, 0);
>> +     return ret;
>> +}
>> +
>> +static int imx7_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
>> +{
>> +     return imx7_gpc_pu_pgc_sw_pxx_req(genpd, true);
>> +}
>> +
>> +static int imx7_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
>> +{
>> +     return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
>> +}
>> +
>> +static struct imx7_pgc_domain imx7_pgc_domains[] = {
>> +     [IMX7_POWER_DOMAIN_USB_HSIC_PHY] = {
>> +             .genpd = {
>> +                     .name      = "usb-hsic-phy",
>> +             },
>> +             .bits  = {
>> +                     .pxx = USB_HSIC_PHY_SW_Pxx_REQ,
>> +                     .map = USB_HSIC_PHY_A7_DOMAIN,
>> +             },
>> +             .voltage   = 1200000,
>> +             .pgc_nctrl = 0x0d00,
>> +     },
>> +
>> +     [IMX7_POWER_DOMAIN_USB_OTG2_PHY] = {
>> +             .genpd = {
>> +                     .name      = "usb-otg2-phy",
>> +             },
>> +             .bits  = {
>> +                     .pxx = USB_OTG2_PHY_SW_Pxx_REQ,
>> +                     .map = USB_OTG2_PHY_A7_DOMAIN,
>> +             },
>> +     },
>> +
>> +     [IMX7_POWER_DOMAIN_USB_OTG1_PHY] = {
>> +             .genpd = {
>> +                     .name      = "usb-otg1-phy",
>> +             },
>> +             .bits  = {
>> +                     .pxx = USB_OTG1_PHY_SW_Pxx_REQ,
>> +                     .map = USB_OTG1_PHY_A7_DOMAIN,
>> +             },
>> +     },
>> +
>> +     [IMX7_POWER_DOMAIN_PCIE_PHY] = {
>> +             .genpd = {
>> +                     .name      = "pcie-phy",
>> +             },
>> +             .bits  = {
>> +                     .pxx = PCIE_PHY_SW_Pxx_REQ,
>> +                     .map = PCIE_PHY_A7_DOMAIN,
>> +             },
>> +             .voltage   = 1000000,
>> +             .pgc_nctrl = 0x0c40,
>> +     },
>> +
>> +     [IMX7_POWER_DOMAIN_MIPI_PHY] = {
>> +             .genpd = {
>> +                     .name      = "mipi-phy",
>> +             },
>> +             .bits  = {
>> +                     .pxx = MIPI_PHY_SW_Pxx_REQ,
>> +                     .map = MIPI_PHY_A7_DOMAIN,
>> +             },
>> +             .voltage   = 1000000,
>> +             .pgc_nctrl = 0x0c00,
>> +     },
>> +};
>> +
>> +static int imx7_pgc_domain_probe(struct platform_device *pdev)
>> +{
>> +     struct imx7_pgc_domain *domain = pdev->dev.platform_data;
>> +     int ret;
>> +
>> +     domain->dev = &pdev->dev;
>> +
>> +     ret = pm_genpd_init(&domain->genpd, NULL, true);
>> +     if (ret) {
>> +             dev_err(domain->dev, "Failed to init power domain\n");
>> +             return ret;
>> +     }
>> +
>> +     domain->regulator = devm_regulator_get_optional(domain->dev, "power");
>> +     if (IS_ERR(domain->regulator) &&
>> +         PTR_ERR(domain->regulator) != -ENODEV) {
>> +             dev_err(domain->dev, "Failed to get domain's regulator\n");
>> +             return PTR_ERR(domain->regulator);
>> +     }
>> +
>> +     if (!IS_ERR(domain->regulator)) {
>> +             if (!domain->voltage) {
>> +                     WARN(1, "No voltage configured for domain's regulator");
>> +                     return -EINVAL;
>> +             }
>
> This is somehow a bit mess.
> Not sure if it's regulator API issue or our using issue...
>

You are going to have to give me something to work with. If you think
this code can be improved please provide concrete suggestions.

>> +
>> +             regulator_set_voltage(domain->regulator,
>> +                                   domain->voltage, domain->voltage);
>> +     }
>> +
>> +     ret = of_genpd_add_provider_simple(domain->dev->of_node,
>> +                                        &domain->genpd);
>> +     if (ret) {
>> +             dev_err(domain->dev, "Failed to add genpd provider\n");
>> +             pm_genpd_remove(&domain->genpd);
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int imx7_pgc_domain_remove(struct platform_device *pdev)
>
> here
>
>> +{
>> +     struct imx7_pgc_domain *domain = pdev->dev.platform_data;
>> +
>> +     of_genpd_del_provider(domain->dev->of_node);
>> +     pm_genpd_remove(&domain->genpd);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct platform_device_id imx7_pgc_domain_id[] = {
>> +     { "imx7-pgc-domain", },
>
> here
>
>> +     { },
>> +};
>> +
>> +static struct platform_driver imx7_pgc_domain_driver = {
>> +     .driver = {
>> +             .name = "imx7-pgc",
>
> here
>
> All you're using imx7, not gpcv2..
>
> That why i prefer gpc-imx7.c
>

I am fine with this inconsistency and I am going to let Shawn decide.

Shawn, please let me know if you want me to do any renaming.


>> +     },
>> +     .probe    = imx7_pgc_domain_probe,
>> +     .remove   = imx7_pgc_domain_remove,
>> +     .id_table = imx7_pgc_domain_id,
>> +};
>> +builtin_platform_driver(imx7_pgc_domain_driver)
>
> I did not understand too much on why we choose this approach to
> add a power domain. AFAIK per current power domain design, a provider
> can support multiple domains. But with this approach, actually we register
> each domain as a provider which is actually a bit violate the real HW.
>
> Lucas, can you please help provide some information on this new approach
> decision history?
>
>> +
>> +static bool imx_gpcv2_readable_reg(struct device *dev, unsigned int reg)
>> +{
>> +     return reg % 4 == 0 &&
>> +            reg <= GPC_MAX_REGISTER;
>> +}
>> +
>> +static bool imx_gpcv2_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +     return reg == GPC_PU_PGC_SW_PUP_REQ ||
>> +            reg == GPC_PU_PGC_SW_PDN_REQ;
>> +}
>> +
>> +static int imx_gpcv2_probe(struct platform_device *pdev)
>> +{
>> +     static const struct regmap_config regmap_config = {
>
> If any special reason to put the structure in this function?
>
>> +             .cache_type     = REGCACHE_FLAT,
>> +             .reg_bits       = 32,
>> +             .val_bits       = 32,
>> +             .reg_stride     = 4,
>> +
>> +             .readable_reg   = imx_gpcv2_readable_reg,
>
> No really need this.
>

OK, I'll drop it.

>> +             .volatile_reg   = imx_gpcv2_volatile_reg,
>
> Can you check if you have the same cache issue as GPC which
> i just sent out a series to fix?
>

It probably does. I'll adopt your fix from GPC driver.

>> +
>> +             .max_register   = GPC_MAX_REGISTER,
>> +     };
>> +     struct device *dev = &pdev->dev;
>> +     struct device_node *pgc_np, *np;
>> +     struct regmap *regmap;
>> +     struct resource *res;
>> +     void __iomem *base;
>> +     int ret;
>> +
>> +     pgc_np = of_get_child_by_name(dev->of_node, "pgc");
>> +     if (!pgc_np) {
>> +             dev_err(dev, "No power domains specified in DT\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     res  = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     base = devm_ioremap_resource(dev, res);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
>> +     if (IS_ERR(regmap)) {
>> +             ret = PTR_ERR(regmap);
>> +             dev_err(dev, "failed to init regmap (%d)\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     for_each_child_of_node(pgc_np, np) {
>> +             struct platform_device *pd_pdev;
>> +             struct imx7_pgc_domain *domain;
>> +             u32 domain_index;
>> +
>> +             ret = of_property_read_u32(np, "reg", &domain_index);
>> +             if (ret) {
>> +                     dev_err(dev, "Failed to read 'reg' property\n");
>> +                     of_node_put(np);
>> +                     return ret;
>> +             }
>> +
>> +             if (domain_index >= ARRAY_SIZE(imx7_pgc_domains)) {
>> +                     dev_warn(dev,
>> +                              "Domain index %d is out of bounds\n",
>> +                              domain_index);
>> +                     continue;
>> +             }
>> +
>> +             domain = &imx7_pgc_domains[domain_index];
>> +             domain->regmap = regmap;
>> +             domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
>> +             domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
>
> Is imx7_gpc_pu_pgc_sw_pup_req used by all power domains?
> The name looks like a bit specific to PU.
>

All power domains currently supported by the driver, which is limited
to domains controlled by GPC_PU_PGC_SW_PUP_REQ register, hence the
name.

>> +
>> +             pd_pdev = platform_device_alloc("imx7-pgc-domain",
>> +                                             domain_index);
>> +             if (!pd_pdev) {
>> +                     dev_err(dev, "Failed to allocate platform device\n");
>> +                     of_node_put(np);
>> +                     return -ENOMEM;
>> +             }
>> +
>> +             pd_pdev->dev.platform_data = domain;
>> +             pd_pdev->dev.parent = dev;
>> +             pd_pdev->dev.of_node = np;
>> +
>> +             ret = platform_device_add(pd_pdev);
>> +             if (ret) {
>> +                     platform_device_put(pd_pdev);
>> +                     of_node_put(np);
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id imx_gpcv2_dt_ids[] = {
>> +     { .compatible = "fsl,imx7d-gpc" },
>> +     { }
>> +};
>> +
>> +static struct platform_driver imx_gpc_driver = {
>> +     .driver = {
>> +             .name = "imx-gpcv2",
>> +             .of_match_table = imx_gpcv2_dt_ids,
>> +     },
>> +     .probe = imx_gpcv2_probe,
>> +};
>> +builtin_platform_driver(imx_gpc_driver)
>> --
>> 2.9.3
>>
