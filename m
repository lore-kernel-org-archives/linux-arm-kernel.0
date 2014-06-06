From: joe@perches.com (Joe Perches)
Date: Thu, 05 Jun 2014 21:23:12 -0700
Subject: [PATCH v2] ARM: fix debug prints relevant to PCI devices
In-Reply-To: <1401994068-820-1-git-send-email-vidyas@nvidia.com>
References: <1401994068-820-1-git-send-email-vidyas@nvidia.com>
Message-ID: <1402028592.3038.4.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-06-06 at 00:17 +0530, Vidya Sagar wrote:
> * replaced printk with pr_info
[]
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
[]
> @@ -354,9 +357,11 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  
>  	/*
>  	 * Report what we did for this bus
> +	 * (only if the bus doesn't have even one PCIe device)
>  	 */
> -	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
> -		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
> +	if (!has_pcie_dev)
> +		pr_info(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
> +			bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");

when you convert to pr_<level> you need to remove the
KERN_<LEVEL> from the format string too.
