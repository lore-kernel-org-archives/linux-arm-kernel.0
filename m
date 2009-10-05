From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 5 Oct 2009 13:06:44 -0400
Subject: [PATCH v1.0 4/4] MM: Switch TS72XX to use sparemem
In-Reply-To: <4AC9E4B8.1040208@techworks.ie>
References: <20091004011413.12578.89897.stgit@localhost.localdomain><20091004011434.12578.76922.stgit@localhost.localdomain>
	<4AC9E4B8.1040208@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7687@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 05, 2009 5:21 AM, Christian Gagneraud wrote:
> Hi,
> 
> What people think about enabling sparsemem on EP93XX? I know this 
> patch as it is will break all but this board.
> 
> Can we define defaults SECTION_SIZE_BITS and MAX_PHYSMEM_BITS that 
> will suit all the supported boards?

With sparsemem enabled what is your memory detected during boot?  For
instance on my ep9307 based system with flatmem I get:

Memory: 32MB 32MB = 64MB total
Memory: 44552KB available (3452K code, 254K data, 124K init, 0K highmem)

And cat /proc/iomem shows:

c0000000-c1ffffff : System RAM
  c0027000-c0385fff : Kernel text
  c03a0000-c03df88f : Kernel data
c4000000-c5ffffff : System RAM

So the kernel finds two 32MB chunks which is what the bootloader passed
in the ATAGS.  And the addresses match what was passed.

What is your intended result by switching to sparsemem?

I have also messed with sparsemem and I get the same results as above
with it enabled.  I don't see any real reason to switch to sparsemem.

The _only_ reason I can see is if a system has more than 8 banks of
memory.  I think that is the current limit for flatmem support in the
kernel.  There are only two configuration I know of that can cause this
on the ep93xx when only on chip select is used:

512 Mbit (16-bit wide device) = 64 MBytes with SROMLL = 0 -> 16 banks
512 Mbit (2 x 16-bit wide device) = 128 Mbytes with SROMLL = 0 -> 16 banks

Both of these configuration can be "fixed" by having the bootloader set
the SROMLL bit = 1. 

512 Mbit (16-bit wide device) = 64 MBytes with SROMLL = 1 -> 8 banks
512 Mbit (2 x 16-bit wide device) = 128 Mbytes with SROMLL = 1 -> 1 bank

Please refer to the following document for more information:

http://arm.cirrus.com/files/HOWTO/EP93xx%20SDRAM%20Address%20Ranges.pdf

Regards,
Hartley
