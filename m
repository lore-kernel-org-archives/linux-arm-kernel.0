From: neko@bakuhatsu.net (Matt Sealey)
Date: Wed, 23 Oct 2013 10:47:50 -0500
Subject: [Patch v2][ 03/37] drm: Add the lacking DRM_MODE_FLAG_* for
 matching the DISPLAY_FLAGS_*
In-Reply-To: <1382022155-21954-4-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-4-git-send-email-denis@eukrea.com>
Message-ID: <CAHCPf3sgPMh5omoqafsYfto8roL+d0CQOCqHUmPn6mTAcQJRDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 10:02 AM, Denis Carikli <denis@eukrea.com> wrote:
> Without that fix, drivers using the drm_display_mode_from_videomode
>   function will not be able to get certain information because
>   some DISPLAY_FLAGS_* have no corresponding DRM_MODE_FLAG_*.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: driverdev-devel at linuxdriverproject.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  drivers/gpu/drm/drm_modes.c |    9 +++++++++
>  include/uapi/drm/drm_mode.h |    4 ++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index b073315..353aaae 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -537,6 +537,15 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
>                 dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
>         if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
>                 dmode->flags |= DRM_MODE_FLAG_DBLCLK;
> +       if (vm->flags & DISPLAY_FLAGS_DE_LOW)
> +               dmode->flags |= DRM_MODE_FLAG_NDATEN;
> +       if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
> +               dmode->flags |= DRM_MODE_FLAG_PDATEN;
> +       if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +               dmode->flags |= DRM_MODE_FLAG_PPIXDATEDGE;
> +       if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +               dmode->flags |= DRM_MODE_FLAG_NPIXDATEDGE;

Is there any reason these aren't named after the original
DISPLAY_FLAGS? DRM_MODE_FLAG_PIXDATA_POSEDGE is easier to get your
head around if you know it is mapped from the DISPLAY_FLAGS_ version.
PDATEN and PPIXDATEDGE don't exactly map to things like EDID field
names either..

> +#define DRM_MODE_FLAG_PPIXDATEDGE              (1<<24)
> +#define DRM_MODE_FLAG_NPIXDATEDGE              (1<<25)

-- 
Matt Sealey <neko@bakuhatsu.net>
