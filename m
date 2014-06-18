From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jun 2014 23:56:38 +0200
Subject: [PATCH v3] ARM: fix debug prints relevant to PCI devices
In-Reply-To: <1403114868-17533-1-git-send-email-vidyas@nvidia.com>
References: <1403114868-17533-1-git-send-email-vidyas@nvidia.com>
Message-ID: <20140618215637.GB26514@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 11:37:48PM +0530, Vidya Sagar wrote:
[...]
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 17a26c1..fcf2581 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -290,6 +290,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  	u16 features = PCI_COMMAND_SERR | PCI_COMMAND_PARITY | PCI_COMMAND_FAST_BACK;
> +	bool has_pcie_dev = 0;

s/0/false/

> @@ -354,9 +357,11 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>  
>  	/*
>  	 * Report what we did for this bus
> +	 * (only if the bus doesn't have even one PCIe device)

I find this hard to read. Perhaps "only if the bus doesn't have any PCIe
devices"?

>  	 */
> -	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
> -		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
> +	if (!has_pcie_dev)
> +		pr_info("PCI: bus%d: Fast back to back transfers %sabled\n",
> +			bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");

I think this now makes checkpatch complain about this last line being
longer than 80 characters. But looking at checkpatch output on the
current version of the file there are already some lines that exceed the
limit as well, so maybe this can be ignored?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/c59c2d39/attachment.sig>
