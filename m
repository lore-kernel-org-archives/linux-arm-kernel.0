From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sun, 12 Jul 2015 17:32:17 +0200
Subject: [PATCH] i2c: omap: fix bus recovery setup
In-Reply-To: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
Message-ID: <55A28881.60703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/15 16:35, Jan Luebbe wrote:
> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to
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

Tested with oscilloscope on Beagle Bone Black, without the patch nothing
meningful appears on SCL during recovery, with the patch I'm able to see
the recovery pulses.

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

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
