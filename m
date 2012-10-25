From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 13:52:17 +0300
Subject: [PATCH 1/2] i2c: omap: re-factor omap_i2c_init function
In-Reply-To: <1351160586-12306-2-git-send-email-shubhrajyoti@ti.com>
References: <1351160586-12306-1-git-send-email-shubhrajyoti@ti.com>
 <1351160586-12306-2-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121025105217.GG21217@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(a small top-post here, don't forget to keep the patch version in the
subject, I think this is v3 already, so next patch should be v4)

On Thu, Oct 25, 2012 at 03:53:05PM +0530, Shubhrajyoti D wrote:
> re-factor omap_i2c_init() so that we can re-use it for resume.
> While at it also remove the bufstate variable as we write it
> in omap_i2c_resize_fifo for every transfer.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   71 ++++++++++++++++++----------------------
>  1 files changed, 32 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5e5cefb..3d400b1 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -209,7 +209,6 @@ struct omap_i2c_dev {
>  	u16			pscstate;
>  	u16			scllstate;
>  	u16			sclhstate;
> -	u16			bufstate;
>  	u16			syscstate;
>  	u16			westate;
>  	u16			errata;
> @@ -285,9 +284,31 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
>  	}
>  }
>  
> +static void __omap_i2c_init(struct omap_i2c_dev *dev)
> +{
> +
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> +	/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
> +	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> +
> +	/* SCL low and high time values */
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
> +	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
> +	if (dev->rev >= OMAP_I2C_REV_ON_3430_3530)
> +		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> +	/* Take the I2C module out of reset: */
> +	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
> +	/*
> +	 * Don't write to this register if the IE state is 0 as it can
> +	 * cause deadlock.
> +	 */
> +	if (dev->iestate)
> +		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);

you still miss the extra blank lines here. Try something like below:


omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);

/* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);

/* SCL low and high time values */
omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);

if (dev->rev >= OMAP_I2C_REV_ON_3430_3530)
	omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);

/* Take the I2C module out of reset: */
omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);

/*
 * Don't write to this register if the IE state is 0 as it can
 * cause deadlock.
 */
if (dev->iestate)
	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/a7ad1a5c/attachment-0001.sig>
