From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 17 Jul 2012 15:32:37 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <201207171307.23514.arnd@arndb.de>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <6125783.OUR7TQ8gMf@flexo> <201207171307.23514.arnd@arndb.de>
Message-ID: <2808767.4NLQARgpQ0@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012 13:07:23 Arnd Bergmann wrote:
> On Tuesday 17 July 2012, Florian Fainelli wrote:
> > On Monday 16 July 2012 15:54:04 Arnd Bergmann wrote:
> > > On Sunday 15 July 2012, Florian Fainelli wrote:
> > > 
> > > > diff --git a/arch/arm/mach-mcs814x/Kconfig b/arch/arm/mach-
mcs814x/Kconfig
> > > > new file mode 100644
> > > > index 0000000..c89422f
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-mcs814x/Kconfig
> > > > @@ -0,0 +1,11 @@
> > > > +if ARCH_MCS814X
> > > > +
> > > > +config MCS8140
> > > > +	select CPU_ARM926T
> > > > +	bool
> > > > +
> > > > +menu "Moschip MCS8140 boards"
> > > > +
> > > > +endmenu
> > > > +
> > > > +endif
> > > 
> > > What values does the Kconfig file actually provide? I see that you are
> > > adding the boards here later, but I think it would be nice to just 
> > > make the new platform a single Kconfig option with no individual
> > > board selection.
> > 
> > I plan on adding support for MCS8142 later on, thus I thought it would be 
nice 
> > to be able to selectively compile board support for MCS8140 or some later 
> > chip.
> 
> But is there much difference between the two? How much code would
> actually get built for one chip but not the other? If all the
> differences can be run-time detected from the device tree, I
> think it's better to not have different compile-time options at
> all.

The big difference between the two is actually the CPU core, for MCS8140 they 
used a genuine ARM926EJS and for MCS8142 they actually use a FA526 core.

> 
> > > Platforms are now converting to the common clock framework in 
drivers/clk.
> > > Mike Turquette as the subsystem maintainer can probably judge better 
whether
> > > we should still be allowing new platforms with their own implementation
> > > of clk, but my feeling is that you should use the subsystem instead
> > > and add a driver in a subdirectory of drivers/clk instead of in the
> > > platform.
> > > 
> > > > +void __iomem *mcs814x_sysdbg_base;
> > > 
> > > Does this have to be globally visible? I would recommend making it 
static.
> > 
> > Yes, since it is used both by clock.c and common.c
> 
> Ok. How about converting this to an global function in common.c that is
> called from clk_local_onoff_enable instead?

Sounds good.

> 
> > > > +void __init mcs814x_map_io(void)
> > > > +{
> > > > +	iotable_init(mcs814x_io_desc, ARRAY_SIZE(mcs814x_io_desc));
> > > > +
> > > > +	mcs814x_sysdbg_base = ioremap(MCS814X_IO_START + MCS814X_SYSDBG,
> > > > +					MCS814X_SYSDBG_SIZE);
> > > > +	if (!mcs814x_sysdbg_base)
> > > > +		panic("unable to remap sysdbg base");
> > > > +}
> > > > +
> > > > +void mcs814x_restart(char mode, const char *cmd)
> > > > +{
> > > > +	__raw_writel(~(1 << 31), mcs814x_sysdbg_base);
> > > > +}
> > > 
> > > You should generally avoid using __raw_readl etc. and instead use
> > > readl/write or readl_relaxed/writel_relaxed.
> > 
> > Allright, even on an ARM926-EJS-based system?
> 
> Yes, there is no practical difference in the way they are defined at
> the moment, but the __raw_ versions are still wrong, you should
> really never be using them from driver code.
> 
> > > > diff --git a/arch/arm/mach-mcs814x/include/mach/cpu.h b/arch/arm/mach-
> > mcs814x/include/mach/cpu.h
> > > > new file mode 100644
> > > > index 0000000..1ef3c4a
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-mcs814x/include/mach/cpu.h
> > > > @@ -0,0 +1,16 @@
> > > > +#ifndef __ASM_ARCH_CPU_H__
> > > > +#define __ASM_ARCH_CPU_H__
> > > > +
> > > > +#include <asm/cputype.h>
> > > > +
> > > > +#define MCS8140_ID	0x41069260	/* ARM926EJ-S */
> > > > +#define MCS814X_MASK	0xff0ffff0
> > > > +
> > > > +#ifdef CONFIG_MCS8140
> > > > +/* Moschip MCS8140 is based on an ARM926EJ-S core */
> > > > +#define soc_is_mcs8140()	((read_cpuid_id() & MCS814X_MASK) == 
MCS8140_ID)
> > > > +#else
> > > > +#define soc_is_mcs8140()	(0)
> > > > +#endif /* !CONFIG_MCS8140 */
> > > > +
> > > > +#endif /* __ASM_ARCH_CPU_H__ */
> > > 
> > > Can you explain what this is used for? Are there other SoCs in the same
> > > platform that will get added later?
> > 
> > Yes, that's the plan.
> 
> Ok. But why do you need to know the soc type? If it's only for the
> uncompress.h code, it should probably stay local to that file.



> 
> > > > +/* IRQ controller register offset */
> > > > +#define MCS814X_IRQ_ICR		0x00
> > > > +#define MCS814X_IRQ_ISR		0x04
> > > > +#define MCS814X_IRQ_MASK	0x20
> > > > +#define MCS814X_IRQ_STS0	0x40
> > > 
> > > I'm pretty sure these can be in irq.c
> > 
> > Not unless I switch to MULTI_IRQ_HANDLER.
> 
> I think you should do that, too. Forgot to mention it.
> 
> > > > +
> > > > +static struct resource io_mem = {
> > > > +	.name	= "PCI I/O space",
> > > > +	.start	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_IOMISC_BASE,
> > > > +	.end	= MCS8140_PCI_HOST_BASE + MCS8140_PCI_IOMISC_BASE + SZ_64M,
> > > > +	.flags	= IORESOURCE_IO,
> > > > +};
> > > 
> > > This is wrong: MCS8140_PCI_HOST_BASE is an address in IORESOURCE_MEM 
space.
> > > You probably also mean SZ_64K instead of SZ_64M.
> > 
> > I will double check with the hardware manual, but I really think it is 
> > 64MBytes.
> 
> Are there any devices hardwired to your PCI bus that require more than a few
> bytes of I/O space? If not, I think it should be 64KB. No known add-on
> cards require more than that, and it would just waste virtual address space,
> and prevents us from using the new common PCI I/O space helpers.

Ok.

> 
> > > 
> > > Leave this one at the default of 0x1000. MCS8140_PCI_HOST_BASE is the
> > > address from the CPU's point of view, not from the bus. You just need
> > > to stay out of the range of possible legacy ISA devices.
> > > 
> > > It's probably a good idea to keep the PCI support as a separate patch
> > > for reviewing purposes.
> > 
> > Good idea, I will do that. Note that none of the boards I have actually 
have 
> > PCI, so the code is just there in case someone needs it. I could also go 
along 
> > and remove it, since I cannot test it, which explains why there are so 
many 
> > inconsistencies with it.
> 
> Fair enough. Best drop it for now then. The PCI code is currently undergoing
> some changes, and when someone wants to get this to work, they should can
> probably better start from scratch with an independent bus driver that will
> end up looking much simpler than what you have today.

Yeah, I like that :)

> 
> 	Arnd
