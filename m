From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 21:56:09 +0000
Subject: External initramfs again ... keep getting "overlaps in-use
	memory region"
In-Reply-To: <3d1967ab1002251323o630c3b33mb49e39270c1e2917@mail.gmail.com>
References: <3d1967ab1002250751t1ef512fehf69e3beb7f3f318e@mail.gmail.com>
	<3d1967ab1002250814q27ed0798l7e250f80c0db3fdb@mail.gmail.com>
	<20100225190913.GC3101@n2100.arm.linux.org.uk>
	<3d1967ab1002251323o630c3b33mb49e39270c1e2917@mail.gmail.com>
Message-ID: <20100225215609.GC24043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 04:23:57PM -0500, Brian Hutchinson wrote:
> > Give us all the information:
> >
> > - where exactly your memory is located and how large
> 
> ARM926EJS with 128M of DDR ... 4 banks of 32M, physical map configured as:
> 
> 0x00000000 - DDR Bank 0
> 0x04000000 - DDR Bank 1
> 0x08000000 - DDR Bank 2
> 0x0c000000 - DDR Bank 3

Ok.

> > - where you've tried putting your initrd image, and how large this is
> 
> The arch fixup is calling a function that does the following to setup
> memory ... passing "size" = 32M and "start"=start address of each DDR
> bank (given above).  The first 32M region is split funny though:
> 
>     meminfo->bank[meminfo->nr_banks].start = PAGE_ALIGN(start);
>     meminfo->bank[meminfo->nr_banks].size = size & PAGE_MASK;
>     meminfo->bank[meminfo->nr_banks].node = PHYS_TO_NID(start);
>     meminfo->nr_banks++;
> 
> The way the code is called it looks like it sets up 16M region
> (0x0-0x01ffffff), then skips 16M (0x02000000-0x07ffffff) (I don't know
> why ... yet) then the last three 32M regions are contiguous (see
> kernel messages below).

Given what you've said above, this seems to be in disagreement with
the physical layout.  If there are aliases of the DDR between these
banks, this is going to lead to very strange behaviour or even oopses
from the kernel.

> #1. For the case where I tftp my initramfs_data.cpio.gz to RAM at
> address 0x02000000 (the hole I mentioned above), I get the following
> kernel messages when I boot with command line of
> initrd=0x2000000,0xc8bdb6 (cpio.gz is around 13M compressed and
> uncompressed the cpio is 34M.  It is outside physical memory so this
> makes sense.

Yes - there's various reasons why we expect the initrd to be real valid
memory which has been declared to the kernel, most notably that it is
freed back into the kernel's free page pool.

> #2.  For the case where I tftp my initramfs_data.cpio.gz to RAM at
> address 0x04000000 (start of second 32M DDR region), I get the
> following kernel messages when I boot with command line of
> initrd=0x4000000,0xc8bdb6 (Same cpio image as used above) ... cpio.gz
> is around 13M compressed and uncompressed the cpio is 34M:
> 
> Starting kernel ...
> 
> Uncompressing Linux..........................................................................................................
> done, booting the kernel.
> Linux version 2.6.28-picochip-3.2.0 (hutch at hutch-laptop) (gcc version
> 4.2.2) #10 PREEMPT Thu Feb 25 09:22:49 EST 2010
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: pc7205-2 1.0. Rev B BOM
> Memory policy: ECC disabled, Data cache writeback
> INITRD: 0x04000000+0x00c8bdb6 overlaps in-use memory region - disabling initrd

Right - I see you're using discontigmem.  Don't.  Really, it's not
worth the overhead and additional expenses - plus you're running into
one of the problems with it right here.

Each node of discontigmem has its own free page data, and this gets
placed at the start of each node, with the exception of node 0 (since
that contains the kernel.)

This means your initrd is being overwritten by the free page data for
the second node.

If you use sparsemem, then everything ends up in 'node 0' because there
is no other node - and the free page data gets all lumped together.

I highly recommend sparsemem - the run-time overheads are lower than
discontigmem.  Discontigmem is designed for NUMA architectures, where
there is a non-uniform cost to allocating memory from non-local nodes.
Sparsemem is designed for non-contiguous memory where the cost is
equal.
