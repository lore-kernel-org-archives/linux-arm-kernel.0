From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 09:49:53 -0700
Subject: [PATCH 02/14] omap: Make uncompress code and DEBUG_LL code generic
In-Reply-To: <4BDB0353.5090800@ti.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
	<20100126201239.15382.34792.stgit@baageli.muru.com>
	<1272640022.3051.1534.camel@localhost> <4BDB0353.5090800@ti.com>
Message-ID: <20100430164953.GD29604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cyril Chemparathy <cyril@ti.com> [100430 09:22]:
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
>     - move the uart base lookup logic to addruart using macros similar
>       to DEBUG_LL_*, except that these expand to assembly code this
>       time.
>     - reuse these debug-macros in uncompress.h and implement putc() and
>       flush() using addruart(), senduart(), etc.
> 
> This way, both the decompresser and the kernel debug macros end up using
> machine_arch_type to get to the right debug uart, without resorting to
> underhand back-channel tricks.
> 
> Any thoughts?

Sounds good to me. There's already the tmp register added to addruart
that can be used for passing the machine id to addruart.

Regards,

Tony
