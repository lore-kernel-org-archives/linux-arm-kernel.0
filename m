From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 14 Jan 2016 16:12:38 +0000
Subject: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
In-Reply-To: <5697C0EB.4020404@codeaurora.org>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452785393.28109.16.camel@redhat.com>
 <5697C0EB.4020404@codeaurora.org>
Message-ID: <20160114161238.GA20706@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 10:38:19AM -0500, Sinan Kaya wrote:
> On 1/14/2016 10:29 AM, Mark Salter wrote:
> On Wed, 2016-01-13 at 14:20 +0100, Tomasz Nowicki wrote:
> > IO resources on Mustang get disabled unless I do:
> > 
> > @@ -126,9 +126,10 @@ static void acpi_dev_ioresource_flags(struct
> > resource *res, u64 len, if (!acpi_dev_resource_len_valid(res->start,
> > res->end, len, true)) res->flags |= IORESOURCE_DISABLED |
> > IORESOURCE_UNSET;
> > 
> > +#if 0 if (res->end >= 0x10003) res->flags |= IORESOURCE_DISABLED |
> > IORESOURCE_UNSET; - +#endif
> > 
> > res->end is way beyond 0x10003 on Mustang:
> > 
> > pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus
> > address [0x10000000-0x1000ffff])
> > 
> > 
> 
> Join the club. I complained about this and I got the message that we
> just do what Intel does.  See Arnd Bergmann's reply.
> 
> [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
> hostbridge init based on ACPI
> 
> 1/12/2016 9:30 AM
> 
> It is an artificial limit coming from the x86 world introduced into
> common code.

Guys, I think you are mixing things up here, we discussed this to
death, read the archives please.

The ACPI IO descriptors AddressMinimum/AddressMaximum describe
the IO space PCI bus addresses. The AddressTranslation field
provides the PCI IO space -> CPU physical address translation, or
put it differently, the secondary to primary bus translation in
ACPI jargon, that's how ACPI tables must be written for IO space,
at least that's what IA64 does (and on ia64 IO space is memory
mapped, as on arm64).

I bet APM IO descriptors specify the *CPU* physical address in
the AddressMinimum field, and that's where the problem lies.

Jiang's patch:

https://lkml.org/lkml/2015/12/16/249

parses the IO descriptors and stores the AddressMinimum, AddressMaximum
in the IO resource (with AddressTranslation as offset which must be the
*CPU* physical address mapping IO), from the log above it seems to me in
AddressMinimum APM specifies the *CPU* physical address generating IO
cycles.

All in all, I was right to fear this would happen, and I already
raised the point within the ACPI spec working group, ACPI IO
descriptors specification is ambiguous and we must agree on how
they have to be specified once for all.

Lorenzo
