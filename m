From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Aug 2017 10:58:44 -0700
Subject: [PATCH 7/7] drm/pl111: Add handling of Versatile platforms
In-Reply-To: <20170830180711.2791-8-linus.walleij@linaro.org>
References: <20170830180711.2791-1-linus.walleij@linaro.org>
 <20170830180711.2791-8-linus.walleij@linaro.org>
Message-ID: <878thzzkiz.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The ARM reference designs in the Versatile family: Integrator,
> Versatile and RealView can make use of the new DRM driver as well.
> We just need to create a bit of platform-specific code for them
> that we isolate to its own file.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/pl111/Makefile          |   1 +
>  drivers/gpu/drm/pl111/pl111_display.c   |   7 -
>  drivers/gpu/drm/pl111/pl111_drv.c       |   5 +
>  drivers/gpu/drm/pl111/pl111_versatile.c | 270 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/pl111/pl111_versatile.h |   9 ++
>  5 files changed, 285 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/gpu/drm/pl111/pl111_versatile.c
>  create mode 100644 drivers/gpu/drm/pl111/pl111_versatile.h
>
> diff --git a/drivers/gpu/drm/pl111/Makefile b/drivers/gpu/drm/pl111/Makefile
> index c5f8f9684848..fce1453a93e1 100644
> --- a/drivers/gpu/drm/pl111/Makefile
> +++ b/drivers/gpu/drm/pl111/Makefile
> @@ -1,4 +1,5 @@
>  pl111_drm-y +=	pl111_display.o \
> +		pl111_versatile.o \
>  		pl111_drv.o
>  
>  pl111_drm-$(CONFIG_DEBUG_FS) += pl111_debugfs.o
> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> index 37f409867934..f7b043f4fed6 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -454,13 +454,6 @@ int pl111_display_init(struct drm_device *drm)
>  	}
>  	of_node_put(endpoint);
>  
> -	if (tft_r0b0g0[0] != 0 ||
> -	    tft_r0b0g0[1] != 8 ||
> -	    tft_r0b0g0[2] != 16) {
> -		dev_err(dev, "arm,pl11x,tft-r0g0b0-pads != [0,8,16] not yet supported\n");
> -		return -EINVAL;
> -	}

I had a note in the DOC section of pl111_drv.c about needing to filter
available formats based on this property.  Could you update that with
some explanation of the new state of things?  (Do we actually need to
filter the formats?)

I haven't verified that we get the same pin routing setup as the fbdev
driver did for these platforms, but even if they don't match yet this
seems like an excellent start and we can make sure we sort them out as
we add panel drivers.

I've verified that my Cygnus board continues working with your series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/7da51f1b/attachment.sig>
