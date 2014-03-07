From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Mar 2014 01:37:38 +0100
Subject: [PATCH v6 1/3] Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
In-Reply-To: <20140305233135.GZ21483@n2100.arm.linux.org.uk>
References: <1394020150-1875-1-git-send-email-Liviu.Dudau@arm.com>
 <1394020150-1875-2-git-send-email-Liviu.Dudau@arm.com>
 <20140305233135.GZ21483@n2100.arm.linux.org.uk>
Message-ID: <201403070137.38621.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 March 2014, Russell King - ARM Linux wrote:
> On Wed, Mar 05, 2014 at 11:49:08AM +0000, Liviu Dudau wrote:
> > The inline version of ioport_map() that gets used when !CONFIG_GENERIC_IOMAP
> > is wrong. It returns a mapped (i.e. virtual) address that can start from
> > zero and completely ignores the PCI_IOBASE and IO_SPACE_LIMIT that most
> > architectures that use !CONFIG_GENERIC_MAP define.
> 
> What value does PCI_IOBASE and IO_SPACE_LIMIT have on other architectures
> who make use of asm-generic/io.h ?
> 
> $ git grep asm-generic/io.h arch/
> arch/arc/include/asm/io.h:#include <asm-generic/io.h>

PCI support hasn't been upstreamed.

> arch/blackfin/include/asm/io.h:#include <asm-generic/io.h>
> arch/metag/include/asm/io.h:#include <asm-generic/io.h>

No PCI support

> arch/microblaze/include/asm/io.h:/* from asm-generic/io.h */

PCI_IOBASE=0, IO_SPACE_LIMIT=0xffffffff, so no change.

> arch/openrisc/include/asm/io.h:#include <asm-generic/io.h>

No PCI support

> arch/s390/include/asm/io.h:#include <asm-generic/io.h>

s390 supports PCI but no I/O space

> arch/score/include/asm/io.h:#include <asm-generic/io.h>

No PCI support

> arch/unicore32/include/asm/io.h:#include <asm-generic/io.h>

unicore32 is broken currently, the patch fixes it.

> arch/xtensa/include/asm/io.h:#include <asm-generic/io.h>

PCI_IOBASE=0, IO_SPACE_LIMIT=0xffffffff, so no change.

For most of these, I assume we actually want to remove support
for inb/outb as they don't support I/O space accesses. The other
ones look correct to me.

	Arnd
