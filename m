From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Apr 2016 15:12:22 +0200
Subject: pci_ioremap_set_mem_type(), pci_remap_iospace()
In-Reply-To: <20160428130228.GW28464@e106497-lin.cambridge.arm.com>
References: <20160427225827.GC17629@localhost>
 <20160428120624.GV28464@e106497-lin.cambridge.arm.com>
 <20160428141336.60aa4be1@free-electrons.com>
 <20160428130228.GW28464@e106497-lin.cambridge.arm.com>
Message-ID: <20160428151222.2ef7ce06@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 28 Apr 2016 14:02:28 +0100, Liviu Dudau wrote:

> > Armada XP itself is not affected by the HW issue that requires use to
> > use strongly-ordered mappings, it's only the Cortex-A9 based SoC, i.e
> > Armada 375, 38x and 39x.
> 
> Sorry, I blame my unfamiliarity with the Armada family of devices when I
> said Armada XP (I know the name better than any other).

No problem. It is impossible to understand the fine details of all SoC
families supported in the kernel. I was making this statement only for
the sake of precision.

> > That being said, could you point to me to which bits of the generic PCI
> > code I should convert our PCI support to? I'd be happy to take a look.
> 
> Hmm, looking at the DT bindings there seem to be a lot of custom stuff in there.
> I would start with trying to see if you can replace the custom parsing of
> ranges with the generic of_pci_range_to_resource() and then look at the
> pcie-designware.c how they got rid of the pci_common_init_dev() and the
> need to use hw_pci structure. You want to end up with calling
> of_pci_get_host_bridge_resources() to get back your list of MEM and IO
> resources (it parses the bus ranges as well) and then use those to map IO
> space and start the root bus scanning.

I will have a look, but there is clearly one thing that is not
possible: parsing the list of MEM and IO resources is not sufficient to
map the IO space.

With the pci-mvebu driver, all the MEM and IO mappings are dynamic. The
device tree does *not* contain the addresses at which the MEM and IO
mappings will be done. Indeed, we have too many PCIe interfaces and too
few MBus windows and physical address space to map everything
statically. So we have a logic that emulates a PCI bridge, for which we
trap the read/write accesses made by the kernel when scanning the PCI
busses, and we use what's written in the configuration space of the
emulated PCI bridge to on-demand create the MBus windows with the
appropriate size. Look at our usage of the DT:

     0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
     0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
     0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
     0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
     0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
     0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
     0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
     0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */

     0x82000000 0x5 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
     0x81000000 0x5 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
     0x82000000 0x6 0     MBUS_ID(0x08, 0xd8) 0 1 0 /* Port 1.1 MEM */
     0x81000000 0x6 0     MBUS_ID(0x08, 0xd0) 0 1 0 /* Port 1.1 IO  */
     0x82000000 0x7 0     MBUS_ID(0x08, 0xb8) 0 1 0 /* Port 1.2 MEM */
     0x81000000 0x7 0     MBUS_ID(0x08, 0xb0) 0 1 0 /* Port 1.2 IO  */
     0x82000000 0x8 0     MBUS_ID(0x08, 0x78) 0 1 0 /* Port 1.3 MEM */
     0x81000000 0x8 0     MBUS_ID(0x08, 0x70) 0 1 0 /* Port 1.3 IO  */

     0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
     0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */

     0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
     0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;

See how the address and size are 0 ? We don't know at the moment of
scanning the DT, what will be the address and size of the different MEM
and IO mappings.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
