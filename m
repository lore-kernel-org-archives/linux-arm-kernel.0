From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Nov 2016 21:38:12 +0100
Subject: [PATCH] drm/sun4i: Fix error handling
In-Reply-To: <1d4a8fc9-6b62-4af7-19bc-565b15cdc413@wanadoo.fr>
References: <20161030084926.15303-1-christophe.jaillet@wanadoo.fr>
 <c15282b4-e88a-06b1-527d-96aedce8b7eb@wanadoo.fr>
 <20161102181444.hfrh6fcr2a5oe5n4@lukather>
 <1d4a8fc9-6b62-4af7-19bc-565b15cdc413@wanadoo.fr>
Message-ID: <20161108203812.rclbve6wwoupaf4v@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut,

On Sat, Nov 05, 2016 at 07:15:45AM +0100, Christophe JAILLET wrote:
> Le 02/11/2016 ? 19:14, Maxime Ripard a ?crit :
> > Hi,
> > 
> > On Sun, Oct 30, 2016 at 12:53:02PM +0100, Christophe JAILLET wrote:
> > > BTW, memory allocation in 'sun4i_layers_init()' looks spurious, especially
> > > the use of 'layer' in the for loop.
> > > Just my 2 cents.
> > What do you mean by it's spurious?
> Hi Maxime,
> 
> what I mean is:
> 
> > struct sun4i_layer **sun4i_layers_init(struct drm_device *drm)
> > {
> >     struct sun4i_drv *drv = drm->dev_private;
> >     struct sun4i_layer **layers;
> >     int i;
> >
> >     layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes),
> >                   sizeof(**layers), GFP_KERNEL);
> Here, we allocate some memory for ARRAY_SIZE(sun4i_backend_planes) (i.e. 2)
> 'struct sun4i_layer'.
> We do not allocate some space for some pointers but for some structure.
> 
> Also, these structures are zeroed and seem to never be initialized by
> anything else.
> 
> >     if (!layers)
> >         return ERR_PTR(-ENOMEM);
> >
> >     /*
> >      * The hardware is a bit unusual here.
> >      *
> >      * Even though it supports 4 layers, it does the composition
> >      * in two separate steps.
> >      *
> >      * The first one is assigning a layer to one of its two
> >      * pipes. If more that 1 layer is assigned to the same pipe,
> >      * and if pixels overlaps, the pipe will take the pixel from
> >      * the layer with the highest priority.
> >      *
> >      * The second step is the actual alpha blending, that takes
> >      * the two pipes as input, and uses the eventual alpha
> >      * component to do the transparency between the two.
> >      *
> >      * This two steps scenario makes us unable to guarantee a
> >      * robust alpha blending between the 4 layers in all
> >      * situations. So we just expose two layers, one per pipe. On
> >      * SoCs that support it, sprites could fill the need for more
> >      * layers.
> >      */
> The comment make me think that this driver (and this function) only handles
> 2 layers ("So we just expose two layers"), which is consistent with
> ARRAY_SIZE(sun4i_backend_planes) (i.e. 2)
> So I would expect that only 2 'struct sun4i_layer' to be allcoated
> 
> >     for (i = 0; i < ARRAY_SIZE(sun4i_backend_planes); i++) {
> >         const struct sun4i_plane_desc *plane = &sun4i_backend_planes[i];
> >         struct sun4i_layer *layer = layers[i];
> Here, we take the address of one of the 2 structure allocated above.
> This is overridden, just the line after.
> 
> >
> >         layer = sun4i_layer_init_one(drm, plane);
> 'sun4i_layer_init_one()' looks() like:
> 
>     struct sun4i_layer *layer;
>     layer = devm_kzalloc(drm->dev, sizeof(*layer), GFP_KERNEL);
>     ...
>     return layer;
> 
> So we once more allocate some 'struct sun4i_layer'
> 
> BUT, the corresponding address is stored into the 'layer' variable, and
> finally seems to get lost and no reference is kept of this. (i.e. 'layers'
> (with an s) is left unchanged)
> 
> >         if (IS_ERR(layer)) {
> >             dev_err(drm->dev, "Couldn't initialize %s plane\n",
> >                 i ? "overlay" : "primary");
> >             return ERR_CAST(layer);
> >         };
> >
> >         DRM_DEBUG_DRIVER("Assigning %s plane to pipe %d\n",
> >                  i ? "overlay" : "primary", plane->pipe);
> >         regmap_update_bits(drv->backend->regs,
> SUN4I_BACKEND_ATTCTL_REG0(i),
> >                    SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL_MASK,
> > SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(plane->pipe));
> >
> >         layer->id = i;
> >     };
> >
> >     return layers;
> > }
> 
> 
> So, 4 'struct sun4i_layer' have been allocated. 2 in 'sun4i_layers_init()'
> and 2 in 'sun4i_layer_init_one()' (once at a time, but called twice)
> 
> What looks spurious to me is either:
>    - 'struct sun4i_layer *layer = layers[i];' which should just be 'struct
> sun4i_layer *layer;'
> or
>    - 'layers' (with an s) should be an array of pointers and the addresses
> returned by 'sun4i_layer_init_one()' should be saved there.
> 
> 
> I don't know at all this driver, so I'm maybe completely wrong.
> What I would have expected would be something like: (un-tested, just to give
> an idea)
> 
> 
> ==============8<================================================
> 
> @@ -133,9 +133,9 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device
> *drm)
>      struct sun4i_layer **layers;
>      int i;
> 
>      layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes),
> -                  sizeof(**layers), GFP_KERNEL);
> +                  sizeof(*layers), GFP_KERNEL);
>      if (!layers)
>          return ERR_PTR(-ENOMEM);
> 
>      /*
> @@ -160,16 +160,17 @@ struct sun4i_layer **sun4i_layers_init(struct
> drm_device *drm)
>       * layers.
>       */
>      for (i = 0; i < ARRAY_SIZE(sun4i_backend_planes); i++) {
>          const struct sun4i_plane_desc *plane = &sun4i_backend_planes[i];
> -        struct sun4i_layer *layer = layers[i];
> +        struct sun4i_layer *layer;
> 
>          layer = sun4i_layer_init_one(drm, plane);
>          if (IS_ERR(layer)) {
>              dev_err(drm->dev, "Couldn't initialize %s plane\n",
>                  i ? "overlay" : "primary");
>              return ERR_CAST(layer);
>          };
> +        layers[i] = layer;
> 
>          DRM_DEBUG_DRIVER("Assigning %s plane to pipe %d\n",
>                   i ? "overlay" : "primary", plane->pipe);
>          regmap_update_bits(drv->backend->regs,
> SUN4I_BACKEND_ATTCTL_REG0(i),

You're totally right. Can you send this as a formal patch?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/2ed78f33/attachment.sig>
