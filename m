From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 3 Jul 2018 11:49:47 -0400
Subject: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <fda77cee8e379f2e9b7ab55fefe17cad@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703143434.GA4086@wunner.de>
 <fda77cee8e379f2e9b7ab55fefe17cad@codeaurora.org>
Message-ID: <867e1f69-8b77-ecb0-d4e3-ab0636a49a2e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/3/2018 11:12 AM, poza at codeaurora.org wrote:
> if (!pci_probe_reset_slot(dev->slot))
> {
> ??? pci_reset_slot(dev->slot)
> ??? result = reset_link(udev, service); >> in this case aer_root_reset must not call pci_reset_bridge_secondary_bus()
> } else
> ??? result = reset_link(udev, service); >> in this case aer_root_reset must call pci_reset_bridge_secondary_bus() [since bridge is not hotplug capable)

Here are two different flow for two different FATAL error sources

dpc_irq
	link is down due to DPC
	pcie_do_fatal_recovery()
		pci_reset_slot()
			mask hotplug IRQ
			secondary bus reset
			unmask hotplug IRQ
			undefined behavior as link went down due to DPC
		dpc_reset_link()
			undefined behavior secondary bus reset happened
					   while a DPC event is pending
			link may or may not be up at this moment
			recover the link via DPC way if HW can cope with this undefined behavior.


aer_irq
	link is up
	pcie_do_fatal_recovery()
		pci_reset_slot()
			mask hotplug IRQ
			secondary bus reset
			unmask hotplug IRQ
			link goes up
		aer_reset_link()
			secondary bus reset
			hotplug link down interrupt again

I tried to change pci_reset_slot() such that we do

mask hotplug IRQ
go to AER/DPC reset_link based on error source
unmask hotplug IRQ

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
