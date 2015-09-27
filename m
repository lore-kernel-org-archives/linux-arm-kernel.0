From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 27 Sep 2015 13:25:24 +0200
Subject: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
In-Reply-To: <1443169573.3135.9.camel@pengutronix.de>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
 <1443169573.3135.9.camel@pengutronix.de>
Message-ID: <5607D224.4050801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/09/15 10:26, Lucas Stach wrote:
> Am Freitag, den 25.09.2015, 14:31 +0800 schrieb James Liao:
>> In kernel late init, it turns off all unused clocks, which
>> needs to access subsystem registers such as VENC and VENC_LT.
>>
>> Accessing MT8173 VENC registers needs two top clocks, mm_sel and
>> venc_sel. Accessing VENC_LT registers needs mm_sel and venclt_sel.
>> So we need to keep these clocks on before accessing their registers.
>>
>> This patch keeps venc_sel / venclt_sel clock on when
>> VENC / VENC_LT's power is on, to prevent system hang up while
>> accessing its registeres.
>>
> This changes the binding of an existing driver, so it needs some more
> consideration. Are VENC_SEL and VENC_LT_SEL really direct clock inputs
> to the VENC module, or are they some kind of parent clock for one of the
> existing clocks used by the old VENC binding?
>
> If they are direct clock inputs to the VENC module, changing the binding
> might be still ok at that point, as there shouldn't be many users of
> that yet. But then we at least need a corresponding change to the
> binding documentation.
>

Yes, we will need a really good reason to change the bindings. Apart 
from that we would need to find a solution which works with the old (and 
wrong bindings) as well.

Apart from that, please send the dtsi part as a seperate patch.

Thanks,
Matthias

