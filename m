From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jan 2015 15:10:57 +0000
Subject: [Linaro-acpi] [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional
 for ACPI on ARM64
In-Reply-To: <54BE4991.5040505@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
 <20150116094913.GA13634@e104818-lin.cambridge.arm.com>
 <54BB51F1.8000900@linaro.org>
 <20150119104240.GE11835@e104818-lin.cambridge.arm.com>
 <54BDBFD4.7050207@linaro.org>
 <20150120110045.GD25575@e104818-lin.cambridge.arm.com>
 <54BE4991.5040505@linaro.org>
Message-ID: <20150120151057.GG25575@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 12:26:57PM +0000, Tomasz Nowicki wrote:
> On 20.01.2015 12:00, Catalin Marinas wrote:
> > On Tue, Jan 20, 2015 at 02:39:16AM +0000, Hanjun Guo wrote:
> >> On 2015?01?19? 18:42, Catalin Marinas wrote:
> >>> On Sun, Jan 18, 2015 at 06:25:53AM +0000, Hanjun Guo wrote:
> >>>> On 2015?01?16? 17:49, Catalin Marinas wrote:
> >>>>> On Wed, Jan 14, 2015 at 03:04:54PM +0000, Hanjun Guo wrote:
> >>>>>> --- a/arch/arm64/kernel/pci.c
> >>>>>> +++ b/arch/arm64/kernel/pci.c
> >>>>>> @@ -10,6 +10,7 @@
> >>>>>>      *
> >>>>>>      */
> >>>>>>
> >>>>>> +#include <linux/acpi.h>
> >>>>>>     #include <linux/init.h>
> >>>>>>     #include <linux/io.h>
> >>>>>>     #include <linux/kernel.h>
> >>>>>> @@ -68,3 +69,30 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> >>>>>>     	bus->domain_nr = domain;
> >>>>>>     }
> >>>>>>     #endif
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * raw_pci_read/write - Platform-specific PCI config space access.
> >>>>>> + *
> >>>>>> + * Default empty implementation.  Replace with an architecture-specific setup
> >>>>>> + * routine, if necessary.
> >>>>>> + */
> >>>>>> +int raw_pci_read(unsigned int domain, unsigned int bus,
> >>>>>> +		  unsigned int devfn, int reg, int len, u32 *val)
> >>>>>> +{
> >>>>>> +	return -EINVAL;
> >>>>>> +}
> >>>>>> +
> >>>>>> +int raw_pci_write(unsigned int domain, unsigned int bus,
> >>>>>> +		unsigned int devfn, int reg, int len, u32 val)
> >>>>>> +{
> >>>>>> +	return -EINVAL;
> >>>>>> +}
> >>>>>> +
> >>>>>> +#ifdef CONFIG_ACPI
> >>>>>> +/* Root bridge scanning */
> >>>>>> +struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >>>>>> +{
> >>>>>> +	/* TODO: Should be revisited when implementing PCI on ACPI */
> >>>>>> +	return NULL;
> >>>>>> +}
> >>>>>> +#endif
> >>> [...]
> >>>>> When PCI is enabled and the above functions are compiled in, do they
> >>>>> need to return any useful data or just -EINVAL. Are they ever called?
> >>>>
> >>>> They will be called if PCI root bridge is defined in DSDT, should I
> >>>> print some warning message before it is implemented?
> >>>
> >>> My point: do they need to return real data when a PCI root bridge is
> >>> defined in DSDT or you always expect them to always return some -E*? Can
> >>> you explain why?
> >>
> >> Not always return -E* or NULL;
> >>
> >> For raw_pci_read/write(), they are needed to access the PCI config space
> >> before the PCI root bus is created. so they will return 0 if access to
> >> PCI config space is ok; pci_acpi_scan_root() will return root bus
> >> pointer if it is successfully created.
> >
> > OK. So what's the plan for implementing these functions properly. For
> > the raw_pci_read/write, the comment states "replace with an
> > architecture-specific setup routine". What does this mean?
> raw_pci_read/write will use MMCONFIG code to access PCI config space. 
> Please see my patch set:
> http://lkml.iu.edu/hypermail/linux/kernel/1411.2/02753.html
> which is going to refactor the x86 specific code so it would be usable 
> for ARM64 too.

OK. Thanks for the information.

-- 
Catalin
