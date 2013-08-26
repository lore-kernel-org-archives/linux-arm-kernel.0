From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 26 Aug 2013 17:09:42 +0800
Subject: [PATCH] net/cadence/macb: fix kernel Oops if no PHY were
 discovered during probe
In-Reply-To: <1377372065-8938-1-git-send-email-b.brezillon@overkiz.com>
References: <1377372065-8938-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <521B1B56.8060903@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 08/25/2013 03:21 AM, Boris BREZILLON wrote:
> Test the presence of a PHY device before printing attached PHY
> informations.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>   drivers/net/ethernet/cadence/macb.c |    6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
> index e866608..fd3b67f 100644
> --- a/drivers/net/ethernet/cadence/macb.c
> +++ b/drivers/net/ethernet/cadence/macb.c
> @@ -1868,8 +1868,10 @@ static int __init macb_probe(struct platform_device *pdev)
>   		    dev->irq, dev->dev_addr);
>
>   	phydev = bp->phy_dev;
> -	netdev_info(dev, "attached PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
> -		    phydev->drv->name, dev_name(&phydev->dev), phydev->irq);
> +	if (phydev)
> +		netdev_info(dev, "attached PHY driver [%s] (mii_bus:phy_addr=%s, irq=%d)\n",
> +			    phydev->drv->name, dev_name(&phydev->dev),
> +			    phydev->irq);

Actually no need this check, if PHY is attached failed, the macb driver 
probe will fail, then it won't show this message.

>   	return 0;
>
>

Best Regards,
Bo Shen
