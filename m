From: vincent.abriou@st.com (Vincent ABRIOU)
Date: Tue, 7 Jun 2016 16:26:13 +0200
Subject: [PATCH v2 2/3] drm: convert DT component matching to
 component_match_add_release()
In-Reply-To: <E1b8pyX-0005OP-2s@rmk-PC.armlinux.org.uk>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
 <E1b8pyX-0005OP-2s@rmk-PC.armlinux.org.uk>
Message-ID: <5756D985.80107@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/03/2016 04:21 PM, Russell King wrote:
> Convert DT component matching to use component_match_add_release().
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/gpu/drm/arm/hdlcd_drv.c             |  9 +++------
>   drivers/gpu/drm/armada/armada_drv.c         |  8 ++------
>   drivers/gpu/drm/drm_of.c                    |  6 ++++--
>   drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 11 ++---------
>   drivers/gpu/drm/msm/msm_drv.c               |  8 ++------
>   drivers/gpu/drm/msm/msm_drv.h               |  1 +
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 12 +++---------
>   drivers/gpu/drm/sti/sti_drv.c               |  9 ++-------
>   drivers/gpu/drm/tilcdc/tilcdc_external.c    |  8 ++------
>   9 files changed, 21 insertions(+), 51 deletions(-)
>
>
> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> index 872495e72294..aeb2787c9bd4 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -10,6 +10,7 @@
>   #include <linux/debugfs.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/of_component.h>
>   #include <linux/of_platform.h>
>
>   #include <drm/drm_atomic.h>
> @@ -341,11 +342,6 @@ static struct drm_driver sti_driver = {
>   	.minor = DRIVER_MINOR,
>   };
>
> -static int compare_of(struct device *dev, void *data)
> -{
> -	return dev->of_node == data;
> -}
> -
>   static int sti_bind(struct device *dev)
>   {
>   	return drm_platform_init(&sti_driver, to_platform_device(dev));
> @@ -375,8 +371,7 @@ static int sti_platform_probe(struct platform_device *pdev)
>   	child_np = of_get_next_available_child(node, NULL);
>
>   	while (child_np) {
> -		component_match_add(dev, &match, compare_of, child_np);
> -		of_node_put(child_np);
> +		component_match_add_of(dev, &match, child_np);
>   		child_np = of_get_next_available_child(node, child_np);
>   	}
>

Hi Russel,

Ok for the sti driver.

Acked-by: Vincent Abriou <vincent.abriou@st.com>
