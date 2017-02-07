From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 7 Feb 2017 08:21:03 +0100
Subject: [PATCH] drm/atmel-hlcdc: Simplify the HLCDC layer logic
In-Reply-To: <1486405627-25714-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1486405627-25714-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170207072103.fmitjl4t6jigybak@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 07:27:07PM +0100, Boris Brezillon wrote:
> An HLCDC layers in Atmel's nomenclature is either a DRM plane or a 'Post
> Processing Layer' which can be used to output the results of the HLCDC
> composition in a memory buffer.
> 
> atmel_hlcdc_layer.c was designed to be generic enough to be re-usable in
> both cases, but we're not exposing the post-processing layer yet, and
> even if we were, I'm not sure the code would provide the necessary tools
> to manipulate this kind of layer.
> 
> Moreover, the code in atmel_hlcdc_{plane,layer}.c was designed before the
> atomic modesetting API, and was trying solve the
> check-setting/commit-if-ok/rollback-otherwise problem, which is now
> entirely solved by the existing core infrastructure.
> 
> And finally, the code in atmel_hlcdc_layer.c in over-complicated compared
> to what we really need. This rework is a good excuse to simplify it. Note
> that this rework solves an existing resource leak (leading to a -EBUSY
> error) which I failed to clearly identify.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Hi Daniel,
> 
> You might not remember, but this is something you asked me to do a while
> ago, and it's finally there.
> This patch reworks the Atmel HLCDC plane logic to get rid of all the
> complexity in atmel_hlcdc_layer.c and this includes getting rid of
> drm_flip_work, which you were trying to kill IIRC.

[snip]

> @@ -76,6 +77,27 @@ drm_plane_state_to_atmel_hlcdc_plane_state(struct drm_plane_state *s)
>  	return container_of(s, struct atmel_hlcdc_plane_state, base);
>  }
>  
> +/**
> + * Atmel HLCDC Plane.
> + *
> + * @base: base DRM plane structure
> + * @desc: HLCDC layer desc structure
> + * @properties: pointer to the property definitions structure
> + * @regmap: HLCDC regmap
> + */
> +struct atmel_hlcdc_plane {
> +	struct drm_plane base;
> +	const struct atmel_hlcdc_layer_desc *desc;

So I'm not 100%, but it looks like you have a 1:1 relationship between
atmel_hlcdc_plane and atmel_hlcdc_layer. I't go one step further even and
merge these two structures together (or embed one into the other). Only
reason against that would be if eventually you need to dynamically assign
layers to planes (e.g. 2 layers for nv12 or something like that), which
would mean you need to keep the pointer (and for dynamic assignement, move
it into the plane_state).

I didn't check the details of your patch really, but in general removing
abstractions when we don't need them is a good idea.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
