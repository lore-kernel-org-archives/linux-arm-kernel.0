From: robherring2@gmail.com (Rob Herring)
Date: Sun, 10 Feb 2013 16:34:52 -0600
Subject: [PATCH 1/2] net: calexdaxgmac: fix printing of hardware version
In-Reply-To: <1360510721-17860-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1360510721-17860-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360510721-17860-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5118208C.7010109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2013 09:38 AM, Ben Dooks wrote:
> The current driver attempts to print netdev_info() before registering the
> network device and allowing the name to be set. Change this print to be
> after the network deviec has been registered, and thus has been allocated

You missed the typo pointed out on the first version sent to lakml.

> a network device name.
> 
> Fix the following issue:
> 
> calxedaxgmac fff50000.ethernet (unregistered net_device): h/w version is 0x1012
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Otherwise,

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  drivers/net/ethernet/calxeda/xgmac.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
> index f7f0290..f91d9b2 100644
> --- a/drivers/net/ethernet/calxeda/xgmac.c
> +++ b/drivers/net/ethernet/calxeda/xgmac.c
> @@ -1715,9 +1715,6 @@ static int xgmac_probe(struct platform_device *pdev)
>  		goto err_io;
>  	}
>  
> -	uid = readl(priv->base + XGMAC_VERSION);
> -	netdev_info(ndev, "h/w version is 0x%x\n", uid);
> -
>  	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
>  	ndev->irq = platform_get_irq(pdev, 0);
>  	if (ndev->irq == -ENXIO) {
> @@ -1771,6 +1768,9 @@ static int xgmac_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_reg;
>  
> +	uid = readl(priv->base + XGMAC_VERSION);
> +	netdev_info(ndev, "h/w version is 0x%x\n", uid);
> +
>  	return 0;
>  
>  err_reg:
> 
