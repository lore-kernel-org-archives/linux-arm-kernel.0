From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 05 May 2014 16:35:46 +0800
Subject: [PATCH v3 part1 08/11] ARM64 / ACPI: Introduce PCI functions
 for ACPI on ARM64
In-Reply-To: <8888740.lgd2Xkrtad@wuerfel>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <201404281549.50738.arnd@arndb.de> <535F6675.1060109@linaro.org>
 <8888740.lgd2Xkrtad@wuerfel>
Message-ID: <53674D62.5020004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Rafael,

Sorry for the late reply, I was on holidays...

I send this email directed to Rafael to ask for help, please
refer to the comments below.

On 2014-4-29 18:01, Arnd Bergmann wrote:
[...]
>>> For raw_pci_{read,write} we can have a trivial generic implementation in
>>> the PCI core, like
>>>
>>> int __weak raw_pci_read(unsigned int domain, unsigned int bus,
>>> 		  unsigned int devfn, int reg, int len, u32 *val)
>>> {
>>> 	struct pci_bus *bus = pci_find_bus(domain, bus);
>>> 	if (!bus)
>>> 		return -ENODEV;
>>>
>>> 	return bus->ops->read(bus, devfn, reg, len, val);
>>> }
>>>
>>> which won't work on x86 or ia64, but should be fine everywhere else. Alternatively,
>>> you can change the ACPI code to do the above manually and call the architecture
>>> independent interfaces, either bus->ops->read, or pci_bus_read_config_{byte,word,dword},
>>> which would actually simplify the ACPI code.
>>
>> This may not work. ACPI needs to be able to access PCI config space before
>> we've done a PCI bus scan and created pci_bus structures, so the pointer
>> of bus will be NULL.
> 
> Hmm, this is a serious issue, and I don't have a good idea for how
> to solve it yet, we need to discuss it some more I think.
> 
> We are currently working on generic PCI support for ARM64 with DT, which
> will be based around the concept that all PCI host drivers can be loadable
> modules, and each host driver would supply its own config space access
> method.

this will be the problem, ACPI may access config space before modules are
loaded.

> 
> With ACPI, we probably don't need the flexibility, because hopefully all
> PCI host bridges will be SBSA compliant and have a regular ECAM config
> space implementation (as opposed to the proprietary methods used by
> e.g. APM X-Gene, Samsung GH7 or everything we have on ARM32).
> 
> If we can rely on always having ECAM support available, it would be
> easy enough to add an implementation of that specifically for ACPI,
> outside of the architecture code or the PCI core, or we could have
> a global implementation of that, which gets used by both ACPI and
> the compliant PCI host bridge drivers and can be built-in even for
> loadable host drivers.
> 
> Alternatively, you could try to see if it's possible to defer the PCI
> access to the time the host driver is loaded. Do you know what the access
> to config space is actually needed for?

There is a statement in ACPI 5.0a spec:
OSPM must guarantee that the following operation regions must always be
accessible (which means even before the driver is ready):
PCI_Config operation regions on a PCI root bus containing a _BBN object.
(invoke _BBN method will return PCI bus number)

And raw_pci_{read,write} will be called in ACPICA to access the PCI_Config
to get some information, so theoretic any device defined in DSDT with
PCI_Config operation region which be enumerated before PCI host bridge will
access config space before the PCI bus scan.

But I haven't find any specific example, I must missed something, Rafael,
could you please comment this?

Thanks
Hanjun
