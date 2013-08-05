From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Aug 2013 10:30:50 +0200
Subject: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
In-Reply-To: <1375418648-22760-2-git-send-email-b35083@freescale.com>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
Message-ID: <20130805083050.GN26614@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 12:44:08PM +0800, Jingchang Lu wrote:
>   Add Freescale Vybrid VF610 I2C controller support to
> imx I2C driver framework.
>   Some operation is different from imx I2C controller.
> The register offset, the i2c clock divider value table,
> the module enabling(I2CR_IEN) which is just invert with imx,
> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
> but w0c on imx.
> 
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> changes in v3:
>   Using struct naming the i2c clock {div, regval} pair.
>   Using address shift handling registers address difference.
> 
> changes in v2:
>   Fix building section mismatch(es) warning.
> 
>  drivers/i2c/busses/i2c-imx.c | 146 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 122 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index e242797..8f9981c 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -30,6 +30,8 @@
>   *	Copyright (C) 2007 RightHand Technologies, Inc.
>   *	Copyright (C) 2008 Darius Augulis <darius.augulis@teltonika.lt>
>   *
> + *	Copyright 2013 Freescale Semiconductor, Inc.
> + *
>   */
>  
>  /** Includes *******************************************************************
> @@ -62,13 +64,6 @@
>  /* Default value */
>  #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
>  
> -/* IMX I2C registers */
> -#define IMX_I2C_IADR	0x00	/* i2c slave address */
> -#define IMX_I2C_IFDR	0x04	/* i2c frequency divider */
> -#define IMX_I2C_I2CR	0x08	/* i2c control */
> -#define IMX_I2C_I2SR	0x0C	/* i2c status */
> -#define IMX_I2C_I2DR	0x10	/* i2c transfer data */
> -
>  /* Bits of IMX I2C registers */
>  #define I2SR_RXAK	0x01
>  #define I2SR_IIF	0x02
> @@ -95,8 +90,12 @@
>   *
>   * Duplicated divider values removed from list
>   */
> +struct imx_i2c_clk_pair {
> +	u16	div;
> +	u16	regval;
> +}i;

Converting this to a struct should be a separate patch. This is an
obvious cleanup which makes maintainers happy and more willing to take
the features you are adding later.

