From: liviu@dudau.co.uk (Liviu Dudau)
Date: Wed, 19 Feb 2014 02:44:27 +0000
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140218174125.GC29304@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <5805232.JrD2FybBlg@wuerfel>
 <20140214220047.GA5394@bart.dudau.co.uk>
 <2312919.pM61KLBcYY@wuerfel>
 <20140218174125.GC29304@obsidianresearch.com>
Message-ID: <20140219024427.GC5394@bart.dudau.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 10:41:25AM -0700, Jason Gunthorpe wrote:
> On Sat, Feb 15, 2014 at 02:03:26PM +0100, Arnd Bergmann wrote:
> 
> > Can anyone with more experience on the subject than me (Bjorn,
> > Russell, Jason, ...) think of a reason why we would not want to
> > just use a new domain for every host bridge we find?
> 
> I personaly think we can safely move away from stuffing multiple host
> bridges into a single domain for DT cases. The reasons for doing this
> have long since been superseded.
> 
> Most importantly, I have a feeling keeping a 1:1 relationship between
> domain and driver will making building a proper modular and hot
> pluggable host driver infrastructure in the PCI core significantly
> simpler. The domain object gives a nice natural place to put things in
> sysfs, a natural place to keep function pointers and avoids all the
> messy questions of what happens if probing overlaps bus numbers, how
> do you number things, how do you hot plug downstream busses, etc.
> 
> Having a PCI core driver infrastructure that supports both 'as a
> domain' and 'as a bunch of busses' seems much more complex, and I
> can't really identify what is being gained by continuing to support
> this.
> 
> As far as I know the host bridge stuffing is something that was
> created before domains to solve the problem on embedded of multiple
> PCI host bridges on a SOC/System Controller. I know I have used it
> that way in the distant past (for MIPS).
> 
> However today PCI-SIG has a standard way to describe multi-port
> root-complexes in config space, so we should not need to use the
> multi-bus hack. SOCs with non-compliant HW that *really* need single
> domain can get there: mvebu shows how to write a driver that provides
> a software version of the missing hardware elements. Pushing mess like
> this out of the core code seems like a good strategy.
> 
> The only reason I can think of to avoid using a domain is if Linux has
> to interface with external firmware that uses bus:device.function
> notation for coding information. (eg Intel-MP tables on x86 encode
> interrupt routing use B:D.F) In this case Linux would need a way to
> map between Linux B:D.F and the Firwmare B:D.F, or it would need to
> use the Firmware B:D.F layout. But this argument does not apply to DT
> systems as DT encodes the domain too. Presumably ACPI will be the
> same.
> 
> Also, bear in mind we now already have multi-domain host drivers for
> ARM, so the multi-platform kernels need to have this option turned on.
> 
> So the Liviu, I would say the API should be similar to what we see in
> other OF enabled driver bases subsystems, call the core code with a
> platform_device pointer and function_ops pointer and have the core
> code create a domain, figure out the domain # from the DT (via
> aliases?), and so on.

I wish things were easier!

Lets look at the 'int pci_domain_nr(struct pci_bus *bus);' function. It is
used to obtain the domain number of the bus passed as an argument.

- include/linux/pci.h defines it as an inline function returning zero if
  !CONFIG_PCI || !CONFIG_PCI_DOMAINS. Otherwise it is silent on what the
  function might look like.

- alpha, ia64, microblaze, mips, powerpc and tile all define it as a cast
  of bus->sysdata to "struct pci_controller *" and then access a data
  member from there to get the domain number. But ... the pci_controller
  structure is different for each architecture, with few more members in
  addition that might be actually shared with generic framework code.

- arm, s390, sparc and x86 have all different names for their sysdata,
  but they all contain inside a member that is used for giving a domain
  back. sparc gets an honorary mention here for getting the API wrong
  and returning -ENXIO in certain conditions (not like the generic code
  cares).

That takes care of the implementation. But what about usage?

- drivers/pci/probe.c: pci_create_root_bus allocates a new bus structure,
  sets up the sysdata and ops member pointers and then goes straight
  into trying to find if the newly created bus doesn't already exist by
  using the bus number given as parameter and pci_domain_nr() with the
  new bus structure as argument. I'm trying really hard to figure out
  what was the intention here, but from the point of view of someone
  trying to implement the pci_domain_nr() function I have no idea what
  to return for a virgin bus structure that is not yet attached to any
  parent.

So I can see the intent of what Jason is proposing and I'm heading that
way myself, but I think I need to cleanup pci_create_root_bus first
(change the creation order between bridge and bus). And if someone has
a good idea on how to determine the domain # from DT we can pluck it
into the pcibios_root_bridge_prepare() function (either the generic
version or the arch specific one).

Best regards,
Liviu


> 
> Jason
> 
