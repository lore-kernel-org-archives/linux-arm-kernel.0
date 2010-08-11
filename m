From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Aug 2010 15:27:28 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <80r5i5z3v1.fsf@merkur.tec.linutronix.de>
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
	<801va635f7.fsf@merkur.tec.linutronix.de>
	<20100811125625.GS27749@pengutronix.de>
	<80r5i5z3v1.fsf@merkur.tec.linutronix.de>
Message-ID: <20100811132728.GV27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 03:16:34PM +0200, John Ogness wrote:
> On 2010-08-11, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> Your version allows a small window between request_irq() and
> >> irq_control() where on the i.MX21 there is a possibility of the
> >> interrupts being disabled twice. Namely, if an interrupt occurs
> >> before irq_control() has had a chance to disable it. IMHO it would be
> >> better to call:
> >> 
> >>     set_irq_flags(host->irq, IRQF_VALID | IRQF_NOAUTOEN);
> >> 
> >> for the i.MX21 before requesting the irq. This closes the window.
> >
> > IIRC it is not allowed to call set_irq_flags before request_irq. We
> > are changing a resource we do not own yet.
> 
> Normally, yes. But the only way the IRQF_NOAUTOEN flag can ever be
> useful is if set_irq_flags() is called before request_irq().
> 
> > I think the worst thing that could happen without this change is that
> > we get an interrupt after request_irq.
> 
> Yes. And this causes a problem on the i.MX21 because the interrupt
> handler will disable the interrupts. The irq_control() after
> request_irq() will _also_ disable the interrupts. This means the
> interrupts are disabled twice, which causes some issues on an RT kernel.
> 
> > Alternatively we could set the interrupt mask bit before requesting
> > the irq.
> 
> Yes. This would be best. But for the i.MX21 it is important that the
> interrupts are unmasked after irq_control() has disabled the interrupts.

Ok, I'll update the patches to use this approach.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
