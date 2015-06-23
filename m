From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 24 Jun 2015 08:32:14 +1000
Subject: [RFC 3/4] arm64: Do not call enable PCI resources when specify
 PCI_PROBE_ONLY
In-Reply-To: <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <1435098734.3996.5.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-09-28 at 15:53 -0500, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> When specify PCI_PROBE_ONLY, the resource parent does not get assigned.
> Therefore, pci_enable_resources() return error saying that
> "BAR x not claimed".
> 
> Note: This same logic is also used in the arch/arm/kernel/bios32.c

This looks broken. Why don't you assign the resource parent ?

> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  arch/arm64/kernel/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index ce5836c..7fd4d2b 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -68,3 +68,11 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>  	bus->domain_nr = domain;
>  }
>  #endif
> +
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +	if (pci_has_flag(PCI_PROBE_ONLY))
> +		return 0;
> +
> +	return pci_enable_resources(dev, mask);
> +}
