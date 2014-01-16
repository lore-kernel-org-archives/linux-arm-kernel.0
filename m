From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 08:10:53 +0100
Subject: [PATCH V6 1/3] ARM: imx: add suspend in ocram support for i.mx6q
In-Reply-To: <1389840105-17625-1-git-send-email-b20788@freescale.com>
References: <1389840105-17625-1-git-send-email-b20788@freescale.com>
Message-ID: <20140116071053.GR16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 10:41:43AM +0800, Anson Huang wrote:
> +struct imx6_pm_socdata {
> +	u32 cpu_type;
> +	const char *mmdc_compat;
> +	const char *src_compat;
> +	const char *iomuxc_compat;
> +	const char *gpc_compat;
> +	const u32 mmdc_io_num;
> +	const u32 mmdc_io_offset[MX6_MAX_MMDC_IO_NUM];
> +};

This is error prone. Use const u32 *mmdc_io_offset here, and...

> +
> +static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
> +	.cpu_type = MXC_CPU_IMX6Q,
> +	.mmdc_compat = "fsl,imx6q-mmdc",
> +	.src_compat = "fsl,imx6q-src",
> +	.iomuxc_compat = "fsl,imx6q-iomuxc",
> +	.gpc_compat = "fsl,imx6q-gpc",
> +	.mmdc_io_num = 33,
> +	.mmdc_io_offset = {
> +		0x5ac, 0x5b4, 0x528, 0x520, /* DQM0 ~ DQM3 */
> +		0x514, 0x510, 0x5bc, 0x5c4, /* DQM4 ~ DQM7 */
> +		0x56c, 0x578, 0x588, 0x594, /* CAS, RAS, SDCLK_0, SDCLK_1 */
> +		0x5a8, 0x5b0, 0x524, 0x51c, /* SDQS0 ~ SDQS3 */
> +		0x518, 0x50c, 0x5b8, 0x5c0, /* SDQS4 ~ SDQS7 */
> +		0x784, 0x788, 0x794, 0x79c, /* GPR_B0DS ~ GPR_B3DS */
> +		0x7a0, 0x7a4, 0x7a8, 0x748, /* GPR_B4DS ~ GPR_B7DS */
> +		0x59c, 0x5a0, 0x750, 0x774, /* SODT0, SODT1, MODE_CTL, MODE */
> +		0x74c,			    /* GPR_ADDS */
> +	},
> +};

static u32 imx6q_mmdc_io_offset[] = {
	0x5ac, 0x5b4, 0x528, 0x520, /* DQM0 ~ DQM3 */
	0x514, 0x510, 0x5bc, 0x5c4, /* DQM4 ~ DQM7 */
	0x56c, 0x578, 0x588, 0x594, /* CAS, RAS, SDCLK_0, SDCLK_1 */
	0x5a8, 0x5b0, 0x524, 0x51c, /* SDQS0 ~ SDQS3 */
	0x518, 0x50c, 0x5b8, 0x5c0, /* SDQS4 ~ SDQS7 */
	0x784, 0x788, 0x794, 0x79c, /* GPR_B0DS ~ GPR_B3DS */
	0x7a0, 0x7a4, 0x7a8, 0x748, /* GPR_B4DS ~ GPR_B7DS */
	0x59c, 0x5a0, 0x750, 0x774, /* SODT0, SODT1, MODE_CTL, MODE */
	0x74c,                      /* GPR_ADDS */
};

static const struct imx6_pm_socdata imx6q_pm_data __initconst = {
	.mmdc_io_num = ARRAY_SIZE(imx6q_mmdc_io_offset),
	.mmdc_io_offset = imx6q_mmdc_io_offset,
};

instead.

> +
> +/*
> + * This structure is for passing necessary data for low level ocram
> + * suspend code(arch/arm/mach-imx/suspend-imx6.S), if this struct
> + * definition is changed, the offset definition in
> + * arch/arm/mach-imx/suspend-imx6.S must be also changed accordingly,
> + * otherwise, the suspend to ocram fucntion will be broken!

s/fucntion/function/

Other than that:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
