From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Oct 2016 16:04:05 +0200
Subject: [PATCH v9 1/4] soc: mediatek: Refine scpsys to support multiple
 platform
In-Reply-To: <1476953798-23263-2-git-send-email-jamesjj.liao@mediatek.com>
References: <1476953798-23263-1-git-send-email-jamesjj.liao@mediatek.com>
 <1476953798-23263-2-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1d5cda95-467a-4f95-1cc9-b8f156271a54@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 10/20/2016 10:56 AM, James Liao wrote:
> -static int scpsys_probe(struct platform_device *pdev)
> +static void init_clks(struct platform_device *pdev, struct clk *clk[CLK_MAX])

I prefer struct clk **clk.

> +{
> +	int i;
> +
> +	for (i = CLK_NONE + 1; i < CLK_MAX; i++)
> +		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> +}
> +
> +static struct scp *init_scp(struct platform_device *pdev,
> +			const struct scp_domain_data *scp_domain_data, int num)
>  {
>  	struct genpd_onecell_data *pd_data;
>  	struct resource *res;
> -	int i, j, ret;
> +	int i, j;
>  	struct scp *scp;
> -	struct clk *clk[MT8173_CLK_MAX];
> +	struct clk *clk[CLK_MAX];

should be *[CLK_MAX - 1] but I would prefer to define in the enum:
CLK_MAX = CLK_VENC_LT,

If you are ok with it, I can fix both of my comments when applying.

Regards,
Matthias
