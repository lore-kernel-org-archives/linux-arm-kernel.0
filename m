From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 12:16:31 +0100
Subject: [PATCH] ARM: Versatile Express: Add default memory layout
In-Reply-To: <1279797089.9564.21.camel@e102109-lin.cambridge.arm.com>
References: <20100721165509.26047.70564.stgit@e102109-lin.cambridge.arm.com>
	<20100722103038.GE31293@n2100.arm.linux.org.uk>
	<1279796069.9564.2.camel@e102109-lin.cambridge.arm.com>
	<20100722105729.GK31293@n2100.arm.linux.org.uk>
	<1279797089.9564.21.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100722111631.GM31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 12:11:29PM +0100, Catalin Marinas wrote:
> On Thu, 2010-07-22 at 11:57 +0100, Russell King - ARM Linux wrote:
> > On Thu, Jul 22, 2010 at 11:54:29AM +0100, Catalin Marinas wrote:
> > > On Thu, 2010-07-22 at 11:30 +0100, Russell King - ARM Linux wrote:
> > > > On Wed, Jul 21, 2010 at 05:55:09PM +0100, Catalin Marinas wrote:
> > > > > Since this platform is known to have 1GB of RAM at 0x60000000, add a
> > > > > .fixup function to set the defaults in case no "mem=" option is passed
> > > > > on the kernel command line.
> > > >
> > > > And the reason why uboot can't pass the RAM information to the kernel
> > > > is...
> > >
> > > It needs implementing, or ask the user to pass it on the kernel command
> > > line. For the latter, I think it would be nicer if the kernel has some
> > > sane defaults.
> > 
> > The kernel does have some sane _safe_ defaults - it assumes that there's
> > at least 16M of RAM.
> 
> That's only during the initial MMU setup. Afterwards it cannot allocate
> any memory without a proper mem= parameter or ATAG.

That's because uboot passes a tagged list without any ATAG_MEM entries.
If it passed no tagged list, then the defaults will be used.  If it
passed the ATAG_MEM entry, it'd also work.

But as it does neither, it falls into the hole.

The kernel boot requirements document has for the last _8_ years said:

   The boot loader must pass at a minimum the size and location of the system
   memory, and root filesystem location. Therefore, the minimum tagged list
   should look:

           +-----------+
   base -> | ATAG_CORE |  |
           +-----------+  |
           | ATAG_MEM  |  | increasing address
           +-----------+  |
           | ATAG_NONE |  |
           +-----------+  v

and still u-boot gets it wrong...  Now tell me why I hate boot loaders
soo much.
