From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2009 17:18:12 +0100
Subject: [PATCH 8/9 v2] MXC: Add a digital audio multiplexer driver
In-Reply-To: <eedb5540911300815u5cf60634jd58918f454269028@mail.gmail.com>
References: <1258022525-21078-8-git-send-email-s.hauer@pengutronix.de>
	<1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
	<20091112150615.GA30179@pengutronix.de>
	<eedb5540911300356p2b41eeaakee050953ad39ec26@mail.gmail.com>
	<20091130121017.GN27548@pengutronix.de>
	<eedb5540911300425n374af9f0k5346d85fdb79eb11@mail.gmail.com>
	<20091130123412.GP27548@pengutronix.de>
	<eedb5540911300509t11cc783cr8e97eda66ee382a@mail.gmail.com>
	<20091130160356.GT27548@pengutronix.de>
	<eedb5540911300815u5cf60634jd58918f454269028@mail.gmail.com>
Message-ID: <20091130161812.GU27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 05:15:45PM +0100, javier Martin wrote:
> 2009/11/30 Sascha Hauer <s.hauer@pengutronix.de>
> 
> > On Mon, Nov 30, 2009 at 02:09:16PM +0100, javier Martin wrote:
> > > From fa87b65915e78ad29a8e4f3f22b26ed0fa6dc7f5 Mon Sep 17 00:00:00 2001
> > >
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Date: Mon, 30 Nov 2009 13:31:29 +0100
> > > > Subject: [PATCH] i.MX27 audmux: Fix register offsets
> > > >
> > > > The PPCR registers start at 0x10, not 0xc. Fix this.
> > > >
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  arch/arm/plat-mxc/include/mach/audmux.h |    6 +++---
> > > >  1 files changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm/plat-mxc/include/mach/audmux.h
> > > > b/arch/arm/plat-mxc/include/mach/audmux.h
> > > > index 5cd6466..dcc12d4 100644
> > > > --- a/arch/arm/plat-mxc/include/mach/audmux.h
> > > > +++ b/arch/arm/plat-mxc/include/mach/audmux.h
> > > > @@ -4,9 +4,9 @@
> > > >  #define MX27_AUDMUX_HPCR1_SSI0         0
> > > >  #define MX27_AUDMUX_HPCR2_SSI1         1
> > > >  #define MX27_AUDMUX_HPCR3_SSI_PINS_4   2
> > > > -#define MX27_AUDMUX_PPCR1_SSI_PINS_1   3
> > > > -#define MX27_AUDMUX_PPCR2_SSI_PINS_2   4
> > > > -#define MX27_AUDMUX_PPCR3_SSI_PINS_3   5
> > > > +#define MX27_AUDMUX_PPCR1_SSI_PINS_1   4
> > > > +#define MX27_AUDMUX_PPCR2_SSI_PINS_2   5
> > > > +#define MX27_AUDMUX_PPCR3_SSI_PINS_3   6
> > > >
> > >
> > > Be careful,
> > > I think this patch breaks some of the boards currently using
> > > MXC_AUDMUX_V1_PCR_RXDSEL(x) and similar macros defined in mach/audmux.h
> > (for
> > > example pcm038).
> > > For those macros the old AUDMUX register indexes are fine.
> > >
> > > I suggest fixing this inside audmux_v1.c instead of modifying
> > mach/audmux.h.
> >
> > Ok. The AUDMUX V1 is used on i.MX21 and i.MX27 and both have this hole
> > in the register space, so fixing it in the driver should be safe.
> >
> > How about this one then?
> >
> > Sascha
> >
> >
> > From 297b5c4cea40c2e7023bbdb96a0c90c13b0e02a1 Mon Sep 17 00:00:00 2001
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Date: Mon, 30 Nov 2009 13:31:29 +0100
> > Subject: [PATCH] i.MX27 audmux: Fix register offsets
> >
> > The PPCR registers start at 0x10, not 0xc. Fix this.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/plat-mxc/audmux-v1.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c
> > index 70ab5af..8fbce7b 100644
> > --- a/arch/arm/plat-mxc/audmux-v1.c
> > +++ b/arch/arm/plat-mxc/audmux-v1.c
> > @@ -37,6 +37,10 @@ int mxc_audmux_v1_configure_port(unsigned int port,
> > unsigned int pcr)
> >                return -ENOSYS;
> >        }
> >
> > +       /* handle hole in the register space */
> > +       if (port > 2)
> > +               port++;
> > +
> >         writel(pcr, audmux_base + MXC_AUDMUX_V1_PCR(port));
> >
> >        return 0;
> > --
> > 1.6.5.2
> >
> 
> Sascha,
> there are actually two holes, with this current patch, PPCR3 still receives
> a wrong value:
> 
> 0x1001_6000 (HPCR1)
> 0x1001_6004 (HPCR2)
> 0x1001_6008 (HPCR3)
> 0x1001_600C (hole)
> 0x1001_6010 (PPCR1)
> 0x1001_6014 (PPCR2)
> 0x1001_6018 (hole)
> 0x1001_601C (PPCR3)

Grumpf. I'm not creating a new patch before getting some sleep.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
