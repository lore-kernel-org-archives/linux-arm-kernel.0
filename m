From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 04 May 2012 15:10:35 +0100
Subject: [PATCH 04/15] drivers/net: Do not free an IRQ if its request
 failed
In-Reply-To: <1334867804-31942-5-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-5-git-send-email-lee.jones@linaro.org>
Message-ID: <4FA3E35B.3000604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/12 21:36, Lee Jones wrote:
> Refrain from attempting to free an interrupt line if the request
> fails and hence, there is no IRQ to free.
>
> CC: netdev at vger.kernel.org
> Signed-off-by: Lee Jones<lee.jones@linaro.org>
> ---
>   drivers/net/ethernet/smsc/smsc911x.c |    3 +--
>   1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
> index 4a69710..f17a76e 100644
> --- a/drivers/net/ethernet/smsc/smsc911x.c
> +++ b/drivers/net/ethernet/smsc/smsc911x.c
> @@ -2382,7 +2382,6 @@ static int __devinit smsc911x_drv_probe(struct platform_device *pdev)
>   	SET_NETDEV_DEV(dev,&pdev->dev);
>
>   	pdata = netdev_priv(dev);
> -
>   	dev->irq = irq_res->start;
>   	irq_flags = irq_res->flags&  IRQF_TRIGGER_MASK;
>   	pdata->ioaddr = ioremap_nocache(res->start, res_size);
> @@ -2446,7 +2445,7 @@ static int __devinit smsc911x_drv_probe(struct platform_device *pdev)
>   	if (retval) {
>   		SMSC_WARN(pdata, probe,
>   			  "Unable to claim requested irq: %d", dev->irq);
> -		goto out_free_irq;
> +		goto out_disable_resources;
>   	}
>
>   	retval = register_netdev(dev);

Anything on this from the Net guys?

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
