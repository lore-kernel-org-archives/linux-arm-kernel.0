From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 21 Sep 2018 10:01:40 +0800
Subject: [PATCH -next] pinctrl: mediatek: moore: fix return value check
 in mtk_moore_pinctrl_probe()
In-Reply-To: <1537424510-23623-1-git-send-email-weiyongjun1@huawei.com>
References: <1537424510-23623-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <1537495300.9654.2.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-09-20 at 06:21 +0000, Wei Yongjun wrote:
> In case of error, the function devm_kmalloc_array() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: b7d7f9eeca55 ("pinctrl: mediatek: extend struct mtk_pin_desc which per-pin driver depends on")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Sean Wang <sean.wang@mediatek.com>

> ---
>  drivers/pinctrl/mediatek/pinctrl-moore.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
> index c27597c..3bf5dd5 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-moore.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
> @@ -608,8 +608,8 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
>  
>  	hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
>  				      sizeof(*hw->base), GFP_KERNEL);
> -	if (IS_ERR(hw->base))
> -		return PTR_ERR(hw->base);
> +	if (!hw->base)
> +		return -ENOMEM;
>  
>  	for (i = 0; i < hw->soc->nbase_names; i++) {
>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> @@ -629,8 +629,8 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
>  	/* Copy from internal struct mtk_pin_desc to register to the core */
>  	pins = devm_kmalloc_array(&pdev->dev, hw->soc->npins, sizeof(*pins),
>  				  GFP_KERNEL);
> -	if (IS_ERR(pins))
> -		return PTR_ERR(pins);
> +	if (!pins)
> +		return -ENOMEM;
>  
>  	for (i = 0; i < hw->soc->npins; i++) {
>  		pins[i].number = hw->soc->pins[i].number;
> 
