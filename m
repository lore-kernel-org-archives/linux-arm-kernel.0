From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Jun 2014 13:29:14 -0600
Subject: [PATCH] ARM: fix debug prints relevant to PCI devices
In-Reply-To: <1401909447-8434-1-git-send-email-vidyas@nvidia.com>
References: <1401909447-8434-1-git-send-email-vidyas@nvidia.com>
Message-ID: <538F738A.6020003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 01:17 PM, Vidya Sagar wrote:
> As per PCIe spec, fast back-to-back transactions feature
> is not applicable to PCIe devices. Hence, do not print
> that fast back-to-back trasactions are disabled when
> there is a PCIe device found on the bus

> @@ -298,6 +299,8 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		u16 status;
>  
> +		if (!has_pcie_dev)
> +			has_pcie_dev = pci_pcie_cap(dev);

This sets the flag if any PCIe device is detected, even if regular PCI
devices are also detected. I assume the two can be mixed on a bus if
there's a bridge (although perhaps that would be separate buses, and
child buses don't get traversed by this function?)

>  	/*
>  	 * Report what we did for this bus
> +	 * (only if the bus doesn't have even one PCIe device)
>  	 */
> -	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
> -		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
> +	if (!has_pcie_dev)
> +		printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
> +			bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");

So, this skips printing the message if any PCIe device was found.

Given that the message is relevant to PCI devices, more than being not
relevant to PCIe devices, perhaps the logic should be inverted, so that
the message is only printed if a PCI/non-PCIe device /is/ found, i.e.:

...
has_pci_device |= !pci_pcie_cap(dev);
...
if (has_pci_device)
	printk(...);
