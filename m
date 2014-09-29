From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 16:38:09 +0200
Subject: [RFC 3/4] arm64: Do not call enable PCI resources when specify
 PCI_PROBE_ONLY
In-Reply-To: <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <4139946.HEULtVYyUh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 September 2014 15:53:29 suravee.suthikulpanit at amd.com wrote:
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index ce5836c..7fd4d2b 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -68,3 +68,11 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>         bus->domain_nr = domain;
>  }
>  #endif
> +
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
> +{
> +       if (pci_has_flag(PCI_PROBE_ONLY))
> +               return 0;
> +
> +       return pci_enable_resources(dev, mask);
> +}

This doesn't look arm64 specific to me, and there is already a generic
pcibios_enable_device() function in drivers/pci/pci.c. Would it
be possible to move the check for PCI_PROBE_ONLY there without breaking
other architectures?

If that works, please do so.

	Arnd
