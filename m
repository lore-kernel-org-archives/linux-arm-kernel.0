From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 29 Aug 2010 11:42:12 +0200
Subject: [PATCH] gpio: sx150x: correct and refine reset-on-probe behavior.
In-Reply-To: <1283015752-11141-1-git-send-email-gbean@codeaurora.org>
References: <1283015752-11141-1-git-send-email-gbean@codeaurora.org>
Message-ID: <20100829114212.36c07b22@hyperion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Sat, 28 Aug 2010 10:15:52 -0700, Gregory Bean wrote:
> Replace the arbitrary software-reset call from the device-probe
> method, because:
> - It is defective.  To work correctly, it should be two byte writes,
>   not a single word write.  As it stands, it does nothing.
> - Some devices with sx150x expanders installed have their NRESET pins
>   ganged on the same line, so resetting one causes the others to reset -
>   not a nice thing to do arbitrarily!
> - The probe, usually taking place at boot, implies a recent hard-reset,
>   so a software reset at this point is just a waste of energy anyway.
> 
> Therefore, make it optional, defaulting to off, as this will match the
> common case of probing at powerup and also matches the current
> broken no-op behavior.
> 
> Signed-off-by: Gregory Bean <gbean@codeaurora.org>
> ---
>  drivers/gpio/sx150x.c      |   29 ++++++++++++++++++++++++-----
>  include/linux/i2c/sx150x.h |    4 ++++
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/sx150x.c b/drivers/gpio/sx150x.c
> index b42f42c..6d68018 100644
> --- a/drivers/gpio/sx150x.c
> +++ b/drivers/gpio/sx150x.c
> @@ -459,17 +459,36 @@ static int sx150x_init_io(struct sx150x_chip *chip, u8 base, u16 cfg)
>  	return err;
>  }
>  
> -static int sx150x_init_hw(struct sx150x_chip *chip,
> -			struct sx150x_platform_data *pdata)
> +static int sx150x_reset(struct sx150x_chip *chip)
>  {
> -	int err = 0;
> +	int err;
> +
> +	err = i2c_smbus_write_byte_data(chip->client,
> +					chip->dev_cfg->reg_reset,
> +					0x12);
> +	if (err < 0)
> +		return err;
>  
> -	err = i2c_smbus_write_word_data(chip->client,
> +	err = i2c_smbus_write_byte_data(chip->client,
>  					chip->dev_cfg->reg_reset,
> -					0x3412);
> +					0x34);
>  	if (err < 0)
>  		return err;
>  
> +	return 0;

You might as well just "return err" in both cases.

> +}
> +
> +static int sx150x_init_hw(struct sx150x_chip *chip,
> +			struct sx150x_platform_data *pdata)
> +{
> +	int err = 0;
> +
> +	if (pdata->reset_during_probe) {
> +		err = sx150x_reset(chip);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	err = sx150x_i2c_write(chip->client,
>  			chip->dev_cfg->reg_misc,
>  			0x01);
> diff --git a/include/linux/i2c/sx150x.h b/include/linux/i2c/sx150x.h
> index ee3049c..52baa79 100644
> --- a/include/linux/i2c/sx150x.h
> +++ b/include/linux/i2c/sx150x.h
> @@ -63,6 +63,9 @@
>   *            IRQ lines will appear.  Similarly to gpio_base, the expander
>   *            will create a block of irqs beginning at this number.
>   *            This value is ignored if irq_summary is < 0.
> + * @reset_during_probe: If set to true, the driver will trigger a full
> + *                      reset of the chip at the beginning of the probe
> + *                      in order to place it in a known state.
>   */
>  struct sx150x_platform_data {
>  	unsigned gpio_base;
> @@ -73,6 +76,7 @@ struct sx150x_platform_data {
>  	u16      io_polarity;
>  	int      irq_summary;
>  	unsigned irq_base;
> +	bool     reset_during_probe;
>  };
>  
>  #endif /* __LINUX_I2C_SX150X_H */


-- 
Jean Delvare
