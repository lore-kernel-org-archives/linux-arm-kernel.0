From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 Nov 2018 16:12:17 +0100
Subject: [PATCH] drm/fbdev: Make skip_vt_switch the default
In-Reply-To: <20181127173424.301-1-daniel.vetter@ffwll.ch>
References: <20181127170952.28507-1-daniel.vetter@ffwll.ch>
 <20181127173424.301-1-daniel.vetter@ffwll.ch>
Message-ID: <48238853.2xeD6gLTbZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 27. November 2018, 18:34:24 CET schrieb Daniel Vetter:
> KMS drivers really should all be able to restore their display state
> on resume without fbcon helping out. So make this the default.
> 
> Since I'm not entirely foolish, make it only a default, which drivers
> can still override. That way when the inevitable regression report
> happens I can fix things up with a one-liner plus FIXME comment that
> someone should fix up the suspend/resume code in that driver.
> 
> But at least all new drivers won't be broken by accident as soon as
> you turn off fbcon because "suspend/resume worked when I tested it".
> 
> v2: Keep this for radeon because of
> 
> commit 18c437caa5b18a235dd65cec224eab54bebcee65
> Author: Alex Deucher <alexander.deucher@amd.com>
> Date:   Tue Nov 14 17:19:29 2017 -0500
> 
>     Revert "drm/radeon: dont switch vt on suspend"
> 
> Thanks to Michel D?nzer for pointing this one out.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c index
> e6650553f5d6..361604e51361 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
> @@ -111,8 +111,6 @@ static int rockchip_drm_fbdev_create(struct
> drm_fb_helper *helper, rk_obj->kvaddr,
>  		      offset, size);
> 
> -	fbi->skip_vt_switch = true;
> -
>  	return 0;
> 
>  out:

for the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>

It looks somewhat obvious for that, as the Rockchip setting was true
from the beginning, but I still gave it some suspend-spins on rk3399
so as well
Tested-by: Heiko Stuebner <heiko@sntech.de>
