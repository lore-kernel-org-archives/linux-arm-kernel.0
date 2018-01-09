From: architt@codeaurora.org (Archit Taneja)
Date: Tue, 9 Jan 2018 16:13:08 +0530
Subject: [PATCH 04/11] drm/bridge/synopsys: dw-hdmi: Export some PHY
 related functions
In-Reply-To: <20171230210203.24115-5-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <20171230210203.24115-5-jernej.skrabec@siol.net>
Message-ID: <6b454804-e910-e8e8-6d2b-5bc25c7a4d4c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/31/2017 02:31 AM, Jernej Skrabec wrote:
> Parts of PHY code could be useful also for custom PHYs. For example,
> Allwinner A83T has custom PHY which is probably Synopsys gen2 PHY
> with few additional memory mapped registers, so most of the Synopsys PHY
> related code could be reused.
> 
> It turns out that even completely custom HDMI PHYs, such as the one
> found in Allwinner H3, can reuse some of those functions. This would
> suggest that (some?) functions exported in this commit are actually part
> of generic PHY interface and not really specific to Synopsys PHYs.
> 
> Export useful PHY functions.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 ++++++++++++++++++++++---------
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  2 ++
>   include/drm/bridge/dw_hdmi.h              | 10 +++++++
>   3 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 7ca14d7325b5..67467d0b683a 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1037,19 +1037,21 @@ static void dw_hdmi_phy_enable_svsret(struct dw_hdmi *hdmi, u8 enable)
>   			 HDMI_PHY_CONF0_SVSRET_MASK);
>   }
>   
> -static void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable)
> +void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable)
>   {
>   	hdmi_mask_writeb(hdmi, enable, HDMI_PHY_CONF0,
>   			 HDMI_PHY_CONF0_GEN2_PDDQ_OFFSET,
>   			 HDMI_PHY_CONF0_GEN2_PDDQ_MASK);
>   }
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_pddq);
>   
> -static void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable)
> +void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable)
>   {
>   	hdmi_mask_writeb(hdmi, enable, HDMI_PHY_CONF0,
>   			 HDMI_PHY_CONF0_GEN2_TXPWRON_OFFSET,
>   			 HDMI_PHY_CONF0_GEN2_TXPWRON_MASK);
>   }
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_txpwron);
>   
>   static void dw_hdmi_phy_sel_data_en_pol(struct dw_hdmi *hdmi, u8 enable)
>   {
> @@ -1065,6 +1067,23 @@ static void dw_hdmi_phy_sel_interface_control(struct dw_hdmi *hdmi, u8 enable)
>   			 HDMI_PHY_CONF0_SELDIPIF_MASK);
>   }
>   
> +void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi, u8 enable)
> +{
> +	hdmi_mask_writeb(hdmi, enable, HDMI_MC_PHYRSTZ,
> +			 HDMI_MC_PHYRSTZ_PHYRSTZ_OFFSET,
> +			 HDMI_MC_PHYRSTZ_PHYRSTZ_MASK);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_reset);
> +
> +void dw_hdmi_phy_set_slave_addr(struct dw_hdmi *hdmi)
> +{
> +	hdmi_phy_test_clear(hdmi, 1);
> +	hdmi_writeb(hdmi, HDMI_PHY_I2CM_SLAVE_ADDR_PHY_GEN2,
> +		    HDMI_PHY_I2CM_SLAVE_ADDR);
> +	hdmi_phy_test_clear(hdmi, 0);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_set_slave_addr);

Should this be called dw_hdmi_phy_gen2_set_slave_addr?

Looks good otherwise. Same for patches 3 and 4 in this series.

Thanks,
Archit

> +
>   static void dw_hdmi_phy_power_off(struct dw_hdmi *hdmi)
>   {
>   	const struct dw_hdmi_phy_data *phy = hdmi->phy.data;
> @@ -1204,15 +1223,12 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)
>   		dw_hdmi_phy_enable_svsret(hdmi, 1);
>   
>   	/* PHY reset. The reset signal is active high on Gen2 PHYs. */
> -	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
> -	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
> +	dw_hdmi_phy_gen2_reset(hdmi, 1);
> +	dw_hdmi_phy_gen2_reset(hdmi, 0);
>   
>   	hdmi_writeb(hdmi, HDMI_MC_HEACPHY_RST_ASSERT, HDMI_MC_HEACPHY_RST);
>   
> -	hdmi_phy_test_clear(hdmi, 1);
> -	hdmi_writeb(hdmi, HDMI_PHY_I2CM_SLAVE_ADDR_PHY_GEN2,
> -		    HDMI_PHY_I2CM_SLAVE_ADDR);
> -	hdmi_phy_test_clear(hdmi, 0);
> +	dw_hdmi_phy_set_slave_addr(hdmi);
>   
>   	/* Write to the PHY as configured by the platform */
>   	if (pdata->configure_phy)
> @@ -1251,15 +1267,16 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
>   	dw_hdmi_phy_power_off(hdmi);
>   }
>   
> -static enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
> -						      void *data)
> +enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
> +					       void *data)
>   {
>   	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
>   		connector_status_connected : connector_status_disconnected;
>   }
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_read_hpd);
>   
> -static void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
> -				   bool force, bool disabled, bool rxsense)
> +void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
> +			    bool force, bool disabled, bool rxsense)
>   {
>   	u8 old_mask = hdmi->phy_mask;
>   
> @@ -1271,8 +1288,9 @@ static void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
>   	if (old_mask != hdmi->phy_mask)
>   		hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
>   }
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_update_hpd);
>   
> -static void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
> +void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
>   {
>   	/*
>   	 * Configure the PHY RX SENSE and HPD interrupts polarities and clear
> @@ -1291,6 +1309,7 @@ static void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
>   	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
>   		    HDMI_IH_MUTE_PHY_STAT0);
>   }
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_setup_hpd);
>   
>   static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops = {
>   	.init = dw_hdmi_phy_init,
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> index 9d90eb9c46e5..fd150430d0b3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> @@ -950,6 +950,8 @@ enum {
>   
>   /* MC_PHYRSTZ field values */
>   	HDMI_MC_PHYRSTZ_PHYRSTZ = 0x01,
> +	HDMI_MC_PHYRSTZ_PHYRSTZ_OFFSET = 0x00,
> +	HDMI_MC_PHYRSTZ_PHYRSTZ_MASK = 0x01,
>   
>   /* MC_HEACPHY_RST field values */
>   	HDMI_MC_HEACPHY_RST_ASSERT = 0x1,
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 182f83283e24..f5cca4362154 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -159,5 +159,15 @@ void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
>   /* PHY configuration */
>   void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
>   			   unsigned char addr);
> +enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
> +					       void *data);
> +void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
> +			    bool force, bool disabled, bool rxsense);
> +void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
> +
> +void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable);
> +void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable);
> +void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi, u8 enable);
> +void dw_hdmi_phy_set_slave_addr(struct dw_hdmi *hdmi);
>   
>   #endif /* __IMX_HDMI_H__ */
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
