From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 21 Jan 2016 13:27:41 +0800
Subject: [PATCH v4 1/4] soc: mediatek: Refine scpsys to support multiple
 platform
In-Reply-To: <1453281244.16515.3.camel@mtksdaap41>
References: <1453270097-53853-1-git-send-email-jamesjj.liao@mediatek.com>
 <1453270097-53853-2-git-send-email-jamesjj.liao@mediatek.com>
 <1453281244.16515.3.camel@mtksdaap41>
Message-ID: <1453354061.5384.40.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-01-20 at 17:14 +0800, Yingjoe Chen wrote:
> On Wed, 2016-01-20 at 14:08 +0800, James Liao wrote:
> > Refine scpsys driver common code to support multiple SoC / platform.
> > 
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> <...>
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
> > new file mode 100644
> > index 0000000..e435bc3
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-scpsys.h
> > @@ -0,0 +1,55 @@
> > +#ifndef __DRV_SOC_MTK_H
> > +#define __DRV_SOC_MTK_H
> > +
> > +enum clk_id {
> > +	CLK_NONE,
> > +	CLK_MM,
> > +	CLK_MFG,
> > +	CLK_VENC,
> > +	CLK_VENC_LT,
> > +	CLK_MAX,
> > +};
> > +
> > +#define MAX_CLKS	2
> > +
> > +struct scp_domain_data {
> > +	const char *name;
> > +	u32 sta_mask;
> > +	int ctl_offs;
> > +	u32 sram_pdn_bits;
> > +	u32 sram_pdn_ack_bits;
> > +	u32 bus_prot_mask;
> > +	enum clk_id clk_id[MAX_CLKS];
> > +	bool active_wakeup;
> > +};
> > +
> > +struct scp;
> > +
> > +struct scp_domain {
> > +	struct generic_pm_domain genpd;
> > +	struct scp *scp;
> > +	struct clk *clk[MAX_CLKS];
> > +	u32 sta_mask;
> > +	void __iomem *ctl_addr;
> > +	u32 sram_pdn_bits;
> > +	u32 sram_pdn_ack_bits;
> > +	u32 bus_prot_mask;
> > +	bool active_wakeup;
> > +	struct regulator *supply;
> > +};
> > +
> > +struct scp {
> > +	struct scp_domain *domains;
> > +	struct genpd_onecell_data pd_data;
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct regmap *infracfg;
> > +};
> > +
> > +struct scp *init_scp(struct platform_device *pdev,
> > +			const struct scp_domain_data *scp_domain_data, int num);
> > +
> > +void mtk_register_power_domains(struct platform_device *pdev,
> > +				struct scp *scp, int num);
> > +
> > +#endif /* __DRV_SOC_MTK_H */
> 
> After merge, only mtk-scpsys.c will use this file. I think it make sense
> to just include them in mtk-scpsys.c. Also init_scp and
> mtk_register_power_domains can be static now.

Hi Yingjoe,

OK. I can merge this header file into mtk-scpsys.c when we confirmed the
MT8173 + MT2701 implementation is OK.


Hi Matthias,

Do you have suggestions for this implementation that merge MT8173 and
MT2701 support in the same file?


Best regards,

James
