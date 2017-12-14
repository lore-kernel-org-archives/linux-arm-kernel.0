From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Dec 2017 11:32:26 +0100
Subject: [PATCH 6/8] drm/sun4i: sun4i_layer: Wire in the frontend
In-Reply-To: <ae438818-7b5c-c2b0-b390-e86004c36d39@vitsch.nl>
References: <1513182183-1118130873.0029cb8ee8@prakkezator.vehosting.nl>
 <ae438818-7b5c-c2b0-b390-e86004c36d39@vitsch.nl>
Message-ID: <20171214103226.qlcuginegkqzsksv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 13, 2017 at 05:23:04PM +0100, Thomas van Kleef wrote:
> I wondered if the following is still valid?
> In file sun4i_layer.c, func sun4i_layers_init
> 
> ------------------
>          /*
>          * The hardware is a bit unusual here.
>          *
>          * Even though it supports 4 layers, it does the composition
>          * in two separate steps.
>          *
>          * The first one is assigning a layer to one of its two
>          * pipes. If more that 1 layer is assigned to the same pipe,
>          * and if pixels overlaps, the pipe will take the pixel from
>          * the layer with the highest priority.
>          *
>          * The second step is the actual alpha blending, that takes
>          * the two pipes as input, and uses the eventual alpha
>          * component to do the transparency between the two.
>          *
>          * This two steps scenario makes us unable to guarantee a
>          * robust alpha blending between the 4 layers in all
>          * situations. So we just expose two layers, one per pipe. On
>          * SoCs that support it, sprites could fill the need for more
>          * layers.
>          */
>         for (i = 0; i < ARRAY_SIZE(sun4i_backend_planes); i++) {
>                 const struct sun4i_plane_desc *plane = &sun4i_backend_planes[i];
>                 struct sun4i_layer *layer;
> 
>                 layer = sun4i_layer_init_one(drm, backend, plane);
>                 if (IS_ERR(layer)) {
>                         dev_err(drm->dev, "Couldn't initialize %s plane\n",
>                                 i ? "overlay" : "primary");
>                         return ERR_CAST(layer);
>                 };
> 
>                 DRM_DEBUG_DRIVER("Assigning %s plane to pipe %d\n",
>                                  i ? "overlay" : "primary", plane->pipe);
>                 regmap_update_bits(engine->regs, SUN4I_BACKEND_ATTCTL_REG0(i),
>                                    SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL_MASK,
>                                    SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(plane->pipe));
> 
>                 layer->id = i;
>                 planes[i] = &layer->plane;
>         };
> -----------------
>
> I have been using the 3rd layer (layer2) as the input for the
> frontend. This essentially overlays the other 2 layers. Is it still
> the case that we can only have 2 layers here?

Yes.

> Or could be present 1 additional layer when it is attached to the
> frontend?

The frontend will still consume a backend layer. In this current
serie, we still define only two layers for the reasons exposed above,
and whatever layer using hardware scaling will use the frontend.

I have a few patches that would remove that limitation, but we need a
few things in order to do that properly.

The first one would be to add a check on the alpha component of our
layers. We basically have two rules:
  - the lowest plane shouldn't use alpha at all, because of a bug in
    the display engine that would render the pixels completely
    transparents if the alpha is set to something less than 255 on the
    lowest plane.
  - we can only have a plane with alpha as the lowest plane of each
    pipe.

This effectively means that the only scenario that works would be that
there can be only one plane can use alpha at a time, that it shouldn't
be the lowest one, and that it must be assigned to the second pipe.

I worked on that a bit quite some time ago, and the only thing I was
missing was a proper way to check for that in atomic_check, but with
the work done in this serie it shouldn't be too hard.

Then, we can enable the four layers, which is not really difficult in
itself.

> Perhaps this is not relevant for this patchset.

Yep, that's quite orthogonal.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171214/c2d79103/attachment.sig>
