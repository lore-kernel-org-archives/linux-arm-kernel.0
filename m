From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Apr 2010 18:18:02 +0100
Subject: [PATCH 02/14] omap: Make uncompress code and DEBUG_LL code generic
In-Reply-To: <4BDB0353.5090800@ti.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
	<20100126201239.15382.34792.stgit@baageli.muru.com>
	<1272640022.3051.1534.camel@localhost> <4BDB0353.5090800@ti.com>
Message-ID: <20100430171802.GB1639@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 30, 2010 at 12:20:35PM -0400, Cyril Chemparathy wrote:
> Hi,
> 
> [...]
> > To fix both problems, maybe we should just use a fixed memory location
> > to pass this temporary data from uncompress to the kernel.  We've had a
> > similar problem on DaVinci recently and a proposal has been made (and
> > tested) to use memory just below the page tables[3].)
> 
> Essentially both of these approaches (internal scratch register and
> fixed address) implement a weird back-channel communication scheme
> between the decompresser and the debug macros.
> 
> A more elegant solution may be as follows:
>     - pass machine_arch_type as an argument into addruart.

Unfortunately, that breaks addruart.  Firstly, addruart is used from
assembly code where very limited registers are available (the fewer
registers it clobbers the less likely debug is going to cause stuff
to break.)

Secondly, the places that addruart may be called from, the location
of the machine type number is indeterminent.  Remember that this
macro can be called when the MMU is on or off, and can be called
before the machine_arch_type has been initialized.

>     - move the uart base lookup logic to addruart using macros similar
>       to DEBUG_LL_*, except that these expand to assembly code this
>       time.
>     - reuse these debug-macros in uncompress.h and implement putc() and
>       flush() using addruart(), senduart(), etc.

Given what I've said above about the debug macros, this is definitely the
wrong solution.

Having the decompressor macros work whatever the machine type is
reasonable, and the machine_is_xxx() macros already work at that point,
so there shouldn't be much of an issue there.

As far as the debug macros go, I think we're at the point where it's
basically just far easier to leave these macros as a developer debugging
tool and we'll just have to put up with it being something that an OMAP
developer has to edit according to his platform to make work.

After all, _NO_ production kernel what so ever should be using this
debug support.
