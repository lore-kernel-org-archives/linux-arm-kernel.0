From: david@gibson.dropbear.id.au (David Gibson)
Date: Thu, 25 Mar 2010 19:40:53 -0400
Subject: RFC: ARM Boot standard for passing device tree blob
In-Reply-To: <20100325210409.GH24984@n2100.arm.linux.org.uk>
References: <fa686aa41003240811l6f40c8cfs6fdad496facdc089@mail.gmail.com>
	<20100325210409.GH24984@n2100.arm.linux.org.uk>
Message-ID: <20100325234053.GB26649@yookeroo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 09:04:09PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 24, 2010 at 09:11:56AM -0600, Grant Likely wrote:
> > Hi all,
> > 
> > Since work is being done to add ARM Flattened Device Tree support to
> > both Linux and FreeBSD, I think it would be worth while to agree on a
> > common boot interface for passing a device tree blob from firmware to
> > the kernel (or in the case of kexec, from the old to new kernels).
> > I've drafted up something quickly on fdt.secretlab.ca.  The page can
> > be found here:
> > 
> > http://fdt.secretlab.ca/Boot_Environment#ARM
> > 
> > Feel free to modify the draft on the wiki if you notice any missing
> > details.  I've also posted the current text below so it is easy to
> > review and comment on.
> > 
> > (btw, the wiki at fdt.secretlab.ca should be moving to devicetree.org
> > in the near future, but I'll keep the old domain name around.
> > devicetree.org will be used to document new device tree bindings in an
> > OS-agnostic location.)
> > 
> > 
> > == ARM ==
> > See Documentation/arm/Booting and arch/arm/include/asm/setup.h in the
> > Linux kernel source tree for background information.  Some of the
> > content of this section is extracted from those files.
> > 
> > '''Draft'''
> > 
> > ===Required System State===
> > *Quiesce all DMA
> > *CPU register contents
> > **r0 = 0
> > **r1 = Linux machine number (as defined in the ARM Linux machine database) or 0
> 
> 0 is a valid machine number.  What is your purpose of passing 0?

Presumably a machine number will need to be allocated to mean "use the
device tree instead of fixed machine number info".

> > **r2 = physical address of tagged parameter list in system RAM
> > *IRQs disabled
> > *MMU off
> > *Instruction cache either on or off
> > *Data cache turned off
> 
> Would recommend saying "Data cache(s) turned off" so that L2 cache is
> included.
> 
> > ===Minimal state for Flattened Device Tree Boot===
> > For FDT booting, the tagged list only needs to contain a single device
> > tree tag, and the device tree blob could be appended to the end of the
> > tagged list so that everything resides in the same region of memory.
> 
> That's a bad idea.  Sometimes the tagged list can be extended by wrappers
> around the kernel, and data placed at the end of the list would be
> overwritten.
> 
> As the tagged list can encode arbitarily sized data chunks, there's no
> reason to use a pointer in the tagged list.  However, there is a problem:
> what do you do with a large chunk of data in the tagged list?  You can't
> allocate memory to copy it in the kernel because no memory allocators
> are up and running...

It's not clear that you'll need to copy it particularly soon.  The
libfdt functions we use in the zImage wrapper on powerpc will deal
fine with a device tree accessed in place, or moved about.  They are
built specifically not to assume the existence of an allocater.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
