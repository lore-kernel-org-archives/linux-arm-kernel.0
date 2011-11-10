From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 Nov 2011 02:02:14 -0700 (MST)
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ming Lei,

just a few quick comments for now -

On Wed, 9 Nov 2011, Ming Lei wrote:

> On Tue, Nov 8, 2011 at 11:26 PM, Paul Walmsley <paul@pwsan.com> wrote:
> 
> >> +static struct omap_hwmod_irq_info omap44xx_emu_irqs[] = {
> >> + ? ? { .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
> >> + ? ? { .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
> >> + ? ? { .irq = -1 }
> >> +};
> >
> > Are you sure these are part of the emulation IP? ?We already have those
> 
> I am not sure, I just figure out one way to make omap4 pmu work. Since there
> are few descriptions in TRM about it, it is a hacking based on [1], :-)
> 
> > IRQs in the MPU hwmod, see omap44xx_mpu_irqs[] in the same file.
> 
> I just see it, but looks like the "mpu" hwmod isn't populated as omap_device,
> so the CTI irqs aren't requested now.

Okay.  Maybe you can probably add some code in mach-omap2/devices.c to 
build an omap_device for this for right now?  I am not 100% sure whether 
those cti0/1 interrupts should be associated with the MPU or with the 
DEBUGSS but Beno?t might be able to answer this.

> Also, current arm perf code don't handle three IRQs(one pl310 irq and 
> two CTI irq) inside one device correctly.

To fix this, that ARM perf code should either be using 
platform_get_irq_byname(), or the hwmod hardware data will need to be 
rearranged to meet the arbitrary ordering requirement.  I'd suggest 
pinging Will on this issue to see what he wants to do.

> So any suggestion about CTI IRQs connecting to which hwmod, so that they can
> be found by pmu driver?
> 
> >> +/*emu hwmod*/
> >> +static struct omap_hwmod omap44xx_emu_hwmod = {
> >> + ? ? .name ? ? ? ? ? = "emu",
> >> + ? ? .class ? ? ? ? ?= &omap44xx_emu_hwmod_class,
> >> + ? ? .clkdm_name ? ? = "emu_sys_clkdm",
> >> + ? ? .prcm = {
> >> + ? ? ? ? ? ? .omap4 = {
> >> + ? ? ? ? ? ? ? ? ? ? .clkctrl_offs = OMAP4_CM_EMU_CLKSTCTRL_OFFSET,
> >
> > This doesn't look right either: EMU is a clockdomain, not an IP block.
> 
> I defined the 'emu' hwmod to control the clock state transition of the EMU
> clock domain by writing to CLKTRCTRL.CM_EMU_CLKSTCTRL with standard
> hwmod interface(_enable / _idle). Is there any other neat way to do it?

So the clockdomain is already defined in 
mach-omap2/clockdomains44xx_data.c and there's code to control it - see 
for example clkdm_enable_idle().  But this code should not be called 
directly by any device driver code or driver integration code.  The thing 
to do here is to ask Beno?t to release the hwmod data for the DEBUGSS 
hwmod, then someone will need to write an MFD driver for that which 
exposes the PMU address space to the PMU platform driver.

But also proper dependency support in hwmod enable/idle operations will be 
needed to enable the instrumentation and emulation interconnects when the 
DEBUGSS is enabled.  This has been on my plate for a few months, it's good 
to have another reason to prioritize it.  


- Paul
