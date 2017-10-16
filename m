From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Mon, 16 Oct 2017 14:38:24 +0800
Subject: [PATCH 6/9] soc: mediatek: extend bus protection API
In-Reply-To: <3cb89b32-2273-9e99-f776-458738a3b71c@gmail.com>
References: <1503397702-7201-1-git-send-email-weiyi.lu@mediatek.com>
 <1503397702-7201-7-git-send-email-weiyi.lu@mediatek.com>
 <3cb89b32-2273-9e99-f776-458738a3b71c@gmail.com>
Message-ID: <1508135904.20464.45.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-10 at 17:45 +0200, Matthias Brugger wrote:
> 
> On 08/22/2017 12:28 PM, Weiyi Lu wrote:
> > MT2712 add "set/clear" bus control register to each control register set
> > instead of providing only one "enable" control register, we could avoid
> > the read-modify-write racing by using extend API with such new design.
> > By improving the mtk-infracfg bus protection implementation to
> > support set/clear bus protection control method by IC configuration.
> > 
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >   drivers/soc/mediatek/mtk-infracfg.c   | 32 ++++++++++----
> >   drivers/soc/mediatek/mtk-scpsys.c     | 81 +++++++++++++++++++++++++++--------
> >   include/linux/soc/mediatek/infracfg.h | 12 ++++--
> >   3 files changed, 96 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> > index dba3055..f55ceaa 100644
> > --- a/drivers/soc/mediatek/mtk-infracfg.c
> > +++ b/drivers/soc/mediatek/mtk-infracfg.c
> > @@ -17,30 +17,35 @@
> >   #include <linux/soc/mediatek/infracfg.h>
> >   #include <asm/processor.h>
> >   with different design
> > -#define INFRA_TOPAXI_PROTECTEN		0x0220
> > -#define INFRA_TOPAXI_PROTECTSTA1	0x0228
> > -
> >   /**
> >    * mtk_infracfg_set_bus_protection - enable bus protection
> >    * @regmap: The infracfg regmap
> >    * @mask: The mask containing the protection bits to be enabled.
> > + * @reg_set: The register used to enable protection bits.
> > + * @reg_en: The register used to enable protection bits when there doesn't
> > + *          exist reg_set.
> > + * @reg_sta: The register used to check the protection bits are enabled.
> >    *
> >    * This function enables the bus protection bits for disabled power
> >    * domains so that the system does not hang when some unit accesses the
> >    * bus while in power down.
> >    */
> > -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
> > +int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> > +		u32 reg_set, u32 reg_en, u32 reg_sta)
> >   {
> >   	unsigned long expired;
> >   	u32 val;
> >   	int ret;
> >   
> > -	regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, mask);
> > +	if (reg_set)
> > +		regmap_write(infracfg, reg_set, mask);
> > +	else
> > +		regmap_update_bits(infracfg, reg_en, mask, mask);
> 
> 
> This looks to me as if it's slightly over-engineered.
> The reg_set and reg_en and reg_sta are the same on all SoCs, so no need to pass 
> the value to the infra bus protection set and clear functions.
> I think we could just add a boolean overwrite_mask for every SoC and check for this.
> 
> Do I miss something?
> 
> Regards,
> Matthias
> 

Yes, currently those SoCs already merged in kernel mainline are the
same, but I've checked some mediatek SoCs in near future might be
different.That's the main reason I'd like to make it more flexible by
passing the register address directly than just adding a boolean to
check.Do you think it be better to refine like Part A below, or keep it
simple like Part B only for those SoCs in mainline?

A. 
struct overwrite_reg {
	u32 reg_en;
	u32 reg_set;
	u32 reg_clr;
	u32 reg_sta;
};

int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask
	bool use_set_reg, bool use_overwrite_reg, struct overwrite_reg
new_regs)
{
	unsigned long expired;
	u32 val;
	int ret;
	u32 reg_en, reg_set, reg_sta;

	if (use_overwrite_reg) {
		reg_en = new_regs.reg_en;
		reg_set = new_regs.reg_set;
		reg_sta = new_regs.reg_sta;
	} else {
		reg_en = INFRA_TOPAXI_PROTECTEN;
		reg_set = INFRA_TOPAXI_PROTECTEN_SET;
		reg_sta = INFRA_TOPAXI_PROTECTSTA1;
	}
		
	if (!use_set_reg)
		regmap_update_bits(infracfg, reg_en, mask, mask);
	else
		regmap_write(infracfg, reg_set, mask);

...
}

B.
int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask
	bool use_set_reg)
{
	unsigned long expired;
	u32 val;
	int ret;
		
	if (!use_set_reg)
		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, mask);
	else
		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);

...
}

