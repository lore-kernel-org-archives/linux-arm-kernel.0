From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 17:19:20 +0100
Subject: [PATCH 6/6] pci, acpi: Share ACPI PCI config space accessors.
In-Reply-To: <1416413091-13452-7-git-send-email-tomasz.nowicki@linaro.org>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
 <1416413091-13452-7-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <2360791.Aj7tQ0nCJ3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 17:04:51 Tomasz Nowicki wrote:
> +/*
> + * raw_pci_read/write - ACPI PCI config space accessors.
> + *
> + * ACPI spec defines MMCFG as the way we can access PCI config space,
> + * so let MMCFG be default (__weak).
> + *
> + * If platform needs more fancy stuff, should provides its own implementation.
> + */
> +int __weak raw_pci_read(unsigned int domain, unsigned int bus,
> +                       unsigned int devfn, int reg, int len, u32 *val)
> +{
> +       return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
> +}
> +
> +int __weak raw_pci_write(unsigned int domain, unsigned int bus,
> +                        unsigned int devfn, int reg, int len, u32 val)
> +{
> +       return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
> +}
> +
> 

I think it would be better to avoid __weak functions here, as they tend
to be hard to follow when trying to understand the code.

How about using a Kconfig symbol like this:

#ifdef CONFIG_ARCH_RAW_PCI_READWRITE
int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
                 int reg, int len, u32 *val);
int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
                  int reg, int len, u32 val);
#else
static inline int raw_pci_read(unsigned int domain, unsigned int bus,
	                       unsigned int devfn, int reg, int len, u32 *val)
{
	return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
}

static inline int raw_pci_write(unsigned int domain, unsigned int bus,
             		                unsigned int devfn, int reg, int len, u32 val)
{
       return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
}
#endif

Same thing for the weak symbols in patch 5.

	Arnd
