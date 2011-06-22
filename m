From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jun 2011 14:34:27 +0200
Subject: [PATCH] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <BANLkTinuY286Lae7sHn0qLrDbEx6dMqn0A@mail.gmail.com>
References: <1308556402-10955-1-git-send-email-bs14@csr.com>
	<201106211753.59376.arnd@arndb.de>
	<BANLkTinuY286Lae7sHn0qLrDbEx6dMqn0A@mail.gmail.com>
Message-ID: <201106221434.27286.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2011, Barry Song wrote:
> >
> > The "compatible" properties should really be more specific than this. You can
> > list multiple alternatives in there, but please always have one that identifies
> > the exact version of each of the macros uniquely.
> 
> i guess you mean compatible =  "sirf,uart", "sirf,prima2-uart",
> "sirf,altas6-uart" ?

It depends on how specific prima2 and atlas6 really are. Are these specific
pieces of silicon, or are they each a family of similar chips? Is one a superset
of the other?

If your device tree describes a board with a prima2 SoC on it, and all prima2
chips are identical, then ("sirf,uart", "sirf,prima2-uart") is fine. If
prima2 is itself a family of chips, you should add a third entry like
"sirf,prima2-1234-uart" where 1234 is the model number of that chip.

My understanding is that prima2 and atlas6 are two separate chips, so you
should not list them both in one device tree.

If your hardware design team has an official nomenclature for different
versions of the uart macro, you can also add that. E.g. if prima1 and atlas5
use version 3.1 of the uart, while prima2 and atlas6 use version 3.2, you
can list that version too. A driver can then match on the uart version
and doesn't have to know about the soc it's used in. This depends on how
your hardware design team works.

Also, if you buy hardware macros from other companies, it's useful to
list those in the compatible property as well, to let the same driver
automatically work across SoCs from multiple vendors that have licensed
the same core, like you do for the ARM l2 cache controller.

> > Do you have any PCI or PCMCIA devices?
> 
> we do have an internal PCI bridge. but it seems it is completely
> transparent to users and softwares just like we have no PCI bridge at
> all.
> anyway, i need the final confirmation from IC guys.

I don't completely understand. If you have actual PCI devices with a
proper configuration space in the system, I would strongly suggest that
you export the PCI host bridge instead of the individual devices and
let the PCI probing code take care of that.

Using hardware probing mechanisms is normally preferred, because it
means you don't have to list every device in the device tree.

> Most platforms without PCI define io.h by giving a simple comment
> "We don't actually have real ISA nor PCI buses, but there is so many
> drivers out there that might just work if we fake them...".

It's on my list to look into.

> >> --- /dev/null
> >> +++ b/arch/arm/mach-prima2/include/mach/map.h
> >> +
> >> +#define SIRFSOC_VA(x)                        (VMALLOC_END + ((x) & 0x00FFF000))
> >> +
> >> +/* INTR */
> >> +#define SIRFSOC_INTR_PA_BASE         0x80020000
> >> +#define SIRFSOC_INTR_VA_BASE         SIRFSOC_VA(0x002000)
> >> +#define SIRFSOC_INTR_SIZE            SZ_4K
> >> +
> >> +/* L2 CACHE */
> >> +#define SIRFSOC_L2CC_PA_BASE         0x80040000
> >> +#define SIRFSOC_L2CC_VA_BASE         SIRFSOC_VA(0x004000)
> >> +#define SIRFSOC_L2CC_SIZE            SZ_4K
> >> +
> >> +/* CLOCK */
> >> +#define SIRFSOC_CLOCK_PA_BASE                0x88000000
> >> +#define SIRFSOC_CLOCK_VA_BASE                SIRFSOC_VA(0x005000)
> >> +#define SIRFSOC_CLOCK_SIZE           SZ_4K
> >> +
> >> +/* RESET CONTROLLER */
> >> +#define SIRFSOC_RSTC_PA_BASE         0x88010000
> >> +#define SIRFSOC_RSTC_VA_BASE         SIRFSOC_VA(0x006000)
> >> +#define SIRFSOC_RSTC_SIZE            SZ_4K
> >> +
> >> +/* OS TIMER */
> >> +#define SIRFSOC_TIMER_PA_BASE                0xb0020000
> >> +#define SIRFSOC_TIMER_VA_BASE                SIRFSOC_VA(0x00c000)
> >> +#define SIRFSOC_TIMER_SIZE           SZ_4K
> >> +
> >> +/* UART-1: used as serial debug port */
> >> +#define SIRFSOC_UART1_PA_BASE                0xb0060000
> >> +#define SIRFSOC_UART1_VA_BASE                SIRFSOC_VA(0x060000)
> >> +#define SIRFSOC_UART1_SIZE           SZ_4K
> >> +
> >> +/* RAM BASE*/
> >> +#define SIRFSOC_SDRAM_PA             0x00000000
> >> +
> >> +#endif
> >
> > I think these should all be converted into device tree properties if
> > possible. Anything that can be initialized late enough should just
> > do an ioremap at the time when you first need to access the registers.
> 
> i totally agree with your opinion. but i guess
> SIRFSOC_UART1_PA_BASE/SIRFSOC_UART1_VA_BASE is necessary here since
> they are mapped very early for DEBUG_LL.

Please make that code optional and dependent on CONFIG_DEBUG_LL then.

I would also recommend splitting out all code related to DEBUG_LL
into one separate patch so we can look at the base code independent
of that.

I believe we already have a problem with DEBUG_LL as soon as we get
to multi-platform kernels. 

> Another issue is that .init_early(fot this case, it is
> sirfsoc_init_clk)  is called earlier than kernel mm init and later
> than .map_io(for this case, it is sirfsoc_map_io),  the early static
> mapping makes .init_early can access mapped virtual memory too.

But does sirfsoc_init_clk have to be called from init_early, or can
you do it a bit later?

> >> +/*
> >> + * Restrict DMA-able region to workaround silicon limitation.
> >> + * The limitation restricts buffers available for DMA to SD/MMC
> >> + * hardware to be below 256MB
> >> + */
> >> +#define ARM_DMA_ZONE_SIZE    (SZ_256M)
> >> +
> >
> > This is very unfortunate, but I guess there is no real way to avoid
> > doing this, right?
> 
> a hardware issue limits DMA address must be less than 256MB for SD
> controller. to make sure SD controller get DMA buffer below 256MB, we
> need that DMA zone.
> But guess the size of the zone doesn't matter at all, it even can be
> 1MB, 2MB or any value less than 256MB. Anyway, we only need a DMA
> buffer for SD.
> if we reserve an area for SD DMA buffer, it seems ugly too?

Probably yes, it would also make the I/O slower because then you have
to alway do bounce-buffering, while now you only have to do it when
the user buffer is above 256 MB.

You should definitely make sure that the SD device has the correct
dma_mask set, which is required for correctness, while the right
ARM_DMA_ZONE_SIZE is more a question of performance. When we get to
multi-platform kernels, we can then just set the minimum of the
configured platforms.

	Arnd
