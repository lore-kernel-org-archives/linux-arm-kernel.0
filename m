From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 30 Nov 2016 15:58:48 +0800
Subject: [PATCH v10 12/13] drm/mediatek: update DSI sub driver flow for
 sending commands to panel
In-Reply-To: <1480070076-6196-13-git-send-email-yt.shen@mediatek.com>
References: <1480070076-6196-1-git-send-email-yt.shen@mediatek.com>
 <1480070076-6196-13-git-send-email-yt.shen@mediatek.com>
Message-ID: <1480492728.32217.20.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

some comments inline.

On Fri, 2016-11-25 at 18:34 +0800, YT Shen wrote:
> This patch update enable/disable flow of DSI module.
> Original flow works on there is a bridge chip: DSI -> bridge -> panel.
> In this case: DSI -> panel, the DSI sub driver flow should be updated.
> We need to initialize DSI first so that we can send commands to panel.
> 
> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 101 +++++++++++++++++++++++++++++--------
>  1 file changed, 80 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index ded4202..0569f2e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -126,6 +126,10 @@
>  #define CLK_HS_POST			(0xff << 8)
>  #define CLK_HS_EXIT			(0xff << 16)
>  
> +#define DSI_VM_CMD_CON		0x130
> +#define VM_CMD_EN			BIT(0)
> +#define TS_VFP_EN			BIT(5)
> +
>  #define DSI_CMDQ0		0x180
>  #define CONFIG				(0xff << 0)
>  #define SHORT_PACKET			0
> @@ -249,7 +253,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  	 * mipi_ratio is mipi clk coefficient for balance the pixel clk in mipi.
>  	 * we set mipi_ratio is 1.05.
>  	 */
> -	dsi->data_rate = dsi->vm.pixelclock * 3 * 21 / (1 * 1000 * 10);
> +	dsi->data_rate = dsi->vm.pixelclock * 12 * 21;
> +	dsi->data_rate /= (dsi->lanes * 1000 * 10);

This looks like a bug fix that use lanes to calculate data rate.

> +	DRM_DEBUG_DRIVER("set mipitx's data rate: %dMHz\n", dsi->data_rate);
>  
>  	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate * 1000000);
>  	if (ret < 0) {
> @@ -333,16 +339,23 @@ static void mtk_dsi_set_mode(struct mtk_dsi *dsi)
>  	u32 vid_mode = CMD_MODE;
>  
>  	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -		vid_mode = SYNC_PULSE_MODE;
> -
> -		if ((dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) &&
> -		    !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE))
> +		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
>  			vid_mode = BURST_MODE;
> +		else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> +			vid_mode = SYNC_PULSE_MODE;
> +		else
> +			vid_mode = SYNC_EVENT_MODE;
>  	}
>  
>  	writel(vid_mode, dsi->regs + DSI_MODE_CTRL);
>  }
>  
> +static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
> +{
> +	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, VM_CMD_EN, VM_CMD_EN);
> +	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
> +}
> +
>  static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
>  {
>  	struct videomode *vm = &dsi->vm;
> @@ -480,6 +493,16 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
>  	writel(1, dsi->regs + DSI_START);
>  }
>  
> +static void mtk_dsi_stop(struct mtk_dsi *dsi)
> +{
> +	writel(0, dsi->regs + DSI_START);
> +}
> +
> +static void mtk_dsi_set_cmd_mode(struct mtk_dsi *dsi)
> +{
> +	writel(CMD_MODE, dsi->regs + DSI_MODE_CTRL);
> +}
> +
>  static void mtk_dsi_set_interrupt_enable(struct mtk_dsi *dsi)
>  {
>  	u32 inten = LPRX_RD_RDY_INT_FLAG | CMD_DONE_INT_FLAG | VM_DONE_INT_FLAG;
> @@ -538,6 +561,19 @@ static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
> +{
> +	mtk_dsi_irq_data_clear(dsi, irq_flag);
> +	mtk_dsi_set_cmd_mode(dsi);
> +
> +	if (!mtk_dsi_wait_for_irq_done(dsi, irq_flag, t)) {
> +		DRM_ERROR("failed to switch cmd mode\n");
> +		return -ETIME;
> +	} else {
> +		return 0;
> +	}
> +}
> +
>  static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>  {
>  	if (WARN_ON(dsi->refcount == 0))
> @@ -546,11 +582,6 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>  	if (--dsi->refcount != 0)
>  		return;
>  
> -	mtk_dsi_lane0_ulp_mode_enter(dsi);
> -	mtk_dsi_clk_ulp_mode_enter(dsi);
> -
> -	mtk_dsi_disable(dsi);
> -
>  	clk_disable_unprepare(dsi->engine_clk);
>  	clk_disable_unprepare(dsi->digital_clk);
>  
> @@ -564,13 +595,6 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
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
> @@ -578,21 +602,43 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
>  	}
>  
>  	mtk_dsi_rxtx_control(dsi);
> +	mtk_dsi_ps_control_vact(dsi);
> +	mtk_dsi_set_vm_cmd(dsi);

Even though dsi does not directly connect to panel, you newly set vm cmd
here. This looks like a bug fix.

> +	mtk_dsi_config_vdo_timing(dsi);
> +	mtk_dsi_set_interrupt_enable(dsi);
>  
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
> +
> +			mtk_dsi_stop(dsi);

You never start dsi before here, why do you stop dsi here?

> +			mtk_dsi_poweroff(dsi);

Refer to next comment, you may goto undo item in bottom of this
function.

> +			return;
> +		}
> +	}
>  
>  	mtk_dsi_set_mode(dsi);
>  	mtk_dsi_clk_hs_mode(dsi, 1);
>  
>  	mtk_dsi_start(dsi);
>  
> +	if (dsi->panel) {
> +		if (drm_panel_enable(dsi->panel)) {
> +			DRM_ERROR("failed to enable the panel\n");
> +
> +			if (drm_panel_unprepare(dsi->panel))
> +				DRM_ERROR("failed to unprepare the panel\n");
> +
> +			mtk_dsi_stop(dsi);

I think you should stop dsi before panel unprepare. Otherwise, why not
move these undo item to the bottom of this function. For example:

		if (drm_panel_enable(dsi->panel)) {
			DRM_ERROR("failed to enable the panel\n");
			goto stop_dsi;

...

	dsi->enabled = true;
	return;

stop_dsi:
	mtk_dsi_stop(dsi);
	if (drm_panel_unprepare(dsi->panel))
		DRM_ERROR("failed to unprepare the panel\n");
poweroff_dsi:
	mtk_dsi_poweroff(dsi);
	return;

> +			mtk_dsi_poweroff(dsi);
> +			return;
> +		}
> +	}
> +
>  	dsi->enabled = true;
>  }
>  
> @@ -608,6 +654,19 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
>  		}
>  	}
>  
> +	mtk_dsi_stop(dsi);

Even though dsi does not directly connect to panel, you newly stop dsi
here. This looks like a bug fix.

> +	if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {

ditto.

> +		if (dsi->panel) {
> +			if (drm_panel_unprepare(dsi->panel))
> +				DRM_ERROR("failed to unprepare the panel\n");
> +		}
> +	}
> +
> +	mtk_dsi_reset_engine(dsi);

ditto.

> +	mtk_dsi_lane0_ulp_mode_enter(dsi);
> +	mtk_dsi_clk_ulp_mode_enter(dsi);
> +	mtk_dsi_disable(dsi);
> +
>  	mtk_dsi_poweroff(dsi);
>  
>  	dsi->enabled = false;

Regards,
CK
