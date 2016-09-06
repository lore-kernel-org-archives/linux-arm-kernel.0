From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2016 16:50:02 +0200
Subject: [PATCH 2/4] ARM: common/locomo: remove NO_IRQ check
In-Reply-To: <20160906142144.GX1041@n2100.armlinux.org.uk>
References: <20160906135637.2622666-1-arnd@arndb.de>
 <20160906135637.2622666-2-arnd@arndb.de>
 <20160906142144.GX1041@n2100.armlinux.org.uk>
Message-ID: <4485846.n2NSoAbukL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 6, 2016 3:21:44 PM CEST Russell King - ARM Linux wrote:
> On Tue, Sep 06, 2016 at 03:53:28PM +0200, Arnd Bergmann wrote:
> > Since commit 489447380a29 ("[PATCH] handle errors returned by
> > platform_get_irq*()") ten years ago, the locomo driver refuses to
> > work without an interrupt line passed in its resources, so the
> > check for NO_IRQ is unnecessary.
> 
> This description is inaccurate and misleading (it looks like it was
> cut'n'pasted from patch 1.)
> 
> platform_get_irq() has nothing to do with your change, as your change
> is more about the irq_base value passed through platform data, and
> not through IRQ resources.

It was copied, but this part refers to this hunk

        irq = platform_get_irq(dev, 0);
        if (irq < 0)
                return -ENXIO;

from locomo_probe that was changed in the same patch as
the on in sa1111.c

> > We still check the irq_base argument for NO_IRQ, but as both

where the irq_base comes in.

I'll try to reword this to make it clearer.

> > @@ -387,7 +389,7 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
> >  
> >  	lchip->phys = mem->start;
> >  	lchip->irq = irq;
> > -	lchip->irq_base = (pdata) ? pdata->irq_base : NO_IRQ;
> > +	lchip->irq_base = pdata->irq_base;
> 
> This removes a NULL pointer check.  Before this change, a NULL pdata
> would be accepted and would lead to the interrupts not being setup.
> After this change, it results in a NULL pointer deference.
> 
> Thankfully, both collie and poodle supply platform data, and are the
> only providers of the locomo device.

Right, that is what I tried to say above. With the check I've added
in __locomo_probe, it would actually get the NULL pointer dereference
earlier than this line. I'll add back that check earlier in the function
and return an error in that case.

	Arnd
