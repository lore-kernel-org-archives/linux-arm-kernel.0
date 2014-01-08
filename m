From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jan 2014 21:40:12 +0000
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <1389112195.4815.27.camel@pizza.hi.pengutronix.de>
References: <1388767737.19394.32.camel@pizza.hi.pengutronix.de>
 <20140103170724.GT7383@n2100.arm.linux.org.uk>
 <1388770004.19394.42.camel@pizza.hi.pengutronix.de>
 <52C70C1A.3090108@boundarydevices.com>
 <1389030088.5590.30.camel@pizza.hi.pengutronix.de>
 <20140106174606.GG27432@n2100.arm.linux.org.uk>
 <52CB6719.6040604@boundarydevices.com>
 <1389094187.4815.24.camel@pizza.hi.pengutronix.de>
 <52CC1DA1.8030803@boundarydevices.com>
 <1389112195.4815.27.camel@pizza.hi.pengutronix.de>
Message-ID: <20140108214012.GU27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 05:29:55PM +0100, Philipp Zabel wrote:
> Thanky you. This is what I came up with so far:
> 
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Subject: [PATCH 1/2] staging: imx-hdmi: use RX_SENSE0 for plug detection if
>  HPD is unreliable
> 
> On some boards HPD might not reliably detect DVI monitors. Allow to use
> RX_SENSE0 as a workaround.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/staging/imx-drm/imx-hdmi.c | 45 +++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
> index 7779337..cc305f3 100644
> --- a/drivers/staging/imx-drm/imx-hdmi.c
> +++ b/drivers/staging/imx-drm/imx-hdmi.c
> @@ -139,6 +139,7 @@ struct imx_hdmi {
>  
>  	struct regmap *regmap;
>  	struct i2c_adapter *ddc;
> +	bool hpd_unreliable;
>  	void __iomem *regs;
>  
>  	unsigned int sample_rate;
> @@ -1309,6 +1310,14 @@ static int imx_hdmi_setup(struct imx_hdmi *hdmi, struct drm_display_mode *mode)
>  /* Wait until we are registered to enable interrupts */
>  static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
>  {
> +	int stat_bit = HDMI_IH_PHY_STAT0_HPD;
> +	int mask_bits = ~HDMI_PHY_HPD;
> +
> +	if (hdmi->hpd_unreliable) {
> +		stat_bit = HDMI_IH_PHY_STAT0_RX_SENSE0;
> +		mask_bits = ~HDMI_PHY_RX_SENSE0;
> +	}
> +

How about storing these in imx_hdmi instead, so we don't have to compute
them in each interrupt?  Maybe "sink_detect_status" and "sink_detect_mask"?

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
