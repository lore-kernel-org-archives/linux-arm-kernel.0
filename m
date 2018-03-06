From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 6 Mar 2018 09:03:13 +0100
Subject: [PATCH] drm: simple_kms_helper: Fix .mode_valid() documentation
In-Reply-To: <20180227101109.6088-1-linus.walleij@linaro.org>
References: <20180227101109.6088-1-linus.walleij@linaro.org>
Message-ID: <20180306080313.GB22212@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 11:11:09AM +0100, Linus Walleij wrote:
> This fixes up the .mode_valid() vtable entry documentation
> by copyediting the documentation from the .mode_valid()
> documentation in the drm_modeset_helper_vtables.h file.
> 
> Fixes: 40275dc4edb4 ("drm: simple_kms_helper: Add mode_valid() callback support")
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  include/drm/drm_simple_kms_helper.h | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
> index d9e4c3c3f009..0d700a869cc8 100644
> --- a/include/drm/drm_simple_kms_helper.h
> +++ b/include/drm/drm_simple_kms_helper.h
> @@ -24,9 +24,30 @@ struct drm_simple_display_pipe_funcs {
>  	/**
>  	 * @mode_valid:
>  	 *
> -	 * This function is called to filter out valid modes from the
> -	 * suggestions suggested by the bridge or display. This optional
> -	 * hook is passed in when initializing the pipeline.
> +	 * This callback is used to check if a specific mode is valid in the
> +	 * crtc used in this simple display pipe. This should be implemented
> +	 * if the display pipe has some sort of restriction in the modes
> +	 * it can display. For example, a given display pipe may be responsible
> +	 * to set a clock value. If the clock can not produce all the values
> +	 * for the available modes then this callback can be used to restrict
> +	 * the number of modes to only the ones that can be displayed. Another
> +	 * reason can be bandwidth mitigation: the memory port on the display
> +	 * controller can have bandwidth limitations not allowing pixel data
> +	 * to be fetched at any rate.
> +	 *
> +	 * This hook is used by the probe helpers to filter the mode list in
> +	 * drm_helper_probe_single_connector_modes(), and it is used by the
> +	 * atomic helpers to validate modes supplied by userspace in
> +	 * drm_atomic_helper_check_modeset().
> +	 *
> +	 * This function is optional.
> +	 *
> +	 * NOTE:
> +	 *
> +	 * Since this function is both called from the check phase of an atomic
> +	 * commit, and the mode validation in the probe paths it is not allowed
> +	 * to look at anything else but the passed-in mode, and validate it
> +	 * against configuration-invariant hardware constraints.
>  	 *
>  	 * RETURNS:
>  	 *
> -- 
> 2.14.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
