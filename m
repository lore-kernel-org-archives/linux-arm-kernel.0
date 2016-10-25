From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 25 Oct 2016 08:46:45 +0200
Subject: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20161025064422.4jua6qmpr7zu3ijt@phenom.ffwll.local>
References: <cover.1477142934.git.moinejf@free.fr>
 <8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
 <20161025064422.4jua6qmpr7zu3ijt@phenom.ffwll.local>
Message-ID: <20161025064645.h3fn3wx6qxiahxjd@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 08:44:22AM +0200, Daniel Vetter wrote:
> On Fri, Oct 21, 2016 at 09:26:18AM +0200, Jean-Francois Moine wrote:
> > +static int de2_drm_bind(struct device *dev)
> > +{
> > +	struct drm_device *drm;
> > +	struct priv *priv;
> > +	int ret;
> > +
> > +	drm = drm_dev_alloc(&de2_drm_driver, dev);

Oh and you might want to look into drm_dev_init, allows you to use
subclassing instead of pointer chasing for your driver-private data.
-Daniel

> > +	if (!drm)
> > +		return -ENOMEM;
> > +
> > +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (!priv) {
> > +		dev_err(dev, "failed to allocate private area\n");
> > +		ret = -ENOMEM;
> > +		goto out1;
> > +	}
> > +
> > +	dev_set_drvdata(dev, drm);
> > +	drm->dev_private = priv;
> > +
> > +	drm_mode_config_init(drm);
> > +	drm->mode_config.min_width = 32;	/* needed for cursor */
> > +	drm->mode_config.min_height = 32;
> > +	drm->mode_config.max_width = 1920;
> > +	drm->mode_config.max_height = 1080;
> > +	drm->mode_config.funcs = &de2_mode_config_funcs;
> > +
> > +	drm->irq_enabled = true;
> > +
> > +	/* initialize the display engine */
> > +	priv->soc_type = (int) of_match_device(de2_drm_of_match, dev)->data;
> > +	ret = de2_de_init(priv, dev);
> > +	if (ret)
> > +		goto out2;
> > +
> > +	/* start the subdevices */
> > +	ret = component_bind_all(dev, drm);
> > +	if (ret < 0)
> > +		goto out2;
> > +
> > +	ret = drm_dev_register(drm, 0);
> 
> This needs to be the very last step in your driver load sequence.
> Kerneldoc explains why. Similar, but inverted for unloading:
> drm_dev_unregister is the very first thing you must call.
> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
