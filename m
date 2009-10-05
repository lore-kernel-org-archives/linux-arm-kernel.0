From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 5 Oct 2009 14:52:39 -0400
Subject: [PATCH v1.0 4/4] MM: Switch TS72XX to use sparemem
In-Reply-To: <4ACA3807.9050908@techworks.ie>
References: <20091004011413.12578.89897.stgit@localhost.localdomain><20091004011434.12578.76922.stgit@localhost.localdomain>
	<4AC9E4B8.1040208@techworks.ie>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7687@mi8nycmail19.Mi8.com>
	<4ACA3807.9050908@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB76E6@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 05, 2009 11:17 AM, Christian Gagneraud wrote:
> H Hartley Sweeten wrote:
>> On Monday, October 05, 2009 5:21 AM, Christian Gagneraud wrote:
>>> Hi,
>>>
>>> What people think about enabling sparsemem on EP93XX? I know this 
>>> patch as it is will break all but this board.
>>>
>>> Can we define defaults SECTION_SIZE_BITS and MAX_PHYSMEM_BITS that 
>>> will suit all the supported boards?
>> 
>> With sparsemem enabled what is your memory detected during boot?  For
>> instance on my ep9307 based system with flatmem I get:
>> 
>> Memory: 32MB 32MB = 64MB total
>> Memory: 44552KB available (3452K code, 254K data, 124K init, 0K highmem)
>           ^^^^^
> Are you missing 16MB?

No.  My rootfs is in /dev/ram and uses the remaining space.

> Here is what i get with sparsemem:
> 
> Memory: 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB = 64MB total 
> 
> Memory: 63264KB available (1252K code, 231K data, 64K init, 0K highmem)
>
> 00000000-007fffff : System RAM 
>   00020000-00276fff : Kernel text 
>   00278000-002c1923 : Kernel data 
> 01000000-017fffff : System RAM 
> 04000000-047fffff : System RAM 
> 05000000-057fffff : System RAM
> e0000000-e07fffff : System RAM 
> e1000000-e17fffff : System RAM 
> e4000000-e47fffff : System RAM 
> e5000000-e57fffff : System RAM
>
> For boards shipped with 32MB, there's one 32MB chip on SD_CS3 that 
> shows at 0x00000000, for boards shipped with 64MB there's another 32MB 
> chip on SD_CS2 which pop up at 0xe0000000

OK.  That makes sense.  I was under the impression that the 64MB board
was using a single chip select.
 
> That's for the models that offer 32 or 64MB, but TS have other models 
> that offer 64 or 128MB, these boards are designed the same way: 1 64MB 
> chip on SD_CS3 and optional a second 64MB chip on SD_CS2.
> I was told that in that case 16 banks needed to be define (and btw it 
> couldn't be handled , I didn't check it yet.

The single chip 64MB board would work fine but it would use 8 banks.  The
128MB board would be a problem with flatmem because of the 16 banks.  In
order to support this NR_BANKS would have to be increased in
arch/arm/include/asm/setup.h.

> Before sparsemem, we had to use discontigmem (and patch it),now with 
> parsemem there's no needs for such a thing anymore, the only needed 
> bits are 4 #define.

Sparsemem is probably a good solution for the multiple chip selects.  But
we need to make sure that any solution used works for all ep93xx variants.

The ep93xx has 4 sdram chip-selects but, because of the ASDO (sync/async)
boot, there are 5 possible base addresses for them.  Then, depending on
the bus width and the density of memory used, the node mapping for each
bank can vary greatly.  Even worse, node mapping changes depending on the
SROMLL bit.  The document referenced below has all the information needed
but at this point I don't know of a good solution.

> http://arm.cirrus.com/files/HOWTO/EP93xx%20SDRAM%20Address%20Ranges.pdf

Maybe Russell can help (Cced).

Regards,
Hartley
