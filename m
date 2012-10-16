From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 16 Oct 2012 06:34:30 +0200
Subject: [PATCH RESEND] serial/amba-pl011: use devm_* managed resources
In-Reply-To: <1350300961-7036-1-git-send-email-linus.walleij@stericsson.com>
References: <1350300961-7036-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121016043430.GA24258@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 01:36:01PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This switches a bunch of allocation and remapping to use the
> devm_* garbage collected methods and cleans up the error
> path and remove() paths consequently.
> 
> devm_ioremap() is only in <linux/io.h> so fix up the
> erroneous <asm/*> include as well.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index d7e1ede..7fca402 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -56,8 +56,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sizes.h>
> -
> -#include <asm/io.h>
> +#include <linux/io.h>
>  
>  #define UART_NR			14
>  
> @@ -1973,7 +1972,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  		goto out;
>  	}
>  
> -	uap = kzalloc(sizeof(struct uart_amba_port), GFP_KERNEL);
> +	uap = devm_kzalloc(&dev->dev, sizeof(struct uart_amba_port),
> +			   GFP_KERNEL);
>  	if (uap == NULL) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -1981,16 +1981,17 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  
>  	i = pl011_probe_dt_alias(i, &dev->dev);
>  
> -	base = ioremap(dev->res.start, resource_size(&dev->res));
> +	base = devm_ioremap(&dev->dev, dev->res.start,
> +			    resource_size(&dev->res));
>  	if (!base) {
>  		ret = -ENOMEM;
> -		goto free;
> +		goto out;
>  	}
>  
>  	uap->pinctrl = devm_pinctrl_get(&dev->dev);
>  	if (IS_ERR(uap->pinctrl)) {
>  		ret = PTR_ERR(uap->pinctrl);
> -		goto unmap;
> +		goto out;
>  	}
>  	uap->pins_default = pinctrl_lookup_state(uap->pinctrl,
>  						 PINCTRL_STATE_DEFAULT);
> @@ -2002,10 +2003,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  	if (IS_ERR(uap->pins_sleep))
>  		dev_dbg(&dev->dev, "could not get sleep pinstate\n");
>  
> -	uap->clk = clk_get(&dev->dev, NULL);
> +	uap->clk = devm_clk_get(&dev->dev, NULL);
>  	if (IS_ERR(uap->clk)) {
>  		ret = PTR_ERR(uap->clk);
> -		goto unmap;
> +		goto out;
>  	}
>  
>  	uap->vendor = vendor;
> @@ -2038,11 +2039,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  		amba_set_drvdata(dev, NULL);
>  		amba_ports[i] = NULL;
>  		pl011_dma_remove(uap);
> -		clk_put(uap->clk);
> - unmap:
> -		iounmap(base);
> - free:
> -		kfree(uap);
>  	}
>   out:
>  	return ret;
> @@ -2062,9 +2058,6 @@ static int pl011_remove(struct amba_device *dev)
>  			amba_ports[i] = NULL;
>  
>  	pl011_dma_remove(uap);
> -	iounmap(uap->port.membase);
> -	clk_put(uap->clk);
> -	kfree(uap);
>  	return 0;
>  }
>  

Tested-by: Domenico Andreoli <domenico.andreoli@linux.com>

Thanks,
Domenido
