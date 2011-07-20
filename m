From: simon@sequanux.org (Simon Guinot)
Date: Wed, 20 Jul 2011 23:45:37 +0000
Subject: plat-orion gpio regression for mixed level and edge sensitive IRQs
In-Reply-To: <4E25DBC5.9010308@drewtech.com>
References: <4E25DBC5.9010308@drewtech.com>
Message-ID: <20110720234537.GD16297@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joey,

On Tue, Jul 19, 2011 at 03:32:21PM -0400, Joey Oravec wrote:
> Orion maintainers,
> 
> I've found a problem on plat-orion when requesting IRQs on GPIO
> lines in the linux-3.0rc. This was introduced with the change to
> generic IRQ chip.
> 
> Processors in this family have separate mask registers for level and
> edge sensitive interrupts, but generic IRQ chip functions like
> irq_gc_mask_set_bit() are designed for chips with a single mask
> register. Test with the following sequence:
> 
> 1. Register a level sensitive interrupt on pinA
> 2. Register an edge sensitive interrupt on pinB
> 
> During #2, the mask_cache (with pinA unmasked) gets written to the
> edge sensitive mask register. At the end of this call pinA is
> unmasked for edge sensitive interrupts. Now you can get into a state
> where an edge interrupt is asserted for pinA, but that edge
> interrupt never gets ack'ed since pinA is registered to handle level
> IRQs.
> 
> The older version of arch/arm/plat-orion/gpio.c does not have the
> problem because it treats the registers separately and doesn't use a
> cache. I've only tested this on MV78200 but any processor that uses
> plat-orion with separate registers will experience this problem.

The same mask cache (stored within struct irq_chip_generic) is shared
between all the irq_chip_type instances. As they can use different mask
registers, there is a problem.

We should probably move mask_cache into struct irq_chip_type.

Note that this issue only affect the Orion SoCs. On the other platform
using the generic interrupt chip API, a single irq_chip_type is defined.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110720/e4ea6982/attachment.sig>
