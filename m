From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 12 May 2015 09:12:24 +0200
Subject: [PATCH 1/5] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
References: <1431372206-1237-1-git-send-email-s.hauer@pengutronix.de>
 <1431372206-1237-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150512071224.GQ6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 09:23:22PM +0200, Sascha Hauer wrote:
> This adds support for some miscellaneous bits of the infracfg controller.
> The mtk_infracfg_set/clear_bus_protection functions are necessary for
> the scpsys power domain driver to handle the bus protection bits which
> are contained in the infacfg register space.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/soc/mediatek/Kconfig        |  9 +++++
>  drivers/soc/mediatek/Makefile       |  1 +
>  drivers/soc/mediatek/mtk-infracfg.c | 80 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-infracfg.c
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index bcdb22d..6fae66f 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -9,3 +9,12 @@ config MTK_PMIC_WRAP
>  	  Say yes here to add support for MediaTek PMIC Wrapper found
>  	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
>  	  hardware to connect the PMIC.
> +
> +config MTK_INFRACFG
> +	tristate "MediaTek INFRACFG Support"
> +	depends on ARCH_MEDIATEK
> +	select REGMAP
> +	help
> +	  Say yes here to add support for the MediaTek INFRACFG controller. The
> +	  INFRACFG controller contains various infrastructure registers not
> +	  directly associated to any device.
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index ecaf4de..ce39119 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> new file mode 100644
> index 0000000..b3ebfae
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-infracfg.c
> @@ -0,0 +1,80 @@
> +#include <linux/regmap.h>
> +#include <linux/export.h>
> +#include <linux/jiffies.h>
> +#include <linux/soc/mediatek/infracfg.h>
> +#include <asm/processor.h>
> +
> +#define INFRA_TOPAXI_PROTECTEN		0x0220
> +#define INFRA_TOPAXI_PROTECTSTA1	0x0228
> +
> +/**
> + * mtk_infracfg_set_bus_protection - enable bus protection
> + * @regmap: The infracfg regmap
> + * @mask: The mask containing the protection bits to be enabled.
> + *
> + * This function enables the bus protection bits for disabled power
> + * domains so that the system does not hanf when some unit accesses the
> + * bus while in power down.
> + */
> +int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
> +{
> +	unsigned long expired;
> +	u32 val;
> +	int ret;
> +
> +	regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, mask);
> +
> +	expired = jiffies + HZ;
> +
> +	while (1) {
> +		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> +		if (ret)
> +			return ret;
> +
> +		if ((val & mask) == mask)
> +			break;
> +
> +		cpu_relax();
> +		if (time_after(jiffies, expired))
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_infracfg_set_bus_protection);
> +
> +/**
> + * mtk_infracfg_clear_bus_protection - disable bus protection
> + * @regmap: The infracfg regmap
> + * @mask: The mask containing the protection bits to be disabled.
> + *
> + * This function disables the bus protection bits previously enabled with
> + * mtk_infracfg_set_bus_protection.
> + */
> +int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask)
> +{
> +	unsigned long expired;
> +	int ret;
> +
> +	regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> +
> +	expired = jiffies + HZ;
> +
> +	while (1) {
> +		u32 val;
> +
> +		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (!(val & mask))
> +			break;
> +
> +		cpu_relax();
> +		if (time_after(jiffies, expired))
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_infracfg_clear_bus_protection);

Forgot to git add include/linux/soc/mediatek/infracfg.h, this file
contains:

#ifndef __SOC_MEDIATEK_INFRACFG_H
#define __SOC_MEDIATEK_INFRACFG_H

#define MT8173_TOP_AXI_PROT_EN_MCI_M2		BIT(0)
#define MT8173_TOP_AXI_PROT_EN_MM_M0		BIT(1)
#define MT8173_TOP_AXI_PROT_EN_MM_M1		BIT(2)
#define MT8173_TOP_AXI_PROT_EN_MMAPB_S		BIT(6)
#define MT8173_TOP_AXI_PROT_EN_L2C_M2		BIT(9)
#define MT8173_TOP_AXI_PROT_EN_L2SS_SMI		BIT(11)
#define MT8173_TOP_AXI_PROT_EN_L2SS_ADD		BIT(12)
#define MT8173_TOP_AXI_PROT_EN_CCI_M2		BIT(13)
#define MT8173_TOP_AXI_PROT_EN_MFG_S		BIT(14)
#define MT8173_TOP_AXI_PROT_EN_PERI_M0		BIT(15)
#define MT8173_TOP_AXI_PROT_EN_PERI_M1		BIT(16)
#define MT8173_TOP_AXI_PROT_EN_DEBUGSYS		BIT(17)
#define MT8173_TOP_AXI_PROT_EN_CQ_DMA		BIT(18)
#define MT8173_TOP_AXI_PROT_EN_GCPU		BIT(19)
#define MT8173_TOP_AXI_PROT_EN_IOMMU		BIT(20)
#define MT8173_TOP_AXI_PROT_EN_MFG_M0		BIT(21)
#define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
#define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)

int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask);
int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask);

#endif /* __SOC_MEDIATEK_INFRACFG_H */

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
