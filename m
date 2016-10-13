From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 13 Oct 2016 15:15:04 -0400
Subject: [PATCH v2] drm/bridge: analogix: protect power when get_modes or
 detect
In-Reply-To: <1476323438-8435-1-git-send-email-mark.yao@rock-chips.com>
References: <1476266442-29803-1-git-send-email-mark.yao@rock-chips.com>
 <1476323438-8435-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAOw6vb+Nj8KNhqQ9Rqk6wpUfubp+UW5HhYdoA2_O_EeHfaQLPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 9:50 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
> The drm callback ->detect and ->get_modes seems is not power safe,
> they may be called when device is power off, do register access on
> detect or get_modes will cause system die.
>
> Here is the path call ->detect before analogix_dp power on
> [<ffffff800843babc>] analogix_dp_detect+0x44/0xdc
> [<ffffff80083fd840>] drm_helper_probe_single_connector_modes_merge_bits+0xe8/0x41c
> [<ffffff80083fdb84>] drm_helper_probe_single_connector_modes+0x10/0x18
> [<ffffff8008418d24>] drm_mode_getconnector+0xf4/0x304
> [<ffffff800840cff0>] drm_ioctl+0x23c/0x390
> [<ffffff80081a8adc>] do_vfs_ioctl+0x4b8/0x58c
> [<ffffff80081a8c10>] SyS_ioctl+0x60/0x88
>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Cc: "Ville Syrj?l?" <ville.syrjala@linux.intel.com>
>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

Thanks for revising, this is much better.


Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
> Changes in v2:
> - remove sub device power on/off callback, use pm_runtime_get/put is enough
> to fix my problem, so will can avoid race to dpms.
>
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index efac8ab..ff2d328 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1062,11 +1062,15 @@ int analogix_dp_get_modes(struct drm_connector *connector)
>                 return 0;
>         }
>
> +       pm_runtime_get_sync(dp->dev);
> +
>         if (analogix_dp_handle_edid(dp) == 0) {
>                 drm_mode_connector_update_edid_property(&dp->connector, edid);
>                 num_modes += drm_add_edid_modes(&dp->connector, edid);
>         }
>
> +       pm_runtime_put(dp->dev);
> +
>         if (dp->plat_data->panel)
>                 num_modes += drm_panel_get_modes(dp->plat_data->panel);
>
> @@ -1106,9 +1110,13 @@ analogix_dp_detect(struct drm_connector *connector, bool force)
>                 return connector_status_disconnected;
>         }
>
> +       pm_runtime_get_sync(dp->dev);
> +
>         if (!analogix_dp_detect_hpd(dp))
>                 status = connector_status_connected;
>
> +       pm_runtime_put(dp->dev);
> +
>         ret = analogix_dp_prepare_panel(dp, false, false);
>         if (ret)
>                 DRM_ERROR("Failed to unprepare panel (%d)\n", ret);
> --
> 1.9.1
>
>
