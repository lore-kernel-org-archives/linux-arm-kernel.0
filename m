From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Aug 2016 10:50:49 -0700
Subject: [PATCH v12 2/4] reset: mediatek: Add MT2701 reset driver
In-Reply-To: <1471854565-19810-3-git-send-email-erin.lo@mediatek.com>
References: <1471854565-19810-1-git-send-email-erin.lo@mediatek.com>
 <1471854565-19810-3-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160824175049.GC19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22, Erin Lo wrote:
> diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
> index 18b4ab5..702fd74 100644
> --- a/drivers/clk/mediatek/clk-mt2701-hif.c
> +++ b/drivers/clk/mediatek/clk-mt2701-hif.c
> @@ -52,11 +52,15 @@ static int mtk_hifsys_init(struct device_node *node)
>  						clk_data);
>  
>  	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> -	if (r)
> +	if (r) {
>  		pr_err("%s(): could not register clock provider: %d\n",
>  			__func__, r);
> +		return r;
> +	}
> +
> +	mtk_register_reset_controller(node, 1, 0x34);

The cleanup here isn't great. mtk_register_reset_controller()
should really return an error so that we can properly cleanup if
needed. Fixing that in a later patch would be a good idea.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
