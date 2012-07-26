From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jul 2012 21:44:42 +0000
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <20120726045149.GQ19660@localhost.localdomain>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <201207251710.53683.arnd@arndb.de>
 <20120726045149.GQ19660@localhost.localdomain>
Message-ID: <201207262144.42820.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 July 2012, Shiraz Hashim wrote:
> Hi Arnd,
> 
> On Wed, Jul 25, 2012 at 05:10:53PM +0000, Arnd Bergmann wrote:
> > On Wednesday 25 July 2012, Shiraz Hashim wrote:
> > > On Wed, Jul 25, 2012 at 06:31:53AM +0000, Arnd Bergmann wrote:
> > > > Can you post here the complete set of callback implementations
> > > > that you have in your development trees at the moment? That should
> > > > help us determine which case we're talking about here.
> > > 
> > > There are following types of callbacks (involving SoC/platform) seen
> > > generally in our case,
> > > 
> > >   * parent clk selection -
> > >         driver is not aware about various clock sources (which also
> > >         varies from platform to platform) and hence can only be
> > >         programmed by corresponding platform.
> > > 
> > >         This is the case in Ethernet, audio, etc.
> > >
> > >   * sata controller
> > >         Similar to OTG case which involves clock initialization.
> >  
> > This should definitely be moved into the drivers. A lot of drivers
> > enable and program clocks using the generic clock interfaces, so
> > there is no point using a callback.
> >
> > Note that since stmmac is an architecture independent driver, this
> > depends on Mark Brown's patch to provide empty stubs for
> > the clock management functions on architectures that don't yet
> > use it.
> 
> Yes, this is true for clocks associated with devices and we do handle
> that in this way.
> 
> I was talking more of cases where, we need to
> 
>    * select clock sources (parents) about which driver has no
>      knowledge and may vary across boards.

I think we should be able to describe this now with the clock bindings
for device tree. If not, then we need to update those bindings rather
than work around the shortcomings.

>    * perform initializations which are more than clock, like phy
>      initialization/programming etc. This is SoC dependant.

Setting up the phy is different, but again I think there is a better
way than using callbacks if you put the initialization for the
phy into the driver that deals with that phy.

> > >   * spi controller
> > >         This is little hack in the h/w. As part of s/w controlled chip
> > >         select/deselect in spi-pl022, we need to write to some system
> > >         specific register.
> > > 
> > >   * OTG controller
> > >         phy clock initialization which involves series of steps
> > >         including powering down, etc.
> > > 
> > >   * NAND controller
> > >         bank selection on runtime by writing to system registers
> > 
> > I don't understand any of these, so unless you post the code
> > that you want help with as I asked above, I'll assume that you find
> > the solution yourself and don't need a callback ;-)
> 
> Some of them are,
> 
> - fsmc NAND controller 
> 
>         -- include/linux/mtd/fsmc.h
> 
>         struct fsmc_nand_platform_data {
>                 ...
> 
>                 void (*select_bank)(uint32_t bank, uint32_t busw);
> 
>                 ...
> 
>         };
> 
> 
>         -- arch/arm/mach-spear13xx/spear13xx.c
> 
>         void nand_select_bank(u32 bank, u32 busw)
>         {
>                 u32 fsmc_cfg;
> 
>                 if (cpu_is_spear1340()) {
>         #ifdef CONFIG_CPU_SPEAR1340
>                         fsmc_cfg = readl(VA_SPEAR1340_FSMC_CFG);
>         #endif
>                 } else 
>                         fsmc_cfg = readl(VA_FSMC_CFG);
> 
>                 fsmc_cfg &= ~(NAND_BANK_MASK << NAND_BANK_SHIFT);
>                 fsmc_cfg |= (bank << NAND_BANK_SHIFT);
> 
>                 if (busw)
>                         fsmc_cfg |= 1 << NAND_DEV_WIDTH16;
>                 else
>                         fsmc_cfg &= ~(1 << NAND_DEV_WIDTH16);
> 
>                 if (cpu_is_spear1340()) {
>         #ifdef CONFIG_CPU_SPEAR1340
>                         writel(fsmc_cfg, VA_SPEAR1340_FSMC_CFG);
>         #endif
>                 } else
>                         writel(fsmc_cfg, VA_FSMC_CFG);
>         }

The FSMC driver is ST Microelectronics specific, and this function looks fairly
straightforward. I think this can easily go into the driver, with a few
modifications:

* Find the FSMC_CFG address using the device tree. You should never have
any hardcoded virtual addresses like the one in this file, but instead
ioremap a resource that gets passed from the device tree. Where is this
register located? I assume that it's not part of the normal fsmc registers,
but how to get to this address depends a bit on where it's located.

* Remove the cpu_is_spear1340() hacks. If you have to tell the difference
between variations, make it depend on different "compatible" properties
on the presence or absence of some other property or register range.


> 
> 
>         -- arch/arm/mach-spear13xx/spear1340.c
> 
>         void sata_miphy_exit(struct device *dev)
>         {
>                 writel(0, VA_SPEAR1340_PCIE_SATA_CFG);
>                 writel(0, VA_SPEAR1340_PCIE_MIPHY_CFG);
> 
>                 /* Enable PCIE SATA Controller reset */
>                 writel((readl(VA_SPEAR1340_PERIP1_SW_RST) | (0x1000)),
>                                 VA_SPEAR1340_PERIP1_SW_RST);
>                 msleep(20);
> 
>                 /* Switch off sata power domain */
>                 writel((readl(VA_SPEAR1340_PCM_CFG) & (~0x800)),
>                                 VA_SPEAR1340_PCM_CFG);
>                 msleep(20);
>         }

Again, you should move the accesses to VA_SPEAR1340_PERIP1_SW_RST etc to some
device driver that deals with the specific register range. This can be
the driver for the actual peripheral itself, or it can be some kind of
"system controller" that exports an interface.
In the case of power domains and getting stuff in and out of reset,
the subsystems that you most likely should be using do do this are the
regulator and the powerdomain framework. Regulators already have device
tree bindings, while the power domains still need them.

	Arnd
