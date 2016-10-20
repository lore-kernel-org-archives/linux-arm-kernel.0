From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 20 Oct 2016 16:39:04 -0400
Subject: [PATCH] drm: convert DT component matching to
 component_match_add_release()
In-Reply-To: <E1bwo6l-0005Io-Q1@rmk-PC.armlinux.org.uk>
References: <E1bwo6l-0005Io-Q1@rmk-PC.armlinux.org.uk>
Message-ID: <CAOw6vbK=z3wJKTh8jZoU2Gj1PtTLLH_sAUUShbsxL=Qi7d+FLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 6:28 AM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:
> Convert DT component matching to use component_match_add_release().
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Can we please get this patch from May merged into the drm-misc or
> whatever trees so that we don't end up with conflicts?  I've no idea
> who looks after drm-misc, as they have _still_ failed to add
> themselves to MAINTAINERS.

I think Daniel explained pretty clearly why this wasn't happening in
the previous thread.

Next time you send a v2, can you please mark it as such and include a
"Changes in v2" section?

>
>  drivers/gpu/drm/arm/hdlcd_drv.c                 |  3 ++-
>  drivers/gpu/drm/arm/malidp_drv.c                |  4 +++-
>  drivers/gpu/drm/armada/armada_drv.c             |  2 +-
>  drivers/gpu/drm/drm_of.c                        | 28 +++++++++++++++++++++++--
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c           |  5 +++--
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c |  7 ++++---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c          |  4 +++-
>  drivers/gpu/drm/msm/msm_drv.c                   | 12 ++++++-----
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c     |  6 ++++--
>  drivers/gpu/drm/sti/sti_drv.c                   |  5 +++--
>  drivers/gpu/drm/sun4i/sun4i_drv.c               |  3 ++-
>  drivers/gpu/drm/tilcdc/tilcdc_external.c        |  4 +++-
>  include/drm/drm_of.h                            | 12 +++++++++++
>  13 files changed, 73 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index fb6a418ce6be..6477d1a65266 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -453,7 +453,8 @@ static int hdlcd_probe(struct platform_device *pdev)
>                 return -EAGAIN;
>         }
>
> -       component_match_add(&pdev->dev, &match, compare_dev, port);
> +       drm_of_component_match_add(&pdev->dev, &match, compare_dev, port);
> +       of_node_put(port);

There's no mention in your commit message about fixing these node leaks.

