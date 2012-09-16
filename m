From: marex@denx.de (Marek Vasut)
Date: Sun, 16 Sep 2012 12:51:41 +0200
Subject: [PATCH V4] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120916102342.GA933@pengutronix.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
 <20120916102342.GA933@pengutronix.de>
Message-ID: <201209161251.41895.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> On Fri, Aug 24, 2012 at 05:44:31AM +0200, Marek Vasut wrote:
> > This patch implements DMA support into mxs-i2c. DMA transfers are now
> > enabled via DT. The DMA operation is enabled by default.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Unsurprisingly, I also couldn't get the mode switching between DMA and
> PIOQUEUE to work :(

I'd say more work should be invested into this. Besides, what about rather 
trying PIO + DMA instead of PIOQ + DMA?

> However, I did come up with an idea how to select DMA or PIOQUEUE per
> bus via devicetree. If we change the view from "I want PIOQUEUE" to "I
> don't want DMA", we could simply override the default DMA configuration
> in the devicetree with, e.g.:
> 
> 			i2c0: i2c at 80058000 {
> 				...
> 				fsl,i2c-dma-channel = <>;
> 			};
> 
> So, no DMA channel set up will fall back to PIOQUEUE. This is more
> generic than a custom binding, because if one doesn't want DMA, don't
> configure it. That should also work with other devices which can fall
> back to something. I think this is worth trying, another advantage is
> that it doesn't expose something new to the user. So, there is no legacy
> support needed in case there will be a better way of configuration.

Ewww ... that's such an ad-hoc hack. Besides, someone might simply forget to add 
the binding, you'd need to print a warning.

> So, here is a proof-of-concept patch which adds that to Marek's DMA
> implementation which I'd like to fold into it. I am about to prepare a
> proper series and will post it later today. Comments appreciated.
> 
> Thanks,
> 
>    Wolfram
> 
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 1f58197..0198a43 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -35,10 +35,6 @@
> 
>  #define DRIVER_NAME "mxs-i2c"
> 
> -static bool use_pioqueue;
> -module_param(use_pioqueue, bool, 0);
> -MODULE_PARM_DESC(use_pioqueue, "Use PIOQUEUE mode for transfer instead of
> DMA"); -
>  #define MXS_I2C_CTRL0		(0x00)
>  #define MXS_I2C_CTRL0_SET	(0x04)
> 
> @@ -556,24 +552,13 @@ static int mxs_i2c_get_ofdata(struct mxs_i2c_dev
> *i2c) int ret;
> 
>  	/*
> -	 * The MXS I2C DMA mode is prefered and enabled by default.
> -	 * The PIO mode is still supported, but should be used only
> -	 * for debuging purposes etc.
> -	 */
> -	i2c->dma_mode = !use_pioqueue;
> -	if (!i2c->dma_mode)
> -		dev_info(dev, "Using PIOQUEUE mode for I2C transfers!\n");
> -
> -	/*
>  	 * TODO: This is a temporary solution and should be changed
>  	 * to use generic DMA binding later when the helpers get in.
>  	 */
>  	ret = of_property_read_u32(node, "fsl,i2c-dma-channel",
>  				   &i2c->dma_channel);
> -	if (ret) {
> -		dev_warn(dev, "Failed to get DMA channel, using PIOQUEUE!\n");
> -		i2c->dma_mode = 0;
> -	}
> +	if (ret)
> +		i2c->dma_mode = false;
> 
>  	ret = of_property_read_u32(node, "clock-frequency", &speed);
>  	if (ret)
> @@ -624,6 +609,13 @@ static int __devinit mxs_i2c_probe(struct
> platform_device *pdev) if (err)
>  		return err;
> 
> +	/*
> +	 * The MXS I2C DMA mode is prefered and enabled by default.
> +	 * Ideally, we'd switch between PIOQUEUE and DMA depending on the
> +	 * message size, but neither Marek Vasut nor Wolfram Sang got this
> +	 * to work without resetting the controller completely :(
> +	 */
> +	i2c->dma_mode = true;
>  	i2c->dev = dev;
>  	i2c->speed = &mxs_i2c_95kHz_config;
> 
> @@ -640,8 +632,8 @@ static int __devinit mxs_i2c_probe(struct
> platform_device *pdev) i2c->dma_data.chan_irq = dmairq;
>  		i2c->dmach = dma_request_channel(mask, mxs_i2c_dma_filter, i2c);
>  		if (!i2c->dmach) {
> -			dev_err(dev, "Failed to request dma\n");
> -			return -ENODEV;
> +			dev_err(dev, "Failed to request dma, falling back\n");
> +			i2c->dma_mode = false;
>  		}
>  	}
> 
> @@ -668,6 +660,8 @@ static int __devinit mxs_i2c_probe(struct
> platform_device *pdev)
> 
>  	of_i2c_register_devices(adap);
> 
> +	dev_info(dev, "registered. DMA: %s\n", i2c->dma_mode ? "on" : "off");

dev_debug() ?

> +
>  	return 0;
>  }