>  
> -static u16 __initdata i2c_clk_div[50][2] = {
> +static struct imx_i2c_clk_pair imx_i2c_clk_div[] = {
>  	{ 22,	0x20 }, { 24,	0x21 }, { 26,	0x22 }, { 28,	0x23 },
>  	{ 30,	0x00 },	{ 32,	0x24 }, { 36,	0x25 }, { 40,	0x26 },
>  	{ 42,	0x03 }, { 44,	0x27 },	{ 48,	0x28 }, { 52,	0x05 },
> @@ -112,11 +111,63 @@ static u16 __initdata i2c_clk_div[50][2] = {
>  	{ 3072,	0x1E }, { 3840,	0x1F }
>  };
>  
> +/* Vybrid VF610 clock divider, register value pairs */
> +static struct imx_i2c_clk_pair vf610_i2c_clk_div[] = {
> +	{ 20,   0x00 }, { 22,   0x01 }, { 24,   0x02 }, { 26,   0x03 },
> +	{ 28,   0x04 }, { 30,   0x05 }, { 32,   0x09 }, { 34,   0x06 },
> +	{ 36,   0x0A }, { 40,   0x07 }, { 44,   0x0C }, { 48,   0x0D },
> +	{ 52,   0x43 }, { 56,   0x0E }, { 60,   0x45 }, { 64,   0x12 },
> +	{ 68,   0x0F }, { 72,   0x13 }, { 80,   0x14 }, { 88,   0x15 },
> +	{ 96,   0x19 }, { 104,  0x16 }, { 112,  0x1A }, { 128,  0x17 },
> +	{ 136,  0x4F }, { 144,  0x1C }, { 160,  0x1D }, { 176,  0x55 },
> +	{ 192,  0x1E }, { 208,  0x56 }, { 224,  0x22 }, { 228,  0x24 },
> +	{ 240,  0x1F }, { 256,  0x23 }, { 288,  0x5C }, { 320,  0x25 },
> +	{ 384,  0x26 }, { 448,  0x2A }, { 480,  0x27 }, { 512,  0x2B },
> +	{ 576,  0x2C }, { 640,  0x2D }, { 768,  0x31 }, { 896,  0x32 },
> +	{ 960,  0x2F }, { 1024, 0x33 }, { 1152, 0x34 }, { 1280, 0x35 },
> +	{ 1536, 0x36 }, { 1792, 0x3A }, { 1920, 0x37 }, { 2048, 0x3B },
> +	{ 2304, 0x3C }, { 2560, 0x3D }, { 3072, 0x3E }, { 3584, 0x7A },
> +	{ 3840, 0x3F }, { 4096, 0x7B }, { 5120, 0x7D }, { 6144, 0x7E },
> +};
> +
>  enum imx_i2c_type {
>  	IMX1_I2C,
>  	IMX21_I2C,
> +	VF610_I2C,
>  };
>  
> +struct imx_i2c_hwdata {
> +	unsigned		regshift;
> +	struct imx_i2c_clk_pair	*clk_div;
> +	unsigned		ndivs;
> +	unsigned		i2sr_clr_opcode;
> +	unsigned		i2cr_ien_opcode;
> +};
> +
> +struct imx_i2c_drvdata {
> +	enum imx_i2c_type	devtype;
> +	struct imx_i2c_hwdata	*hwdata;
> +};
> +
> +#define IMX_I2C_IADR	(0x00 << i2c_imx->i2c_hwdata->regshift)
> +#define IMX_I2C_IFDR	(0x01 << i2c_imx->i2c_hwdata->regshift)
> +#define IMX_I2C_I2CR	(0x02 << i2c_imx->i2c_hwdata->regshift)
> +#define IMX_I2C_I2SR	(0x03 << i2c_imx->i2c_hwdata->regshift)
> +#define IMX_I2C_I2DR	(0x04 << i2c_imx->i2c_hwdata->regshift)

Macros should not assume there is a i2c_imx variable present in a
function. Instead, add static inline accessor functions.

> +
> +/*
> + * Interrupt flags clear operation differ between SoCs:
> + * - write zero to clear(w0c) INT flag on I.MX,

It's i.MX. With a Freescale mail address you should get this right ;)

> + * - but write one to clear(w1c) INT flag on Vybrid.
> + * I2C module enable operation also differ bteween SoCs:

s/bteween/between/

> + * - set I2CR_IEN bit enable the module on I.MX,
> + * - but clear I2CR_IEN bit enable the module on Vybrid.
> + */
> +#define I2SR_CLR_OPCODE_W0C		0x0
> +#define I2SR_CLR_OPCODE_W1C		(I2SR_IAL | I2SR_IIF)
> +#define I2CR_IEN_OPCODE_0		0x0
> +#define I2CR_IEN_OPCODE_1		I2CR_IEN
> +
>  struct imx_i2c_struct {
>  	struct i2c_adapter	adapter;
>  	struct clk		*clk;
> @@ -127,15 +178,52 @@ struct imx_i2c_struct {
>  	int			stopped;
>  	unsigned int		ifdr; /* IMX_I2C_IFDR */
>  	enum imx_i2c_type	devtype;
> +	struct imx_i2c_hwdata	*i2c_hwdata;
> +};
> +
> +static struct imx_i2c_hwdata imx_i2c_hwdata = {
> +	.regshift		= 2,
> +	.clk_div		= imx_i2c_clk_div,
> +	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> +	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> +	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> +
> +};

unnecessary blank line

> +
> +static struct imx_i2c_hwdata vf610_i2c_hwdata = {
> +	.regshift		= 0,
> +	.clk_div		= vf610_i2c_clk_div,
> +	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
> +	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
> +	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
> +
> +};

ditto

> +
> +static struct imx_i2c_drvdata imx_i2c_drvdata[] = {
> +	[IMX1_I2C] = {
> +		.devtype = IMX1_I2C,
> +		.hwdata = &imx_i2c_hwdata
> +	},
> +	[IMX21_I2C] = {
> +		.devtype = IMX21_I2C,
> +		.hwdata = &imx_i2c_hwdata
> +	},
> +	[VF610_I2C] = {
> +		.devtype = VF610_I2C,
> +		.hwdata = &vf610_i2c_hwdata
> +	},
>  };

Why add this array?

>  
>  static struct platform_device_id imx_i2c_devtype[] = {
>  	{
>  		.name = "imx1-i2c",
> -		.driver_data = IMX1_I2C,
> +		.driver_data = (kernel_ulong_t)&imx_i2c_drvdata[IMX1_I2C],

You should reference imx_i2c_hwdata/vf610_i2c_hwdata directly here.

>  	}, {
>  		.name = "imx21-i2c",
> -		.driver_data = IMX21_I2C,
> +		.driver_data = (kernel_ulong_t)&imx_i2c_drvdata[IMX21_I2C],
> +	}, {
> +		.name = "vf610-i2c",
> +		.driver_data = (kernel_ulong_t)&imx_i2c_drvdata[VF610_I2C],
>  	}, {
>  		/* sentinel */
>  	}
> @@ -145,6 +233,7 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype);
>  static const struct of_device_id i2c_imx_dt_ids[] = {
>  	{ .compatible = "fsl,imx1-i2c", .data = &imx_i2c_devtype[IMX1_I2C], },
>  	{ .compatible = "fsl,imx21-i2c", .data = &imx_i2c_devtype[IMX21_I2C], },
> +	{ .compatible = "fsl,vf610-i2c", .data = &imx_i2c_devtype[VF610_I2C], },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, i2c_imx_dt_ids);
> @@ -215,9 +304,8 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>  	clk_prepare_enable(i2c_imx->clk);
>  	writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
>  	/* Enable I2C controller */
> -	writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> -	writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> -
> +	writeb(i2c_imx->i2c_hwdata->i2sr_clr_opcode, i2c_imx->base + IMX_I2C_I2SR);
> +	writeb(i2c_imx->i2c_hwdata->i2cr_ien_opcode, i2c_imx->base + IMX_I2C_I2CR);
>  	/* Wait controller to be stable */
>  	udelay(50);
>  
> @@ -260,7 +348,8 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>  	}
>  
>  	/* Disable I2C controller */
> -	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> +	writeb(i2c_imx->i2c_hwdata->i2cr_ien_opcode ^ I2CR_IEN,
> +						i2c_imx->base + IMX_I2C_I2CR);
>  	clk_disable_unprepare(i2c_imx->clk);
>  }
>  
> @@ -270,19 +359,20 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  	unsigned int i2c_clk_rate;
>  	unsigned int div;
>  	int i;
> +	struct imx_i2c_clk_pair *i2c_clk_div = i2c_imx->i2c_hwdata->clk_div;
>  
>  	/* Divider value calculation */
>  	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
>  	div = (i2c_clk_rate + rate - 1) / rate;
> -	if (div < i2c_clk_div[0][0])
> +	if (div < i2c_clk_div[0].div)
>  		i = 0;
> -	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1][0])
> -		i = ARRAY_SIZE(i2c_clk_div) - 1;
> +	else if (div > i2c_clk_div[i2c_imx->i2c_hwdata->ndivs - 1].div)
> +		i = i2c_imx->i2c_hwdata->ndivs - 1;
>  	else
> -		for (i = 0; i2c_clk_div[i][0] < div; i++);
> +		for (i = 0; i2c_clk_div[i].div < div; i++);
>  
>  	/* Store divider value */
> -	i2c_imx->ifdr = i2c_clk_div[i][1];
> +	i2c_imx->ifdr = i2c_clk_div[i].regval;
>  
>  	/*
>  	 * There dummy delay is calculated.
> @@ -290,7 +380,7 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  	 * This delay is used in I2C bus disable function
>  	 * to fix chip hardware bug.
>  	 */
> -	i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
> +	i2c_imx->disable_delay = (500000U * i2c_clk_div[i].div
>  		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
>  
>  	/* dev_dbg() can't be used, because adapter is not yet registered */
> @@ -298,7 +388,7 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> I2C_CLK=%d, REQ DIV=%d\n",
>  		__func__, i2c_clk_rate, div);
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
> -		__func__, i2c_clk_div[i][1], i2c_clk_div[i][0]);
> +		__func__, i2c_clk_div[i].regval, i2c_clk_div[i].div);
>  #endif
>  }
>  
> @@ -312,6 +402,7 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>  		/* save status register */
>  		i2c_imx->i2csr = temp;
>  		temp &= ~I2SR_IIF;
> +		temp |= (i2c_imx->i2c_hwdata->i2sr_clr_opcode & I2SR_IIF);
>  		writeb(temp, i2c_imx->base + IMX_I2C_I2SR);
>  		wake_up(&i2c_imx->queue);
>  		return IRQ_HANDLED;
> @@ -493,6 +584,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	struct imx_i2c_struct *i2c_imx;
>  	struct resource *res;
>  	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
> +	struct imx_i2c_drvdata *drvdata;
>  	void __iomem *base;
>  	int irq, ret;
>  	u32 bitrate;
> @@ -519,7 +611,9 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  
>  	if (of_id)
>  		pdev->id_entry = of_id->data;

This is wrong in the original driver code. This field should be changed
in a driver.

> -	i2c_imx->devtype = pdev->id_entry->driver_data;
> +	drvdata = (struct imx_i2c_drvdata *)pdev->id_entry->driver_data;

Unnecessary cast.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
