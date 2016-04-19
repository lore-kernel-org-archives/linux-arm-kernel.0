From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 19 Apr 2016 08:27:10 +0200
Subject: [PATCH] drm/rockchip: support non-iommu buffer path
In-Reply-To: <1461032372-14630-1-git-send-email-mark.yao@rock-chips.com>
References: <1461032372-14630-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <2221474.O4M7g09IWn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 19. April 2016, 10:19:32 schrieb Mark Yao:
> Some rockchip vop not support iommu, need use non-iommu
> buffer for it. And if we get iommu issues, we can compare
> the issues with non-iommu path, the would help the debug.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   65
> +++++++++++++++++++-------- 1 file changed, 47 insertions(+), 18
> deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c index f556a8f..90729c0 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c

[...]

> @@ -497,6 +514,18 @@ static int rockchip_drm_platform_probe(struct
> platform_device *pdev) continue;
>  		}
> 
> +		iommu = of_parse_phandle(port->parent, "iommus", 0);
> +		if (!iommu || !of_device_is_available(iommu->parent)) {
> +			dev_warn(dev, "No available iommu found for %s\n",
> +				 port->parent->full_name);
> +			dev_warn(dev, "Force non-iommu buffer for all crtc\n");

As stated in the patch-description, this is somewhat common for _some_ vops 
[like the Cortex-A9s I'm still hoping to support at some point in the future 
:-D ], so this should probably be either a dev_dbg or a dev_info as maximum 
and also condensed into one line of output like:

	dev_dbg(dev, "no iommu attached for %s, using non-iommu buffers\n",
			  port->parent->full_name);


Heiko
