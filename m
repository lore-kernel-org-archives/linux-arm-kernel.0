From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Dec 2012 16:15:02 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20121211170338.4859ddf0@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de> <20121211170338.4859ddf0@skate>
Message-ID: <201212111615.03262.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 December 2012, Thomas Petazzoni wrote:
> On Tue, 11 Dec 2012 10:43:49 +0000, Arnd Bergmann wrote:
> > On Friday 07 December 2012, Thomas Petazzoni wrote:
> > > The pcim_*() functions are used by the libata-sff subsystem, and this
> > > subsystem is used for many SATA drivers on ARM platforms that do not
> > > necessarily have I/O ports.
> > 
> > I think this one is wrong as the CONFIG_HAS_IOPORT does not refer to the
> > presence of PIO ports but to whether or not they provide an ioport_map
> > function. If there is no ioport_map(), devm_pci_iomap will fail to link
> > as far as I can tell.
> 
> The problem is that on ARCH_MULTI_V7, ARCH_VEXPRESS is forcefully
> enabled. And ARCH_VEXPRESS selects NO_IOPORT.. so you don't have the
> pcim_*() functions, and therefore libata-sff.c (needed for many SATA
> drivers) will not build. How do you solve this?

What you describe here are probable two bugs, and we should fix both:

* ARCH_VEXPRESS should not select NO_IOPORT. It's generally wrong
  to select this in combination with ARCH_MULTIPLATFORM, when some
  of the other platforms you may enable actually have IOPORT mapping
  support.

* We should not unconditionally select ARCH_VEXPRESS from ARCH_MULTIPLATFORM.
  There is no reason why we would enable that platform for building
  a kernel that runs on only one other platform.

> I'm not sure which devm_pci_iomap() you're referring to since my patch
> makes only the pcim_iomap_table(), pcim_iomap(), pcim_iounmap(),
> pcim_iomap_regions(), pcim_iomap_regions_request_all() and
> pcim_iounmap_regions() available under CONFIG_PCI instead of CONFIG_PCI
> && CONFIG_HAS_IOPORT.

Sorry, I meant pcim_iomap.

> So maybe you were referring to pcim_iomap(). I haven't checked in
> details, but I guess it builds because ioport_map() is implemented in
> arch/arm/mm/iomap.c.

Right. If an ioport_map function is provided for a given platform,
we should also set HAVE_IOPORT and vice versa. This is probably
fallout of the io.h conversion for multiplatform.

	Arnd
