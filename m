From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 25 Feb 2016 12:07:50 +0000
Subject: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
 HiSilicon SoCs Host Controllers
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECCD209@lhreml503-mbs>
References: <1455039260-6040-4-git-send-email-gabriele.paoloni@huawei.com>
 <20160209182429.GD4348@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1591@lhreml503-mbs>
 <20160210111234.GC2632@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1D30@lhreml503-mbs>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECC5F00@lhreml503-mbs>
 <20160224011418.GB13026@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECCAD6A@lhreml503-mbs>
 <20160224152538.GA19700@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECCD209@lhreml503-mbs>
Message-ID: <20160225120750.GA32016@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 03:01:19AM +0000, Gabriele Paoloni wrote:

[...]

> > I think the relevant spec is the PCI Firmware Spec, r3.0, sec 4.1.2.
> > Note 2 in that section says the address range of an MMCFG region
> > must be reserved by declaring a motherboard resource, i.e., included
> > in the _CRS of a PNP0C02 or similar device.
> 
> I had a look a this. So yes the specs says that we should use the 
> PNP0C02 device if MCFG is not supported. 

AFAIK, PNP0C02 is a resource reservation mechanism, the spec says that
MCFG regions must be reserved using PNP0C02, even though its
current usage on x86 is a bit unfathomable to me, in particular
in relation to MCFG resources retrieved for hotpluggable bridges (ie
through _CBA, which I think consider the MCFG region as reserved
by default, regardless of PNP0c02):

see pci_mmcfg_check_reserved() arch/x86/pci/mmconfig-shared.c

Have a look at drivers/pnp/system.c for PNP0c02

> So probably I can use acpi_get_devices("PNP0C02",...) to retrieve it
> from the quirk match function, I will look into this... 
> 
> > 
> > > On the other side, since this is an exception only for the config
> > > space address of our host controller (as said before all the buses
> > > below the root one support ECAM), I think that it is right to put
> > > this address as a device specific data (in fact the rest of the
> > > config space addresses will be parsed from MCFG).
> > 
> > A kernel with no support for your host controller (and thus no
> > knowledge of its _DSD) should still be able to operate the rest of the
> > system correctly.  That means we must have a generic way to learn what
> > address space is consumed by the host controller so we don't try to
> > assign it to other devices.
> 
> This is something I don't understand much...
> Are you talking about a scenario where we have a Kernel image compiled
> without our host controller support and running on our platform?

I *think* the point here is that your host controller config space should be
reserved through PNP0c02 so that the kernel will reserve it through the
generic PNP0c02 driver even if your host controller driver (and related
_DSD) is not supported in the kernel.

I do not understand how PNP0c02 works, currently, by the way.

If I read x86 code correctly, the unassigned PCI bus resources are
assigned in arch/x86/pci/i386.c (?) fs_initcall(pcibios_assign_resources),
with a comment:

/**
 * called in fs_initcall (one below subsys_initcall),
 * give a chance for motherboard reserve resources
 */

Problem is, motherboard resources are requested through (?):

drivers/pnp/system.c

which is also initialized at fs_initcall, so it might be called after
core x86 code reassign resources, defeating the purpose PNP0c02 was
designed for, namely, request motherboard regions before resources
are assigned, am I wrong ?

As per last Tomasz's patchset, we claim and assign unassigned PCI
resources upon ACPI PCI host bridge probing (which happens at
subsys_initcall time, courtesy of ACPI current code); at that time the
kernel did not even register the PNP0c02 driver (drivers/pnp/system.c)
(it does that at fs_initcall). On the other hand, we insert MCFG
regions into the resource tree upon MCFG parsing, so I do not
see why we need to rely on PNP0c02 to do that for us (granted, the
mechanism is part of the PCI fw specs, which are x86 centric anyway
ie we can't certainly rely on Int15 e820 to detect reserved memory
on ARM :D)

There is lots of legacy x86 here and Bjorn definitely has more
visibility into that than I have, the ARM world must understand
how this works to make sure we have an agreement.

Thanks,
Lorenzo
