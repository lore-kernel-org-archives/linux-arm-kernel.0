From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 May 2015 17:31:46 +0200
Subject: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
In-Reply-To: <5565CD0B.6020206@hisilicon.com>
References: <000001d096a9$27bf43f0$773dcbd0$@com> <3340422.95mKZ6cYUI@wuerfel>
 <5565CD0B.6020206@hisilicon.com>
Message-ID: <2378629.Ocol8HRDqD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 May 2015 21:56:27 Zhou Wang wrote:
> On 2015/5/26 16:02, Arnd Bergmann wrote:
> > On Tuesday 26 May 2015 10:49:51 Zhou Wang wrote:
> >>
> >> I am a little confused that pci_sys_data is still needed as we don't use the code
> >> in bios32. What was the problem you met? Could you share me more information? Then
> >> let's see how to solve the problem.
> >>
> > 
> > The PCI core code still calls pcibios_align_resource(), which will try to
> > use the dev->sysdata pointer as 'struct pci_sys_data'. To solve this, we
> 
> Thanks for reminding.
> 
> > need to change the pci-mvebu driver and the core code first to let the
> 
> It seams that only pci-mvebu implemented align_resource callback in ARM ?

Correct. The pointer in struct pci_sys_data was added for this driver, and
no other driver has needed it so far.

> > driver override pcibios_align_resource() through an operation in 
> > struct pci_host_bridge.
> > 
> > The other remaining use of dev->sysdata is the ARM pcibios_msi_controller()
> > function that overrides the generic implementation.  To solve this, we need
> > to change the five remaining drivers that set hw_pci->msi_ctrl to use
> > the new generic method, and remove the ARM specific implementation.
> 
> Yes, that is better if we can do like this. But for pcie-designware, can we
> just set bus->msi = &dw_pcie_msi_chip and get msi controller using dev->bus->msi
> in pci_msi_controller()?

Yes, that works. However there are two problems with the approach:

- we have to change all PCI host drivers on ARM to do this in order to remove
  the ARM-specific pcibios_msi_controller() function
- it's possible that there are dw_pcie implementations that do not include
  an MSI controller, so that pointer would be NULL, which leads to the
  core code to still call the ARM-specific pcibios_msi_controller() function
  unless we remove it.

	Arnd
