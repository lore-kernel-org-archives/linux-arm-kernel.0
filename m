From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 8 Mar 2017 13:56:35 +0100
Subject: pcie-iproc: broken 2nd (& 3rd?) controller support by c3245a566400
 ("PCI: iproc: Request host bridge window resources")
Message-ID: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just tried upgrading BCM5301X from 4.4 to 4.9 and noticed I don't see card
connected to the 2nd controller.

[    2.593534] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[    2.599786] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
[    2.606663] pcie_iproc_bcma bcma0:7: link: UP
[    2.611316] PCI: bus0: Fast back to back transfers disabled
[    2.616899] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.625395] PCI: bus1: Fast back to back transfers disabled
[    2.631011] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
[    2.637795] pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
[    2.645091] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.650042] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]

[    2.657199] pcie_iproc_bcma bcma0:8: resource collision: [mem 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem 0x40000000-0x47ffffff]
[    2.669946] pcie_iproc_bcma bcma0:8: PCIe controller setup failed
[    2.676032] pcie_iproc_bcma: probe of bcma0:8 failed with error -16


This used to work with older kernels because there wasn't any collision check:

[    2.587117] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
[    2.593378] pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
[    2.600256] pcie_iproc_bcma bcma0:7: link: UP
[    2.604888] PCI: bus0: Fast back to back transfers disabled
[    2.610474] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.618973] PCI: bus1: Fast back to back transfers disabled
[    2.624591] pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
[    2.631382] pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
[    2.638686] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.643633] pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]

[    2.777118] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
[    2.783367] pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
[    2.790245] pcie_iproc_bcma bcma0:8: link: UP
[    2.794862] PCI: bus0: Fast back to back transfers disabled
[    2.800452] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    2.808946] PCI: bus1: Fast back to back transfers disabled
[    2.814558] pci 0001:00:00.0: BAR 8: assigned [mem 0x40000000-0x400fffff]
[    2.821352] pci 0001:01:00.0: BAR 0: assigned [mem 0x40000000-0x40007fff 64bit]
[    2.828650] pci 0001:00:00.0: PCI bridge to [bus 01]
[    2.833600] pci 0001:00:00.0:   bridge window [mem 0x40000000-0x400fffff]


I guess the check is OK after all and the real problem is iproc driver assigning
the same resource.

Broadcom team: could you take a look at this, please?

-- 
Rafa?
