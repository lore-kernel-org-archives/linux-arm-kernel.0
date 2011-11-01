From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 1 Nov 2011 07:25:23 +0100
Subject: orion/kirkwood and device tree
In-Reply-To: <201110312350.28475.michael@walle.cc>
References: <20111031105740.GC29402@lunn.ch>
	<20111031152100.GR32165@titan.lakedaemon.net>
	<20111031164042.GD29402@lunn.ch>
	<201110312350.28475.michael@walle.cc>
Message-ID: <20111101062523.GK4388@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael

> i've already ported some marvell devices to DT. spi-orion, orion-wdt, rtc-mv 
> and mv_cesa.

Sounds good.

> Atm i'm struggling with how to pass kirkwood_mbus_dram_info to 
> the device drivers (the old method is to pass it through platform_data)

I have some changes in this area in my tree. All the different orion
platforms, kirkwood, dove, orion5x, mv78xx0 have the very similar
addr-map.c code. Its a classic ARM cut/paste problem when supporting
new devices. So i unified the code, and made it mostly table driven in
the mach- part. For kirkwood i have the table:

static const struct orion_addr_map_info addr_map_info[] = {
        /*
         * Windows for PCIe IO+MEM space.
         */
        { 0, KIRKWOOD_PCIE_IO_PHYS_BASE, KIRKWOOD_PCIE_IO_SIZE,
          TARGET_PCIE, ATTR_PCIE_IO, KIRKWOOD_PCIE_IO_BUS_BASE
        },
        { 1, KIRKWOOD_PCIE_MEM_PHYS_BASE, KIRKWOOD_PCIE_MEM_SIZE,
          TARGET_PCIE, ATTR_PCIE_MEM, KIRKWOOD_PCIE_MEM_BUS_BASE
        },
        { 2, KIRKWOOD_PCIE1_IO_PHYS_BASE, KIRKWOOD_PCIE1_IO_SIZE,
          TARGET_PCIE, ATTR_PCIE1_IO, KIRKWOOD_PCIE1_IO_BUS_BASE
        },
        { 3, KIRKWOOD_PCIE1_MEM_PHYS_BASE, KIRKWOOD_PCIE1_MEM_SIZE,
          TARGET_PCIE, ATTR_PCIE1_MEM, KIRKWOOD_PCIE1_MEM_BUS_BASE
        },
        /*
         * Window for NAND controller.
         */
        { 4, KIRKWOOD_NAND_MEM_PHYS_BASE, KIRKWOOD_NAND_MEM_SIZE,
          TARGET_DEV_BUS, ATTR_DEV_NAND, -1
        },
        /*
         * Window for SRAM.
         */
        { 5, KIRKWOOD_SRAM_PHYS_BASE, KIRKWOOD_SRAM_SIZE,
          TARGET_SRAM, ATTR_SRAM, -1
        },
        /* End marker */
        { -1, 0, 0, 0, 0, 0 }
};

We could maybe put this table into DT?

The kirkwood_mbus_dram_info could become orion_mbus_dram_info, and put
into plat-orion/orion-dt.c?

I will post a patch of my changes and maybe we can then find a
solution passing kirkwood_mbus_dram_info.

	 Andrew
