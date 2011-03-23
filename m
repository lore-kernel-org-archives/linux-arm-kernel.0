From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Mar 2011 20:03:53 +0000
Subject: multiple definition of show_mem for pxa
In-Reply-To: <4D89F000.1070509@cam.ac.uk>
References: <4D89F000.1070509@cam.ac.uk>
Message-ID: <20110323200353.GA9844@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 01:05:04PM +0000, Jonathan Cameron wrote:
> Hi all
> 
> Can't immediately track down what changed to cause this issue, but
> building with current mainline is giving me:
> 
> lib/lib.a(show_mem.o): In function `show_mem':
> show_mem.c:(.text+0x13c): multiple definition of `show_mem'
> arch/arm/mm/built-in.o:copypage-xscale.c:(.text+0xfcc): first defined here
> make: *** [vmlinux.o] Error 1
> 
> 
> Anyone know what caused this?
> 
> There are indeed two versions of mem_info, the generic one and one
> in arch/arm/mm/init.c but I think they have both been around for
> some time without issue.

The generic one doesn't work on ARM, and it's supposed to override the
generic one.  It seems that ddd588b5dd55f14320379961e47683db4e4c1d90
causes the generic one to be pulled in due to a reference to __show_mem()
which then causes show_mem() to be defined twice.

The change in lib/show_mem.c needs to also be ported to ARMs own version.
