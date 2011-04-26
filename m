From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 06:11:57 +0200
Subject: [PATCH 07/14] at91: switch gpio to early platfrom device
In-Reply-To: <4DB5FB09.8020501@bluewatersys.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-7-git-send-email-plagnioj@jcrosoft.com>
	<4DB5FB09.8020501@bluewatersys.com>
Message-ID: <20110426041157.GB12904@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:51 Tue 26 Apr     , Ryan Mallon wrote:
> On 04/26/2011 06:31 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> > ---
> > need patch
> > clkdev: add support to lookup for early platform device
> 
> <snip>
> 
> > diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
> > new file mode 100644
> > index 0000000..4d39f9b
> > --- /dev/null
> > +++ b/arch/arm/mach-at91/devices.h
> > @@ -0,0 +1,55 @@
> > +/*
> > + * arch/arm/mach-at91/devices.h
> > + *
> > + * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > + *
> > + * Under GPLv2
> > + *
> > + */
> > +
> > +#ifndef _AT91_DEVICES_H
> > +#define _AT91_DEVICES_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define RES_MEM(size)				\
> > +	{					\
> > +		.end	= size - 1,		\
> > +		.flags	= IORESOURCE_MEM,	\
> > +	}
> > +
> > +#define RES_IRQ()				\
> > +	{					\
> > +		.flags	= IORESOURCE_IRQ,	\
> > +	}
> > +
> > +
> > +static inline void set_resource_mem(struct resource *res, resource_size_t mmio_base)
> > +{
> > +	BUG_ON(res->flags != IORESOURCE_MEM);
> > +	res->start = mmio_base;
> > +	res->end  += mmio_base;
> > +}
> > +
> > +static inline void set_resource_irq(struct resource *res, int irq)
> > +{
> > +	if (!irq)
> > +		return;
> > +
> > +	BUG_ON(res->flags != IORESOURCE_IRQ);
> > +	res->start = irq;
> > +	res->end   = irq;
> > +}
> > +
> > +struct at91_dev_resource {
> > +	resource_size_t	mmio_base;
> > +	int		irq;
> > +};
> > +
> > +struct at91_dev_resource_array {
> > +	struct at91_dev_resource *resource;
> > +	int num_resources;
> > +};
> 
> We will have to consolidate here since this conflicts with my patch set.
> Our approaches are pretty similar though, so hopefully it's not too big
> a deal. How do you want to manage the merging of our patches? Do you
> want to take my stuff via your tree and handle the merge there or do you
> want be to try rebasing my patches on top of a branch of your git tree?
I've start to rebase your patchset as this one will allw to simpliify it
as we known on which we are on

until the udc

Let me 1 or 2 days to push it
It did test it on some atmel ref board and fix it

Best Regards,
J.
> 
> ~Ryan
> 
> -- 
> Bluewater Systems Ltd - ARM Technology Solution Centre
> 
> Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
> ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
> http://www.bluewatersys.com	New Zealand
> Phone: +64 3 3779127		Freecall: Australia 1800 148 751
> Fax:   +64 3 3779135			  USA 1800 261 2934
