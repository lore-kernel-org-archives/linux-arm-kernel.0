From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 27 Jan 2017 13:44:49 +0100
Subject: [PATCH] Net: ethernet: mediatek - Fix possible NULL derefrence.
In-Reply-To: <1485515980-3814-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170127111947epcas2p14f5ea86f0069142be02339754fda4a55@epcas2p1.samsung.com>
 <1485515980-3814-1-git-send-email-shailendra.v@samsung.com>
Message-ID: <20170127124449.GB13611@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 04:49:40PM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 4a62ffd..4495b7b 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2369,6 +2369,10 @@ static int mtk_probe(struct platform_device *pdev)
>  	int i;
>  
>  	match = of_match_device(of_mtk_match, &pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "Error: No device match found\n");
> +		return -ENODEV;
> +	}
>  	soc = (struct mtk_soc_data *)match->data;
>  
>  	eth = devm_kzalloc(&pdev->dev, sizeof(*eth), GFP_KERNEL);
> -- 

Hello

You could use of_device_get_match_data() and simplifiy code

Regards
Corentin Labbe
