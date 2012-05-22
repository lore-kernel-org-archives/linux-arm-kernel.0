From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 22 May 2012 16:06:41 +0200
Subject: 
In-Reply-To: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4FBB9D71.5040906@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2012 02:27 PM, Sascha Hauer wrote:
> Hi All,
> 
> The following adds a drm/kms driver for the Freescale i.MX LCDC
> controller. Most notable change to the last SDRM based version is that
> the SDRM layer has been removed and the driver now is purely i.MX
> specific. I hope that this is more acceptable now.
> 
> Another change is that the probe is now devicetree based. For now I
> took the easy way out and only put an edid blob into the devicetree.
> I haven't documented the binding yet, I would add that when the rest
> is considered ok.
> 
> Comments very welcome.
> 

Hi,

I really liked the sdrm layer. At least some bits of it. I've been working
on a "simple" DRM driver as well. The hardware has no fancy acceleration
features, just a simple buffer and some scanout logic. I'm basically using
the same gem buffer structure and the buffer is also allocated using
dma_alloc_writecombine, which means we can probably share all of the GEM
handling code and probably also most of the fbdev code. I also started with
the Exynos GEM code as a template, but reworked it later to be more like the
UDL code, which made it a bit more compact. I think it would be a good idea
to put at least the GEM handling in some common code as I expect that we'll
see more similar "simple" DRM drivers pop up.

The code in question can be found at
https://github.com/lclausen-adi/linux-2.6/commit/87a8fd6b98eeee317c7a486846cc8405d0bd68d8

Btw. the imx-drm.h is missing in your patch.

- Lars

> Thanks
>  Sascha
> 
> ----------------------------------------------------------------
> Sascha Hauer (2):
>       DRM: add Freescale i.MX LCDC driver
>       pcm038 lcdc support
> 
>  arch/arm/boot/dts/imx27-phytec-phycore.dts |   39 ++
>  arch/arm/boot/dts/imx27.dtsi               |    7 +
>  arch/arm/mach-imx/clock-imx27.c            |    1 +
>  drivers/gpu/drm/Kconfig                    |    2 +
>  drivers/gpu/drm/Makefile                   |    1 +
>  drivers/gpu/drm/imx/Kconfig                |   18 +
>  drivers/gpu/drm/imx/Makefile               |    8 +
>  drivers/gpu/drm/imx/imx-drm-core.c         |  745 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/imx/imx-fb.c               |  179 +++++++
>  drivers/gpu/drm/imx/imx-fbdev.c            |  275 ++++++++++
>  drivers/gpu/drm/imx/imx-gem.c              |  343 +++++++++++++
>  drivers/gpu/drm/imx/imx-lcdc-crtc.c        |  517 +++++++++++++++++++
>  drivers/gpu/drm/imx/imx-parallel-display.c |  228 +++++++++
>  13 files changed, 2363 insertions(+)
>  create mode 100644 drivers/gpu/drm/imx/Kconfig
>  create mode 100644 drivers/gpu/drm/imx/Makefile
>  create mode 100644 drivers/gpu/drm/imx/imx-drm-core.c
>  create mode 100644 drivers/gpu/drm/imx/imx-fb.c
>  create mode 100644 drivers/gpu/drm/imx/imx-fbdev.c
>  create mode 100644 drivers/gpu/drm/imx/imx-gem.c
>  create mode 100644 drivers/gpu/drm/imx/imx-lcdc-crtc.c
>  create mode 100644 drivers/gpu/drm/imx/imx-parallel-display.c
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
