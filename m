From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 1 Apr 2012 19:46:13 +0000
Subject: ioremap to a specific virtual address
In-Reply-To: <CAKON4OzohgrZ2k0ddhDrOTqumRYizf-aLUhWdcZstD-7QTYYZg@mail.gmail.com>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203311943500.24151@xanadu.home>
 <CAKON4OzohgrZ2k0ddhDrOTqumRYizf-aLUhWdcZstD-7QTYYZg@mail.gmail.com>
Message-ID: <201204011946.14113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 01 April 2012, jonsmirl at gmail.com wrote:
> Looks good, way cleaner than my x86 desktop which is full of 8KB
> mappings. On my ARM I had about 50 regions before since I was mapping
> each device individually.
> 
> root at OpenWrt:/proc# cat vmallocinfo
> 0xc4804000-0xc4810000   49152 cramfs_uncompress_init+0x24/0x60 pages=11 vmalloc
> 0xc4810000-0xc4853000  274432 jffs2_zlib_init+0x14/0xa4 pages=66 vmalloc
> 0xc4853000-0xc485f000   49152 jffs2_zlib_init+0x48/0xa4 pages=11 vmalloc
> 0xc485f000-0xc4886000  159744 ssd1289_probe+0x250/0x85c pages=38 vmalloc
> 0xf1300000-0xf1400000 1048576 iotable_init+0x0/0xb0 phys=13000000 ioremap
> 0xf1500000-0xf1600000 1048576 iotable_init+0x0/0xb0 phys=15000000 ioremap
> 0xf1600000-0xf1700000 1048576 iotable_init+0x0/0xb0 phys=16000000 ioremap
> 0xf1700000-0xf1800000 1048576 iotable_init+0x0/0xb0 phys=17000000 ioremap
> 0xf1800000-0xf1900000 1048576 iotable_init+0x0/0xb0 phys=18000000 ioremap
> 0xf1900000-0xf1a00000 1048576 iotable_init+0x0/0xb0 phys=19000000 ioremap
> 0xf2000000-0xf2100000 1048576 iotable_init+0x0/0xb0 phys=20000000 ioremap
> 0xf6000000-0xf6100000 1048576 iotable_init+0x0/0xb0 phys=60000000 ioremap
> 0xf7000000-0xf7100000 1048576 iotable_init+0x0/0xb0 phys=70000000 ioremap
> root at OpenWrt:/proc#

Well, you loose the information about which devices specifically do the ioremap,
but that wasn't very reliable to start with. How about combining those that
are already consecutive areas, e.g. 0xf1300000-0xf1a00000? I don't see
any downsides of doing that, and it would save a few bytes here and there.

	Arnd
