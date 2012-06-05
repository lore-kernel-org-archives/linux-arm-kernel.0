From: marex@denx.de (Marek Vasut)
Date: Tue, 5 Jun 2012 17:03:17 +0200
Subject: [PATCH v3 03/12] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <Pine.LNX.4.44L0.1206051025540.1542-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1206051025540.1542-100000@iolanthe.rowland.org>
Message-ID: <201206051703.17691.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alan Stern,

> On Tue, 5 Jun 2012, Alexander Shishkin wrote:
> > Richard Zhao <richard.zhao@freescale.com> writes:
> > > It still has below limitations:
> > > - it does not work for multi-phy ehci
> > > - the best place is after debounce, but I can't get
> > > 
> > >   phy there
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > 
> > Alan, are you ok with this?
> > 
> > > ---
> > > 
> > >  drivers/usb/host/ehci-hcd.c |   14 ++++++++++++++
> > >  1 files changed, 14 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> > > index b100f5f..8c39a7a 100644
> > > --- a/drivers/usb/host/ehci-hcd.c
> > > +++ b/drivers/usb/host/ehci-hcd.c
> > > @@ -928,6 +928,20 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
> > > 
> > >  			pstatus = ehci_readl(ehci,
> > >  			
> > >  					 &ehci->regs->port_status[i]);
> > > 
> > > +			/* FIXME:
> > > +			 * - it does not work for multi-phy ehci
> > > +			 * - the best place is after debounce, but I can't get
> > > +			 *   phy there
> > > +			 */
> > > +			if ((pstatus & PORT_CSC) && ehci->transceiver) {
> 
> Do the tests in the opposite order and add "unlikely":
> 
> 			if (unlikely(ehci->transceiver &&
> 					(pstatus & PORT_CSC)) {
> 
> That way it will fail more quickly on systems where it doesn't apply or
> for unaffected ports.

Does this unlikely() have any effect on ARM/MIPS/PPC, where this chipidea IP is 
used ? Or is there some x86 device sporting this IP too?

> > > +				if (pstatus & PORT_CONNECT)
> > > +					usb_phy_notify_connect(
> > > +						ehci->transceiver, i);
> > > +				else
> > > +					usb_phy_notify_disconnect(
> > > +						ehci->transceiver, i);
> > > +			}
> > > +
> > > 
> > >  			if (pstatus & PORT_OWNER)
> > >  			
> > >  				continue;
> > >  			
> > >  			if (!(test_bit(i, &ehci->suspended_ports) &&
> 
> Otherwise it's okay.
> 
> Alan Stern

Best regards,
Marek Vasut
