From: adouglas@cadence.com (Alan Douglas)
Date: Tue, 1 Nov 2016 11:47:46 +0000
Subject: Use of GICv3/ITS with PCIe host-generic driver - resizing ITS MAPD?
Message-ID: <CY1PR07MB2506C5C771B446139A743B99D8A10@CY1PR07MB2506.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am using a Cadence PCIe Root Port in an ECAM setup with A53 and GICv3 with ITS, and have configured the host-generic driver to use MSI, using Device Tree.
Setup works well and the bus is correctly enumerated.  However, to get MSI/MSI-X working correctly I needed to make a change in drivers/irqchip/irq-gic-v3-its.c

The PCI setup I am currently testing is:
# lspci -t
-[0000:00]---00.0-[01-04]----00.0-[02-04]--+-03.0-[03]----00.0
                                           \-07.0-[04]----00.0

Device 00:00.0 is a pci-bridge, and claims 1 MSI interrupt.
       01:00.0 is a pci-bridge, 1 MSI interrupt
       02:03.0 is a pci-bridge, 1 MSI interrupt
       02:03.0 is a pci-bridge, 1 MSI interrupt
       03:00.0 is a USB controller with 2 MSI-X interrupts
       04:00.0 is a SATA controller with 1 MSI interrupt

When setting up bus 0, the ITS device is created, and its_build_map_cmd() sets the size of the ITS MAPD based on the number of interrupts claimed by bus 0.  When subsequent buses are enumerated, the ITS device will be reused, however we do not increase the number of supported interrupts to allow for the additional interrupts claimed by the additional devices being enumerated.  (This can be seen in its_msi_prepare(), which is called for each device which has MSI/MSI-X enabled, and will reuse an existing ITS. )

The solution I have implemented is in its_alloc_device_irq(), if the offset into the LPI table for the allocated interrupt is greater than the ITS MAPD, I reallocate the itt area, and resize the ITS MAPD.  I'm looking for comments as to whether this is a suitable solution and I should submit as a patch, is there some other recommendation or am I missing something regarding reuse of the ITS?

Regards
Alan Douglas
