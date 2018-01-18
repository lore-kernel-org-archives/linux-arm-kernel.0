From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 Jan 2018 08:22:58 +0100
Subject: [PATCH v3 08/13] drm/sun4i: Add a driver for the display frontend
In-Reply-To: <CAGb2v65o-fYvP6Qf8gq=eceAG4oqq7E-r4hyxq4xe+fm0sKfqg@mail.gmail.com>
References: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
 <3b7164f4a5199f0499c6f41201b31bc471cb3af9.1515492513.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65o-fYvP6Qf8gq=eceAG4oqq7E-r4hyxq4xe+fm0sKfqg@mail.gmail.com>
Message-ID: <20180118072258.ucbchh32mhyln2qn@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 17, 2018 at 09:43:31PM +0800, Chen-Yu Tsai wrote:
> >         if (sun4i_drv_node_is_connector(node))
> >                 return 0;
> >
> > -       if (!sun4i_drv_node_is_frontend(node)) {
> > +       /*
> > +        * If the device is either just a regular device, or an
> > +        * enabled frontend supported by the driver, we add it to our
> > +        * component list.
> > +        */
> > +       if (!sun4i_drv_node_is_frontend(node) ||
> > +           (sun4i_drv_node_is_supported_frontend(node) &&
> > +            of_device_is_available(node))) {
> 
> Nit: sun4i_drv_node_is_supported_frontend should be a subset of
> sun4i_drv_node_is_frontend, so of_device_is_available should always
> be true at this point.

That's not really the condition though :)

It's if the device is *not* a frontend or if it is a supported
frontend that is available, add it to the endpoints list.

> > +       regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
> > +                    SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(1) |
> > +                    SUN4I_FRONTEND_INPUT_FMT_DATA_FMT(in_fmt_val) |
> > +                    SUN4I_FRONTEND_INPUT_FMT_PS(1));
> > +       regmap_write(frontend->regs, SUN4I_FRONTEND_OUTPUT_FMT_REG,
> > +                    SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT(out_fmt_val));
> 
> Seems that you also need to set the "ALPHA_EN" bit for ARGB.

I have not seen that bit documented anywhere. Where is it coming from?

> > +       frontend->reset = devm_reset_control_get(dev, NULL);
> > +       if (IS_ERR(frontend->reset)) {
> > +               dev_err(dev, "Couldn't get our reset line\n");
> > +               return PTR_ERR(frontend->reset);
> > +       }
> > +       reset_control_reset(frontend->reset);
> 
> reset_control_reset leaves the reset control deasserted. At this
> point the clock might not be running, which might mean the internal
> state is not completely wiped out. (Though this really depends on
> the design of the internal logic.)
> 
> Maybe just assert it? It gets deasserted in the runtime PM callback
> later. And just to be safe, I would move it close to the end of the
> probe path, past all possible errors, so the hardware doesn't get
> touched until everything is ready. Or don't touch it anywhere in
> the probe path, and have the runtime PM resume function do a reset.

That seems like the best solution yes.

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/bc349914/attachment.sig>
