From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Thu, 1 Jun 2017 01:55:21 +0100
Subject: [PATCH 3/4] drm/bridge: dw-hdmi: add better clock disable control
In-Reply-To: <E1dFi3J-0004lo-TU@rmk-PC.armlinux.org.uk>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3J-0004lo-TU@rmk-PC.armlinux.org.uk>
Message-ID: <cd12bc19-d706-de9a-4df0-d1e8dadace75@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,


On 30-05-2017 15:23, Russell King wrote:
> The video setup path aways sets the clock disable register to a specific
> value, which has the effect of disabling the CEC engine.  When we add the
> CEC driver, this becomes a problem.
>
> Fix this by only setting/clearing the bits that the video path needs to.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Jose Abreu <joabreu@synopsys.com>

Best regards,
Jose Miguel Abreu

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 966422576c44..58781d4c1034 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -166,6 +166,7 @@ struct dw_hdmi {
>  	bool bridge_is_on;		/* indicates the bridge is on */
>  	bool rxsense;			/* rxsense state */
>  	u8 phy_mask;			/* desired phy int mask settings */
> +	u8 mc_clkdis;			/* clock disable register */
>  
>  	spinlock_t audio_lock;
>  	struct mutex audio_mutex;
> @@ -1543,8 +1544,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  /* HDMI Initialization Step B.4 */
>  static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
>  {
> -	u8 clkdis;
> -
>  	/* control period minimum duration */
>  	hdmi_writeb(hdmi, 12, HDMI_FC_CTRLDUR);
>  	hdmi_writeb(hdmi, 32, HDMI_FC_EXCTRLDUR);
> @@ -1556,17 +1555,21 @@ static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
>  	hdmi_writeb(hdmi, 0x21, HDMI_FC_CH2PREAM);
>  
>  	/* Enable pixel clock and tmds data path */
> -	clkdis = 0x7F;
> -	clkdis &= ~HDMI_MC_CLKDIS_PIXELCLK_DISABLE;
> -	hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
> +	hdmi->mc_clkdis |= HDMI_MC_CLKDIS_HDCPCLK_DISABLE |
> +			   HDMI_MC_CLKDIS_CSCCLK_DISABLE |
> +			   HDMI_MC_CLKDIS_AUDCLK_DISABLE |
> +			   HDMI_MC_CLKDIS_PREPCLK_DISABLE |
> +			   HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
> +	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_PIXELCLK_DISABLE;
> +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>  
> -	clkdis &= ~HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
> -	hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
> +	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
> +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>  
>  	/* Enable csc path */
>  	if (is_color_space_conversion(hdmi)) {
> -		clkdis &= ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
> -		hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
> +		hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
> +		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>  	}
>  
>  	/* Enable color space conversion if needed */
> @@ -1580,7 +1583,8 @@ static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
>  
>  static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi)
>  {
> -	hdmi_modb(hdmi, 0, HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
> +	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_AUDCLK_DISABLE;
> +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>  }
>  
>  /* Workaround to clear the overflow condition */
> @@ -2261,6 +2265,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>  	hdmi->disabled = true;
>  	hdmi->rxsense = true;
>  	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
> +	hdmi->mc_clkdis = 0x7f;
>  
>  	mutex_init(&hdmi->mutex);
>  	mutex_init(&hdmi->audio_mutex);
