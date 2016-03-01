From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 01 Mar 2016 23:15:03 +0200
Subject: [PATCH] drm: rcar-du: clarify vsp dependency
In-Reply-To: <1456487546-3886345-1-git-send-email-arnd@arndb.de>
References: <1456487546-3886345-1-git-send-email-arnd@arndb.de>
Message-ID: <1889313.6DCL1oqnHh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thank you for the patch.

On Friday 26 February 2016 12:52:20 Arnd Bergmann wrote:
> The VSP1 compositor code in DRM links against the respective V4L
> driver, but the dependency is not expressed correctly in Kconfig,
> which leads to a build error when the DRM driver is built-in
> and the V4L driver is a module:
> 
> drivers/gpu/built-in.o: In function `rcar_du_vsp_plane_atomic_update':
> rcar-du/rcar_du_vsp.c:183: undefined reference to `vsp1_du_atomic_update'
> 
> This patch avoids the problem by ensuring that the DRM VSP code can
> only be enabled if the V4L driver is linked into the kernel, or
> both are loadable modules.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6d62ef3ac30b ("drm: rcar-du: Expose the VSP1 compositor through KMS
> planes")

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Dave, could you please queue this for v4.6 ?

> ---
>  drivers/gpu/drm/rcar-du/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/Kconfig
> b/drivers/gpu/drm/rcar-du/Kconfig index 1f10fa0928b4..eb1e6d5cfed9 100644
> --- a/drivers/gpu/drm/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/rcar-du/Kconfig
> @@ -27,6 +27,6 @@ config DRM_RCAR_LVDS
>  config DRM_RCAR_VSP
>  	bool "R-Car DU VSP Compositor Support"
>  	depends on DRM_RCAR_DU
> -	depends on VIDEO_RENESAS_VSP1
> +	depends on VIDEO_RENESAS_VSP1=y || (VIDEO_RENESAS_VSP1 && DRM_RCAR_DU=m)
>  	help
>  	  Enable support to expose the R-Car VSP Compositor as KMS planes.

-- 
Regards,

Laurent Pinchart
