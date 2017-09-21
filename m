From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 21 Sep 2017 13:13:07 -0700
Subject: [PATCH] drm/rockchip: Fix uninitialized use of ret
In-Reply-To: <3163442d-356a-4000-f15b-74391b79188f@rock-chips.com>
References: <20170921001408.1839-1-seanpaul@chromium.org>
 <3163442d-356a-4000-f15b-74391b79188f@rock-chips.com>
Message-ID: <CAOw6vb+HAKQ8j9gYYnCLVRVBhhKxJVCsetCiRNWiPeJCOP78=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 6:03 PM, Mark yao <mark.yao@rock-chips.com> wrote:
> On 2017?09?21? 08:13, Sean Paul wrote:
>
> If there are no children for lvds, ret is used uninitialized. This patch
> initializes ret and returns an error if the port has no children.
>
> Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
> Cc: Mark Yao <mark.yao@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index c5fbe533796c..0ce6205d8d80 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -346,7 +346,7 @@ static int rockchip_lvds_bind(struct device *dev, struct
> device *master,
>   struct drm_connector *connector;
>   struct device_node *remote = NULL;
>   struct device_node  *port, *endpoint;
> - int ret;
> + int ret = 0, child_count = 0;
>   const char *name;
>   u32 endpoint_id;
>
> @@ -358,13 +358,18 @@ static int rockchip_lvds_bind(struct device *dev,
> struct device *master,
>   return -EINVAL;
>   }
>   for_each_child_of_node(port, endpoint) {
> + child_count++;
>   of_property_read_u32(endpoint, "reg", &endpoint_id);
>   ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
>    &lvds->panel, &lvds->bridge);
>   if (!ret)
>   break;
>   }
> - if (ret) {
> + if (!child_count) {
> + DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
> + ret  = -EINVAL;
>
>
> Double space on "ret  =",  except this, looks good for me.
> Reviewed-by: Mark Yao <mark.yao@rock-chips.com>
>

Thanks for your review, Mark!

I've pushed the patch with whitespace fixes to -misc-next.

Sean


> + goto err_put_port;
> + } else if (ret) {
>   DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
>   ret  = -EPROBE_DEFER;
>   goto err_put_port;
>
>
> --
> ?ark Yao
