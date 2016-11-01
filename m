From: atull@opensource.altera.com (atull)
Date: Tue, 1 Nov 2016 14:29:18 -0500
Subject: [RFC] fpga: Pull checks for supported operations into
 framework
In-Reply-To: <CAAtXAHeXZi1EM=Z7TNcO-Og+5-QGb5QR=KjGRUG0fAOfksaB8A@mail.gmail.com>
References: <1477851123-17686-1-git-send-email-moritz.fischer@ettus.com>
 <CAAtXAHeXZi1EM=Z7TNcO-Og+5-QGb5QR=KjGRUG0fAOfksaB8A@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1611011422150.3201@atull-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Oct 2016, Moritz Fischer wrote:

> Found a couple of issues, will resubmit after cleaning up. Feel free to add
> general feedback on the idea anyways in the meantime. Sorry for double post.

Hi Moritz,

This looks good and useful to me.  One comment below.

> 
> On Sun, Oct 30, 2016 at 11:12 AM, Moritz Fischer
> <moritz.fischer@ettus.com> wrote:
> > Most of the drivers only support a subset of {PARTIAL, FULL}
> > reconfiguration.
> > Pull duplicate checks in each driver into the framework.
> >
> > Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> > Cc: Alan Tull <atull@opensource.altera.com>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> > Cc: linux-kernel at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > ---
> > Hi all,
> >
> > with the new drivers (ice40, altera-ps-spi) being submitted I've noticed
> > we're duplicating this check over and over again,
> > so I figured we might as well pull it into the framework.
> >
> > I'm not sure if there are gonna be other 'flags' we need to support
> > in the short term (we talked about byte-swapping ...)
> >
> > Note: This patch goes on top of greg's char-misc-testing  that already
> > contains Alan's latest changes to support the A10 and won't apply
> > to master.
> >
> > Cheers,
> >
> > Moritz
> >
> > ---
> >  drivers/fpga/fpga-mgr.c       | 12 ++++++++++++
> >  drivers/fpga/socfpga-a10.c    |  4 +++-
> >  drivers/fpga/socfpga.c        |  3 ++-
> >  drivers/fpga/zynq-fpga.c      |  3 ++-
> >  include/linux/fpga/fpga-mgr.h |  9 +++++++--
> >  5 files changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index c58b4c4..85f17d8 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -49,6 +49,11 @@ int fpga_mgr_buf_load(struct fpga_manager *mgr, struct fpga_image_info *info,
> >         struct device *dev = &mgr->dev;
> >         int ret;
> >
> > +       if (!(mgr->supported_flags & info->flags)) {
> > +               dev_err(dev, "Unsupported flags passed\n");
> > +               return -ENOTSUPP;
> > +       }
> 
> That condition is obviously garbage ...
> > +
> >         /*
> >          * Call the low level driver's write_init function.  This will do the
> >          * device-specific things to get the FPGA into the state where it is
> > @@ -252,6 +257,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_put);
> >   */
> >  int fpga_mgr_register(struct device *dev, const char *name,
> >                       const struct fpga_manager_ops *mops,
> > +                     u32 supported_flags,
> >                       void *priv)
> >  {
> >         struct fpga_manager *mgr;
> > @@ -268,6 +274,11 @@ int fpga_mgr_register(struct device *dev, const char *name,
> >                 return -EINVAL;
> >         }
> >
> > +       if (!supported_flags) {
> > +               dev_err(dev, "Attempt to register with no supported flags\n");
> > +               return -EINVAL;
> > +       }
> > +
> >         mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> >         if (!mgr)
> >                 return -ENOMEM;
> > @@ -282,6 +293,7 @@ int fpga_mgr_register(struct device *dev, const char *name,
> >
> >         mgr->name = name;
> >         mgr->mops = mops;
> > +       mgr->supported_flags = supported_flags;
> >         mgr->priv = priv;
> >
> >         /*
> > diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> > index ccd9fb2..e7c82ff 100644
> > --- a/drivers/fpga/socfpga-a10.c
> > +++ b/drivers/fpga/socfpga-a10.c
> > @@ -519,7 +519,9 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
> >         }
> >
> >         return fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
> > -                                &socfpga_a10_fpga_mgr_ops, priv);
> > +                                &socfpga_a10_fpga_mgr_ops,
> > +                                FPGA_MGR_PARTIAL_RECONFIG,
> > +                                priv);
> >  }
> >
> >  static int socfpga_a10_fpga_remove(struct platform_device *pdev)
> > diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> > index b6672e6..3285b7d 100644
> > --- a/drivers/fpga/socfpga.c
> > +++ b/drivers/fpga/socfpga.c
> > @@ -582,7 +582,8 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
> >                 return ret;
> >
> >         return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> > -                                &socfpga_fpga_ops, priv);
> > +                                &socfpga_fpga_ops, FPGA_MGR_FULL_RECONFIG,
> > +                                priv);
> >  }
> >
> >  static int socfpga_fpga_remove(struct platform_device *pdev)
> > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> > index 249682e..1dabd25 100644
> > --- a/drivers/fpga/zynq-fpga.c
> > +++ b/drivers/fpga/zynq-fpga.c
> > @@ -413,6 +413,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
> >         struct zynq_fpga_priv *priv;
> >         struct resource *res;
> >         int err;
> > +       u32 flags = FPGA_MGR_FULL_RECONFIG | FPGA_MGR_PARTIAL_RECONFIG;
> >
> >         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >         if (!priv)
> > @@ -465,7 +466,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
> >         clk_disable(priv->clk);
> >
> >         err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
> > -                               &zynq_fpga_ops, priv);
> > +                               &zynq_fpga_ops, flags, priv);
> >         if (err) {
> >                 dev_err(dev, "unable to register FPGA manager");
> >                 clk_unprepare(priv->clk);
> > diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> > index 040b86d..4f4bcf2 100644
> > --- a/include/linux/fpga/fpga-mgr.h
> > +++ b/include/linux/fpga/fpga-mgr.h
> > @@ -64,9 +64,12 @@ enum fpga_mgr_states {
> >
> >  /*
> >   * FPGA Manager flags
> > + * FPGA_MGR_FULL_RECONFIG: do full reconfiguration if supported
> >   * FPGA_MGR_PARTIAL_RECONFIG: do partial reconfiguration if supported
> >   */
> > -#define FPGA_MGR_PARTIAL_RECONFIG      BIT(0)
> > +#define FPGA_MGR_FULL_RECONFIG         BIT(0)
> > +#define FPGA_MGR_PARTIAL_RECONFIG      BIT(1)
> > +#define FPGA_MGR_EXTERNAL_CONFIG       BIT(2)
> 
> On second thought the FULL_RECONFIG is the same as !PARTIAL_RECONFIG,
> so useless ..

That looks good and doesn't seem useless to me.  A driver may
support PR, FR, or both.  It's nice and clear what
FPGA_MGR_PARTIAL_RECONFIG|FPGA_MGR_FULL_RECONFIG means when
a driver supports both.

> 
> >
> >  /**
> >   * struct fpga_image_info - information specific to a FPGA image
> > @@ -119,6 +122,7 @@ struct fpga_manager {
> >         enum fpga_mgr_states state;
> >         const struct fpga_manager_ops *mops;
> >         void *priv;
> > +       u32 supported_flags;
> >  };
> >
> >  #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
> > @@ -135,7 +139,8 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
> >  void fpga_mgr_put(struct fpga_manager *mgr);
> >
> >  int fpga_mgr_register(struct device *dev, const char *name,
> > -                     const struct fpga_manager_ops *mops, void *priv);
> > +                     const struct fpga_manager_ops *mops, u32 supported_flags,
> > +                     void *priv);
> >
> >  void fpga_mgr_unregister(struct device *dev);
> >
> > --
> > 2.4.11
> >
> 
> Cheers,
> 
> Moritz
> 
