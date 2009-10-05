From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Mon, 05 Oct 2009 19:16:39 +0100
Subject: [PATCH v1.0 4/4] MM: Switch TS72XX to use sparemem
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7687@mi8nycmail19.Mi8.com>
References: <20091004011413.12578.89897.stgit@localhost.localdomain><20091004011434.12578.76922.stgit@localhost.localdomain>
	<4AC9E4B8.1040208@techworks.ie>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7687@mi8nycmail19.Mi8.com>
Message-ID: <4ACA3807.9050908@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> On Monday, October 05, 2009 5:21 AM, Christian Gagneraud wrote:
>> Hi,
>>
>> What people think about enabling sparsemem on EP93XX? I know this 
>> patch as it is will break all but this board.
>>
>> Can we define defaults SECTION_SIZE_BITS and MAX_PHYSMEM_BITS that 
>> will suit all the supported boards?
> 
> With sparsemem enabled what is your memory detected during boot?  For
> instance on my ep9307 based system with flatmem I get:
> 
> Memory: 32MB 32MB = 64MB total
> Memory: 44552KB available (3452K code, 254K data, 124K init, 0K highmem)
           ^^^^^
Are you missing 16MB?

Here is what i get with sparsemem:

Memory: 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB = 64MB total 

Memory: 63264KB available (1252K code, 231K data, 64K init, 0K highmem)

> And cat /proc/iomem shows:
> 
> c0000000-c1ffffff : System RAM
>   c0027000-c0385fff : Kernel text
>   c03a0000-c03df88f : Kernel data
> c4000000-c5ffffff : System RAM


00000000-007fffff : System RAM 

   00020000-00276fff : Kernel text 

   00278000-002c1923 : Kernel data 

01000000-017fffff : System RAM 

04000000-047fffff : System RAM 

05000000-057fffff : System RAM
80010000-8001ffff : ep93xx-eth 

   80010000-8001ffff : ep93xx-eth 

80020000-80020fff : ep93xx-ohci 

808c0000-808c0fff : apb:uart1 

   808c0000-808c003f : uart-pl010 

808d0000-808d0fff : apb:uart2 

   808d0000-808d003f : uart-pl010 

808e0000-808e0fff : apb:uart3 

   808e0000-808e003f : uart-pl010 

80920000-8092010b : ep93xx-rtc
e0000000-e07fffff : System RAM 

e1000000-e17fffff : System RAM 

e4000000-e47fffff : System RAM 

e5000000-e57fffff : System RAM


For boards shipped with 32MB, there's one 32MB chip on SD_CS3 that 
shows at 0x00000000, for boards shipped with 64MB there's another 32MB 
chip on SD_CS2 which pop up at 0xe0000000

That's for the models that offer 32 or 64MB, but TS have other models 
that offer 64 or 128MB, these boards are designed the same way: 1 64MB 
chip on SD_CS3 and optional a second 64MB chip on SD_CS2.
I was told that in that case 16 banks needed to be define (and btw it 
couldn't be handled , I didn't check it yet.

Before sparsemem, we had to use discontigmem (and patch it),now with 
parsemem there's no needs for such a thing anymore, the only needed 
bits are 4 #define.


> 
> So the kernel finds two 32MB chunks which is what the bootloader passed
> in the ATAGS.  And the addresses match what was passed.
> 
> What is your intended result by switching to sparsemem?
> 
> I have also messed with sparsemem and I get the same results as above
> with it enabled.  I don't see any real reason to switch to sparsemem.
> 
> The _only_ reason I can see is if a system has more than 8 banks of
> memory.  I think that is the current limit for flatmem support in the
> kernel.  There are only two configuration I know of that can cause this
> on the ep93xx when only on chip select is used:
> 
> 512 Mbit (16-bit wide device) = 64 MBytes with SROMLL = 0 -> 16 banks
> 512 Mbit (2 x 16-bit wide device) = 128 Mbytes with SROMLL = 0 -> 16 banks
> 
> Both of these configuration can be "fixed" by having the bootloader set
> the SROMLL bit = 1. 
> 
> 512 Mbit (16-bit wide device) = 64 MBytes with SROMLL = 1 -> 8 banks
> 512 Mbit (2 x 16-bit wide device) = 128 Mbytes with SROMLL = 1 -> 1 bank
> 
> Please refer to the following document for more information:
> 
> http://arm.cirrus.com/files/HOWTO/EP93xx%20SDRAM%20Address%20Ranges.pdf

Interesting, thank you.

Regards,
Chris

> 
> Regards,
> Hartley
