From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 23 Mar 2016 10:00:50 +0100
Subject: [PATCH] net: mediatek: fix checking for NULL instead of IS_ERR()
 in .probe
In-Reply-To: <1458687964-9690-1-git-send-email-vz@mleia.com>
References: <1458687964-9690-1-git-send-email-vz@mleia.com>
Message-ID: <56F25B42.5030005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/03/16 00:06, Vladimir Zapolskiy wrote:
> devm_ioremap_resource() returns ERR_PTR() value on error, it never
> returns NULL, fix it and propagate the returned error upwards.
>
> Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

>   drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 7f2126b..e0b68af 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1690,8 +1690,8 @@ static int mtk_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>
>   	eth->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (!eth->base)
> -		return -EADDRNOTAVAIL;
> +	if (IS_ERR(eth->base))
> +		return PTR_ERR(eth->base);
>
>   	spin_lock_init(&eth->page_lock);
>
>
