From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 17 Apr 2018 16:37:29 +0200
Subject: [PATCH] soc: mediatek: use of_device_get_match_data()
In-Reply-To: <b7fffebff04c6b717c568194ac7503144a3302a8.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
 <b7fffebff04c6b717c568194ac7503144a3302a8.1523347340.git.ryder.lee@mediatek.com>
Message-ID: <ca67f622-d624-81c1-b8f4-eb5dfe4d5dab@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/16/2018 04:33 AM, Ryder Lee wrote:
> The usage of of_device_get_match_data() reduce the code size a bit.
> 
> Also, the only way to call pwrap_probe() is to match an entry in
> of_pwrap_match_tbl[], so of_id cannot be NULL.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to v4.17-next/soc

Thanks.

>  drivers/soc/mediatek/mtk-pmic-wrap.c | 13 +++----------
>  drivers/soc/mediatek/mtk-scpsys.c    |  4 +---
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index e9e054a..2afae64 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1458,19 +1458,12 @@ static int pwrap_probe(struct platform_device *pdev)
>  	int ret, irq;
>  	struct pmic_wrapper *wrp;
>  	struct device_node *np = pdev->dev.of_node;
> -	const struct of_device_id *of_id =
> -		of_match_device(of_pwrap_match_tbl, &pdev->dev);
>  	const struct of_device_id *of_slave_id = NULL;
>  	struct resource *res;
>  
> -	if (!of_id) {
> -		dev_err(&pdev->dev, "Error: No device match found\n");
> -		return -ENODEV;
> -	}
> +	if (np->child)
> +		of_slave_id = of_match_node(of_slave_match_tbl, np->child);
>  
> -	if (pdev->dev.of_node->child)
> -		of_slave_id = of_match_node(of_slave_match_tbl,
> -					    pdev->dev.of_node->child);
>  	if (!of_slave_id) {
>  		dev_dbg(&pdev->dev, "slave pmic should be defined in dts\n");
>  		return -EINVAL;
> @@ -1482,7 +1475,7 @@ static int pwrap_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, wrp);
>  
> -	wrp->master = of_id->data;
> +	wrp->master = of_device_get_match_data(&pdev->dev);
>  	wrp->slave = of_slave_id->data;
>  	wrp->dev = &pdev->dev;
>  
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 435ce5e..a02a18e 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -973,15 +973,13 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  
>  static int scpsys_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match;
>  	const struct scp_subdomain *sd;
>  	const struct scp_soc_data *soc;
>  	struct scp *scp;
>  	struct genpd_onecell_data *pd_data;
>  	int i, ret;
>  
> -	match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
> -	soc = (const struct scp_soc_data *)match->data;
> +	soc = of_device_get_match_data(&pdev->dev);
>  
>  	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
>  			soc->bus_prot_reg_update);
> 
