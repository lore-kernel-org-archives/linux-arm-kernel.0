From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Thu, 26 Jul 2012 10:21:49 +0530
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <201207251710.53683.arnd@arndb.de>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <201207250631.54157.arnd@arndb.de>
 <20120725073406.GM19660@localhost.localdomain>
 <201207251710.53683.arnd@arndb.de>
Message-ID: <20120726045149.GQ19660@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jul 25, 2012 at 05:10:53PM +0000, Arnd Bergmann wrote:
> On Wednesday 25 July 2012, Shiraz Hashim wrote:
> > On Wed, Jul 25, 2012 at 06:31:53AM +0000, Arnd Bergmann wrote:
> > > Can you post here the complete set of callback implementations
> > > that you have in your development trees at the moment? That should
> > > help us determine which case we're talking about here.
> > 
> > There are following types of callbacks (involving SoC/platform) seen
> > generally in our case,
> > 
> >   * parent clk selection -
> >         driver is not aware about various clock sources (which also
> >         varies from platform to platform) and hence can only be
> >         programmed by corresponding platform.
> > 
> >         This is the case in Ethernet, audio, etc.
> >
> >   * sata controller
> >         Similar to OTG case which involves clock initialization.
>  
> This should definitely be moved into the drivers. A lot of drivers
> enable and program clocks using the generic clock interfaces, so
> there is no point using a callback.
>
> Note that since stmmac is an architecture independent driver, this
> depends on Mark Brown's patch to provide empty stubs for
> the clock management functions on architectures that don't yet
> use it.

Yes, this is true for clocks associated with devices and we do handle
that in this way.

I was talking more of cases where, we need to

   * select clock sources (parents) about which driver has no
     knowledge and may vary across boards.
   * perform initializations which are more than clock, like phy
     initialization/programming etc. This is SoC dependant.

> >   * spi controller
> >         This is little hack in the h/w. As part of s/w controlled chip
> >         select/deselect in spi-pl022, we need to write to some system
> >         specific register.
> > 
> >   * OTG controller
> >         phy clock initialization which involves series of steps
> >         including powering down, etc.
> > 
> >   * NAND controller
> >         bank selection on runtime by writing to system registers
> 
> I don't understand any of these, so unless you post the code
> that you want help with as I asked above, I'll assume that you find
> the solution yourself and don't need a callback ;-)

Some of them are,

- fsmc NAND controller 

        -- include/linux/mtd/fsmc.h

        struct fsmc_nand_platform_data {
                ...

                void (*select_bank)(uint32_t bank, uint32_t busw);

                ...

        };


        -- arch/arm/mach-spear13xx/spear13xx.c

        void nand_select_bank(u32 bank, u32 busw)
        {
                u32 fsmc_cfg;

                if (cpu_is_spear1340()) {
        #ifdef CONFIG_CPU_SPEAR1340
                        fsmc_cfg = readl(VA_SPEAR1340_FSMC_CFG);
        #endif
                } else 
                        fsmc_cfg = readl(VA_FSMC_CFG);

                fsmc_cfg &= ~(NAND_BANK_MASK << NAND_BANK_SHIFT);
                fsmc_cfg |= (bank << NAND_BANK_SHIFT);

                if (busw)
                        fsmc_cfg |= 1 << NAND_DEV_WIDTH16;
                else
                        fsmc_cfg &= ~(1 << NAND_DEV_WIDTH16);

                if (cpu_is_spear1340()) {
        #ifdef CONFIG_CPU_SPEAR1340
                        writel(fsmc_cfg, VA_SPEAR1340_FSMC_CFG);
        #endif
                } else
                        writel(fsmc_cfg, VA_FSMC_CFG);
        }


- SATA Controller

        -- include/linux/ahci_platform.h

        struct ahci_platform_data {
                int (*init)(struct device *dev, void __iomem *addr);
                void (*exit)(struct device *dev);
                const struct ata_port_info *ata_port_info;
                unsigned int force_port_map;
                unsigned int mask_port_map;
        };


        -- arch/arm/mach-spear13xx/spear1340.c

        void sata_miphy_exit(struct device *dev)
        {
                writel(0, VA_SPEAR1340_PCIE_SATA_CFG);
                writel(0, VA_SPEAR1340_PCIE_MIPHY_CFG);

                /* Enable PCIE SATA Controller reset */
                writel((readl(VA_SPEAR1340_PERIP1_SW_RST) | (0x1000)),
                                VA_SPEAR1340_PERIP1_SW_RST);
                msleep(20);

                /* Switch off sata power domain */
                writel((readl(VA_SPEAR1340_PCM_CFG) & (~0x800)),
                                VA_SPEAR1340_PCM_CFG);
                msleep(20);
        }

        static int sata_miphy_init(struct device *dev, void __iomem *addr)
        {
                writel(SPEAR1340_SATA_CFG_VAL, VA_SPEAR1340_PCIE_SATA_CFG);
                writel(SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK,
                                VA_SPEAR1340_PCIE_MIPHY_CFG);
                /* Switch on sata power domain */
                writel((readl(VA_SPEAR1340_PCM_CFG) | (0x800)),
                                VA_SPEAR1340_PCM_CFG);
                msleep(20);
                /* Disable PCIE SATA Controller reset */
                writel((readl(VA_SPEAR1340_PERIP1_SW_RST) & (~0x1000)),
                                VA_SPEAR1340_PERIP1_SW_RST);
                msleep(20);

                return 0;
        }

        static struct ahci_platform_data sata_pdata = {
                .init = sata_miphy_init,
                .exit = sata_miphy_exit,
        };

--
regards
Shiraz
