From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Jun 2013 23:16:10 +0800
Subject: [PATCH v3 06/11] staging: drm/imx: Add LDB support
In-Reply-To: <1364484215-13935-7-git-send-email-p.zabel@pengutronix.de>
References: <1364484215-13935-1-git-send-email-p.zabel@pengutronix.de>
 <1364484215-13935-7-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130606151608.GE28270@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 04:23:30PM +0100, Philipp Zabel wrote:
> +static void imx_ldb_encoder_prepare(struct drm_encoder *encoder)
> +{
> +	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
> +	struct imx_ldb *ldb = imx_ldb_ch->ldb;
> +	struct drm_display_mode *mode = &encoder->crtc->mode;
> +	unsigned long serial_clk;
> +	unsigned long di_clk = mode->clock * 1000;
> +	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->imx_drm_encoder,
> +					     encoder->crtc);
> +
> +	if (ldb->ldb_ctrl & LDB_SPLIT_MODE_EN) {
> +		/* dual channel LVDS mode */
> +		serial_clk = 3500UL * mode->clock;
> +		imx_ldb_set_clock(ldb, mux, 0, serial_clk, di_clk);
> +		imx_ldb_set_clock(ldb, mux, 1, serial_clk, di_clk);
> +	} else {
> +		serial_clk = 7000UL * mode->clock;
> +		imx_ldb_set_clock(ldb, mux, imx_ldb_ch->chno, serial_clk, di_clk);
> +	}
> +
> +	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_LVDS,
> +			V4L2_PIX_FMT_RGB24);

I have panel which needs it to be V4L2_PIX_FMT_BGR666.  We should
probably have a device tree property for that like interface_pix_fmt in
parallel display support?

Shawn

> +}
