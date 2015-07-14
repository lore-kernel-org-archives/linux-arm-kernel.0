From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 14 Jul 2015 13:10:05 +0200
Subject: [PATCH] i2c: omap: fix bus recovery setup
In-Reply-To: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
Message-ID: <20150714111004.GB1517@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to

Felipe: it seems you did not need this; is this AM335x specific?

> allow direct access to the SCL and SDA pins. In addition to ST_EN, we
> need to set the TMODE to 0b11 (Loop back & SDA/SCL IO mode select).
> Also, as the reset values of SCL_O and SDA_O are 0 (which means "drive
> low level"), we need to set them to 1 (which means "high-impedance") to
> avoid unwanted changes on the pins.
> 
> As a precaution, reset all these bits to their default values after
> recovery is complete.
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  drivers/i2c/busses/i2c-omap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d1c22e3fdd14..fc9bf7f30e35 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1247,7 +1247,14 @@ static void omap_i2c_prepare_recovery(struct i2c_adapter *adap)
>  	u32 reg;
>  
>  	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
> +	/* enable test mode */
>  	reg |= OMAP_I2C_SYSTEST_ST_EN;
> +	/* select SDA/SCL IO mode */
> +	reg |= 3 << OMAP_I2C_SYSTEST_TMODE_SHIFT;
> +	/* set SCL to high-impedance state (reset value is 0) */
> +	reg |= OMAP_I2C_SYSTEST_SCL_O;
> +	/* set SDA to high-impedance state (reset value is 0) */
> +	reg |= OMAP_I2C_SYSTEST_SDA_O;
>  	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
>  }
>  
> @@ -1257,7 +1264,11 @@ static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
>  	u32 reg;
>  
>  	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
> +	/* restore reset values */
>  	reg &= ~OMAP_I2C_SYSTEST_ST_EN;
> +	reg &= ~OMAP_I2C_SYSTEST_TMODE_MASK;
> +	reg &= ~OMAP_I2C_SYSTEST_SCL_O;
> +	reg &= ~OMAP_I2C_SYSTEST_SDA_O;
>  	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
>  }
>  
> -- 
> 2.1.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/d6115559/attachment.sig>
