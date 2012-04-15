From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sun, 15 Apr 2012 14:38:57 -0400
Subject: Problem with of_irq_to_resource() and IRQ flags
Message-ID: <CAKON4OwjBEsDb4=TvS_WkK-9dabHgLm0+Vgkprse9tSs6+bo8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to enable the dm9000 driver for DT support.  I've run into
a problem with the interrupt flags. The dm9000 driver is expecting to
get them passed in on the resource flags:

unsigned long irqflags = db->irq_res->flags & IRQF_TRIGGER_MASK;

But of_irq_to_resource() is not adding them:

		r->flags = IORESOURCE_IRQ;

Now if I trace into of_irq_to_resource() it calls
irq_of_parse_and_map() which calls irq_create_of_mapping() which then
calls  domain->ops->dt_translate() to get the flags.  So we have the
flags down the callstack but passing them back means adding a
parameter to a public API.

I can't see any API to ask an irq for its current flags. That would be
another way to get them and add them to the resource.

Any other options?

-- 
Jon Smirl
jonsmirl at gmail.com