> >   
> >   	expired = jiffies + HZ;
> >   
> >   	while (1) {
> > -		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> > +		ret = regmap_read(infracfg, reg_sta, &val);
> >   		if (ret)
> >   			return ret;
> >   
> > @@ -59,23 +64,32 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
> >    * mtk_infracfg_clear_bus_protection - disable bus protection
> >    * @regmap: The infracfg regmap
> >    * @mask: The mask containing the protection bits to be disabled.
> > + * @reg_clr: The register used to disable protection bits.
> > + * @reg_en: The register used to disable protection bits when there doesn't
> > + *          exist reg_clr.
> > + * @reg_sta: The register used to check the protection bits are disabled.
> >    *
> >    * This function disables the bus protection bits previously enabled with
> >    * mtk_infracfg_set_bus_protection.
> >    */
> > -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask)
> > +
> > +int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> > +		u32 reg_clr, u32 reg_en, u32 reg_sta)
> >   {
> >   	unsigned long expired;
> >   	int ret;
> >   
> > -	regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> > +	if (reg_clr)
> > +		regmap_write(infracfg, reg_clr, mask);
> > +	else
> > +		regmap_update_bits(infracfg, reg_en, mask, 0);
> >   
> >   	expired = jiffies + HZ;
> >   
> >   	while (1) {
> >   		u32 val;
> >   
> > -		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> > +		ret = regmap_read(infracfg, reg_sta, &val);
> >   		if (ret)
> >   			return ret;
> >   
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index e1ce8b1..2569390 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -127,13 +127,25 @@ struct scp_ctrl_reg {
> >   	int pwr_sta2nd_offs;
> >   };
> >   
> > +struct bus_prot_reg {
> > +	u32 set_offs;
> > +	u32 clr_offs;
> > +	u32 en_offs;
> > +	u32 sta_offs;
> > +};
> > +
> > +struct soc_reg {
> > +	struct scp_ctrl_reg scp_ctrl;
> > +	struct bus_prot_reg bus_prot;
> > +};
> > +
> >   struct scp {
> >   	struct scp_domain *domains;
> >   	struct genpd_onecell_data pd_data;
> >   	struct device *dev;
> >   	void __iomem *base;
> >   	struct regmap *infracfg;
> > -	struct scp_ctrl_reg ctrl_reg;
> > +	struct soc_reg soc_reg;
> >   };
> >   
> >   struct scp_subdomain {
> > @@ -146,16 +158,16 @@ struct scp_soc_data {
> >   	int num_domains;
> >   	const struct scp_subdomain *subdomains;
> >   	int num_subdomains;
> > -	const struct scp_ctrl_reg regs;
> > +	const struct soc_reg regs;
> >   };
> >   
> >   static int scpsys_domain_is_on(struct scp_domain *scpd)
> >   {
> >   	struct scp *scp = scpd->scp;
> >   
> > -	u32 status = readl(scp->base + scp->ctrl_reg.pwr_sta_offs) &
> > +	u32 status = readl(scp->base + scp->soc_reg.scp_ctrl.pwr_sta_offs) &
> >   						scpd->data->sta_mask;
> > -	u32 status2 = readl(scp->base + scp->ctrl_reg.pwr_sta2nd_offs) &
> > +	u32 status2 = readl(scp->base + scp->soc_reg.scp_ctrl.pwr_sta2nd_offs) &
> >   						scpd->data->sta_mask;
> >   
> >   	/*
> > @@ -254,7 +266,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >   
> >   	if (scpd->data->bus_prot_mask) {
> >   		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > -				scpd->data->bus_prot_mask);
> > +				scpd->data->bus_prot_mask,
> > +				scp->soc_reg.bus_prot.clr_offs,
> > +				scp->soc_reg.bus_prot.en_offs,
> > +				scp->soc_reg.bus_prot.sta_offs);
> >   		if (ret)
> >   			goto err_pwr_ack;
> >   	}
> > @@ -289,7 +304,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >   
> >   	if (scpd->data->bus_prot_mask) {
> >   		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> > -				scpd->data->bus_prot_mask);
> > +				scpd->data->bus_prot_mask,
> > +				scp->soc_reg.bus_prot.set_offs,
> > +				scp->soc_reg.bus_prot.en_offs,
> > +				scp->soc_reg.bus_prot.sta_offs);
> >   		if (ret)
> >   			goto out;
> >   	}
> > @@ -382,7 +400,7 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
> >   
> >   static struct scp *init_scp(struct platform_device *pdev,
> >   			const struct scp_domain_data *scp_domain_data, int num,
> > -			const struct scp_ctrl_reg *scp_ctrl_reg)
> > +			const struct soc_reg *soc_reg)
> >   {
> >   	struct genpd_onecell_data *pd_data;
> >   	struct resource *res;
> > @@ -394,8 +412,13 @@ static struct scp *init_scp(struct platform_device *pdev,
> >   	if (!scp)
> >   		return ERR_PTR(-ENOMEM);
> >   
> > -	scp->ctrl_reg.pwr_sta_offs = scp_ctrl_reg->pwr_sta_offs;
> > -	scp->ctrl_reg.pwr_sta2nd_offs = scp_ctrl_reg->pwr_sta2nd_offs;
> > +	scp->soc_reg.scp_ctrl.pwr_sta_offs = soc_reg->scp_ctrl.pwr_sta_offs;
> > +	scp->soc_reg.scp_ctrl.pwr_sta2nd_offs =
> > +			soc_reg->scp_ctrl.pwr_sta2nd_offs;
> > +	scp->soc_reg.bus_prot.set_offs = soc_reg->bus_prot.set_offs;
> > +	scp->soc_reg.bus_prot.clr_offs = soc_reg->bus_prot.clr_offs;
> > +	scp->soc_reg.bus_prot.en_offs = soc_reg->bus_prot.en_offs;
> > +	scp->soc_reg.bus_prot.sta_offs = soc_reg->bus_prot.sta_offs;
> >   
> >   	scp->dev = &pdev->dev;
> >   
> > @@ -814,8 +837,14 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >   	.domains = scp_domain_data_mt2701,
> >   	.num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
> >   	.regs = {
> > -		.pwr_sta_offs = SPM_PWR_STATUS,
> > -		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> > +		.scp_ctrl = {
> > +			.pwr_sta_offs = SPM_PWR_STATUS,
> > +			.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> > +		},
> > +		.bus_prot = {
> > +			.en_offs = INFRA_TOPAXI_PROTECTEN,
> > +			.sta_offs = INFRA_TOPAXI_PROTECTSTA1
> > +		},
> >   	}
> >   };
> >   
> > @@ -825,8 +854,14 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >   	.subdomains = scp_subdomain_mt6797,
> >   	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt6797),
> >   	.regs = {
> > -		.pwr_sta_offs = SPM_PWR_STATUS_MT6797,
> > -		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797
> > +		.scp_ctrl = {
> > +			.pwr_sta_offs = SPM_PWR_STATUS_MT6797,
> > +			.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797
> > +		},
> > +		.bus_prot = {
> > +			.en_offs = INFRA_TOPAXI_PROTECTEN,
> > +			.sta_offs = INFRA_TOPAXI_PROTECTSTA1
> > +		},
> >   	}
> >   };
> >   
> > @@ -834,8 +869,14 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >   	.domains = scp_domain_data_mt7622,
> >   	.num_domains = ARRAY_SIZE(scp_domain_data_mt7622),
> >   	.regs = {
> > -		.pwr_sta_offs = SPM_PWR_STATUS,
> > -		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> > +		.scp_ctrl = {
> > +			.pwr_sta_offs = SPM_PWR_STATUS,
> > +			.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> > +		},
> > +		.bus_prot = {
> > +			.en_offs = INFRA_TOPAXI_PROTECTEN,
> > +			.sta_offs = INFRA_TOPAXI_PROTECTSTA1
> > +		},
> >   	}
> >   };
> >   
> > @@ -845,8 +886,14 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >   	.subdomains = scp_subdomain_mt8173,
> >   	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt8173),
> >   	.regs = {
> > -		.pwr_sta_offs = SPM_PWR_STATUS,
> > -		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> > +		.scp_ctrl = {
> > +			.pwr_sta_offs = SPM_PWR_STATUS,
> > +			.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> > +		},
> > +		.bus_prot = {
> > +			.en_offs = INFRA_TOPAXI_PROTECTEN,
> > +			.sta_offs = INFRA_TOPAXI_PROTECTSTA1
> > +		},
> >   	}
> >   };
> >   
> > diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> > index a0182ec..c704af5 100644
> > --- a/include/linux/soc/mediatek/infracfg.h
> > +++ b/include/linux/soc/mediatek/infracfg.h
> > @@ -1,6 +1,11 @@
> >   #ifndef __SOC_MEDIATEK_INFRACFG_H
> >   #define __SOC_MEDIATEK_INFRACFG_H
> >   
> > +#define INFRA_TOPAXI_PROTECTEN		0x0220
> > +#define INFRA_TOPAXI_PROTECTSTA1	0x0228
> > +#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
> > +#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
> 
> The last two a never used.

Currently, the last two would be used in Patch 8 like below, will be
related by how bus protect API is implemented.
+static const struct scp_soc_data mt2712_data = {
+       .domains = scp_domain_data_mt2712,
+       .num_domains = ARRAY_SIZE(scp_domain_data_mt2712),
+       .regs = {
+               .scp_ctrl = {
+                       .pwr_sta_offs = SPM_PWR_STATUS,
+                       .pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
+               },
+               .bus_prot = {
+                       .set_offs = INFRA_TOPAXI_PROTECTEN_SET,
+                       .clr_offs = INFRA_TOPAXI_PROTECTEN_CLR,
+                       .sta_offs = INFRA_TOPAXI_PROTECTSTA1
+               },
+       }
+};
> 
> > +
> >   #define MT8173_TOP_AXI_PROT_EN_MCI_M2		BIT(0)
> >   #define MT8173_TOP_AXI_PROT_EN_MM_M0		BIT(1)
> >   #define MT8173_TOP_AXI_PROT_EN_MM_M1		BIT(2)
> > @@ -27,7 +32,8 @@
> >   #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
> >   						 BIT(7) | BIT(8))
> >   
> > -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask);
> > -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask);
> > -
> > +int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> > +		u32 reg_set, u32 reg_en, u32 reg_sta);
> > +int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> > +		u32 reg_clr, u32 reg_en, u32 reg_sta);
> >   #endif /* __SOC_MEDIATEK_INFRACFG_H */
> > 
