From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 7 Sep 2018 10:41:43 +0100
Subject: [PATCH] [v3] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
In-Reply-To: <20180711144403.1022829-1-arnd@arndb.de>
References: <20180711144403.1022829-1-arnd@arndb.de>
Message-ID: <105cb1cf-577a-043a-9b50-248a37090bdd@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/07/18 15:43, Arnd Bergmann wrote:
> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
> a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:
> 
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
> 
> This solves the problem by adding a silent symbol for the tcon_top module,
> building it as a separate module in exactly the cases that we need it,
> but in a way that it is reachable by the other modules.
> 
> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
> Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
I am seeing the following on today's -next (20180907) as well the last
few -next versions for that matter ...

ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!

Seems like this issue has cropped up again as Arnd's fix is present. I
am seeing this on ARM64 builds. 

Cheers
Jon

-- 
nvpublic
