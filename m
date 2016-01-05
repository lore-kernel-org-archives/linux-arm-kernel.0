From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 05 Jan 2016 10:30:01 +0100
Subject: [PATCH v2 4/6] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1451975422-31174-5-git-send-email-jamesjj.liao@mediatek.com>
References: <1451975422-31174-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451975422-31174-5-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1451986201.3391.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Am Dienstag, den 05.01.2016, 14:30 +0800 schrieb James Liao:
> From: Shunli Wang <shunli.wang@mediatek.com>
> 
> Add MT2701 clock support, include topckgen, apmixedsys,
> infracfg, pericfg and subsystem clocks.
> 
> Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig      |    8 +
>  drivers/clk/mediatek/Makefile     |    1 +
>  drivers/clk/mediatek/clk-gate.c   |   56 ++
>  drivers/clk/mediatek/clk-gate.h   |    2 +
>  drivers/clk/mediatek/clk-mt2701.c | 1210 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.c    |   25 +
>  drivers/clk/mediatek/clk-mtk.h    |   35 +-
>  7 files changed, 1334 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt2701.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index dc224e6..6c7cdc0 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -6,6 +6,14 @@ config COMMON_CLK_MEDIATEK
>  	---help---
>  	  Mediatek SoCs' clock support.
>  
> +config COMMON_CLK_MT2701
> +	bool "Clock driver for Mediatek MT2701 and MT7623"
> +	depends on COMMON_CLK
> +	select COMMON_CLK_MEDIATEK
> +	default ARCH_MEDIATEK
> +	---help---
> +	  This driver supports Mediatek MT2701 and MT7623 clocks.
> +
>  config COMMON_CLK_MT8135
>  	bool "Clock driver for Mediatek MT8135"
>  	depends on COMMON_CLK
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 32e7222..5b2b91b 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o
>  obj-$(CONFIG_RESET_CONTROLLER) += reset.o
> +obj-$(CONFIG_COMMON_CLK_MT2701) += clk-mt2701.o
>  obj-$(CONFIG_COMMON_CLK_MT8135) += clk-mt8135.o
>  obj-$(CONFIG_COMMON_CLK_MT8173) += clk-mt8173.o
> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
> index 576bdb7..38badb4 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -61,6 +61,26 @@ static void mtk_cg_clr_bit(struct clk_hw *hw)
>  	regmap_write(cg->regmap, cg->clr_ofs, BIT(cg->bit));
>  }
>  
> +static void mtk_cg_set_bit_no_setclr(struct clk_hw *hw)
> +{
> +	struct mtk_clk_gate *cg = to_clk_gate(hw);
> +	u32 val;
> +
> +	regmap_read(cg->regmap, cg->sta_ofs, &val);
> +	val |= BIT(cg->bit);
> +	regmap_write(cg->regmap, cg->sta_ofs, val);

You can use regmap_update_bits here:

	u32 bit = BIT(cg->bit);
	regmap_update_bits(cg->regmap, cg->sta_ofs, bit, bit);

> +}
> +
> +static void mtk_cg_clr_bit_no_setclr(struct clk_hw *hw)
> +{
> +	struct mtk_clk_gate *cg = to_clk_gate(hw);
> +	u32 val;
> +
> +	regmap_read(cg->regmap, cg->sta_ofs, &val);
> +	val &= ~(BIT(cg->bit));
> +	regmap_write(cg->regmap, cg->sta_ofs, val);

and here:

	u32 bit = BIT(cg->bit);
	regmap_update_bits(cg->regmap, cg->sta_ofs, bit, 0);

best regards
Philipp
