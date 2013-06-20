From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Jun 2013 10:04:06 +0200
Subject: [PATCH v2 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
In-Reply-To: <1371545327-12481-1-git-send-email-b35083@freescale.com>
References: <1371545327-12481-1-git-send-email-b35083@freescale.com>
Message-ID: <20130620080406.GD14308@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 04:48:47PM +0800, Jingchang Lu wrote:
> +static u16 imx_i2c_clk_div[50][2] = {
>  	{ 22,	0x20 }, { 24,	0x21 }, { 26,	0x22 }, { 28,	0x23 },
>  	{ 30,	0x00 },	{ 32,	0x24 }, { 36,	0x25 }, { 40,	0x26 },
>  	{ 42,	0x03 }, { 44,	0x27 },	{ 48,	0x28 }, { 52,	0x05 },
> @@ -112,11 +107,67 @@ static u16 __initdata i2c_clk_div[50][2] = {
>  	{ 3072,	0x1E }, { 3840,	0x1F }
>  };
>  
> +/* Vybrid VF610 clock divider, register value pairs */
> +static u16 vf610_i2c_clk_div[60][2] = {
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

...

> +static struct imx_i2c_hwdata imx_i2c_hwdata = {
> +	.addr_reg		= 0x00,
> +	.freq_reg		= 0x04,
> +	.ctrl_reg		= 0x08,
> +	.status_reg		= 0x0c,
> +	.data_reg		= 0x10,
> +	.clk_div		= imx_i2c_clk_div,
> +	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> +	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> +	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> +
> +};
> +
> +static struct imx_i2c_hwdata vf610_i2c_hwdata = {
> +	.addr_reg		= 0x00,
> +	.freq_reg		= 0x01,
> +	.ctrl_reg		= 0x02,
> +	.status_reg		= 0x03,
> +	.data_reg		= 0x04,
> +	.clk_div		= vf610_i2c_clk_div,
> +	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
> +	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
> +	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
> +
> +};

Wow. The i2c unit remained unchanged since the i.MX21 days. Shuffling
some registers or divider values was long overdue...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
