From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 17 Jul 2018 22:41:20 +1000
Subject: [linux-sunxi] [PATCH 2/2] drm/sun4i: sun4i: Introduce a quirk for
 lowest plane alpha support
In-Reply-To: <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
References: <20180717085230.17472-1-paul.kocialkowski@bootlin.com>
 <20180717085230.17472-2-paul.kocialkowski@bootlin.com>
Message-ID: <CAGRGNgX27bbJz2qe3FOb4eP5WKgDYFUNxoz7SkUbN_QDF25pAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, Jul 17, 2018 at 6:53 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Not all sunxi platforms with the first version of the Display Engine
> support an alpha component on the plane with the lowest z position
> (as in: lowest z-pos), that gets blended with the background color.
>
> In particular, the A13 is known to have this limitation. However, it was
> recently discovered that the A20 and A33 are capable of having alpha on
> their lowest plane.
>
> Thus, this introduces a specific quirk to indicate such support,
> per-platform. Since this was not tested on sun4i and sun6i platforms, a
> conservative approach is kept and this feature is not supported.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index a3cc398d4d80..cdc4a8a91ea2 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -584,8 +587,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>         }
>
>         /* We can't have an alpha plane at the lowest position */
> -       if (plane_states[0]->fb->format->has_alpha ||
> -           (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE))
> +       if ((plane_states[0]->fb->format->has_alpha ||
> +           (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE)) &&
> +           !backend->quirks->supports_lowest_plane_alpha)

>From a readability perspective, it'd be fractionally nicer if the
quirk check was before the alpha checks.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
