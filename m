From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Dec 2013 10:34:30 -0600
Subject: [PATCH v3 11/15] mfd: menelaus: Start to use irqdomain
In-Reply-To: <20131210092050.GT12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-11-git-send-email-balbi@ti.com>
 <20131210092050.GT12675@lee--X1>
Message-ID: <20131210163430.GG22750@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 09:20:50AM +0000, Lee Jones wrote:
> > Introduce an irq_chip and irq_domain for menelaus driver. Following
> > patches will convert uses to traditional request_threaded_irq().
> > 
> > While at that, some better error handling had to be added, so we could
> > free irq descs we allocated.
> > 
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/menelaus.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++---
> 
> <snip>
> 
> > +	irq_domain_add_legacy(node, MENELAUS_NR_IRQS, irq_base, 0,
> > +			&irq_domain_simple_ops, m);
> 
> When will this driver become DT compliant?

when OMAP2 becomes DT-compliant. It still boots with legacy board-file +
platform_data.

> > +	m->irq_base = irq_base;
> > +
> > +	for (i = irq_base; i < irq_base + MENELAUS_NR_IRQS; i++) {
> > +		irq_set_chip_data(i, m);
> > +		irq_set_chip_and_handler(i, &menelaus_irq_chip,
> > +				handle_simple_irq);
> > +		irq_set_nested_thread(i, 1);
> > +		set_irq_flags(i, IRQF_VALID);
> 
> This assumes that this h/w only exists on ARM platforms. Is that true?

it was made *only* for Nokia to use on their ARM-only internet tablets.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/7980652b/attachment.sig>
