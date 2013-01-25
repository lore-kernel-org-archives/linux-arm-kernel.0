From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 25 Jan 2013 13:19:08 +0000
Subject: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
In-Reply-To: <1358894185-21617-2-git-send-email-robdclark@gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-2-git-send-email-robdclark@gmail.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA939BB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Jan 23, 2013 at 04:06:22, Rob Clark wrote:

> A simple DRM/KMS driver for the TI LCD Controller found in various
> smaller TI parts (AM33xx, OMAPL138, etc).  This driver uses the

> +void tilcdc_crtc_update_clk(struct drm_crtc *crtc)

> +	/* in raster mode, minimum divisor is 2: */
> +	ret = clk_set_rate(priv->disp_clk, crtc->mode.clock * 1000 * 2);

These things can better be handled with divider clock having a
minimum value (being discussed with Mike on how exactly it should
be) and instead of setting rate over a platform specific clock,
you can set rate over lcd clock using SET_RATE_PARENT at platform
level, more below,

> +	/* Configure the LCD clock divisor. */
> +	tilcdc_write(dev, LCDC_CTRL_REG, LCDC_CLK_DIVISOR(div) |
> +			LCDC_RASTER_MODE);
> +
> +	if (priv->rev == 2)
> +		tilcdc_set(dev, LCDC_CLK_ENABLE_REG,
> +				LCDC_V2_DMA_CLK_EN | LCDC_V2_LIDD_CLK_EN |
> +				LCDC_V2_CORE_CLK_EN);

Mike was suggesting to model the above using gate/divider/composite
clocks of CCF in the FB driver.

> +	priv->clk = clk_get(dev->dev, "fck");
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev->dev, "failed to get functional clock\n");
> +		ret = -ENODEV;
> +		goto fail;
> +	}
> +
> +	priv->disp_clk = clk_get(dev->dev, "dpll_disp_ck");
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev->dev, "failed to get display clock\n");
> +		ret = -ENODEV;
> +		goto fail;
> +	}

"dpll_disp_ck" is a platform specific matter, driver should not
be handling platform specifics. And this won't work on DaVinci,
you can probably make use of

my series "[PATCH v2 0/4] ARM: AM335x: LCDC platform support"

or something similar to overcome this.

Regards
Afzal
