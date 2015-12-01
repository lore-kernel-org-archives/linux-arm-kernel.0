From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 1 Dec 2015 11:30:27 -0500 (EST)
Subject: Virtual addresses, ioremap, vmalloc, etc
In-Reply-To: <565D8DA9.8040700@free.fr>
References: <565D8DA9.8040700@free.fr>
Message-ID: <alpine.LFD.2.20.1512011124180.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Dec 2015, Mason wrote:

> Hello everyone,
> 
> I was wondering if someone could help clear my confusion.
> 
> In my company's legacy port (based on 3.4, dating back to 2.6) someone
> chose to map the first 16 MB of physical addresses using:
> 
> static struct map_desc tango_map_desc[] __initdata = {
> 	{
> 		.virtual	= 0xf0000000,
> 		.pfn		=__phys_to_pfn(0),
> 		.length		= SZ_16M,
> 		.type 		= MT_DEVICE,
> 	},
> };
> 
> static void __init tango_map_io(void)
> {
> 	iotable_init(tango_map_desc, ARRAY_SIZE(tango_map_desc));
> }
> 
> Is the virtual address 0xf0000000 chosen arbitrary?
> Could I pick 0xf04200000 for example?

It is arbitrary, but the benefit of a static mapping is to enforce a 
specific alignment so the MMU entry can use larger page table elements 
and reduce TLB usage.

> The same kernel, with no such boot-time mapping prints:
> 
> [    0.000000] Memory: 641720K/655360K available (3135K kernel code, 109K rwdata, 1056K rodata, 3044K init, 218K bss, 13640K reserved, 0K cma-reserve)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xe8800000 - 0xff000000   ( 360 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xe8000000   ( 640 MB)
> 
> It looks like 0xf0000000 is in the middle of the vmalloc space.
> Is it a good idea to "statically" map something there?

Yes.  Static mappings are reused whenever you do a ioremap() that could 
match it.

> If I were to call ioremap(0, SZ_16M); at run-time, I would imagine
> the virtual address could be anywhere in the vmalloc space?
> There's no reason it would be 0xf0000000, right?

Right. But if the static mapping is there, then ioremap() will return 
0xf0000000.

> In short, is virtual address 0xf0000000 special in any way?
> (Other than being in the vmalloc space perhaps.)

It used to, but not anymore.


Nicolas
