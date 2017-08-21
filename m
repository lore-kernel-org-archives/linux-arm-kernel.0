From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 21 Aug 2017 18:30:16 +0200
Subject: [PATCH 2/4 v2] drm/tve200: Add new driver for TVE200
In-Reply-To: <20170820100557.24991-2-linus.walleij@linaro.org>
References: <20170820100557.24991-1-linus.walleij@linaro.org>
 <20170820100557.24991-2-linus.walleij@linaro.org>
Message-ID: <20170821163016.l2lw3xmsxxvh45xs@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 20, 2017 at 12:05:55PM +0200, Linus Walleij wrote:
> This adds a new DRM driver for the Faraday Technology TVE200
> block. This "TV Encoder" encodes a ITU-T BT.656 stream and can
> be found in the StorLink SL3516 (later Cortina Systems CS3516)
> as well as the Grain Media GM8180.
> 
> I do not have definitive word from anyone at Faraday that this
> IP block is theirs, but it bears the hallmark of their 3-digit
> version code (200) and is used in two SoCs from completely
> different companies. (Grain Media was fully owned by Faraday
> until it was transferred to NovoTek this january, and
> Faraday did lots of work on the StorLink SoCs.)
> 
> The D-Link DIR-685 uses this in connection with the Ilitek
> ILI9322 panel driver that supports BT.656 input, while the
> GM8180 apparently has been used with the Cirrus Logic CS4954
> digital video encoder. The oldest user seems to be
> something called Techwall 2835.
> 
> This driver is heavily inspired by Eric Anholt's PL111
> driver and therefore I have mentioned all the ancestor authors
> in the header file.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Just 2 comments for the discussion:

On wiring up the panel-bridge: The rough idea would be to be to wrap the
panel into drm_bridge using devm_drm_panel_bridge_add(). That should
remove pretty much all your connector code.

Then attach that bridge to your simple kms pipe using
drm_simple_display_pipe_attach_bridge(). If you use that one you can pass
NULL for the connector when calling drm_simple_display_pipe_init(), the
kernel-doc explains that.

I don't think anything else would be needed really, it should all just
work. Well, you'd need to remove all the explicit calls to enable/disable
the panel, since the bridge takes care of that.

But imo that can be done as a follow up, if you're bored.

> +static int tve200_display_prepare_fb(struct drm_simple_display_pipe *pipe,
> +				    struct drm_plane_state *plane_state)
> +{
> +	return drm_fb_cma_prepare_fb(&pipe->plane, plane_state);
> +}

I think a wrapper in the simple_kms_helper for the above would be good.
Probably best done after Noralf's cleanup has landed (since that removes
the cma-specific prepare_fb function and replaces it by a generic one
which works for all gem based drivers).

btw for merging your driver I think you only need the DT ack from Rob
Herring, then you can push the entire pile to drm-misc.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
