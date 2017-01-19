From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 19 Jan 2017 11:20:25 +0800
Subject: [PATCH v11 11/12] drm/mediatek: update DSI sub driver flow for
 sending commands to panel
In-Reply-To: <1484117473-46644-12-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
 <1484117473-46644-12-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484796025.19089.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

one comment inline.

On Wed, 2017-01-11 at 14:51 +0800, YT Shen wrote:
> This patch update enable/disable flow of DSI module.
> Original flow works on there is a bridge chip: DSI -> bridge -> panel.
> In this case: DSI -> panel, the DSI sub driver flow should be updated.
> We need to initialize DSI first so that we can send commands to panel.
> 
> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 89 +++++++++++++++++++++++++++++++-------
>  1 file changed, 74 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 85f22d2..21392c4 100644
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
> @@ -365,16 +369,23 @@ static void mtk_dsi_set_mode(struct mtk_dsi *dsi)
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
> @@ -512,6 +523,16 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
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
> @@ -570,6 +591,19 @@ static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
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
> @@ -578,6 +612,17 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>  	if (--dsi->refcount != 0)
>  		return;
>  
> +	mtk_dsi_stop(dsi);
> +	if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
> +		if (dsi->panel) {
> +			if (drm_panel_unprepare(dsi->panel)) {

Why drm_panel_unprepare() in mtk_dsi_poweroff() but drm_panel_prepare()
in mtk_output_dsi_enable()? This asymmetric design would easily cause
some bugs.

Regards,
CK

> +				DRM_ERROR("failed to unprepare the panel\n");
> +				return;
> +			}
> +		}
> +	}
> +
> +	mtk_dsi_reset_engine(dsi);
>  	mtk_dsi_lane0_ulp_mode_enter(dsi);
>  	mtk_dsi_clk_ulp_mode_enter(dsi);
>  
> @@ -596,13 +641,6 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
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
> @@ -610,22 +648,43 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
>  	}
>  
>  	mtk_dsi_rxtx_control(dsi);
> +	mtk_dsi_ps_control_vact(dsi);
> +	mtk_dsi_set_vm_cmd(dsi);
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
> +			goto err_dsi_power_off;
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
> +			goto err_panel_disable;
> +		}
> +	}
> +
>  	dsi->enabled = true;
> +
> +	return;
> +err_panel_disable:
> +	mtk_dsi_stop(dsi);
> +	if (dsi->panel)
> +		drm_panel_unprepare(dsi->panel);
> +err_dsi_power_off:
> +	mtk_dsi_poweroff(dsi);
>  }
>  
>  static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