>
>         return component_master_add_with_match(&pdev->dev, &hdlcd_master_ops,
>                                                match);
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 9280358b8f15..9f4739452a25 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -493,7 +493,9 @@ static int malidp_platform_probe(struct platform_device *pdev)
>                 return -EAGAIN;
>         }
>
> -       component_match_add(&pdev->dev, &match, malidp_compare_dev, port);
> +       drm_of_component_match_add(&pdev->dev, &match, malidp_compare_dev,
> +                                  port);
> +       of_node_put(port);
>         return component_master_add_with_match(&pdev->dev, &malidp_master_ops,
>                                                match);
>  }
> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> index 1e0e68f608e4..94e46da9a758 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -254,7 +254,7 @@ static void armada_add_endpoints(struct device *dev,
>                         continue;
>                 }
>
> -               component_match_add(dev, match, compare_of, remote);
> +               drm_of_component_match_add(dev, match, compare_of, remote);
>                 of_node_put(remote);
>         }
>  }
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index bc98bb94264d..47848ed8ca48 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -6,6 +6,11 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_of.h>
>
> +static void drm_release_of(struct device *dev, void *data)
> +{
> +       of_node_put(data);
> +}
> +
>  /**
>   * drm_crtc_port_mask - find the mask of a registered CRTC by port OF node
>   * @dev: DRM device
> @@ -64,6 +69,24 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>  EXPORT_SYMBOL(drm_of_find_possible_crtcs);
>
>  /**
> + * drm_of_component_match_add - Add a component helper OF node match rule
> + * @master: master device
> + * @matchptr: component match pointer
> + * @compare: compare function used for matching component
> + * @node: of_node
> + */
> +void drm_of_component_match_add(struct device *master,
> +                               struct component_match **matchptr,
> +                               int (*compare)(struct device *, void *),
> +                               struct device_node *node)
> +{
> +       of_node_get(node);
> +       component_match_add_release(master, matchptr, drm_release_of,
> +                                   compare, node);
> +}
> +EXPORT_SYMBOL_GPL(drm_of_component_match_add);
> +
> +/**
>   * drm_of_component_probe - Generic probe function for a component based master
>   * @dev: master device containing the OF node
>   * @compare_of: compare function used for matching components
> @@ -101,7 +124,7 @@ int drm_of_component_probe(struct device *dev,
>                         continue;
>                 }
>
> -               component_match_add(dev, &match, compare_of, port);
> +               drm_of_component_match_add(dev, &match, compare_of, port);
>                 of_node_put(port);
>         }
>
> @@ -140,7 +163,8 @@ int drm_of_component_probe(struct device *dev,
>                                 continue;
>                         }
>
> -                       component_match_add(dev, &match, compare_of, remote);
> +                       drm_of_component_match_add(dev, &match, compare_of,
> +                                                  remote);
>                         of_node_put(remote);
>                 }
>                 of_node_put(port);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index aa687669e22b..0dee6acbd880 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -16,6 +16,7 @@
>
>  #include <linux/component.h>
>  #include <linux/of_platform.h>
> +#include <drm/drm_of.h>
>
>  #include "etnaviv_drv.h"
>  #include "etnaviv_gpu.h"
> @@ -629,8 +630,8 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
>                         if (!core_node)
>                                 break;
>
> -                       component_match_add(&pdev->dev, &match, compare_of,
> -                                           core_node);
> +                       drm_of_component_match_add(&pdev->dev, &match,
> +                                                  compare_of, core_node);
>                         of_node_put(core_node);
>                 }
>         } else if (dev->platform_data) {
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index 90377a609c98..e88fde18c946 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_of.h>
>
>  #include "kirin_drm_drv.h"
>
> @@ -260,14 +261,13 @@ static struct device_node *kirin_get_remote_node(struct device_node *np)
>                 DRM_ERROR("no valid endpoint node\n");
>                 return ERR_PTR(-ENODEV);
>         }
> -       of_node_put(endpoint);
>
>         remote = of_graph_get_remote_port_parent(endpoint);
> +       of_node_put(endpoint);

Another bug that's being fixed without mention in the commit.

>         if (!remote) {
>                 DRM_ERROR("no valid remote node\n");
>                 return ERR_PTR(-ENODEV);
>         }
> -       of_node_put(remote);
>
>         if (!of_device_is_available(remote)) {
>                 DRM_ERROR("not available for remote node\n");
> @@ -294,7 +294,8 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
>         if (IS_ERR(remote))
>                 return PTR_ERR(remote);
>
> -       component_match_add(dev, &match, compare_of, remote);
> +       drm_of_component_match_add(dev, &match, compare_of, remote);
> +       of_node_put(remote);
>
>         return component_master_add_with_match(dev, &kirin_drm_ops, match);
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index cf83f6507ec8..9c5430fb82a2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_of.h>
>  #include <linux/component.h>
>  #include <linux/iommu.h>
>  #include <linux/of_address.h>
> @@ -415,7 +416,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
>                     comp_type == MTK_DPI) {
>                         dev_info(dev, "Adding component match for %s\n",
>                                  node->full_name);
> -                       component_match_add(dev, &match, compare_of, node);
> +                       drm_of_component_match_add(dev, &match, compare_of,
> +                                                  node);
>                 } else {
>                         struct mtk_ddp_comp *comp;
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index fb5c0b0a7594..84d38eaea585 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -15,6 +15,8 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#include <drm/drm_of.h>
> +
>  #include "msm_drv.h"
>  #include "msm_debugfs.h"
>  #include "msm_fence.h"
> @@ -919,8 +921,8 @@ static int add_components_mdp(struct device *mdp_dev,
>                         continue;
>                 }
>
> -               component_match_add(master_dev, matchptr, compare_of, intf);
> -
> +               drm_of_component_match_add(master_dev, matchptr, compare_of,
> +                                          intf);
>                 of_node_put(intf);
>                 of_node_put(ep_node);
>         }
> @@ -962,8 +964,8 @@ static int add_display_components(struct device *dev,
>                 put_device(mdp_dev);
>
>                 /* add the MDP component itself */
> -               component_match_add(dev, matchptr, compare_of,
> -                                   mdp_dev->of_node);
> +               drm_of_component_match_add(dev, matchptr, compare_of,
> +                                          mdp_dev->of_node);
>         } else {
>                 /* MDP4 */
>                 mdp_dev = dev;
> @@ -996,7 +998,7 @@ static int add_gpu_components(struct device *dev,
>         if (!np)
>                 return 0;
>
> -       component_match_add(dev, matchptr, compare_of, np);
> +       drm_of_component_match_add(dev, matchptr, compare_of, np);
>
>         of_node_put(np);
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 8c8cbe837e61..6fe161192bb4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -20,6 +20,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_of.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/module.h>
> @@ -388,7 +389,7 @@ static void rockchip_add_endpoints(struct device *dev,
>                         continue;
>                 }
>
> -               component_match_add(dev, match, compare_of, remote);
> +               drm_of_component_match_add(dev, match, compare_of, remote);
>                 of_node_put(remote);
>         }
>  }
> @@ -437,7 +438,8 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
>                 }
>
>                 of_node_put(iommu);
> -               component_match_add(dev, &match, compare_of, port->parent);
> +               drm_of_component_match_add(dev, &match, compare_of,
> +                                          port->parent);
>                 of_node_put(port);
>         }
>
> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> index 2784919a7366..5e819876e642 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -17,6 +17,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_of.h>
>
>  #include "sti_crtc.h"
>  #include "sti_drv.h"
> @@ -423,8 +424,8 @@ static int sti_platform_probe(struct platform_device *pdev)
>         child_np = of_get_next_available_child(node, NULL);
>
>         while (child_np) {
> -               component_match_add(dev, &match, compare_of, child_np);
> -               of_node_put(child_np);
> +               drm_of_component_match_add(dev, &match, compare_of,
> +                                          child_np);
>                 child_np = of_get_next_available_child(node, child_np);
>         }
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 0da9862ad8ed..b3c4ad605e81 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -18,6 +18,7 @@
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_of.h>
>
>  #include "sun4i_crtc.h"
>  #include "sun4i_drv.h"
> @@ -239,7 +240,7 @@ static int sun4i_drv_add_endpoints(struct device *dev,
>                 /* Add current component */
>                 DRM_DEBUG_DRIVER("Adding component %s\n",
>                                  of_node_full_name(node));
> -               component_match_add(dev, match, compare_of, node);
> +               drm_of_component_match_add(dev, match, compare_of, node);
>                 count++;
>         }
>
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
> index 68e895021005..06a4c584f3cb 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/component.h>
>  #include <linux/of_graph.h>
> +#include <drm/drm_of.h>
>
>  #include "tilcdc_drv.h"
>  #include "tilcdc_external.h"
> @@ -160,7 +161,8 @@ int tilcdc_get_external_components(struct device *dev,
>
>                 dev_dbg(dev, "Subdevice node '%s' found\n", node->name);
>                 if (match)
> -                       component_match_add(dev, match, dev_match_of, node);
> +                       drm_of_component_match_add(dev, match, dev_match_of,
> +                                                  node);
>                 of_node_put(node);
>                 count++;
>         }
> diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
> index 3fd87b386ed7..d6b4c5587bbe 100644
> --- a/include/drm/drm_of.h
> +++ b/include/drm/drm_of.h
> @@ -4,6 +4,7 @@
>  #include <linux/of_graph.h>
>
>  struct component_master_ops;
> +struct component_match;
>  struct device;
>  struct drm_device;
>  struct drm_encoder;
> @@ -12,6 +13,10 @@ struct device_node;
>  #ifdef CONFIG_OF
>  extern uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>                                            struct device_node *port);
> +extern void drm_of_component_match_add(struct device *master,
> +                                      struct component_match **matchptr,
> +                                      int (*compare)(struct device *, void *),
> +                                      struct device_node *node);
>  extern int drm_of_component_probe(struct device *dev,
>                                   int (*compare_of)(struct device *, void *),
>                                   const struct component_master_ops *m_ops);
> @@ -25,6 +30,13 @@ static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>         return 0;
>  }
>
> +static void drm_of_component_match_add(struct device *master,
> +                                      struct component_match **matchptr,
> +                                      int (*compare)(struct device *, void *),
> +                                      struct device_node *node)
> +{
> +}
> +
>  static inline int
>  drm_of_component_probe(struct device *dev,
>                        int (*compare_of)(struct device *, void *),
> --
> 2.1.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
