From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Dec 2012 16:23:25 +0000
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions
 in CONFIG_HAS_IOPORT
In-Reply-To: <201212111615.03262.arnd@arndb.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de> <20121211170338.4859ddf0@skate>
 <201212111615.03262.arnd@arndb.de>
Message-ID: <20121211162325.GR14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 04:15:02PM +0000, Arnd Bergmann wrote:
> On Tuesday 11 December 2012, Thomas Petazzoni wrote:
> > On Tue, 11 Dec 2012 10:43:49 +0000, Arnd Bergmann wrote:
> > > On Friday 07 December 2012, Thomas Petazzoni wrote:
> > > > The pcim_*() functions are used by the libata-sff subsystem, and this
> > > > subsystem is used for many SATA drivers on ARM platforms that do not
> > > > necessarily have I/O ports.
> > > 
> > > I think this one is wrong as the CONFIG_HAS_IOPORT does not refer to the
> > > presence of PIO ports but to whether or not they provide an ioport_map
> > > function. If there is no ioport_map(), devm_pci_iomap will fail to link
> > > as far as I can tell.
> > 
> > The problem is that on ARCH_MULTI_V7, ARCH_VEXPRESS is forcefully
> > enabled. And ARCH_VEXPRESS selects NO_IOPORT.. so you don't have the
> > pcim_*() functions, and therefore libata-sff.c (needed for many SATA
> > drivers) will not build. How do you solve this?
> 
> What you describe here are probable two bugs, and we should fix both:
> 
> * ARCH_VEXPRESS should not select NO_IOPORT. It's generally wrong
>   to select this in combination with ARCH_MULTIPLATFORM, when some
>   of the other platforms you may enable actually have IOPORT mapping
>   support.

No.  ARCH_VEXPRESS selects NO_IOPORT because it _does_ _not_ support
PCI/ISA IO space.  That in itself is reasonable, but what isn't
reasonable is the _negative_ logic being used.  Negative logic in
the config system always tends to provoke this kind of sillyness
because you're selecting something to be excluded which another
platform may require.

Positive logic is the only way to deal with this.

We should instead have HAVE_IOPORT and platforms which need ISA/PCI IO
space support should select this symbol instead - so it becomes an
_inclusive_ feature rather than an _exclusive_ feature.
