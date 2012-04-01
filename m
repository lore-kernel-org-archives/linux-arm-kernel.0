From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Sat, 31 Mar 2012 20:08:31 -0400
Subject: ioremap to a specific virtual address
In-Reply-To: <alpine.LFD.2.02.1203311943500.24151@xanadu.home>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203222348210.24151@xanadu.home>
 <CAKON4OxVpV-2DGVswc2y+6B6LhLzkhn0ohpSEmDBCVoaNJ4vww@mail.gmail.com>
 <alpine.LFD.2.02.1203311943500.24151@xanadu.home>
Message-ID: <CAKON4OzohgrZ2k0ddhDrOTqumRYizf-aLUhWdcZstD-7QTYYZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 7:52 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 31 Mar 2012, jonsmirl at gmail.com wrote:
>
>> On Fri, Mar 23, 2012 at 12:00 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Thu, 22 Mar 2012, jonsmirl at gmail.com wrote:
>> >
>> >> When iotable is used to initially map memory you can specify the
>> >> mapping address. In this case IO_SDMMC_PHYS is 0x18000000 and it gets
>> >> mapped to ?0xf1800000
>> >>
>> >> NXP has supplied this handly macro
>> >> #define io_p2v(x) (0xf0000000 | (((x) & 0xff000000) >> 4) | ((x) & 0x000fffff))
>> >>
>> >> iotable_init(lpc313x_io_desc, ARRAY_SIZE(lpc313x_io_desc));
>> >>
>> >> ? ? ? {
>> >> ? ? ? ? ? ? ? .virtual ? ? ? ?= io_p2v(IO_SDMMC_PHYS),
>> >> ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(IO_SDMMC_PHYS),
>> >> ? ? ? ? ? ? ? .length ? ? ? ? = IO_SDMMC_SIZE,
>> >> ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
>> >> ? ? ? },
>> >>
>> >> The supplied kernel is full of code that uses this type of addressing.
>> >> It has macros for register definition that all depend on the registers
>> >> being mapped to a well know location - io_p2v(x).
>> >>
>> >> I'd like to move the map out of the core code and into the SDMMC
>> >> device driver and then only do it if the driver loads.
>> >
>> > Why would you do that? ?Those static mappings are meant to be global and
>> > remain there. ?The handy macro is in fact not handy at all as it forces
>> > virtual addresses on you.
>> >
>> > It is OK to keep the static mappings as you can use 1MB regions and the
>> > mapping code will use first level mappings which are better with TLB
>> > usage.
>>
>> I switched over to 1MB mappings. 1MB map regions are implemented on
>> ARM9, right? Is there some way to see if I got the huge maps?
>
> Once booted, you can look in /proc/vmallocinfo for the mappings in use.
>
> There is no way to know for sure if the first level pagetable mappings
> are actually used, unless you instrument the kernel code. ?But yes, all
> ARM architectures with a MMU support 1MB regions.

Looks good, way cleaner than my x86 desktop which is full of 8KB
mappings. On my ARM I had about 50 regions before since I was mapping
each device individually.

root at OpenWrt:/proc# cat vmallocinfo
0xc4804000-0xc4810000   49152 cramfs_uncompress_init+0x24/0x60 pages=11 vmalloc
0xc4810000-0xc4853000  274432 jffs2_zlib_init+0x14/0xa4 pages=66 vmalloc
0xc4853000-0xc485f000   49152 jffs2_zlib_init+0x48/0xa4 pages=11 vmalloc
0xc485f000-0xc4886000  159744 ssd1289_probe+0x250/0x85c pages=38 vmalloc
0xf1300000-0xf1400000 1048576 iotable_init+0x0/0xb0 phys=13000000 ioremap
0xf1500000-0xf1600000 1048576 iotable_init+0x0/0xb0 phys=15000000 ioremap
0xf1600000-0xf1700000 1048576 iotable_init+0x0/0xb0 phys=16000000 ioremap
0xf1700000-0xf1800000 1048576 iotable_init+0x0/0xb0 phys=17000000 ioremap
0xf1800000-0xf1900000 1048576 iotable_init+0x0/0xb0 phys=18000000 ioremap
0xf1900000-0xf1a00000 1048576 iotable_init+0x0/0xb0 phys=19000000 ioremap
0xf2000000-0xf2100000 1048576 iotable_init+0x0/0xb0 phys=20000000 ioremap
0xf6000000-0xf6100000 1048576 iotable_init+0x0/0xb0 phys=60000000 ioremap
0xf7000000-0xf7100000 1048576 iotable_init+0x0/0xb0 phys=70000000 ioremap
root at OpenWrt:/proc#

-- 
Jon Smirl
jonsmirl at gmail.com
