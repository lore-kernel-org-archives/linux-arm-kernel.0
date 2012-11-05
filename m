From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 16:11:54 +0200
Subject: [PATCHv3 3/8] i2c: omap: remove the dtrev
In-Reply-To: <1352118223-3796-4-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-4-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121105141154.GC4815@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 05:53:38PM +0530, Shubhrajyoti D wrote:
> The dtrev is used only for the comments. Remove the same and use
> the scheme instead to know if it is version2.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> v3: remove the scheme from the commments.
> todo: remove the dtrev from hwmod etc.
> 
>  drivers/i2c/busses/i2c-omap.c |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 737d843..5f0c06c 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -191,7 +191,6 @@ struct omap_i2c_dev {
>  	u32			latency;	/* maximum MPU wkup latency */
>  	struct pm_qos_request	pm_qos_request;
>  	u32			speed;		/* Speed of bus in kHz */
> -	u32			dtrev;		/* extra revision from DT */
>  	u32			flags;
>  	u16			cmd_err;
>  	u8			*buf;
> @@ -1076,7 +1075,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	int irq;
>  	int r;
>  	u32 rev;
> -	u16 minor, major;
> +	u16 minor, major, scheme;
>  
>  	/* NOTE: driver uses the static register mapping */
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1108,7 +1107,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  		u32 freq = 100000; /* default to 100000 Hz */
>  
>  		pdata = match->data;
> -		dev->dtrev = pdata->rev;
>  		dev->flags = pdata->flags;
>  
>  		of_property_read_u32(node, "clock-frequency", &freq);
> @@ -1117,7 +1115,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  	} else if (pdata != NULL) {
>  		dev->speed = pdata->clkrate;
>  		dev->flags = pdata->flags;
> -		dev->dtrev = pdata->rev;
>  	}
>  
>  	dev->dev = &pdev->dev;
> @@ -1146,7 +1143,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  	 */
>  	rev = __raw_readw(dev->base + 0x04);
>  
> -	switch (OMAP_I2C_SCHEME(rev)) {
> +	scheme = OMAP_I2C_SCHEME(rev);
> +	switch (scheme) {
>  	case OMAP_I2C_SCHEME_0:
>  		dev->regs = (u8 *)reg_map_ip_v1;
>  		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG);
> @@ -1230,8 +1228,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;
>  	}
>  
> -	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
> -		 dev->dtrev, major, minor, dev->speed);
> +	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
> +		 major, minor, dev->speed);
>  
>  	of_i2c_register_devices(adap);
>  
> -- 
> 1.7.5.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/e4644380/attachment-0001.sig>
