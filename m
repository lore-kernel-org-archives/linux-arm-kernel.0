From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 10 Jul 2013 16:11:49 -0300
Subject: [RFC/PATCH 2/2] ARM: kirkwood: Add basic suspend-to-RAM support
In-Reply-To: <20130710171348.GA3981@localhost>
References: <1372718849-2912-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1372718849-2912-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130710130702.GD28813@lunn.ch> <20130710171348.GA3981@localhost>
Message-ID: <20130710191147.GB3981@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Yet another resend, this time to public ML as well)

On Wed, Jul 10, 2013 at 02:13:48PM -0300, Ezequiel Garcia wrote:
> (Resending it with some more Ccs)
> 
> On Wed, Jul 10, 2013 at 03:07:02PM +0200, Andrew Lunn wrote:
> > On Mon, Jul 01, 2013 at 07:47:29PM -0300, Ezequiel Garcia wrote:
> > > Implements suspend-to-RAM support in a standby-like fashion:
> > > when the SoC enters suspend state the peripheral clocks are gated
> > > and the memory PM units are disabled.
> > > 
> > > However the network controller clock is not gated for now, since there is
> > > still some work to be done in the driver to provide proper suspend/resume
> > > operations.
> > > 
> > > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/mach-kirkwood/Makefile                   |  1 +
> > >  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
> > >  arch/arm/mach-kirkwood/pm.c                       | 83 +++++++++++++++++++++++
> > >  3 files changed, 86 insertions(+)
> > >  create mode 100644 arch/arm/mach-kirkwood/pm.c
> > > 
> > > diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> > > index e1f3735..2c56aa0 100644
> > > --- a/arch/arm/mach-kirkwood/Makefile
> > > +++ b/arch/arm/mach-kirkwood/Makefile
> > > @@ -1,4 +1,5 @@
> > >  obj-y				+= common.o irq.o pcie.o mpp.o
> > > +obj-$(CONFIG_PM)		+= pm.o
> > >  
> > >  obj-$(CONFIG_MACH_D2NET_V2)		+= d2net_v2-setup.o lacie_v2-common.o
> > >  obj-$(CONFIG_MACH_DB88F6281_BP)		+= db88f6281-bp-setup.o
> > > diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> > > index 5c82b7d..fad3a35 100644
> > > --- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> > > +++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
> > > @@ -78,4 +78,6 @@
> > >  #define CGC_TDM			(1 << 20)
> > >  #define CGC_RESERVED		(0x6 << 21)
> > >  
> > > +#define MEMORY_PM_CTRL		(BRIDGE_VIRT_BASE + 0x118)
> > > +
> > >  #endif
> > > diff --git a/arch/arm/mach-kirkwood/pm.c b/arch/arm/mach-kirkwood/pm.c
> > > new file mode 100644
> > > index 0000000..5624b66
> > > --- /dev/null
> > > +++ b/arch/arm/mach-kirkwood/pm.c
> > > @@ -0,0 +1,83 @@
> > > +/*
> > > + * Power Management driver for Marvell Kirkwood SoCs
> > > + *
> > > + * Copyright (C) 2013 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > + * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License,
> > > + * version 2 of the License.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/suspend.h>
> > > +#include <linux/io.h>
> > > +#include <mach/bridge-regs.h>
> > > +
> > > +
> > > +static void __iomem *ddr_operation_base;
> > > +
> > > +static void kirkwood_suspend_mem(void)
> > > +{
> > > +	u32 clk_ctrl, mem_pm_ctrl;
> > > +
> > > +	clk_ctrl = readl(CLOCK_GATING_CTRL);
> > > +	mem_pm_ctrl = readl(MEMORY_PM_CTRL);
> > > +
> > > +	/*
> > > +	 * Gate clocks, except for so-called 'Runit' unit, which apparently
> > > +	 * corresponds to NAND, SPI and BootROM.
> > > +	 *
> > > +	 * Also, we skip the gating of the GE0 and GE1 clocks for now.
> > > +	 *
> > > +	 * Contrary to my expectation, the SDRAM clock can also be disabled and
> > > +	 * the suspend-resume cycle will complete successfully.
> > > +	 */
> > > +	writel(CGC_GE1 | CGC_GE0 | CGC_RUNIT, CLOCK_GATING_CTRL);
> > > +
> > > +	/* Set peripherals to low-power mode */
> > > +	writel(~0, MEMORY_PM_CTRL);
> > > +
> > > +	/*
> > > +	 * Set DDR in self-refresh.
> > > +	 */
> > > +	writel(0x7, ddr_operation_base);
> > > +
> > > +	/*
> > > +	 * Set CPU in wait-for-interrupt state.
> > > +	 */
> > > +	cpu_do_idle();
> > > +
> > > +	writel(mem_pm_ctrl, MEMORY_PM_CTRL);
> > > +	writel(clk_ctrl, CLOCK_GATING_CTRL);
> > > +}
> > > +
> > > +static int kirkwood_suspend_enter(suspend_state_t state)
> > > +{
> > > +	switch (state) {
> > > +	case PM_SUSPEND_MEM:
> > > +		kirkwood_suspend_mem();
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct platform_suspend_ops kirkwood_suspend_ops = {
> > > +	.enter = kirkwood_suspend_enter,
> > > +	.valid = suspend_valid_only_mem,
> > > +};
> > > +
> > > +static int __init kirkwood_pm_init(void)
> > > +{
> > > +	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
> > 
> > Sorry for not replying earlier.
> > 
> 
> No problem. I've been testing this a lot lately, so I'll send a v2
> -more or less- soon.
> 
> FWIW, the v2 will remove *completely* the clock gating from this file,
> since I consider that to be each driver's business and don't think
> it's a good idea to mess with that.
> 
> Before I send the v2 I'd like to perform some (basic) power measurements
> to test the effect of this.
> 
> > Have you tried this in combination with the kirkwood cpuidle code?
> > That also ioremap()s the DDR_OPERATION_BASE. Are two drivers allowed
> > to do this?
> > 
> 
> Hum... yes, I'm pretty sure I've been testing them together.
> 
> AFAIK, nothing prevents you from ioremapping twice the same area,
> it's request_mem_region() what handle such situations, not ioremap.
> 
> However, now that you bring this to my mind: we should re-visit this
> approach as it's a bit racy. Maybe the cpuidle can export a function
> to set the self-refresh mode?
> 
> > And a dumb question. What actually brings it out of suspend mode?
> > Interrupts on GPIO lines?
> > 
> 
> I'm not entirely sure, but I guess the CPU will get out of the
> Wait-for-interrupt state by any enabled interruption source.
> Currently, I'm waking it with a console key stroke or a GPIO button,
> but there may be other means of resuming.
> 
> Thanks a lot for looking at this!

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
