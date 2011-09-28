From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 28 Sep 2011 13:03:40 +0100
Subject: [PATCHv2 08/10] ARM: u300: convert to MULTI_IRQ_HANDLER
In-Reply-To: <CACRpkdYOdWA2vg2zq+nhOPSvPN7zdy9NVsOcqfZ7i9W5Sq5cpw@mail.gmail.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-9-git-send-email-jamie@jamieiles.com>
	<CACRpkdYOdWA2vg2zq+nhOPSvPN7zdy9NVsOcqfZ7i9W5Sq5cpw@mail.gmail.com>
Message-ID: <20110928120340.GH17204@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Sep 28, 2011 at 01:03:34PM +0200, Linus Walleij wrote:
> Hold your horses:
> 
> On Wed, Sep 28, 2011 at 12:41 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> 
> > diff --git a/arch/arm/mach-u300/include/mach/entry-macro.S b/arch/arm/mach-u300/include/mach/entry-macro.S
> > index 20731ae..7181d6a 100644
> > --- a/arch/arm/mach-u300/include/mach/entry-macro.S
> > +++ b/arch/arm/mach-u300/include/mach/entry-macro.S
> > @@ -8,33 +8,9 @@
> > ?* Low-level IRQ helper macros for ST-Ericsson U300
> > ?* Author: Linus Walleij <linus.walleij@stericsson.com>
> > ?*/
> > -#include <mach/hardware.h>
> > -#include <asm/hardware/vic.h>
> >
> > ? ? ? ?.macro ?disable_fiq
> > ? ? ? ?.endm
> >
> > - ? ? ? .macro ?get_irqnr_preamble, base, tmp
> > - ? ? ? .endm
> > -
> > ? ? ? ?.macro ?arch_ret_to_user, tmp1, tmp2
> > ? ? ? ?.endm
> > -
> > - ? ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> > - ? ? ? ldr ? ? \base, = U300_AHB_PER_VIRT_BASE-U300_AHB_PER_PHYS_BASE+U300_INTCON0_BASE
> > - ? ? ? ldr ? ? \irqstat, [\base, #VIC_IRQ_STATUS] @ get masked status
> > - ? ? ? mov ? ? \irqnr, #0
> > - ? ? ? teq ? ? \irqstat, #0
> > - ? ? ? bne ? ? 1002f
> > -1001: ?ldr ? ? \base, = U300_AHB_PER_VIRT_BASE-U300_AHB_PER_PHYS_BASE+U300_INTCON1_BASE
> > - ? ? ? ldr ? ? \irqstat, [\base, #VIC_IRQ_STATUS] @ get masked status
> > - ? ? ? mov ? ? \irqnr, #32
> > - ? ? ? teq ? ? \irqstat, #0
> > - ? ? ? beq ? ? 1003f
> > -1002: ?tst ? ? \irqstat, #1
> > - ? ? ? bne ? ? 1003f
> > - ? ? ? add ? ? \irqnr, \irqnr, #1
> > - ? ? ? movs ? ?\irqstat, \irqstat, lsr #1
> > - ? ? ? bne ? ? 1002b
> > -1003: ? ? ? ? ?/* EQ will be set if no irqs pending */
> > - ? ? ? .endm
> 
> When I inspect patch 2 in this series I get the feeling that it assumes that
> there is one and only one VIC bank with 32 interrupts involved. This is
> not the case in the U300, it has 64 possible IRQ sources by OR:in the
> output IRQ signal from two VIC:s and feeding the resulting IRQ line
> into the CPU.

No, it will handle more than one vic, and it will check them in the 
order the vic_init() is called.  I've tested this on picoxcell that has 
2 vic's in the same configuration as this.

> So in the code above we first check the 32 bits at the first VIC instance,
> and if that is zero we go on to check the other 32 bits.
> 
> vic_single_handle_irq() needs to be modified to handle several
> ranges or atleast two.

The platform IRQ handler is actually vic_handle_irq() that internally 
calls vic_single_handle_irq() for each registered vic (in the order of 
registration).

> Note that in mach-u300/core.c we initialize each VIC like this:
> vic_init((void __iomem *) U300_INTCON0_VBASE, 0, mask[0], mask[0]);
> vic_init((void __iomem *) U300_INTCON1_VBASE, 32, mask[1], mask[1]);
> 
> So I think the easiest may be to let vic_init() add registered VIC
> ranges to a list or array, and increas some num_vics variable
> to that  vic_single_handle_irq() can traverse both ranges in
> order.

Jamie
