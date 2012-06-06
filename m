From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 6 Jun 2012 19:05:39 +0800
Subject: [PATCH v4] usb: ehci-hcd: notify phy when connect change
In-Reply-To: <87mx4g93tg.fsf@ashishki-desk.ger.corp.intel.com>
References: <1337912665-16615-4-git-send-email-richard.zhao@freescale.com>
 <1338946190-19105-1-git-send-email-richard.zhao@freescale.com>
 <87mx4g93tg.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120606110539.GA5566@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 12:39:55PM +0300, Alexander Shishkin wrote:
> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> > It still has below limitations:
> > - it does not work for multi-phy ehci
> > - the best place is after debounce, but I can't get
> >   phy there
> >
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  drivers/usb/host/ehci-hcd.c |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> > index b100f5f..724ac471 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -928,6 +928,21 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
> >  			pstatus = ehci_readl(ehci,
> >  					 &ehci->regs->port_status[i]);
> >  
> > +			/* FIXME:
> > +			 * - it does not work for multi-phy ehci
> > +			 * - the best place is after debounce, but I can't get
> > +			 *   phy there
> > +			 */
> > +			if (unlikely(ehci->transceiver &&
> > +					(pstatus & PORT_CSC))) {
> 
> I don't think you need parens around (pstatus & PORT_CSC), since it
> should already have higher precedence.
But it's more readable. Isn't it?

Thanks
Richard
