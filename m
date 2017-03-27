From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 27 Mar 2017 12:03:41 +0530
Subject: [PATCH v2] drm: dw_hdmi: Don't rely on the status of the bridge
 for updating HPD
In-Reply-To: <20170310093129.16890-1-romain.perier@collabora.com>
References: <20170310093129.16890-1-romain.perier@collabora.com>
Message-ID: <49effa0d-d6df-815b-33a7-c4cd8e25e300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/10/2017 03:01 PM, Romain Perier wrote:
> Currently, the irq handler that monitores changes for HPD anx RX_SENSE
> relies on the status of the bridge for updating the status of the HPD.
> The update is done only when the bridge is enabled.
>
> However, on Rockchip platforms we have found use cases where it could be
> a problem. When HDMI is being used, turning off/on the screen or
> unplugging/re-plugging the cable, the following simplified code path
> will happen:
>
> - dw_hdmi_irq() will be triggered by an HPD event, as the bridge is on
> hdmi->disabled is false, then the handler will update the rxsense flag
> accordingly.
> - dw_hdmi_update_power() will be invoked with the mode
> DRM_FORCE_UNSPECIFIED and rxsense == 1, so dw_hdmi_poweroff() will be
> called and the PHY will be desactivated (its pixel clocks and TMDS)
>
> [...]
>
> - dw_hdmi_bridge_disable() will be invoked, the bridge will be marked as
> disabled.
>
> - dw_hdmi_irq() will be triggered by an HPD event, as the bridge is
> currently disabled the HPD status won't be updated, so hdmi->rxsense
> won't be changed. Even if the data part of the PHY is disabled, this
> information coming from the HDMI Transmitter is correct and should be
> saved.
>
> [...]
>
> - dw_hdmi_bridge_enable() will be invoked, the bridge will be marked as
> enabled.
> - dw_hdmi_update_power() will be called. When hdmi->force is equal to
> DRM_FORCE_UNSPECIFIED the function will rely on hdmi->rxsense. If this
> field has not been updated by the irq handler, it will be false and
> DRM_FORCE_ON won't be put to hdmi->force.
>
> Consequently, most of the time dw_hdmi_poweron() won't be called in this
> use case, TMDS won't be re-enabled the PHY won't be re-initialized,
> resulting in a "Signal not found".
>
> This commit fixes the issue by removing the check for "!hdmi->disabled".
> As already explained, even if the PHY is partially disabled, information
> coming from HDMI Transmitter about HPD should be saved for a later use.

I pushed this to drm-misc-next after incorporating the directory change and
fixing some typos in the commit message.

Thanks,
Archit

>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>
> Changes in v2:
> - I have re-worded the commit message, as suggested by Russel
>
>  drivers/gpu/drm/bridge/dw-hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
> index 3a70016..5b6090c 100644
> --- a/drivers/gpu/drm/bridge/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw-hdmi.c
> @@ -1793,7 +1793,7 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  	if (intr_stat &
>  	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
>  		mutex_lock(&hdmi->mutex);
> -		if (!hdmi->disabled && !hdmi->force) {
> +		if (!hdmi->force) {
>  			/*
>  			 * If the RX sense status indicates we're disconnected,
>  			 * clear the software rxsense status.
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