> Regards,
> Lucas
>
>> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
>> ---
>>
>> This patch is based on v4.3-rc2, to fix system hanging up issue
>> while disabling unused clocks.
>>
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi |  6 ++-
>>   drivers/soc/mediatek/mtk-scpsys.c        | 67 +++++++++++++++++++++-----------
>>   2 files changed, 48 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index d18ee42..188917f 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -227,8 +227,10 @@
>>   			#power-domain-cells = <1>;
>>   			reg = <0 0x10006000 0 0x1000>;
>>   			clocks = <&clk26m>,
>> -				 <&topckgen CLK_TOP_MM_SEL>;
>> -			clock-names = "mfg", "mm";
>> +				 <&topckgen CLK_TOP_MM_SEL>,
>> +				 <&topckgen CLK_TOP_VENC_SEL>,
>> +				 <&topckgen CLK_TOP_VENC_LT_SEL>;
>> +			clock-names = "mfg", "mm", "venc", "venc_lt";
>>   			infracfg = <&infracfg>;
>>   		};
>>
>> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
>> index 164a7d8..06032ba 100644
>> --- a/drivers/soc/mediatek/mtk-scpsys.c
>> +++ b/drivers/soc/mediatek/mtk-scpsys.c
>> @@ -54,12 +54,16 @@
>>   #define PWR_STATUS_USB			BIT(25)
>>
>>   enum clk_id {
>> +	MT8173_CLK_NONE,
>>   	MT8173_CLK_MM,
>>   	MT8173_CLK_MFG,
>> -	MT8173_CLK_NONE,
>> -	MT8173_CLK_MAX = MT8173_CLK_NONE,
>> +	MT8173_CLK_VENC,
>> +	MT8173_CLK_VENC_LT,
>> +	MT8173_CLK_MAX,
>>   };
>>
>> +#define MAX_CLKS	2
>> +
>>   struct scp_domain_data {
>>   	const char *name;
>>   	u32 sta_mask;
>> @@ -67,7 +71,7 @@ struct scp_domain_data {
>>   	u32 sram_pdn_bits;
>>   	u32 sram_pdn_ack_bits;
>>   	u32 bus_prot_mask;
>> -	enum clk_id clk_id;
>> +	enum clk_id clk_id[MAX_CLKS];
>>   };
>>
>>   static const struct scp_domain_data scp_domain_data[] __initconst = {
>> @@ -77,7 +81,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_VDE_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(12, 12),
>> -		.clk_id = MT8173_CLK_MM,
>> +		.clk_id = {MT8173_CLK_MM},
>>   	},
>>   	[MT8173_POWER_DOMAIN_VENC] = {
>>   		.name = "venc",
>> @@ -85,7 +89,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_VEN_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(15, 12),
>> -		.clk_id = MT8173_CLK_MM,
>> +		.clk_id = {MT8173_CLK_MM, MT8173_CLK_VENC},
>>   	},
>>   	[MT8173_POWER_DOMAIN_ISP] = {
>>   		.name = "isp",
>> @@ -93,7 +97,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_ISP_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(13, 12),
>> -		.clk_id = MT8173_CLK_MM,
>> +		.clk_id = {MT8173_CLK_MM},
>>   	},
>>   	[MT8173_POWER_DOMAIN_MM] = {
>>   		.name = "mm",
>> @@ -101,7 +105,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_DIS_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(12, 12),
>> -		.clk_id = MT8173_CLK_MM,
>> +		.clk_id = {MT8173_CLK_MM},
>>   		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
>>   			MT8173_TOP_AXI_PROT_EN_MM_M1,
>>   	},
>> @@ -111,7 +115,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_VEN2_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(15, 12),
>> -		.clk_id = MT8173_CLK_MM,
>> +		.clk_id = {MT8173_CLK_MM, MT8173_CLK_VENC_LT},
>>   	},
>>   	[MT8173_POWER_DOMAIN_AUDIO] = {
>>   		.name = "audio",
>> @@ -119,7 +123,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_AUDIO_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(15, 12),
>> -		.clk_id = MT8173_CLK_NONE,
>> +		.clk_id = {MT8173_CLK_NONE},
>>   	},
>>   	[MT8173_POWER_DOMAIN_USB] = {
>>   		.name = "usb",
>> @@ -127,7 +131,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_USB_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(15, 12),
>> -		.clk_id = MT8173_CLK_NONE,
>> +		.clk_id = {MT8173_CLK_NONE},
>>   	},
>>   	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
>>   		.name = "mfg_async",
>> @@ -135,7 +139,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = 0,
>> -		.clk_id = MT8173_CLK_MFG,
>> +		.clk_id = {MT8173_CLK_MFG},
>>   	},
>>   	[MT8173_POWER_DOMAIN_MFG_2D] = {
>>   		.name = "mfg_2d",
>> @@ -143,7 +147,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_MFG_2D_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(11, 8),
>>   		.sram_pdn_ack_bits = GENMASK(13, 12),
>> -		.clk_id = MT8173_CLK_NONE,
>> +		.clk_id = {MT8173_CLK_NONE},
>>   	},
>>   	[MT8173_POWER_DOMAIN_MFG] = {
>>   		.name = "mfg",
>> @@ -151,7 +155,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>>   		.ctl_offs = SPM_MFG_PWR_CON,
>>   		.sram_pdn_bits = GENMASK(13, 8),
>>   		.sram_pdn_ack_bits = GENMASK(21, 16),
>> -		.clk_id = MT8173_CLK_NONE,
>> +		.clk_id = {MT8173_CLK_NONE},
>>   		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
>>   			MT8173_TOP_AXI_PROT_EN_MFG_M0 |
>>   			MT8173_TOP_AXI_PROT_EN_MFG_M1 |
>> @@ -166,7 +170,7 @@ struct scp;
>>   struct scp_domain {
>>   	struct generic_pm_domain genpd;
>>   	struct scp *scp;
>> -	struct clk *clk;
>> +	struct clk *clk[MAX_CLKS];
>>   	u32 sta_mask;
>>   	void __iomem *ctl_addr;
>>   	u32 sram_pdn_bits;
>> @@ -212,11 +216,16 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>>   	u32 sram_pdn_ack = scpd->sram_pdn_ack_bits;
>>   	u32 val;
>>   	int ret;
>> +	int i;
>> +
>> +	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++) {
>> +		ret = clk_prepare_enable(scpd->clk[i]);
>> +		if (ret) {
>> +			for (--i; i >= 0; i--)
>> +				clk_disable_unprepare(scpd->clk[i]);
>>
>> -	if (scpd->clk) {
>> -		ret = clk_prepare_enable(scpd->clk);
>> -		if (ret)
>>   			goto err_clk;
>> +		}
>>   	}
>>
>>   	val = readl(ctl_addr);
>> @@ -282,7 +291,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>>   	return 0;
>>
>>   err_pwr_ack:
>> -	clk_disable_unprepare(scpd->clk);
>> +	for (i = MAX_CLKS - 1; i >= 0; i--) {
>> +		if (scpd->clk[i])
>> +			clk_disable_unprepare(scpd->clk[i]);
>> +	}
>>   err_clk:
>>   	dev_err(scp->dev, "Failed to power on domain %s\n", genpd->name);
>>
>> @@ -299,6 +311,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>>   	u32 pdn_ack = scpd->sram_pdn_ack_bits;
>>   	u32 val;
>>   	int ret;
>> +	int i;
>>
>>   	if (scpd->bus_prot_mask) {
>>   		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
>> @@ -360,8 +373,8 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>>   			expired = true;
>>   	}
>>
>> -	if (scpd->clk)
>> -		clk_disable_unprepare(scpd->clk);
>> +	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
>> +		clk_disable_unprepare(scpd->clk[i]);
>>
>>   	return 0;
>>
>> @@ -375,7 +388,7 @@ static int __init scpsys_probe(struct platform_device *pdev)
>>   {
>>   	struct genpd_onecell_data *pd_data;
>>   	struct resource *res;
>> -	int i, ret;
>> +	int i, j, ret;
>>   	struct scp *scp;
>>   	struct clk *clk[MT8173_CLK_MAX];
>>
>> @@ -405,6 +418,14 @@ static int __init scpsys_probe(struct platform_device *pdev)
>>   	if (IS_ERR(clk[MT8173_CLK_MFG]))
>>   		return PTR_ERR(clk[MT8173_CLK_MFG]);
>>
>> +	clk[MT8173_CLK_VENC] = devm_clk_get(&pdev->dev, "venc");
>> +	if (IS_ERR(clk[MT8173_CLK_VENC]))
>> +		return PTR_ERR(clk[MT8173_CLK_VENC]);
>> +
>> +	clk[MT8173_CLK_VENC_LT] = devm_clk_get(&pdev->dev, "venc_lt");
>> +	if (IS_ERR(clk[MT8173_CLK_VENC_LT]))
>> +		return PTR_ERR(clk[MT8173_CLK_VENC_LT]);
>> +
>>   	scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>>   			"infracfg");
>>   	if (IS_ERR(scp->infracfg)) {
>> @@ -428,8 +449,8 @@ static int __init scpsys_probe(struct platform_device *pdev)
>>   		scpd->sram_pdn_bits = data->sram_pdn_bits;
>>   		scpd->sram_pdn_ack_bits = data->sram_pdn_ack_bits;
>>   		scpd->bus_prot_mask = data->bus_prot_mask;
>> -		if (data->clk_id != MT8173_CLK_NONE)
>> -			scpd->clk = clk[data->clk_id];
>> +		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++)
>> +			scpd->clk[j] = clk[data->clk_id[j]];
>>
>>   		genpd->name = data->name;
>>   		genpd->power_off = scpsys_power_off;
>
