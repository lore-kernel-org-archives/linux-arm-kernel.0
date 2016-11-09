From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 9 Nov 2016 10:59:47 +0200
Subject: [PATCH v2 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
In-Reply-To: <20161109081431.10115-2-romain.perier@free-electrons.com>
References: <20161109081431.10115-1-romain.perier@free-electrons.com>
 <20161109081431.10115-2-romain.perier@free-electrons.com>
Message-ID: <20161109085946.cmd4ltaxpiojq7il@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,

On Wed, Nov 09, 2016 at 09:14:29AM +0100, Romain Perier wrote:
> The Armada 3700 has two I2C controllers that is compliant with the I2C
> Bus Specificiation 2.1, supports multi-master and different bus speed:
> Standard mode (up to 100 KHz), Fast mode (up to 400 KHz),
> High speed mode (up to 3.4 Mhz).
> 
> This IP block has a lot of similarity with the PXA, except some register
> offsets and bitfield. This commits adds a basic support for this I2C
> unit.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[...]

> @@ -122,7 +131,9 @@ MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
>  #define ICR_SADIE	(1 << 13)	   /* slave address detected int enable */
>  #define ICR_UR		(1 << 14)	   /* unit reset */
>  #define ICR_FM		(1 << 15)	   /* fast mode */
> +#define ICR_BUSMODE_FM	(1 << 16)	   /* shifted fast mode for armada-3700 */
>  #define ICR_HS		(1 << 16)	   /* High Speed mode */
> +#define ICR_BUSMODE_HS	(1 << 17)	   /* shifted high speed mode for armada-3700 */
>  #define ICR_GPIOEN	(1 << 19)	   /* enable GPIO mode for SCL in HS */
>  
>  #define ISR_RWM		(1 << 0)	   /* read/write mode */
> @@ -193,6 +204,8 @@ struct pxa_i2c {
>  	unsigned char		master_code;
>  	unsigned long		rate;
>  	bool			highmode_enter;
> +	unsigned long		fm_mask;
> +	unsigned long		hs_mask;

Do you really need 64bit for that?

baruch

>  };
>  
>  #define _IBMR(i2c)	((i2c)->reg_ibmr)
> @@ -503,8 +516,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  		writel(i2c->slave_addr, _ISAR(i2c));
>  
>  	/* set control register values */
> -	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
> -	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
> +	writel(I2C_ICR_INIT | (i2c->fast_mode ? i2c->fm_mask : 0), _ICR(i2c));
> +	writel(readl(_ICR(i2c)) | (i2c->high_mode ? i2c->hs_mask : 0), _ICR(i2c));
>  
>  #ifdef CONFIG_I2C_PXA_SLAVE
>  	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
> @@ -1137,6 +1150,7 @@ static const struct of_device_id i2c_pxa_dt_ids[] = {
>  	{ .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
>  	{ .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
>  	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA910 },
> +	{ .compatible = "marvell,armada-3700-i2c", .data = (void *)REGS_A3700 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
> @@ -1158,6 +1172,13 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
>  		i2c->use_pio = 1;
>  	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
>  		i2c->fast_mode = 1;
> +	if (of_device_is_compatible(np, "marvell,armada-3700-i2c")) {
> +		i2c->fm_mask = ICR_BUSMODE_FM;
> +		i2c->hs_mask = ICR_BUSMODE_HS;
> +	} else {
> +		i2c->fm_mask = ICR_FM;
> +		i2c->hs_mask = ICR_HS;
> +	}
>  
>  	*i2c_types = (enum pxa_i2c_types)(of_id->data);

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
