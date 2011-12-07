From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 19:15:39 +0800
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: preserve
 MII/RMII setting in fec_stop()
In-Reply-To: <20191.17573.87285.411253@ipc1.ka-ro>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <d6f4de9e4cfb393754b42815a2ef1a59c96eab83.1323163127.git.LW@KARO-electronics.de>
 <20111207094146.GG5550@S2100-06.ap.freescale.net>
 <20191.17172.493079.722098@ipc1.ka-ro>
 <20111207105816.GH5550@S2100-06.ap.freescale.net>
 <20191.17573.87285.411253@ipc1.ka-ro>
Message-ID: <20111207111538.GJ5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 11:49:09AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > On Wed, Dec 07, 2011 at 11:42:28AM +0100, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > Shawn Guo writes:
> > > > On Tue, Dec 06, 2011 at 11:27:14AM +0100, Lothar Wa?mann wrote:
> > > > > Additionally to setting the ETHER_EN bit in FEC_ECNTRL the MII/RMII
> > > > > setting in FEC_R_CNTRL needs to be preserved to keep the MII interface
> > > > 
> > > > s/MII/RMII?  From what I see from imx28 and imx6q RM, the reset state
> > > > for this setting is MII mode.
> > > > 
> > > > > functional.
> > > > > 
> > > > > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > > > > ---
> > > > >  drivers/net/ethernet/freescale/fec.c |    5 ++++-
> > > > >  1 files changed, 4 insertions(+), 1 deletions(-)
> > > > 
> > > > I assume this is fixing a problem you are seeing on imx28 only.
> > > > Do you see the problem on imx53/51?
> > > > 
> > > No. i.MX53 uses the RMII gasket which is not affected by resetting the
> > > controller. And imMX51 does not support RMII at all.
> > > 
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> > > > > index 11534b9..ab0afb5 100644
> > > > > --- a/drivers/net/ethernet/freescale/fec.c
> > > > > +++ b/drivers/net/ethernet/freescale/fec.c
> > > > > @@ -515,6 +515,7 @@ fec_stop(struct net_device *ndev)
> > > > >  	struct fec_enet_private *fep = netdev_priv(ndev);
> > > > >  	const struct platform_device_id *id_entry =
> > > > >  				platform_get_device_id(fep->pdev);
> > > > > +	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
> > > > 
> > > > This bit is only available on ENET (imx28 and imx6q).  Do we want to
> > > > do the same thing for FEC (imx25/27/35/51/53)?
> > > > 
> > > No. AFAICT that's not necessary there.
> > > 
> > So you need to check it's actually running on ENET before accessing
> > the bit.
> > 
> That's done in the place where the register is being written:
> |	if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
> |		writel(2, fep->hwp + FEC_ECNTRL);
> |		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
> |	}
> 
> We could save one register read by doing the check also for the read,
> but that would further complicate the code.
> 
Ok.  Will have a test and then get back to you.

-- 
Regards,
Shawn
