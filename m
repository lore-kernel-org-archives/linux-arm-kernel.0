From: ykk@rock-chips.com (Yakir)
Date: Fri, 22 May 2015 23:19:26 +0800
Subject: [PATCH 02/13] drm: bridge/dw_hdmi: clean up phy configuration
In-Reply-To: <E1Yr1xJ-0006kc-GE@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1xJ-0006kc-GE@rmk-PC.arm.linux.org.uk>
Message-ID: <555F48FE.4070301@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

? 2015/5/9 18:26, Russell King ??:
> The phy configuration is dependent on the SoC, and we look up values for
> some of the registers in SoC specific data.  However, we had partially
> programmed the phy before we had successfully looked up the clock rate.
> Also, we were only checking that we had a valid configuration for the
> currctrl register.
>
> Move all these lookups to the start of this function instead, so we can
> check that all lookups were successful before beginning to program the
> phy.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Test on RK3288 platform, it works wells  :-)

Test-by: <ykk@rock-chips.com>

Best regards,
Yakir Yang
> ---
>   drivers/gpu/drm/bridge/dw_hdmi.c | 68 +++++++++++++++++++++-------------------
>   1 file changed, 35 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 3494391e4199..23ea8c5c85b6 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -753,12 +753,12 @@ static void dw_hdmi_phy_sel_interface_control(struct dw_hdmi *hdmi, u8 enable)
>   static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
>   			      unsigned char res, int cscon)
>   {
> -	unsigned res_idx, i;
> +	unsigned res_idx;
>   	u8 val, msec;
> -	const struct dw_hdmi_plat_data *plat_data = hdmi->plat_data;
> -	const struct dw_hdmi_mpll_config *mpll_config = plat_data->mpll_cfg;
> -	const struct dw_hdmi_curr_ctrl *curr_ctrl = plat_data->cur_ctr;
> -	const struct dw_hdmi_phy_config *phy_config = plat_data->phy_config;
> +	const struct dw_hdmi_plat_data *pdata = hdmi->plat_data;
> +	const struct dw_hdmi_mpll_config *mpll_config = pdata->mpll_cfg;
> +	const struct dw_hdmi_curr_ctrl *curr_ctrl = pdata->cur_ctr;
> +	const struct dw_hdmi_phy_config *phy_config = pdata->phy_config;
>   
>   	if (prep)
>   		return -EINVAL;
> @@ -778,6 +778,30 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
>   		return -EINVAL;
>   	}
>   
> +	/* PLL/MPLL Cfg - always match on final entry */
> +	for (; mpll_config->mpixelclock != ~0UL; mpll_config++)
> +		if (hdmi->hdmi_data.video_mode.mpixelclock <=
> +		    mpll_config->mpixelclock)
> +			break;
> +
> +	for (; curr_ctrl->mpixelclock != ~0UL; curr_ctrl++)
> +		if (hdmi->hdmi_data.video_mode.mpixelclock <=
> +		    curr_ctrl->mpixelclock)
> +			break;
> +
> +	for (; phy_config->mpixelclock != ~0UL; phy_config++)
> +		if (hdmi->hdmi_data.video_mode.mpixelclock <=
> +		    phy_config->mpixelclock)
> +			break;
> +
> +	if (mpll_config->mpixelclock == ~0UL ||
> +	    curr_ctrl->mpixelclock == ~0UL ||
> +	    phy_config->mpixelclock == ~0UL) {
> +		dev_err(hdmi->dev, "Pixel clock %d - unsupported by HDMI\n",
> +			hdmi->hdmi_data.video_mode.mpixelclock);
> +		return -EINVAL;
> +	}
> +
>   	/* Enable csc path */
>   	if (cscon)
>   		val = HDMI_MC_FLOWCTRL_FEED_THROUGH_OFF_CSC_IN_PATH;
> @@ -803,40 +827,18 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
>   		    HDMI_PHY_I2CM_SLAVE_ADDR);
>   	hdmi_phy_test_clear(hdmi, 0);
>   
> -	/* PLL/MPLL Cfg - always match on final entry */
> -	for (i = 0; mpll_config[i].mpixelclock != (~0UL); i++)
> -		if (hdmi->hdmi_data.video_mode.mpixelclock <=
> -		    mpll_config[i].mpixelclock)
> -			break;
> -
> -	hdmi_phy_i2c_write(hdmi, mpll_config[i].res[res_idx].cpce, 0x06);
> -	hdmi_phy_i2c_write(hdmi, mpll_config[i].res[res_idx].gmp, 0x15);
> -
> -	for (i = 0; curr_ctrl[i].mpixelclock != (~0UL); i++)
> -		if (hdmi->hdmi_data.video_mode.mpixelclock <=
> -		    curr_ctrl[i].mpixelclock)
> -			break;
> -
> -	if (curr_ctrl[i].mpixelclock == (~0UL)) {
> -		dev_err(hdmi->dev, "Pixel clock %d - unsupported by HDMI\n",
> -			hdmi->hdmi_data.video_mode.mpixelclock);
> -		return -EINVAL;
> -	}
> +	hdmi_phy_i2c_write(hdmi, mpll_config->res[res_idx].cpce, 0x06);
> +	hdmi_phy_i2c_write(hdmi, mpll_config->res[res_idx].gmp, 0x15);
>   
>   	/* CURRCTRL */
> -	hdmi_phy_i2c_write(hdmi, curr_ctrl[i].curr[res_idx], 0x10);
> +	hdmi_phy_i2c_write(hdmi, curr_ctrl->curr[res_idx], 0x10);
>   
>   	hdmi_phy_i2c_write(hdmi, 0x0000, 0x13);  /* PLLPHBYCTRL */
>   	hdmi_phy_i2c_write(hdmi, 0x0006, 0x17);
>   
> -	for (i = 0; phy_config[i].mpixelclock != (~0UL); i++)
> -		if (hdmi->hdmi_data.video_mode.mpixelclock <=
> -		    phy_config[i].mpixelclock)
> -			break;
> -
> -	hdmi_phy_i2c_write(hdmi, phy_config[i].term, 0x19);  /* TXTERM */
> -	hdmi_phy_i2c_write(hdmi, phy_config[i].sym_ctr, 0x09); /* CKSYMTXCTRL */
> -	hdmi_phy_i2c_write(hdmi, phy_config[i].vlev_ctr, 0x0E); /* VLEVCTRL */
> +	hdmi_phy_i2c_write(hdmi, phy_config->term, 0x19);  /* TXTERM */
> +	hdmi_phy_i2c_write(hdmi, phy_config->sym_ctr, 0x09); /* CKSYMTXCTRL */
> +	hdmi_phy_i2c_write(hdmi, phy_config->vlev_ctr, 0x0E); /* VLEVCTRL */
>   
>   	/* REMOVE CLK TERM */
>   	hdmi_phy_i2c_write(hdmi, 0x8000, 0x05);  /* CKCALCTRL */
