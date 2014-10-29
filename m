From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 29 Oct 2014 21:51:03 +0100
Subject: [PATCH 1/2] ARM: socfpga: Add driver for the L3 interconnect
In-Reply-To: <alpine.DEB.2.02.1410291521290.29374@atx-linux-37>
References: <1414582436-12772-1-git-send-email-s.trumtrar@pengutronix.de>
 <alpine.DEB.2.02.1410291521290.29374@atx-linux-37>
Message-ID: <20141029205103.GF10262@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Oct 29, 2014 at 03:30:10PM -0500, atull wrote:
> On Wed, 29 Oct 2014, Steffen Trumtrar wrote:
> 
> > The L3 interconnect provides Global Programmer View (GPV) registers for every
> > AXI master and slave on the SoC.
> > Although this is just a bunch of bits, syscon is not the right approach for
> > this IP core.
> > The L3 interconnect is configured with a lot of reserved "holes" in its memory
> > space. Just mapping this with regmap, what syscon would do, would lead to the
> > system completely hanging, if one of those areas would be touched.
> > One example for when this might happen is the regmap registers dump in the
> > debugfs.
> > 
> > This driver specifies also the valid readable and writable ranges of the L3
> > interconnect. Other drivers that want to access their GPV registers can do
> > so with this driver via socfpga_l3nic_regmap_by_phandle.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  .../bindings/soc/socfpga/altr,l3-nic.txt           |  15 ++
> >  drivers/soc/Kconfig                                |   1 +
> >  drivers/soc/Makefile                               |   1 +
> >  drivers/soc/socfpga/Kconfig                        |  11 +
> >  drivers/soc/socfpga/Makefile                       |   1 +
> >  drivers/soc/socfpga/l3nic.c                        | 221 +++++++++++++++++++++
> >  include/soc/socfpga/gpv.h                          |  63 ++++++
> >  include/soc/socfpga/l3regs.h                       | 194 ++++++++++++++++++
> >  8 files changed, 507 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,l3-nic.txt
> >  create mode 100644 drivers/soc/socfpga/Kconfig
> >  create mode 100644 drivers/soc/socfpga/Makefile
> >  create mode 100644 drivers/soc/socfpga/l3nic.c
> >  create mode 100644 include/soc/socfpga/gpv.h
> >  create mode 100644 include/soc/socfpga/l3regs.h
> > 
> 
> Hi Steffen,
> 
> This looks really nice and useful.
> 
> I tried it out with my bridge driver and at least with my superficial
> testing it looked good.
> 

\o/

Thanks for testing.

> > +
> > +int socfpga_l3nic_regmap_by_phandle(struct device_node *np,
> > +				    struct regmap **regmap,
> > +				    const char *name)
> > +{
> 
> This could return the regmap or ERR_PTR(-ENODEV) and just
> have the np and name parameter, similar to 
> syscon_regmap_lookup_by_phandle.
>

I wanted to do that, but I also want to propagate the return
value of socfpga_gpv_device_by_phandle and this doesn't
seem to work than. Open for suggestions, though.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
