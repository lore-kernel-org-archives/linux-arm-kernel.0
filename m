From: josh.cartwright@ni.com (Josh Cartwright)
Date: Tue, 23 Oct 2012 11:26:41 -0500
Subject: [PATCH v2 2/4] zynq: move static peripheral mappings
In-Reply-To: <201210231450.11540.arnd@arndb.de>
References: <20121022211219.GC31538@beefymiracle.amer.corp.natinst.com>
 <201210231450.11540.arnd@arndb.de>
Message-ID: <20121023162641.GG20593@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Arnd-

Thanks for the review/suggestions.

On Tue, Oct 23, 2012 at 02:50:11PM +0000, Arnd Bergmann wrote:
> On Monday 22 October 2012, Josh Cartwright wrote:
> > Shifting them up into the vmalloc region prevents the following warning,
> > when booting a zynq qemu target with more than 512mb of RAM:
> > 
> >   BUG: mapping for 0xe0000000 at 0xe0000000 out of vmalloc space
> > 
> > In addition, it allows for reuse of these mappings when the proper
> > drivers issue requests via ioremap().
> > 
> > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> 
> This looks like a bug fix that should be backported to older kernels,
> so it would be good to add 'Cc: stable at vger.kernel.org' below your
> Signed-off-by.

Will-do, thanks.

> > diff --git a/arch/arm/mach-zynq/include/mach/zynq_soc.h b/arch/arm/mach-zynq/include/mach/zynq_soc.h
> > index d0d3f8f..ae3b236 100644
> > --- a/arch/arm/mach-zynq/include/mach/zynq_soc.h
> > +++ b/arch/arm/mach-zynq/include/mach/zynq_soc.h
> > @@ -15,33 +15,37 @@
> >  #ifndef __MACH_XILINX_SOC_H__
> >  #define __MACH_XILINX_SOC_H__
> >  
> > +#include <asm/pgtable.h>
> > +
> >  #define PERIPHERAL_CLOCK_RATE		2500000
> >  
> > -/* For now, all mappings are flat (physical = virtual)
> > +/* Static peripheral mappings are mapped at the top of the
> > + * vmalloc region
> >   */
> > -#define UART0_PHYS			0xE0000000
> > -#define UART0_VIRT			UART0_PHYS
> > +#define UART0_PHYS		0xE0000000
> > +#define UART0_SIZE		SZ_4K
> > +#define UART0_VIRT		(VMALLOC_END - UART0_SIZE)
> 
> There are plans to move the uart location into a fixed virtual
> address in the future, but it hasn't been decided yet.
> It will still need a fixed mapping though, just to a different
> address.
> 
> > -#define TTC0_PHYS			0xF8001000
> > -#define TTC0_VIRT			TTC0_PHYS
> > +#define TTC0_PHYS		0xF8001000
> > +#define TTC0_SIZE		SZ_4K
> > +#define TTC0_VIRT		(UART0_VIRT - TTC0_SIZE)
> 
> It's quite likely that this does not have to be a fixed mapping
> any more. Just have a look at how drivers/clocksource/dw_apb_timer_of.c
> calls of_iomap() to get the address.

Yes, this is already on my list of plans.  The in-tree TTC driver
unfortunately doesn't yet support device tree bindings.  Are you
comfortable waiting on the DT-ification of the TTC in a follow-up
patchset?

> > -#define PL310_L2CC_PHYS			0xF8F02000
> > -#define PL310_L2CC_VIRT			PL310_L2CC_PHYS
> > +#define PL310_L2CC_PHYS		0xF8F02000
> > +#define PL310_L2CC_SIZE		SZ_4K
> > +#define PL310_L2CC_VIRT		(TTC0_VIRT - PL310_L2CC_SIZE)
> 
> This address would not need a fixed mapping by calling l2x0_of_init
> rather than l2x0_init.

Great, I'll take care of this.

> > -#define SCU_PERIPH_PHYS			0xF8F00000
> > -#define SCU_PERIPH_VIRT			SCU_PERIPH_PHYS
> > +#define SCU_PERIPH_PHYS		0xF8F00000
> > +#define SCU_PERIPH_SIZE		SZ_8K
> > +#define SCU_PERIPH_VIRT		(PL310_L2CC_VIRT - SCU_PERIPH_SIZE)
> 
> And your patch 3 already obsoletes this mapping.

I'll spin up a reordered patchset to eliminate this odd state.

Thanks again,

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/95ceb569/attachment.sig>
