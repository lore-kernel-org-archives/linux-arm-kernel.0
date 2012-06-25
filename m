From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Jun 2012 15:35:43 +0300
Subject: [PATCHv10 6/7] I2C: OMAP: Correct I2C revision for OMAP3
In-Reply-To: <1340622702-21622-7-git-send-email-shubhrajyoti@ti.com>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
 <1340622702-21622-7-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120625123542.GE30463@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 04:41:41PM +0530, Shubhrajyoti D wrote:
> From: Jon Hunter <jon-hunter@ti.com>
> 
> The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
> revision is the same for 3430 and 3530. However, the OMAP3630 device has the
> same I2C revision as OMAP4. Correct the revision definition to reflect this.
> 
> This patch is based on work done by Jon Hunter <jon-hunter@ti.com>
> Changes from his patch
> - Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/i2c/busses/i2c-omap.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 8344ad030..0557b0d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -50,8 +50,8 @@
>  
>  /* I2C controller revisions present on specific hardware */
>  #define OMAP_I2C_REV_ON_2430		0x36
> -#define OMAP_I2C_REV_ON_3430		0x3C
> -#define OMAP_I2C_REV_ON_3530_4430	0x40
> +#define OMAP_I2C_REV_ON_3430_3530	0x3C
> +#define OMAP_I2C_REV_ON_3630_4430	0x40
>  
>  /* timeout waiting for the controller to respond */
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> @@ -305,7 +305,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
>  					   SYSC_AUTOIDLE_MASK);
>  
> -		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
> +		} else if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
>  			dev->syscstate = SYSC_AUTOIDLE_MASK;
>  			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
>  			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
> @@ -1021,7 +1021,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>  		dev->errata |= I2C_OMAP_ERRATA_I207;
>  
> -	if (dev->rev <= OMAP_I2C_REV_ON_3430)
> +	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
>  		dev->errata |= I2C_OMAP_ERRATA_I462;
>  
>  	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
> @@ -1039,7 +1039,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  		dev->fifo_size = (dev->fifo_size / 2);
>  
> -		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
> +		if (dev->rev >= OMAP_I2C_REV_ON_3630_4430)
>  			dev->b_hw = 0; /* Disable hardware fixes */
>  		else
>  			dev->b_hw = 1; /* Enable hardware fixes */
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/c9cb3632/attachment.sig>
