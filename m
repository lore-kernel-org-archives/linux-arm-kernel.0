From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 11 Mar 2018 23:51:17 +0100
Subject: [PATCH] soc: mediatek: fix the mistaken pointer accessed when
 subdomains are added
In-Reply-To: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
References: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
Message-ID: <b3923ae4-3fb4-c107-e7df-cd9d3c5f0652@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/08/2018 07:07 PM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix the pointer to struct scp_subdomian not being moved forward
> when each sub-domain is expected to be iteratively added through
> pm_genpd_add_subdomain call.
> 
> Cc: stable at vger.kernel.org
> Fixes: 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
> Reported-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Pushed now to v4.16-next/soc

Thanks a lot

@stable this would need to be applied since v4.13

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index fc55faa..9de801e 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -1048,7 +1048,7 @@ static int scpsys_probe(struct platform_device *pdev)
>  
>  	pd_data = &scp->pd_data;
>  
> -	for (i = 0, sd = soc->subdomains ; i < soc->num_subdomains ; i++) {
> +	for (i = 0, sd = soc->subdomains; i < soc->num_subdomains; i++, sd++) {
>  		ret = pm_genpd_add_subdomain(pd_data->domains[sd->origin],
>  					     pd_data->domains[sd->subdomain]);
>  		if (ret && IS_ENABLED(CONFIG_PM))
> 
