From: mpeg.blue@free.fr (Mason)
Date: Tue, 09 Dec 2014 23:59:22 +0100
Subject: ARM page tables
In-Reply-To: <20141209172729.GK11285@n2100.arm.linux.org.uk>
References: <54872F9C.2080005@free.fr>
 <20141209172729.GK11285@n2100.arm.linux.org.uk>
Message-ID: <54877ECA.6050501@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russel,

On 09/12/2014 18:27, Russell King - ARM Linux wrote:
> On Tue, Dec 09, 2014 at 06:21:32PM +0100, Mason wrote:
>> On my SoC, we have two MMIO regions mapped at init:
>>
>>  {
>>   .virtual = (0xf0000000 + 0x00800000),
>>   .pfn =((unsigned long)((0x20000000) >> 12)),
>>   .length = 0x00200000,
>>   .type = 0,
>>  },
>>  {
>>   .virtual = (0xf0000000 +(0)),
>>   .pfn =((unsigned long)((0) >> 12)),
>>   .length = 0x00800000,
>>   .type = 0,
>>  },
>>
>> I dumped the L1 page table descriptors, expecting to find
>> entries for the MMIO regions:
>> (AFAICT, the page table starts at 0xc0007000)
> 
> No, it starts at 0xc0004000.

I should have suspected that I had the wrong start address. Thanks!
What's the name of the symbolic constant for that address?

The page table is allocated in pgd_alloc, right?
  new_pgd = __pgd_alloc();
#define __pgd_alloc()   (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_REPEAT, 2)

If that's the correct init code, how does it guarantee to always
return 0xc0004000?

>> col_1 = entry number (hex)
>> col_2 = entry value
>> col_3 = string for (desc & 3)
>>
>> 300 00011452 SECTION
>> 301 00111452 SECTION
>> 302 00211452 SECTION
>> 303 00311452 SECTION
>> 304 00411452 SECTION
>> 305 00511452 SECTION
>> 306 00611452 SECTION
>> 307 00711452 SECTION
>> 308 20011452 SECTION
>> 309 20111452 SECTION
>>
>> If I understand correctly, entry 308 means:
>> VIRTUAL ADDRESS 0x3080_0000 is mapped to PHYSICAL ADDRESS 0x2000_0000
>> (Is my reading correct?)
> 
> No.  If you're talking about 0x308 from an offset of 0x3000 into the
> page table, that's 0x308 * 1MB + 0xc0000000 = 0xf0800000.
> 
>> But we asked to map PA 0x2000_0000 to VA 0xf080_0000 in iotable_init,
>> so I'm confused...
> 
> So, with the right starting point, it works out correctly.

Indeed!

I am investigating this issue:

As I described, we map PA 0-8MB. But some code actually accesses
address 0xf0920000 (from kernel space) and I was expecting very
nasty things, like the equivalent of SIGSEGV in the kernel.
But nothing happens, no page fault, no BUG_ON, no panic, no
implosion... (Writes seem ignored, and reads always return 0)

I don't understand how it is possible to access unmapped virtual
addresses without the MMU throwing a fit... That's why I'm looking
at the page table.

Regards.
