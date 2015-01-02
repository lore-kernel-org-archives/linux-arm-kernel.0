From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 22:09:33 +0100
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <54A6E0DE.6090309@amd.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20150102115533.GA25573@red-moon> <54A6E0DE.6090309@amd.com>
Message-ID: <30239600.UAZhntKiNS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 January 2015 12:18:06 Suravee Suthikulanit wrote:
> On 1/2/2015 5:55 AM, Lorenzo Pieralisi wrote:
> > Hi Suravee,
> >
> > On Mon, Dec 29, 2014 at 07:32:44PM +0000, Suravee Suthikulpanit wrote:
> >> >Hi,
> >> >
> >> >I am not sure if this thread is still alive. I'm trying to see what I
> >> >can do to help clean up/convert to make the PCI GHC also works for arm64
> >> >w/ zero or minimal ifdefs.
> >> >
> >> >Please let me know if someone is already working on this. I noticed that
> >> >Lorenzo's patches has already been in 3.19-rc1, and in Bjorn's
> >> >pci/domain branch. Otherwise, I'll try to continue the work based on the
> >> >sample patch from Arnd here.
> > If I am not mistaken, the only bit missing to remove pci_sys_data (and so
> > having a generic host controller driver that works on ARM32/64) is generic
> > MSI management.
> 
> Lorenzo,
> 
> Do you mean to remove pci_sys_data from pci-host-generic.c or removing 
> it completely? I assume the former case.

Something inbetween: We should be able to remove pci_sys_data and
pci_common_init_dev from all drivers in drivers/pci/host/, but keep them
for all drivers in arch/arm/*/pci.c

> So, looking at the current code in the pci-host-generic.c, my 
> understanding is that the:
>      *gen_pci = pci_bus->sysdata->private_data
> will be changed to:
>      *gen_pci = pci_bus->sysdata
> 
> Then, we can simply just call pci_scan_root_bus() directly since we no 
> longer need to declare hw_pci for calling pci_common_init_dev().

Right.

> > I know for certain Marc is working on it, and the solution is WIP,
> > I think we should prevent adding more churn to pci_sys_data, since
> > I managed to remove most of the dependencies (domain, mem_offset).
> 
> Thanks for cleaning up the domain and mem_offset.
> 
> I saw Marc's irq/msi_domain patch series 
> (http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/msi_domain). 
> 
> 
> My understanding is that deals with associating the newly introduced 
> msi_domain to each device, which replaces the need for pci_bus->msi and 
> hw_pci->msi_ctrl when configure with CONFIG_PCI_MSI_IRQ_DOMAIN (not sure 
> if this would be the plan for all arm32).  For ARM32, if not define 
> CONFIG_PCI_MSI_IRQ_DOMAIN, it would still fall back to using the 
> [pci_sys_data|hw_pci]->msi_ctrl.

For all I can tell, we have two cases on ARM regarding MSI:

- arch/arm/mach-iop13xx/pci.c uses its own
  arch_setup_msi_irq/arch_teardown_msi_irq implementation and does not
  use pci_bus->msi.

- everything else that supports MSI has a modern driver with multiplatform
  support and uses msi_controller. If any platform wants to support GICv2m,
  we have to use CONFIG_PCI_MSI_IRQ_DOMAIN for all of them, and that
  seems like the best way forward.

	Arnd
