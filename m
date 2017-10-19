From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 19:20:15 +0200
Subject: [PATCH v5 6/9] soc: mediatek: extend bus protection API
In-Reply-To: <1508381330-3700-7-git-send-email-weiyi.lu@mediatek.com>
References: <1508381330-3700-1-git-send-email-weiyi.lu@mediatek.com>
 <1508381330-3700-7-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <ca39cefb-7ab2-dc6a-8fd6-04a440cf20bb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/19/2017 04:48 AM, Weiyi Lu wrote:
> MT2712 add "set/clear" bus control register to each control register set
> instead of providing only one "enable" control register, we could avoid
> the read-modify-write racing by using extend API with such new design.
> By improving the mtk-infracfg bus protection implementation to
> support set/clear bus protection control method by IC configuration.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-infracfg.c   | 24 ++++++++++++++++++++----
>  drivers/soc/mediatek/mtk-scpsys.c     | 28 ++++++++++++++++++++--------
>  include/linux/soc/mediatek/infracfg.h |  7 ++++---
>  3 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> index dba3055..344ffba 100644
> --- a/drivers/soc/mediatek/mtk-infracfg.c
> +++ b/drivers/soc/mediatek/mtk-infracfg.c
> @@ -19,23 +19,32 @@
>  
>  #define INFRA_TOPAXI_PROTECTEN		0x0220
>  #define INFRA_TOPAXI_PROTECTSTA1	0x0228
> +#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
> +#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
>  
>  /**
>   * mtk_infracfg_set_bus_protection - enable bus protection
>   * @regmap: The infracfg regmap
>   * @mask: The mask containing the protection bits to be enabled.
> + * @use_reg_set: The boolean flag determines to set the protection bits
> + *               by set register or enable register

Huh, I thought it does or write the whole register or just enables the necessary
bits.

>   *
>   * This function enables the bus protection bits for disabled power
>   * domains so that the system does not hang when some unit accesses the
>   * bus while in power down.
>   */
> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
> +int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> +		bool use_reg_set)

Please rename the variable to something that makes you understand what it does.
Actually I find it easier to swap the if statement and use reg_update as
variable name.

>  {
>  	unsigned long expired;
>  	u32 val;
>  	int ret;
>  
> -	regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, mask);
> +	if (use_reg_set)
> +		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> +	else
> +		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask,
> +				mask);
>  
>  	expired = jiffies + HZ;
>  
> @@ -59,16 +68,23 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask)
>   * mtk_infracfg_clear_bus_protection - disable bus protection
>   * @regmap: The infracfg regmap
>   * @mask: The mask containing the protection bits to be disabled.
> + * @use_reg_clr: The boolean flag determines to clear the protection bits
> + *               by clear register or enable register

same here.

>   *
>   * This function disables the bus protection bits previously enabled with
>   * mtk_infracfg_set_bus_protection.
>   */
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask)
> +
> +int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> +		bool use_reg_clr)

same here.

>  {
>  	unsigned long expired;
>  	int ret;
>  
> -	regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> +	if (use_reg_clr)
> +		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> +	else
> +		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
>  
>  	expired = jiffies + HZ;
>  
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index e1ce8b1..ebee3e9 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -134,6 +134,7 @@ struct scp {
>  	void __iomem *base;
>  	struct regmap *infracfg;
>  	struct scp_ctrl_reg ctrl_reg;
> +	bool bus_prot_use_set_clr_reg;
>  };
>  
>  struct scp_subdomain {
> @@ -147,6 +148,7 @@ struct scp_soc_data {
>  	const struct scp_subdomain *subdomains;
>  	int num_subdomains;
>  	const struct scp_ctrl_reg regs;
> +	bool bus_prot_use_set_clr_reg;

bus_prot_reg_update or something like this?

Thanks,
Matthias

>  };
>  
>  static int scpsys_domain_is_on(struct scp_domain *scpd)
> @@ -254,7 +256,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  
>  	if (scpd->data->bus_prot_mask) {
>  		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> -				scpd->data->bus_prot_mask);
> +				scpd->data->bus_prot_mask,z
> +				scp->bus_prot_use_set_clr_reg);
>  		if (ret)
>  			goto err_pwr_ack;
>  	}
> @@ -289,7 +292,8 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  
>  	if (scpd->data->bus_prot_mask) {
>  		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> -				scpd->data->bus_prot_mask);
> +				scpd->data->bus_prot_mask,
> +				scp->bus_prot_use_set_clr_reg);
>  		if (ret)
>  			goto out;
>  	}
> @@ -382,7 +386,8 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
>  
>  static struct scp *init_scp(struct platform_device *pdev,
>  			const struct scp_domain_data *scp_domain_data, int num,
> -			const struct scp_ctrl_reg *scp_ctrl_reg)
> +			const struct scp_ctrl_reg *scp_ctrl_reg,
> +			bool bus_prot_use_set_clr_reg)
>  {
>  	struct genpd_onecell_data *pd_data;
>  	struct resource *res;
> @@ -397,6 +402,8 @@ static struct scp *init_scp(struct platform_device *pdev,
>  	scp->ctrl_reg.pwr_sta_offs = scp_ctrl_reg->pwr_sta_offs;
>  	scp->ctrl_reg.pwr_sta2nd_offs = scp_ctrl_reg->pwr_sta2nd_offs;
>  
> +	scp->bus_prot_use_set_clr_reg = bus_prot_use_set_clr_reg;
> +
>  	scp->dev = &pdev->dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -816,7 +823,8 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  	.regs = {
>  		.pwr_sta_offs = SPM_PWR_STATUS,
>  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> -	}
> +	},
> +	.bus_prot_use_set_clr_reg = false,
>  };
>  
>  static const struct scp_soc_data mt6797_data = {
> @@ -827,7 +835,8 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  	.regs = {
>  		.pwr_sta_offs = SPM_PWR_STATUS_MT6797,
>  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797
> -	}
> +	},
> +	.bus_prot_use_set_clr_reg = false,
>  };
>  
>  static const struct scp_soc_data mt7622_data = {
> @@ -836,7 +845,8 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  	.regs = {
>  		.pwr_sta_offs = SPM_PWR_STATUS,
>  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> -	}
> +	},
> +	.bus_prot_use_set_clr_reg = false,
>  };
>  
>  static const struct scp_soc_data mt8173_data = {
> @@ -847,7 +857,8 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  	.regs = {
>  		.pwr_sta_offs = SPM_PWR_STATUS,
>  		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> -	}
> +	},
> +	.bus_prot_use_set_clr_reg = false,
>  };
>  
>  /*
> @@ -884,7 +895,8 @@ static int scpsys_probe(struct platform_device *pdev)
>  	match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
>  	soc = (const struct scp_soc_data *)match->data;
>  
> -	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs);
> +	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
> +			soc->bus_prot_use_set_clr_reg);
>  	if (IS_ERR(scp))
>  		return PTR_ERR(scp);
>  
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index a0182ec..7df0fc8 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -27,7 +27,8 @@
>  #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
>  						 BIT(7) | BIT(8))
>  
> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask);
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask);
> -
> +int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> +		bool use_reg_set);
> +int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> +		bool use_reg_clr);
>  #endif /* __SOC_MEDIATEK_INFRACFG_H */
> 
