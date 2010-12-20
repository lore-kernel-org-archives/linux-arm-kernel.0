From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 20 Dec 2010 10:44:09 +0100
Subject: [PATCH v7 08/15] ARM: mxs: Add iomux support
In-Reply-To: <1292679575-2635-7-git-send-email-shawn.guo@freescale.com>
References: <1292679575-2635-1-git-send-email-shawn.guo@freescale.com>
	<1292679575-2635-7-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101220094409.GT1940@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn

On Sat, Dec 18, 2010 at 09:39:32PM +0800, Shawn Guo wrote:
> MXS-based SoCs implements iomux functions in block PINCTRL.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> [...]
> diff --git a/arch/arm/mach-mxs/iomux.c b/arch/arm/mach-mxs/iomux.c
> new file mode 100644
> index 0000000..8c8cbf2
> --- /dev/null
> +++ b/arch/arm/mach-mxs/iomux.c
> @@ -0,0 +1,101 @@
> +[...]
> +/*
> + * configures a single pad in the iomuxer
> + */
> +int mxs_iomux_setup_pad(iomux_cfg_t pad)
> +{
> +	u32 reg, ofs, bp, bm;
> +	void __iomem *iomux_base = MXS_IO_ADDRESS(MXS_PINCTRL_BASE_ADDR);
> +
> +	/* muxsel */
> +	ofs = 0x100;
> +	ofs += PAD_BANK(pad) * 0x20 + PAD_PIN(pad) / 16 * 0x10;
> +	bp = PAD_PIN(pad) % 16 * 2;
> +	bm = 0x3 << bp;
> +	reg = __raw_readl(iomux_base + ofs);
> +	reg &= ~bm;
> +	reg |= PAD_MUXSEL(pad) << bp;
> +	__raw_writel(reg, iomux_base + ofs);
> +
> +	/* drive */
> +	ofs = cpu_is_mx23() ? 0x200 : 0x300;
> +	ofs += PAD_BANK(pad) * 0x40 + PAD_PIN(pad) / 8 * 0x10;
> +	/* mA */
> +	if (PAD_MA_VALID(pad)) {
> +		bp = PAD_PIN(pad) % 8 * 4;
> +		bm = 0x3 << bp;
> +		reg = __raw_readl(iomux_base + ofs);
> +		reg &= ~bm;
> +		reg |= PAD_MA(pad)  << bp;
s/  / /
This wasn't here before

I'm not sure if this is worth a v8.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
