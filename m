From: rjui@broadcom.com (Ray Jui)
Date: Fri, 2 Oct 2015 15:44:39 -0700
Subject: [PATCH v2] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <5225360.GkBHX0QnIA@wuerfel>
References: <1443689961-23909-1-git-send-email-bharatku@xilinx.com>
 <2677327.lnRZhqx5GI@wuerfel> <560DD374.4000708@broadcom.com>
 <5225360.GkBHX0QnIA@wuerfel>
Message-ID: <560F08D7.7040707@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/2/2015 3:36 PM, Arnd Bergmann wrote:
> On Thursday 01 October 2015 17:44:36 Ray Jui wrote:
>>
>> Sorry for stealing this discussion, :)
>>
>> I have some questions here, since this affects how I should implement
>> the MSI support for iProc based PCIe controller. I understand it makes
>> more sense to use separate device node for MSI and have "msi-parent"
>> from the pci node points to the MSI node, and that MSI node can be
>> gicv2m or gicv3 based on more advanced ARMv8 platforms.
>>
>> Then I would assume the MSI controller would deserve its own driver?
>> Which is a lot of people do nowadays. In that case, how I should handle
>> the case when the iProc MSI support is handled through some event queue
>> mechanism with their registers embedded in the PCIe controller register
>> space?
>>
>> Does the following logic make sense to you?
>>
>> 1. parse phandle of "msi-parent"
>> 2. Call of_pci_find_msi_chip_by_node to hook it up to msi chip already
>> registered (in the gicv2m and gicv3 case)
>> 3. If failed, fall back to use the iProc's own event queue logic by
>> calling iproc_pcie_msi_init.
>>
>> The iProc MSI still has its own node that looks like this:
>> 141 msi0: msi at 20020000 {
>> 142                         msi-controller;
>> 143                         interrupt-parent = <&gic>;
>> 144                         interrupts = <GIC_SPI 277 IRQ_TYPE_NONE>,
>> 145                                      <GIC_SPI 278 IRQ_TYPE_NONE>,
>> 146                                      <GIC_SPI 279 IRQ_TYPE_NONE>,
>> 147                                      <GIC_SPI 280 IRQ_TYPE_NONE>,
>> 148                                      <GIC_SPI 281 IRQ_TYPE_NONE>,
>> 149                                      <GIC_SPI 282 IRQ_TYPE_NONE>;
>> 150                         brcm,num-eq-region = <1>;
>> 151                         brcm,num-msi-msg-region = <1>;
>> 152                 };
>>
>> But it does not have its own "reg" since they are embedded in the PCI
>> controller's registers and it relies on one calling iproc_pcie_msi_init
>> to pass in base register value and some other information.
> 
> I don't think I have a perfect answer to this. One way would be to
> separate the actual PCI root device node from the IP block that
> contains both the PCI root and the MSI catcher, but I guess that
> would require an incompatible change to your binding and it's not
> worth the pain.

Indeed, that's going to be very painful given that this iProc PCIe
controller driver is used on multiple platforms including Northstar,
Cygnus, Northstar+, and Northstar 2.

> 
> It's probably also ok to make the PCI host node itself be the msi-controller
> node and have an msi-parent phandle that points to the node itself. Not
> sure if that violates any rules that we may want or need to follow though.
> 
> Having a device node without registers is also a bit problematic,
> especially the 'msi at 20020000' name doesn't make sense if 0x20020000
> is not the first number in the reg property. Maybe it's best to 
> put that node directly under the PCI host controller and not assign
> any registers. This is still a bit ugly because we'd expect devices
> under the host bridge to be PCI devices rather than random other things,
> but it may be the least of the evils.

This is what I have right now. With the msi node under the PCIe
controller node and have msi-parent points to the msi node. Maybe it
will be a lot easier to discuss this when I submit the code for review
within the next couple weeks.

> 
> 	Arnd
> 

Thanks,

Ray
