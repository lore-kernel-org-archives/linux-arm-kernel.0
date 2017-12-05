From: opendmb@gmail.com (Doug Berger)
Date: Mon, 4 Dec 2017 17:01:57 -0800
Subject: [PATCH 1/7 v2] net: bcmgenet: Fix platform_get_irq's error
 checking
In-Reply-To: <1512409703-20881-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1512409703-20881-2-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <7fd6f043-3e66-a03a-e2fa-c71cffe5019e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2017 09:48 AM, Arvind Yadav wrote:
> The platform_get_irq() function returns negative number if an error occurs,
> Zero if No irq is found and positive number if irq gets successful.
> platform_get_irq() error checking only for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              commit message was not correct.
> 
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 24b4f4c..e2f1268 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3371,7 +3371,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
>  	priv->irq0 = platform_get_irq(pdev, 0);
>  	priv->irq1 = platform_get_irq(pdev, 1);
>  	priv->wol_irq = platform_get_irq(pdev, 2);
> -	if (!priv->irq0 || !priv->irq1) {
> +	if (priv->irq0 <= 0 || priv->irq1 <= 0 || priv->wol_irq <= 0) {
>  		dev_err(&pdev->dev, "can't find IRQs\n");
>  		err = -EINVAL;
>  		goto err;
> 

The absence of a Wake-on-LAN interrupt (wol_irq <= 0) is not a terminal
error for the driver so it should not be included in this check.

The error checking for irq0 and irq1 is appropriate to add, but it
sounds like David Miller is proposing changing platform_get_irq() so
I'll let that dust settle before saying whether <= or < is appropriate.

Thanks,
    Doug
