From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 27 Mar 2013 19:40:51 +0100
Subject: [PATCH v2 01/11] staging: drm/imx: Add LDB support
In-Reply-To: <1364405445-5271-2-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <51533D33.8060305@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 27/03/13 18:30, Philipp Zabel wrote:
> +static bool imx_ldb_encoder_mode_fixup(struct drm_encoder *encoder,
> +			   const struct drm_display_mode *mode,
> +			   struct drm_display_mode *adjusted_mode)
> +{
> +/*
> +	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
> +
> +	adjusted_mode->clock = clk_round_rate(imx_ldb_ch->ldb->clk_pll[imx_ldb_ch->chno],
> +			adjusted_mode->clock * 1000) / 1000;
> +*/
This should probably be removed :)
> +static void imx_ldb_set_clock(struct imx_ldb *ldb, int mux, int chno,
> +		unsigned long serial_clk, unsigned long di_clk)
> +{
> +	int ret;
> +
> +	dev_dbg(ldb->dev, "%s: now: %ld want: %ld\n", __func__,
> +			clk_get_rate(ldb->clk_pll[chno]), serial_clk);
> +	clk_set_rate(ldb->clk_pll[chno], serial_clk);
> +
> +	dev_dbg(ldb->dev, "%s after: %ld\n", __func__,
> +			clk_get_rate(ldb->clk_pll[chno]));
> +
> +	dev_dbg(ldb->dev, "%s: now: %ld want: %ld\n", __func__,
> +			clk_get_rate(ldb->clk[chno]),
> +			(long int)di_clk);
> +	clk_set_rate(ldb->clk[chno], di_clk);
> +
> +	dev_dbg(ldb->dev, "%s after: %ld\n", __func__,
> +			clk_get_rate(ldb->clk[chno]));
> +
Are all these debug statements still useful?
> +static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
> +{
> +	if (imx_ldb_ch == &ldb->channel[0] || dual) {
> +		ldb->ldb_ctrl &= ~0x3;
> +		if (mux == 0 || ldb->lvds_mux)
> +			ldb->ldb_ctrl |= LDB_CH0_MODE_EN_TO_DI0;
> +		else if (mux == 1)
> +			ldb->ldb_ctrl |= LDB_CH0_MODE_EN_TO_DI1;
> +	}
> +	if (imx_ldb_ch == &ldb->channel[1] || dual) {
> +		ldb->ldb_ctrl &= ~0xc;
> +		if (mux == 1 || ldb->lvds_mux)
> +			ldb->ldb_ctrl |= LDB_CH1_MODE_EN_TO_DI1;
> +		else if (mux == 0)
> +			ldb->ldb_ctrl |= LDB_CH1_MODE_EN_TO_DI0;
> +	}
Maybe avoid the magic 0x3 and 0x0c by building from LDB_CHx_MODE_EN_TO_DIx?
> +
> +static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
> +{
> +	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
> +	struct imx_ldb *ldb = imx_ldb_ch->ldb;
> +
> +	/*
> +	 * imx_ldb_encoder_disable is called by
> +	 * drm_helper_disable_unused_functions without
> +	 * the encoder being enabled before.
> +	 */
> +	if (imx_ldb_ch == &ldb->channel[0] && (ldb->ldb_ctrl & 0x3) == 0)
> +		return;
> +	else if (imx_ldb_ch == &ldb->channel[1] && (ldb->ldb_ctrl & 0xc) == 0)
> +		return;
> +
> +	if (imx_ldb_ch == &ldb->channel[0])
> +		ldb->ldb_ctrl &= ~0x3;
> +	else if (imx_ldb_ch == &ldb->channel[1])
> +		ldb->ldb_ctrl &= ~0xc;
> +
Idem magic numbers


Regards,

Martin
