From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 09 Jul 2018 10:58:07 +0200
Subject: [PATCH] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
In-Reply-To: <20180709080724.3ekqb45fsjubvhcm@flea>
References: <20180706124628.3192421-1-arnd@arndb.de>
 <20180709080724.3ekqb45fsjubvhcm@flea>
Message-ID: <1768773.IAdV5VvfSI@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ponedeljek, 09. julij 2018 ob 10:07:24 CEST je Maxime Ripard napisal(a):
> On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
> > Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results
> > in a link error, as we try to access a symbol from the sun8i_tcon_top.ko
> > module:
> > 
> > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko]
> > undefined! ERROR: "sun8i_tcon_top_of_table"
> > [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
> > 
> > This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol,
> > building
> > the sun8i_tcon_top module the same way as the core sun4i-drm module
> > whenever DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
> > 
> > Alternatively, we could always build sun8i_tcon_top.ko along with
> > sun4-drm.ko and detach it from the mixer module, I could not tell which
> > way is more appropriate here.
> 
> If that's easily doable, then yeah, that would be the preferred option
> I guess. Jernej? Chen-Yu? Any opinion on this?

I guess that only means building sun8i_tcon_top.o with DRM_SUN4I instead of  
DRM_SUN8I_MIXER.

While this would be simple solution, sun8i_tcon_top would be dead weight if 
DRM_SUN8I_MIXER is disabled. But it is really small module, so I don't see any 
harm.

Additionally, with my follow up R40 HDMI series, there is even more calls from 
DRM_SUN4I enabled drivers to sun8i_tcon_top driver.

So I'm also for sun8i_tcon_top.o being build with DRM_SUN4I, because it is 
simpler, cleaner and it's symbols (including those introduced in R40 HDMI 
follow up series) are used mostly by DRM_SUN4I drivers (only exception being 
sun8i_dw_hdmi).

Best regards,
Jernej
