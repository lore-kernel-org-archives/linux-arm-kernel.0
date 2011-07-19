From: joravec@drewtech.com (Joey Oravec)
Date: Tue, 19 Jul 2011 15:32:21 -0400
Subject: plat-orion gpio regression for mixed level and edge sensitive IRQs
Message-ID: <4E25DBC5.9010308@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orion maintainers,

I've found a problem on plat-orion when requesting IRQs on GPIO lines in 
the linux-3.0rc. This was introduced with the change to generic IRQ chip.

Processors in this family have separate mask registers for level and 
edge sensitive interrupts, but generic IRQ chip functions like 
irq_gc_mask_set_bit() are designed for chips with a single mask 
register. Test with the following sequence:

1. Register a level sensitive interrupt on pinA
2. Register an edge sensitive interrupt on pinB

During #2, the mask_cache (with pinA unmasked) gets written to the edge 
sensitive mask register. At the end of this call pinA is unmasked for 
edge sensitive interrupts. Now you can get into a state where an edge 
interrupt is asserted for pinA, but that edge interrupt never gets 
ack'ed since pinA is registered to handle level IRQs.

The older version of arch/arm/plat-orion/gpio.c does not have the 
problem because it treats the registers separately and doesn't use a 
cache. I've only tested this on MV78200 but any processor that uses 
plat-orion with separate registers will experience this problem.

-joey
