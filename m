From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sun, 1 Apr 2012 17:41:08 -0400
Subject: ioremap to a specific virtual address
In-Reply-To: <201204011946.14113.arnd@arndb.de>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203311943500.24151@xanadu.home>
 <CAKON4OzohgrZ2k0ddhDrOTqumRYizf-aLUhWdcZstD-7QTYYZg@mail.gmail.com>
 <201204011946.14113.arnd@arndb.de>
Message-ID: <CAKON4OyW2t+5GNRSEFOVjsGM8OifH7iqYNoO+BEOiGsdWq56sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 3:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 01 April 2012, jonsmirl at gmail.com wrote:
>> Looks good, way cleaner than my x86 desktop which is full of 8KB
>> mappings. On my ARM I had about 50 regions before since I was mapping
>> each device individually.
>>
>> root at OpenWrt:/proc# cat vmallocinfo
>> 0xc4804000-0xc4810000 ? 49152 cramfs_uncompress_init+0x24/0x60 pages=11 vmalloc
>> 0xc4810000-0xc4853000 ?274432 jffs2_zlib_init+0x14/0xa4 pages=66 vmalloc
>> 0xc4853000-0xc485f000 ? 49152 jffs2_zlib_init+0x48/0xa4 pages=11 vmalloc
>> 0xc485f000-0xc4886000 ?159744 ssd1289_probe+0x250/0x85c pages=38 vmalloc
>> 0xf1300000-0xf1400000 1048576 iotable_init+0x0/0xb0 phys=13000000 ioremap
>> 0xf1500000-0xf1600000 1048576 iotable_init+0x0/0xb0 phys=15000000 ioremap
>> 0xf1600000-0xf1700000 1048576 iotable_init+0x0/0xb0 phys=16000000 ioremap
>> 0xf1700000-0xf1800000 1048576 iotable_init+0x0/0xb0 phys=17000000 ioremap
>> 0xf1800000-0xf1900000 1048576 iotable_init+0x0/0xb0 phys=18000000 ioremap
>> 0xf1900000-0xf1a00000 1048576 iotable_init+0x0/0xb0 phys=19000000 ioremap
>> 0xf2000000-0xf2100000 1048576 iotable_init+0x0/0xb0 phys=20000000 ioremap
>> 0xf6000000-0xf6100000 1048576 iotable_init+0x0/0xb0 phys=60000000 ioremap
>> 0xf7000000-0xf7100000 1048576 iotable_init+0x0/0xb0 phys=70000000 ioremap
>> root at OpenWrt:/proc#
>
> Well, you loose the information about which devices specifically do the ioremap,
> but that wasn't very reliable to start with. How about combining those that
> are already consecutive areas, e.g. 0xf1300000-0xf1a00000? I don't see
> any downsides of doing that, and it would save a few bytes here and there.

 0xf1300000-0xf1a00000 is the virtual address.  0x13000000-0x21000000
is the physical address.  That's a span of 224MB.  How do the page
table entries work on ARM? I thought we only got 1MB per entry.  So I
need seven entries to span the range with the individual maps. I'd
need 224 entries to cover the entire region. Or can we make make the
page table entries any size we want?

There is only about 64KB in use at each of the 16MB boundaries.


>
> ? ? ? ?Arnd



-- 
Jon Smirl
jonsmirl at gmail.com
