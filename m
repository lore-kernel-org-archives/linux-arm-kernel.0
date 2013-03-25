From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 25 Mar 2013 15:39:00 +0100
Subject: [PATCH 2/3] ARM: zynq: get slcr base earlier 
In-Reply-To: <CAHTX3dJDTvs4UXoTa_8u4M83fQ9N2n96ecZzFjaXLsXkp_vWjg@mail.gmail.com>
References: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
 <1364043450-18700-3-git-send-email-s.trumtrar@pengutronix.de>
 <CAHTX3dJDTvs4UXoTa_8u4M83fQ9N2n96ecZzFjaXLsXkp_vWjg@mail.gmail.com>
Message-ID: <20130325143900.GC27739@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 03:04:36PM +0100, Michal Simek wrote:
> 2013/3/23 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> > The slcr is needed for pinctrl, clocks and reset. Therefore we want it as early
> > as possible. As there is no driver that handles it and instead a pointer needs
> > to be passed around, rename the variable to something a little more obvious.
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  arch/arm/mach-zynq/common.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> > index 014131c..1b9bb3d 100644
> > --- a/arch/arm/mach-zynq/common.c
> > +++ b/arch/arm/mach-zynq/common.c
> > @@ -38,6 +38,7 @@
> >
> >  #include "common.h"
> >
> > +void __iomem *slcr_base_addr;
> >  void __iomem *scu_base;
> >
> >  static struct of_device_id zynq_of_bus_ids[] __initdata = {
> > @@ -61,19 +62,21 @@ static void __init xilinx_init_machine(void)
> >
> >  static void __init xilinx_zynq_timer_init(void)
> >  {
> > -       struct device_node *np;
> > -       void __iomem *slcr;
> > -
> > -       np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
> > -       slcr = of_iomap(np, 0);
> > -       WARN_ON(!slcr);
> > -
> > -       xilinx_zynq_clocks_init(slcr);
> > +       xilinx_zynq_clocks_init(slcr_base_addr);
> >
> >         twd_local_timer_of_register();
> >         xttcps_timer_init();
> >  }
> >
> > +static void zynq_slcr_init(void)
> > +{
> > +       struct device_node *np;
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
> > +       slcr_base_addr = of_iomap(np, 0);
> > +       WARN_ON(!slcr_base_addr);
> > +}
> 
> Xilinx is using separate driver for slcr and IMHO make sense to have it
> like that because this IP can handle more things which will be just messy
> to have it in one file.
> What do you think?
> 

Definitely. I think we should have a main slcr driver for locking/unlocking
etc. and the clock/reset/mio-drivers should be "clients" of this.
Then for example the clockdriver would request a write to a register.
The slcr can then unlock and make the write.
But maybe this is overengineering. I haven't found time to look at the
xilinx driver. And I'm actually not sure why I would want to lock the
slcr. But as Xilinx opted for this feature, it should be handeled correctly.
At the moment I was trying to make do with what is there.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
