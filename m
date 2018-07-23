From: ayan.halder@arm.com (Ayan Halder)
Date: Mon, 23 Jul 2018 10:35:51 +0100
Subject: [PATCH 03/10] drm: mali-dp: Use __drm_atomic_helper_plane_reset
 instead of copying the logic
In-Reply-To: <20180720211509.23605-4-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
 <20180720211509.23605-4-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180723093335.GA26447@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 10:15:02PM +0100, Alexandru Gheorghe wrote:
> Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_planes.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 29409a65d864..49c37f6dd63e 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -78,11 +78,8 @@ static void malidp_plane_reset(struct drm_plane *plane)
>  	kfree(state);
>  	plane->state = NULL;
>  	state = kzalloc(sizeof(*state), GFP_KERNEL);
> -	if (state) {
> -		state->base.plane = plane;
> -		state->base.rotation = DRM_MODE_ROTATE_0;
> -		plane->state = &state->base;
> -	}
> +	if (state)
> +		__drm_atomic_helper_plane_reset(plane, &state->base);
>  }
>  
>  static struct
> -- 
> 2.18.0
>
A commit description like the following might be useful (though the
patch is a part of series) :-
Invoke a newly added drm atomic helper function
(__drm_atomic_helper_plane_reset) to reset the 'drm_plane_state' to
its default values for rotation, alpha and plane.

Otherwise, with my limited knowledge on DRM, this looks OK to me:-
Reviewed-by :- Ayan Kumar halder <ayan.halder@arm.com> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
