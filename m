From: balbi@ti.com (Felipe Balbi)
Date: Mon, 16 Dec 2013 18:19:11 -0600
Subject: [PATCH 05/10] mfd: menelaus: Use for_each_set_bit()
In-Reply-To: <1387239455.18217.61.camel@joe-AO722>
References: <20131216153936.GQ18769@lee--X1>
 <1387238904-7843-1-git-send-email-balbi@ti.com>
 <1387238904-7843-5-git-send-email-balbi@ti.com>
 <1387239455.18217.61.camel@joe-AO722>
Message-ID: <20131217001911.GE29284@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 04:17:35PM -0800, Joe Perches wrote:
> On Mon, 2013-12-16 at 18:08 -0600, Felipe Balbi wrote:
> > That macro just helps removing some extra line of code and hides ffs()
> > calls.
> > 
> > While at that, also fix a variable shadowing bug where 'int irq' was
> > being redeclared inside inner loop while it was also argument to
> > interrupt handler.
> > 
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/menelaus.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> > index 87d80a8..d3e3022 100644
> > --- a/drivers/mfd/menelaus.c
> > +++ b/drivers/mfd/menelaus.c
> > @@ -795,24 +795,22 @@ static irqreturn_t menelaus_irq(int irq, void *_menelaus)
> >  {
> >  	struct menelaus_chip *menelaus = _menelaus;
> >  	void (*handler)(struct menelaus_chip *menelaus);
> > -	unsigned isr;
> > +	unsigned long isr;
> > +	unsigned long i;
> >  
> >  	isr = (menelaus_read_reg(MENELAUS_INT_STATUS2)
> >  			& ~menelaus->mask2) << 8;
> >  	isr |= menelaus_read_reg(MENELAUS_INT_STATUS1)
> >  		& ~menelaus->mask1;
> >  
> > -	while (isr) {
> > -		int irq = fls(isr) - 1;
> > -		isr &= ~(1 << irq);
> > -
> > +	for_each_set_bit(i, &isr, 16) {
> >  		mutex_lock(&menelaus->lock);
> > -		menelaus_disable_irq(irq);
> > -		menelaus_ack_irq(irq);
> > -		handler = menelaus->handlers[irq];
> > +		menelaus_disable_irq(i);
> > +		menelaus_ack_irq(i);
> > +		handler = menelaus->handlers[i];
> >  		if (handler)
> >  			handler(menelaus);
> > -		menelaus_enable_irq(irq);
> > +		menelaus_enable_irq(i);
> >  		mutex_unlock(&menelaus->lock);
> >  	}
> >  
> 
> This could handle the irqs in reverse order.
> Does that matter?

order does not matter with this device.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/1dc6fd72/attachment-0001.sig>
