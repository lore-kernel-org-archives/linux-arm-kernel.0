From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 09 Feb 2011 16:41:38 +0300
Subject: [PATCH 1/2] atmel/macb: fix device name when SOFT/HARD_IRQ enabled
In-Reply-To: <1297255416-6920-1-git-send-email-plagnioj@jcrosoft.com>
References: <1297255416-6920-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4D529992.7050502@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-02-2011 15:43, Jean-Christophe PLAGNIOL-VILLARD wrote:

> From: Paul Chavent<paul.chavent@fnac.net>

> When listing processes on a system with SOFT/HARD_IRQ enabled,
> the name of the ethernet device is [irq/eth%d] (instead of [irq/eth0] for example).

> This patch call the request_irq function after having initialized the name of the device.

> Signed-off-by: Paul Chavent<paul.chavent@fnac.net>
> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
[...]

> diff --git a/drivers/net/macb.c b/drivers/net/macb.c
> index f69e73e..d642e08 100644
> --- a/drivers/net/macb.c
> +++ b/drivers/net/macb.c
[...]
> @@ -1219,13 +1209,23 @@ static int __init macb_probe(struct platform_device *pdev)
>   	err = register_netdev(dev);
>   	if (err) {
>   		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
> -		goto err_out_free_irq;
> +		goto err_out_iounmap;
>   	}
>
> -	if (macb_mii_init(bp) != 0) {
> +	dev->irq = platform_get_irq(pdev, 0);

    platform_get_irq() can fail...

> +	err = request_irq(dev->irq, macb_interrupt, IRQF_SAMPLE_RANDOM,
> +			  dev->name, dev);
> +	if (err) {
> +		printk(KERN_ERR
> +		       "%s: Unable to request IRQ %d (error %d)\n",
> +		       dev->name, dev->irq, err);
>   		goto err_out_unregister_netdev;
>   	}
>
> +	if (macb_mii_init(bp) != 0) {
> +		goto err_out_free_irq;
> +	}

    {} not needed here. I think checkpatch.pl should notice this.

WBR, Sergei
