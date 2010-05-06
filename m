From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 6 May 2010 02:26:08 +0100
Subject: [PATCH] ARM: S3C64XX: Add USB clock source frequency as driver
	data to s3c-hsotg
In-Reply-To: <4BE00124.7030702@gmail.com>
References: <4BE00124.7030702@gmail.com>
Message-ID: <20100506012608.GB6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 01:12:36PM +0200, Maurus Cuelenaere wrote:
> The upcoming SmartQ machines use a different base clock frequency
> for the USB block, this patch allows passing it as platform data
> to the driver.

When I merge thomas' patch for addign a clock for this crystal, it might
be worth changing the driver to get this and see what rate the clock is
at by that method.

Will hold off on this patch, also going to do some woth on the hsotg
driver anyway, since it could really do with some work on DMA support
and some debugging.
 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  arch/arm/plat-samsung/include/plat/udc-hs.h |    8 ++++++++
>  drivers/usb/gadget/s3c-hsotg.c              |    1 +
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/udc-hs.h b/arch/arm/plat-samsung/include/plat/udc-hs.h
> index a22a4f2..2905344 100644
> --- a/arch/arm/plat-samsung/include/plat/udc-hs.h
> +++ b/arch/arm/plat-samsung/include/plat/udc-hs.h
> @@ -18,12 +18,20 @@ enum s3c_hsotg_dmamode {
>  	S3C_HSOTG_DMA_DRV,	/* DMA is chosen by driver */
>  };
>  
> +enum s3c_hsotg_clkfreq {
> +	S3C_HSOTG_CLKFREQ_48MHZ = 0,
> +	S3C_HSOTG_CLKFREQ_12MHZ = 2,
> +	S3C_HSOTG_CLKFREQ_24MHZ = 3,
> +};
> +
>  /**
>   * struct s3c_hsotg_plat - platform data for high-speed otg/udc
>   * @dma: Whether to use DMA or not.
>   * @is_osc: The clock source is an oscillator, not a crystal
> + * @clk_sel: Frequency of the clock source
>   */
>  struct s3c_hsotg_plat {
>  	enum s3c_hsotg_dmamode	dma;
>  	unsigned int		is_osc : 1;
> +	enum s3c_hsotg_clkfreq	clk_sel;
>  };
> diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
> index 1f73b48..600b56d 100644
> --- a/drivers/usb/gadget/s3c-hsotg.c
> +++ b/drivers/usb/gadget/s3c-hsotg.c
> @@ -2705,6 +2705,7 @@ static void s3c_hsotg_otgreset(struct s3c_hsotg *hsotg)
>  	mdelay(1);
>  
>  	osc = hsotg->plat->is_osc ? S3C_PHYCLK_EXT_OSC : 0;
> +	osc |= hsotg->plat->clk_sel;
>  
>  	writel(osc | 0x10, S3C_PHYCLK);
>  
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
