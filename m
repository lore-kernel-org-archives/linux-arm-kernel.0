From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 30 Nov 2011 21:35:30 +0800
Subject: [PATCH] ARM: mxs: Select FEC driver
In-Reply-To: <20111130090641.GC26618@pengutronix.de>
References: <1322592607-22834-1-git-send-email-fabio.estevam@freescale.com>
 <20111129193304.GP17668@pengutronix.de>
 <20111130082241.GC2506@S2100-06.ap.freescale.net>
 <20111130090641.GC26618@pengutronix.de>
Message-ID: <20111130133529.GA711@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 10:06:41AM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Wed, Nov 30, 2011 at 04:22:41PM +0800, Shawn Guo wrote:
> > On Tue, Nov 29, 2011 at 08:33:04PM +0100, Uwe Kleine-K?nig wrote:
> > > On Tue, Nov 29, 2011 at 04:50:07PM -0200, Fabio Estevam wrote:
> > > > Let the FEC driver be built by default.
> > > > 
> > > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > > > ---
> > > >  arch/arm/configs/mxs_defconfig |    2 ++
> > > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
> > > > index 6ee781b..f99bcfc 100644
> > > > --- a/arch/arm/configs/mxs_defconfig
> > > > +++ b/arch/arm/configs/mxs_defconfig
> > > > @@ -59,6 +59,8 @@ CONFIG_DEVTMPFS=y
> > > >  # CONFIG_BLK_DEV is not set
> > > >  CONFIG_NETDEVICES=y
> > > >  CONFIG_NET_ETHERNET=y
> > > > +CONFIG_NET_VENDOR_FREESCALE=y
> > > > +CONFIG_FEC=y
> > > I'd prefer to add
> > > 
> > > 	default y
> > > 
> > > or maybe
> > > 
> > > 	default y if SOME_SENSIBLE_OPTION
> > > 
> > > to NET_VENDOR_FREESCALE and FEC instead. We already had that, but Shawn
> > > removed it in
> > > 
> > > 	230dec6 (net/fec: add imx6q enet support)
> > > 
> > > (by mistake if I remember an earlier thread here correctly).
> > > 
> > Here is what the commit changed.
> > 
> > diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
> > index 4dbe41f..1cf6716 100644
> > --- a/drivers/net/ethernet/freescale/Kconfig
> > +++ b/drivers/net/ethernet/freescale/Kconfig
> > @@ -7,7 +7,7 @@ config NET_VENDOR_FREESCALE
> >         default y
> >         depends on FSL_SOC || QUICC_ENGINE || CPM1 || CPM2 || PPC_MPC512x || \
> >                    M523x || M527x || M5272 || M528x || M520x || M532x || \
> > -                  IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC || \
> > +                  ARCH_MXC || ARCH_MXS || \
> >                    (PPC_MPC52xx && PPC_BESTCOMM)
> >         ---help---
> >           If you have a network (Ethernet) card belonging to this class, say Y
> > @@ -16,16 +16,15 @@ config NET_VENDOR_FREESCALE
> > 
> >           Note that the answer to this question doesn't directly affect the
> >           kernel: saying N will just cause the configurator to skip all
> > -         the questions about IBM devices. If you say Y, you will be asked for
> > -         your specific card in the following questions.
> > +         the questions about Freescale devices. If you say Y, you will be
> > +         asked for your specific card in the following questions.
> > 
> >  if NET_VENDOR_FREESCALE
> > 
> >  config FEC
> >         bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
> >         depends on (M523x || M527x || M5272 || M528x || M520x || M532x || \
> > -                   IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC)
> > -       default IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC if ARM
> > +                  ARCH_MXC || ARCH_MXS)
> >         select PHYLIB
> >         ---help---
> >           Say Y here if you want to use the built-in 10/100 Fast ethernet
> > 
> > Since for device tree support, we have neither IMX_HAVE_PLATFORM_FEC
> > nor MXS_HAVE_PLATFORM_FEC set.  It's all about change
> > 'IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC' to 'ARCH_MXC ||
> > ARCH_MXS'.  I do not see a mistake there.
> You did s/IMX_HAVE_PLATFORM_FEC/ARCH_MXC/ and
> s/MXS_HAVE_PLATFORM_FEC/ARCH_MXS/ in the dependencies of FEC (which is
> OK and intended). And you removed
> 
> 	default IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC if ARM
> 
> without a substitute. I suggest to add
> 
> 	default ARCH_MXC || ARCH_MXS if ARM
> 
> (with "if ARM" only being there to document where the ARCH_MX? symbols
> come from). NET_VENDOR_FREESCALE already has a default y, so adding that
> to the defconfigs shouldn't be necessary.
> 
Yes, you are all right.  That was a mistake :)

-- 
Regards,
Shawn
