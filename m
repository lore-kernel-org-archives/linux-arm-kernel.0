From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Aug 2010 14:56:25 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <801va635f7.fsf@merkur.tec.linutronix.de>
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
	<801va635f7.fsf@merkur.tec.linutronix.de>
Message-ID: <20100811125625.GS27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 04:31:40PM +0200, John Ogness wrote:
> On 2010-08-10, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Sorry, last time I sent only up to 09/12, so the patches I explicitely
> > mentioned to solve the things from your previous series were missing.
> > I just sent them. My versions of the patches differ slightly.
> 
> Your version allows a small window between request_irq() and
> irq_control() where on the i.MX21 there is a possibility of the
> interrupts being disabled twice. Namely, if an interrupt occurs before
> irq_control() has had a chance to disable it. IMHO it would be better to
> call:
> 
>     set_irq_flags(host->irq, IRQF_VALID | IRQF_NOAUTOEN);
> 
> for the i.MX21 before requesting the irq. This closes the window.

IIRC it is not allowed to call set_irq_flags before request_irq. We are
changing a resource we do not own yet.
I think the worst thing that could happen without this change is that we
get an interrupt after request_irq.
Alternatively we could set the interrupt mask bit before requesting the
irq.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
