From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 14 Sep 2016 13:42:21 +0800
Subject: [PATCH v8 8/9] drm/mediatek: update DSI sub driver flow
In-Reply-To: <1473681672-47144-9-git-send-email-yt.shen@mediatek.com>
References: <1473681672-47144-1-git-send-email-yt.shen@mediatek.com>
 <1473681672-47144-9-git-send-email-yt.shen@mediatek.com>
Message-ID: <1473831741.28437.78.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Mon, 2016-09-12 at 20:01 +0800, YT Shen wrote:
> This patch update enable/disable flow of DSI module and MIPI TX module.
> Original flow works on there is a bridge chip: DSI -> bridge -> panel.
> In this case: DSI -> panel, the DSI sub driver flow should be updated.
> We need to initialize DSI first so that we can send commands to panel.
> 
> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  

[snip...]

>  
> +static void mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi)
> +{
> +	s32 ret = 0;
> +	unsigned long timeout = msecs_to_jiffies(500);
> +
> +	mtk_dsi_irq_data_clear(dsi, VM_DONE_INT_FLAG);
> +	mtk_dsi_set_cmd_mode(dsi);
> +
> +	ret = wait_event_interruptible_timeout(dsi->irq_wait_queue,
> +					       dsi->irq_data & VM_DONE_INT_FLAG,
> +					       timeout);
> +	if (ret == 0) {
> +		dev_info(dsi->dev, "dsi wait engine idle timeout\n");
> +
> +		mtk_dsi_enable(dsi);
> +		mtk_dsi_reset_engine(dsi);
> +	}

I think you should replace this event-waiting with
mtk_dsi_wait_for_irq_done(). And this is a reason for moving
mtk_dsi_wait_for_irq_done() to the patch of irq control.

> +}
> +
>  static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>  {
>  	if (WARN_ON(dsi->refcount == 0))
> @@ -528,6 +574,17 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>  	if (--dsi->refcount != 0)
>  		return;
>  
> +	mtk_dsi_switch_to_cmd_mode(dsi);
> +
> +	if (dsi->panel) {
> +		if (drm_panel_unprepare(dsi->panel)) {
> +			DRM_ERROR("failed to unprepare the panel\n");
> +			return;
> +		}
> +	}

I think drm_panel_unprepare should be placed after dsi is disabled. So
move this part after calling mtk_dsi_poweroff() in
mtk_output_dsi_disable().

> +
> +	mtk_dsi_reset_engine(dsi);
> +
>  	mtk_dsi_lane0_ulp_mode_enter(dsi);
>  	mtk_dsi_clk_ulp_mode_enter(dsi);
>  
> @@ -546,29 +603,37 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
>  	if (dsi->enabled)
>  		return;
>  
> -	if (dsi->panel) {
> -		if (drm_panel_prepare(dsi->panel)) {
> -			DRM_ERROR("failed to setup the panel\n");
> -			return;
> -		}
> -	}
> -
>  	ret = mtk_dsi_poweron(dsi);
>  	if (ret < 0) {
>  		DRM_ERROR("failed to power on dsi\n");
>  		return;
>  	}
>  
> +	usleep_range(20000, 21000);
> +
>  	mtk_dsi_rxtx_control(dsi);
> +	mtk_dsi_phy_timconfig(dsi);
> +	mtk_dsi_ps_control_vact(dsi);
> +	mtk_dsi_set_vm_cmd(dsi);
> +	mtk_dsi_config_vdo_timing(dsi);
> +	mtk_dsi_set_interrupt_enable(dsi);
>  
> +	mtk_dsi_enable(dsi);
>  	mtk_dsi_clk_ulp_mode_leave(dsi);
>  	mtk_dsi_lane0_ulp_mode_leave(dsi);
>  	mtk_dsi_clk_hs_mode(dsi, 0);
> -	mtk_dsi_set_mode(dsi);
>  
> -	mtk_dsi_ps_control_vact(dsi);
> -	mtk_dsi_config_vdo_timing(dsi);
> -	mtk_dsi_set_interrupt_enable(dsi);
> +	if (dsi->panel) {
> +		if (drm_panel_prepare(dsi->panel)) {
> +			DRM_ERROR("failed to prepare the panel\n");
> +			return;
> +		}
> +
> +		if (drm_panel_enable(dsi->panel)) {
> +			DRM_ERROR("failed to enable the panel\n");
> +			return;
> +		}
> +	}

I think drm_panel_prepare() should be called before DSI is enabled and
drm_panel_enable() should be called after DSI is enabled. But you may
encounter the problem that panel need transfer data when prepare and you
can refer to [1].

[1]
http://lxr.free-electrons.com/source/drivers/gpu/drm/exynos/exynos_drm_dsi.c#L1431

>  
>  	mtk_dsi_set_mode(dsi);
>  	mtk_dsi_clk_hs_mode(dsi, 1);
> @@ -590,6 +655,7 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
>  		}
>  	}
>  
> +	mtk_dsi_stop(dsi);
>  	mtk_dsi_poweroff(dsi);
>  
>  	dsi->enabled = false;
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> index 108d31a..34e95c6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> @@ -177,7 +177,9 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
>  
>  	dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
>  
> -	if (mipi_tx->data_rate >= 500000000) {
> +	if (mipi_tx->data_rate > 1250000000) {
> +		return -EINVAL;
> +	} else if (mipi_tx->data_rate >= 500000000) {

What is the relationship of this part and "DSI driver flow"? Would this
be an independent patch?

>  		txdiv = 1;
>  		txdiv0 = 0;
>  		txdiv1 = 0;
> @@ -201,6 +203,10 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
>  		return -EINVAL;
>  	}
>  
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> +				RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
> +				(8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
> +
>  	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_BG_CON,
>  				RG_DSI_VOUT_MSK |
>  				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN,
>  

You modify many place without 'if (dsi->panel)'. Are all these
modifications compatible with bridge case?

Regards,
CK
