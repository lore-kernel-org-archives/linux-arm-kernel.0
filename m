From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 3 Mar 2014 17:01:02 -0700
Subject: [PATCH 0/7] PCI irq mapping fixes and cleanups
In-Reply-To: <CAJ+vNU2ojt_o9=AOGfpbx6NCOE_kE6tsV8FvjoGYk9BBwP_OFQ@mail.gmail.com>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2VN5haOU2GN5o7UUg9vgYh06pAhvDaoGw6EzTBEbD0mg@mail.gmail.com>
 <20140301183059.GA6315@obsidianresearch.com>
 <000601cf36b8$330b3a90$9921afb0$%han@samsung.com>
 <CAJ+vNU3UL+LTWnoxW7scAig19=z2xoYCA-HZ6a7GUyGEXtKK9Q@mail.gmail.com>
 <CAJ+vNU2ojt_o9=AOGfpbx6NCOE_kE6tsV8FvjoGYk9BBwP_OFQ@mail.gmail.com>
Message-ID: <20140304000102.GC5603@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 03:40:43PM -0800, Tim Harvey wrote:

> of_irq_parse_and_map_pci().  The GIC function that translates the
> interrupt per domain is given irq_data: 0x123 0x04 0x00 

This has been shifted by 1 byte..

> IRQ 123, which should get 32 added to it for irq155).  Instead, the
> implementation of gic_irq_domain_xlate()
> (http://lxr.missinglinkelectronics.com/linux/drivers/irqchip/irq-gic.c#L832)
> adds 32 to the 0x04 returning 20:
> [    1.841781] of_irq_parse_raw:  /soc/pcie at 0x01000000:00000001
> [    1.841813] of_irq_parse_raw: ipar=/soc/pcie at 0x01000000, size=1
> [    1.841838]  -> addrsize=3
> [    1.841870]  -> match=1 (imaplen=28)
                              ^^^^^^^^^^^^^

That looks odd, it should be the number of dwords in the
interrupt-map, you have 4 lines of 8 dwords each, so it should be
32. 

You have 7*4, which really suggests to me that your interrupt-map
is corrupted somehow, are you sure you are using this:

>       interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>                       <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
>                       <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
>                       <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;

If an element was missing it would explain why everything is broken,
in fact if GIC_SPI was missing it would match the debug perfectly.

> [    1.841903]  -> newintsize=3, newaddrsize=1
> [    1.841916]  -> imaplen=23
> [    1.841928]  -> new parent: /interrupt-controller at 00a01000
> [    1.841946]  -> got it !

K..

> [    1.841972] irq_create_of_mapping: calling xlate for 123/4/0 3

And it is the wrong data.. 123/4/0 is 


> For the slots above that swizzle to pin2,3,4 of_irq_parse_raw()
> returns -EINVAL because for some reason it can't match an interrupt
> mapping for the pcie host controller:
> [    1.842996] of_irq_parse_raw:  /soc/pcie at 0x01000000/pcie at 0,0:00000002
> [    1.843046] of_irq_parse_raw: ipar=/soc/pcie at 0x01000000, size=1
> [    1.843070]  -> addrsize=3
> [    1.843100]  -> match=0 (imaplen=28)
> ^^^^^ indicates no match in interrupt map.

Well, since we know the map is corrupted somehow, it isn't surprising
that the 2nd entry won't match anything. It is probably matching
against '0 0 2 &intc'
 
Jason
