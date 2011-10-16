From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 16 Oct 2011 22:59:18 +0200
Subject: [PATCH 2/9] ARM: SPMP8000: Add machine base files
In-Reply-To: <CAGVye5PjCZRgdmP+VCXifw_MnW1rAN41BPWfJvk9CAuXBt4ggw@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<201110111644.56505.arnd@arndb.de>
	<CAGVye5PjCZRgdmP+VCXifw_MnW1rAN41BPWfJvk9CAuXBt4ggw@mail.gmail.com>
Message-ID: <201110162259.19960.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 16 October 2011, Zoltan Devai wrote:
> 2011/10/11 Arnd Bergmann <arnd@arndb.de>:
> > On Sunday 09 October 2011, Zoltan Devai wrote:
> >> +
> >> +/* Static mappings:
> >> + * SCU: timer needs clk support which is inited in init_early
> >> + * UART: needed for earlyprintk
> >> + */
> >> +static struct map_desc io_desc[] __initdata = {
> >> +     {
> >> +             .virtual        = IO_ADDRESS(SPMP8000_SCU_A_BASE),
> >> +             .pfn            = __phys_to_pfn(SPMP8000_SCU_A_BASE),
> >> +             .length         = SPMP8000_SCU_A_SIZE,
> >> +             .type           = MT_DEVICE,
> >> +     }, {
> >> +             .virtual        = IO_ADDRESS(SPMP8000_SCU_B_BASE),
> >> +             .pfn            = __phys_to_pfn(SPMP8000_SCU_B_BASE),
> >> +             .length         = SPMP8000_SCU_B_SIZE,
> >> +             .type           = MT_DEVICE,
> >> +     }, {
> >> +             .virtual        = IO_ADDRESS(SPMP8000_SCU_C_BASE),
> >> +             .pfn            = __phys_to_pfn(SPMP8000_SCU_C_BASE),
> >> +             .length         = SPMP8000_SCU_C_SIZE,
> >> +             .type           = MT_DEVICE,
> >> +     },
> >
> > With Nicolas Pitre's rework of the MMIO space handling, I think it
> > would be nice to just use a single area that spans all of the devices
> > so you can do an optimized ioremap and huge TLBs. Unfortunately
> > that series won't make it into 3.2, but if you just set up a large
> > area now, it will automatically work.
> What do you mean by 'all of the devices' ?
> These three, or all MMIO peripherals ?
> These are at addresses 0x90005000, 0x92005000 and 0x93007000.
> So either a 50 or 256 MB area, but both seem like a waste of
> virtual memory space.

I was thinking of mapping everything that your IO_ADDRESS macro covers,
which should be something like 240 MB starting at 0x90000000/0xf0000000.
On most ARM9 platforms, virtual memory is not really contraint at all
because there is not all that much physical memory. Also, you currently
reserve the entire 0xf0000000 segment for MMIO ranges, so I would
expect that you can keep doing that after the cleanup.

> >> +#ifdef CONFIG_DEBUG_LL
> >> +     {
> >> +             .virtual        = IO_ADDRESS(SPMP8000_UARTC0_BASE),
> >> +             .pfn            = __phys_to_pfn(SPMP8000_UARTC0_BASE),
> >> +             .length         = SPMP8000_UARTC0_SIZE,
> >> +             .type           = MT_DEVICE,
> >> +     },
> >> +#endif
> >> +};
> >>
> > And it would be nice to move this into a separate file that handles the
> > early debug code, as prima2 does.
> Prima2 doesn't have other static mappings. In my case, that would
> mean a separate map_desc table in lluart.c and an
> #ifdef CONFIG_DEBUG_LL in the map_io call.
> Is it worth it ?

Yes, it's worth it. Don't do the #ifdef in the map_io call though, do
it in the header file that declares the function prototype.

> BTW, the static mappings are only needed to be able to set up the
> clk stuff in init_early. That in turn is only needed for the timer code to
> determinate its input clock.
> If I would hard-code the timer clock rate in its driver (the bootloader is
> very unlikely to change), then I could init the clk driver from
> machine_init and get rid of these mappings.
> How about that ?

Maybe you can just pass the clock rate in the device tree then. If the boot
loader changes it, it can still pass the correct rate and you don't
need the early mappings for functional reasons any more.

> BTW2,
> shouldn't the timer driver also go to drivers/clocksource ?

Yes, good point. Please move it there.

> >> +#ifndef __MACH_SPMP8000_REGS_TIMER_H__
> >> +#define __MACH_SPMP8000_REGS_TIMER_H__
> >> +
> >> +#define SPMP8000_TMRB(tnum)  (tnum * 0x20)
> >> +#define SPMP8000_TMRB_CTR    0x00
> >> +#define SPMP8000_TMRB_CTR_TE BIT(0)
> >> +#define SPMP8000_TMRB_CTR_IE BIT(1)
> >> +#define SPMP8000_TMRB_CTR_OE BIT(2)
> >> +#define SPMP8000_TMRB_CTR_PWMON      BIT(3)
> >> +#define SPMP8000_TMRB_CTR_UD BIT(4)
> >> +#define SPMP8000_TMRB_CTR_UDS        BIT(5)
> >> +#define SPMP8000_TMRB_CTR_OM BIT(6)
> >> +#define SPMP8000_TMRB_CTR_ES_SH      8
> >> +#define SPMP8000_TMRB_CTR_M_SH       10
> >> +#define SPMP8000_TMRB_PSR    0x04
> >> +#define SPMP8000_TMRB_LDR    0x08
> >> +#define SPMP8000_TMRB_VLR    0x08
> >> +#define SPMP8000_TMRB_ISR    0x0C
> >> +#define SPMP8000_TMRB_CMP    0x10
> >> +
> >> +#endif /* __MACH_SPMP8000_REGS_TIMER_H__ */
> >
> > No need for this header, just move the definitions into the timer driver.
> It's also used by the pwm driver (pwm is just a timer with a HW output pin)
> as the header indicates. Not a lots of lines, so I can include it in both
> if you think that's more appropriate.

Normally you need to have proper locking around register accesses when 
a piece of hardware is used by two drivers. My feeling is that the
abstraction should be on a higher level because of this, either exporting
functions from the timer driver that are used by the pwm driver, or
having one low-level mfd driver exporting simple functions that are used by
both of them.

> > The BIT() definition is really just mean for kernel-internal bitops,
> > not so much for device registers.
> >
> > My recommended style of this is
> >
> > #define APLL_CFG_P              0x00000001
> > #define APLL_CFG_S              0x00000002
> > #define APLL_CFG_F              0x00000004
> > #define APLL_CFG_E              0x00000008
> Are you sure about this ?
> I recall reading a recommendation to use BIT() as its less
> error-prone, easier matched with the datasheet and properly typed.
> Also:
> kernel$ grep -R " BIT(" drivers/ | wc -l
> 2186

Fair enough. My preference is still the other way (maybe with an added 'ul'
for type safety), but that may be mostly because I got bitten too much by
IBM hardware specifications numbering the bits in the opposite way.
Just decide for yourself here.

	Arnd
