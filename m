From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Tue, 06 Oct 2009 22:26:52 +0100
Subject: [PATCH v1.0 4/4] MM: Switch TS72XX to use sparemem
In-Reply-To: <4ACBB4BD.5080402@techworks.ie>
References: <20091004011413.12578.89897.stgit@localhost.localdomain><20091004011434.12578.76922.stgit@localhost.localdomain>
	<4AC9E4B8.1040208@techworks.ie>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7687@mi8nycmail19.Mi8.com>
	<4ACA3807.9050908@techworks.ie>
	<BD79186B4FD85F4B8E60E381CAEE190901DB76E6@mi8nycmail19.Mi8.com>
	<4ACBB4BD.5080402@techworks.ie>
Message-ID: <4ACBB61C.9000506@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Gagneraud wrote:
> H Hartley Sweeten wrote:
>> On Monday, October 05, 2009 11:17 AM, Christian Gagneraud wrote:
>>> H Hartley Sweeten wrote:
>>>> On Monday, October 05, 2009 5:21 AM, Christian Gagneraud wrote:
>>>>> Hi,
>>>>>
>>>>> What people think about enabling sparsemem on EP93XX? I know this 
>>>>> patch as it is will break all but this board.
>>>>>
>>>>> Can we define defaults SECTION_SIZE_BITS and MAX_PHYSMEM_BITS that 
>>>>> will suit all the supported boards?
>>>> With sparsemem enabled what is your memory detected during boot?  For
>>>> instance on my ep9307 based system with flatmem I get:
>>>>
>>>> Memory: 32MB 32MB = 64MB total
>>>> Memory: 44552KB available (3452K code, 254K data, 124K init, 0K 
>>>> highmem)
>>>           ^^^^^
>>> Are you missing 16MB?
>>
>> No.  My rootfs is in /dev/ram and uses the remaining space.
>>
>>> Here is what i get with sparsemem:
>>>
>>> Memory: 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB = 64MB total
>>> Memory: 63264KB available (1252K code, 231K data, 64K init, 0K highmem)
>>>
>>> 00000000-007fffff : System RAM   00020000-00276fff : Kernel text   
>>> 00278000-002c1923 : Kernel data 01000000-017fffff : System RAM 
>>> 04000000-047fffff : System RAM 05000000-057fffff : System RAM
>>> e0000000-e07fffff : System RAM e1000000-e17fffff : System RAM 
>>> e4000000-e47fffff : System RAM e5000000-e57fffff : System RAM
>>>
>>> For boards shipped with 32MB, there's one 32MB chip on SD_CS3 that 
>>> shows at 0x00000000, for boards shipped with 64MB there's another 
>>> 32MB chip on SD_CS2 which pop up at 0xe0000000
>>
>> OK.  That makes sense.  I was under the impression that the 64MB board
>> was using a single chip select.
>>  
>>> That's for the models that offer 32 or 64MB, but TS have other models 
>>> that offer 64 or 128MB, these boards are designed the same way: 1 
>>> 64MB chip on SD_CS3 and optional a second 64MB chip on SD_CS2.
>>> I was told that in that case 16 banks needed to be define (and btw it 
>>> couldn't be handled , I didn't check it yet.
>>
>> The single chip 64MB board would work fine but it would use 8 banks.  The
>> 128MB board would be a problem with flatmem because of the 16 banks.  In
>> order to support this NR_BANKS would have to be increased in
>> arch/arm/include/asm/setup.h.
>>
>>> Before sparsemem, we had to use discontigmem (and patch it),now with 
>>> parsemem there's no needs for such a thing anymore, the only needed 
>>> bits are 4 #define.
>>
>> Sparsemem is probably a good solution for the multiple chip selects.  But
>> we need to make sure that any solution used works for all ep93xx 
>> variants.
>>
>> The ep93xx has 4 sdram chip-selects but, because of the ASDO (sync/async)
>> boot, there are 5 possible base addresses for them.  Then, depending on
>> the bus width and the density of memory used, the node mapping for each
>> bank can vary greatly.  Even worse, node mapping changes depending on the
>> SROMLL bit.  The document referenced below has all the information needed
>> but at this point I don't know of a good solution.
>>
>>> http://arm.cirrus.com/files/HOWTO/EP93xx%20SDRAM%20Address%20Ranges.pdf
> 
> Actually, in the EP93XX User's Manual, the table 13-11 on pages 3-12 to 
> 13-16 gives all the possibilities.

It is exactly the same table actually, sorry for the noise.

Regards,
Chris.

> 
> When SROMLL=0, SECTION_SIZE_BITS=24 suits all the cases (segments are 
> always spaced by a multiple of 16MB: 0xNM00.0000 with N=0,C,D,E,F 
> depending of the chip select, and M=1,2,..,F).
> 
> Now for SROMLL=1, I see at least 4 exceptions:
> - 64MBit/32bit/11x8x4banks => 4 segments of 2MB spaced by 4MB:
>   - 0xN000-0xN01F
>   - 0xN040-...
>   - 0xN080-...
>   - 0xN0C0-...
> 
>   23 >= SECTION_SIZE_BITS >= 22
> 
> - 128MBit/32bit/12x9x4banks => 1 segment of 32 MB
>   - 0xN000-0xN1FF
> 
>   SECTION_SIZE_BITS >= 25
> 
> - 256Mbit/32bit/13x9x4banks => 2 segments of 32 MB spaced by 64MB:
>   - 0xN000-0xN1FF
>   - 0xN400-...
> 
>   26 >= SECTION_SIZE_BITS >=25
> 
> - 512Mbit/32bit/13x10x4 => 1 segment of 128 MB
>   - 0xN000-0xN7FF
> 
>   SECTION_SIZE_BITS>=27
> 
> (Am I right Russel?)
> 
> So on 12 possibilities, there's only 4 exceptions.
> 
> And finally for the virt<->phys:
> 
> There's 4 chip select, one of them can pop-up at two different 
> addresses. The biggest SDRAM segment being 128MB, we
> have the following possible address ranges:
> 0x0000-0x07FF
> 0xC000-0xC7FF
> 0xD000-0xD7FF
> 0xE000-0xE7FF
> 0xF000-0xF7FF
> 
> So why not a mapping like this one:
> 0xC000 => PAGE_OFFSET + 0x0000 (1100.0XXX => XX00.0XXX)
> 0xD000 => PAGE_OFFSET + 0x0800 (1101.0XXX => XX00.1XXX)
> 0xE000 => PAGE_OFFSET + 0x1000 (1110.0XXX => XX01.0XXX)
> 0xF000 => PAGE_OFFSET + 0x1800 (1111.0XXX => XX01.1XXX)
> 0x0000 => PAGE_OFFSET + 0x2000 (0000.0XXX => XX10.0XXX)
> 
> Which should be done with:
> ((pa&0x80000000) ? (pa&0x07FFFFFF)|((pa&0x30000000)>>1) : 
> (pa|0x20000000)) | PAGE_OFFSET
> 
> and for virt_to_phys something like:
> (va&0x07FFFFFFF)| ((va&0x20000000) ? ((va&0x18000000)<<1)|0xC0000000 : 
>  0x00000000)
> (NB: this macro is PHYS_OFFSET agnostic and allow the use of multiple 
> chips select)
> 
> A simpler possibility would be to activate sparsemem only for ts72xx and 
> stuff memory.h with:
> 
> #if defined(CONFIG_SPARSEMEM)
> #if defined(CONFIG_MACH_TS72XX)
> ...
> #else
> #error ...
> #endif
> #endif
> 
> 
> What do you think?
> 
> Regards,
> Chris
> 
> 
>>
>> Maybe Russell can help (Cced).
>>
>> Regards,
>> Hartley
> 
> 
