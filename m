From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 8 Mar 2017 09:22:30 -0800
Subject: pcie-iproc: broken 2nd (& 3rd?) controller support by
 c3245a566400 ("PCI: iproc: Request host bridge window resources")
In-Reply-To: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
References: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
Message-ID: <88dc6a0e-8989-d09f-1f93-6673a31664c1@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafal,

On 3/8/2017 4:56 AM, Rafa? Mi?ecki wrote:
> Hi,
> 
> I just tried upgrading BCM5301X from 4.4 to 4.9 and noticed I don't see
> card
> connected to the 2nd controller.
> 
> [    2.593534] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
> [    2.599786] pci_bus 0000:00: root bus resource [mem
> 0x08000000-0x0fffffff]
> [    2.606663] pcie_iproc_bcma bcma0:7: link: UP
> [    2.611316] PCI: bus0: Fast back to back transfers disabled
> [    2.616899] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [    2.625395] PCI: bus1: Fast back to back transfers disabled
> [    2.631011] pci 0000:00:00.0: BAR 8: assigned [mem
> 0x08000000-0x080fffff]
> [    2.637795] pci 0000:01:00.0: BAR 0: assigned [mem
> 0x08000000-0x08007fff 64bit]
> [    2.645091] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    2.650042] pci 0000:00:00.0:   bridge window [mem
> 0x08000000-0x080fffff]
> 
> [    2.657199] pcie_iproc_bcma bcma0:8: resource collision: [mem
> 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem
> 0x40000000-0x47ffffff]
> [    2.669946] pcie_iproc_bcma bcma0:8: PCIe controller setup failed
> [    2.676032] pcie_iproc_bcma: probe of bcma0:8 failed with error -16
> 

Would you be able to add some debugging trace to see when the resource
was allocated the first time, and when the resource was allocated the
second time and therefore results in the conflict?

In addition, I'm puzzled why this resource conflict issue for BCMA is
not seen with the first controller with outbound memory in the range of
0x08000000 - 0x0fffffff? Maybe that provides a valuable data point here.

Thanks,

Ray

> 
> This used to work with older kernels because there wasn't any collision
> check:
> 
> [    2.587117] pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
> [    2.593378] pci_bus 0000:00: root bus resource [mem
> 0x08000000-0x0fffffff]
> [    2.600256] pcie_iproc_bcma bcma0:7: link: UP
> [    2.604888] PCI: bus0: Fast back to back transfers disabled
> [    2.610474] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [    2.618973] PCI: bus1: Fast back to back transfers disabled
> [    2.624591] pci 0000:00:00.0: BAR 8: assigned [mem
> 0x08000000-0x080fffff]
> [    2.631382] pci 0000:01:00.0: BAR 0: assigned [mem
> 0x08000000-0x08007fff 64bit]
> [    2.638686] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    2.643633] pci 0000:00:00.0:   bridge window [mem
> 0x08000000-0x080fffff]
> 
> [    2.777118] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
> [    2.783367] pci_bus 0001:00: root bus resource [mem
> 0x40000000-0x47ffffff]
> [    2.790245] pcie_iproc_bcma bcma0:8: link: UP
> [    2.794862] PCI: bus0: Fast back to back transfers disabled
> [    2.800452] pci 0001:00:00.0: bridge configuration invalid ([bus
> 00-00]), reconfiguring
> [    2.808946] PCI: bus1: Fast back to back transfers disabled
> [    2.814558] pci 0001:00:00.0: BAR 8: assigned [mem
> 0x40000000-0x400fffff]
> [    2.821352] pci 0001:01:00.0: BAR 0: assigned [mem
> 0x40000000-0x40007fff 64bit]
> [    2.828650] pci 0001:00:00.0: PCI bridge to [bus 01]
> [    2.833600] pci 0001:00:00.0:   bridge window [mem
> 0x40000000-0x400fffff]
> 
> 
> I guess the check is OK after all and the real problem is iproc driver
> assigning
> the same resource.
> 
> Broadcom team: could you take a look at this, please?
> 
