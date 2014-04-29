From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 12:01:30 +0200
Subject: [Linaro-acpi] [PATCH v3 part1 08/11] ARM64 / ACPI: Introduce PCI
 functions for ACPI on ARM64
In-Reply-To: <535F6675.1060109@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <201404281549.50738.arnd@arndb.de> <535F6675.1060109@linaro.org>
Message-ID: <8888740.lgd2Xkrtad@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 16:44:37 Hanjun Guo wrote:
> On 2014-4-28 21:49, Arnd Bergmann wrote:
> > On Friday 25 April 2014, Hanjun Guo wrote:
> >> CONFIG_ACPI depends CONFIG_PCI now, and ACPI provides ACPI based
> >> PCI hotplug and PCI host bridge hotplug, introduce some PCI
> >> functions to make ACPI core can be compiled, some of the functions
> >> should be revisited when implemented on ARM64.
> > 
> >> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> >> index d93576f..0aa3607 100644
> >> --- a/arch/arm64/include/asm/pci.h
> >> +++ b/arch/arm64/include/asm/pci.h
> >> @@ -21,6 +21,17 @@ struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
> >>  #define pcibios_assign_all_busses() \
> >>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
> >>  
> >> +static inline void pcibios_penalize_isa_irq(int irq, int active)
> >> +{
> >> +	/* we don't do dynamic pci irq allocation */
> >> +}
> >> +
> >> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> >> +{
> >> +	/* no legacy IRQ on arm64 */
> >> +	return -ENODEV;
> >> +}
> >> +
> > 
> > I think these would be better addressed in the caller. From what I can tell, they
> > are only called by the ISAPNP code path for doing IRQ resource allocation, while
> > the ACPIPNP code uses hardwired IRQ resources.
> 
> I agree. pcibios_penalize_isa_irq() is only used by x86 and I will send out a
> patch to make pcibios_penalize_isa_irq() as __weak in PCI core and remove
> all the stub function out except x86. For pci_get_legacy_ide_irq(), I think we
> can fix it in the same way, does this make sense to you?

Actually I had only looked at pci_get_legacy_ide_irq() and I'm pretty sure it's
only needed for ISAPNP. I had missed the fact that pcibios_penalize_isa_irq()
is used in other places as well, but it makes sense that it's also not needed,
since we don't have legacy ISA IRQs.

> > And these probably don't need to be done at the architecture level. I expect we
> > will only have to worry about SBSA compliant PCI hosts, so this can be done in
> > the host controller driver for compliant devices, which is probably the one
> > that Will Deacon is working on already.
> > 
> > Note that we are aiming for an empty PCI implementation in ARM64, doing everything
> > in either the PCI core or in the individual host drivers.
> 
> Ok, I will review Will Deacon's patch to find out the solution for
> pci_acpi_scan_root().

Ok. Please ask if you have more questions about that. It's definitely a complex
topic.

> > For raw_pci_{read,write} we can have a trivial generic implementation in
> > the PCI core, like
> > 
> > int __weak raw_pci_read(unsigned int domain, unsigned int bus,
> > 		  unsigned int devfn, int reg, int len, u32 *val)
> > {
> > 	struct pci_bus *bus = pci_find_bus(domain, bus);
> > 	if (!bus)
> > 		return -ENODEV;
> > 
> > 	return bus->ops->read(bus, devfn, reg, len, val);
> > }
> > 
> > which won't work on x86 or ia64, but should be fine everywhere else. Alternatively,
> > you can change the ACPI code to do the above manually and call the architecture
> > independent interfaces, either bus->ops->read, or pci_bus_read_config_{byte,word,dword},
> > which would actually simplify the ACPI code.
> 
> This may not work. ACPI needs to be able to access PCI config space before
> we've done a PCI bus scan and created pci_bus structures, so the pointer
> of bus will be NULL.

Hmm, this is a serious issue, and I don't have a good idea for how
to solve it yet, we need to discuss it some more I think.

We are currently working on generic PCI support for ARM64 with DT, which
will be based around the concept that all PCI host drivers can be loadable
modules, and each host driver would supply its own config space access
method.

With ACPI, we probably don't need the flexibility, because hopefully all
PCI host bridges will be SBSA compliant and have a regular ECAM config
space implementation (as opposed to the proprietary methods used by
e.g. APM X-Gene, Samsung GH7 or everything we have on ARM32).

If we can rely on always having ECAM support available, it would be
easy enough to add an implementation of that specifically for ACPI,
outside of the architecture code or the PCI core, or we could have
a global implementation of that, which gets used by both ACPI and
the compliant PCI host bridge drivers and can be built-in even for
loadable host drivers.

Alternatively, you could try to see if it's possible to defer the PCI
access to the time the host driver is loaded. Do you know what the access
to config space is actually needed for?

	Arnd
