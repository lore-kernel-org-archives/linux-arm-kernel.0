From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 04 Jun 2014 23:32:48 +0400
Subject: [PATCH] ARM: fix debug prints relevant to PCI devices
In-Reply-To: <1401909447-8434-1-git-send-email-vidyas@nvidia.com>
References: <1401909447-8434-1-git-send-email-vidyas@nvidia.com>
Message-ID: <538F7460.6020600@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/04/2014 11:17 PM, Vidya Sagar wrote:

> As per PCIe spec, fast back-to-back transactions feature
> is not applicable to PCIe devices. Hence, do not print
> that fast back-to-back trasactions are disabled when
> there is a PCIe device found on the bus

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>   arch/arm/kernel/bios32.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 17a26c1..95ad3fb 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
[...]
> @@ -354,9 +357,11 @@ void pcibios_fixup_bus(struct pci_bus *bus)
>
>   	/*
>   	 * Report what we did for this bus
> +	 * (only if the bus doesn't have even one PCIe device)
>   	 */
> -	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
> -		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
> +	if (!has_pcie_dev)
> +		printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",

    Time to change this to pr_info()...

> +			bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
>   }
>   EXPORT_SYMBOL(pcibios_fixup_bus);

WBR, Sergei
