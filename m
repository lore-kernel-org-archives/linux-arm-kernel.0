From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 Mar 2012 08:09:57 -0500
Subject: Device tree and IO map_desc.
In-Reply-To: <CAKON4OyHRVvdtZGt+HiCnsRT_5zTuDVBVgOx22kFC2xxFLnD+Q@mail.gmail.com>
References: <CAKON4OyHRVvdtZGt+HiCnsRT_5zTuDVBVgOx22kFC2xxFLnD+Q@mail.gmail.com>
Message-ID: <4F69D325.1000500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2012 11:52 AM, jonsmirl at gmail.com wrote:
> Is there a helper for building the IO map_desc from the device tree?
> 

No. This is one of those things that device tree cannot have knowledge
of what needs to be statically mapped as that's not a h/w description.

We could probably have a list of nodes to map and extract the size and
physical addresses from the DT. There's lots of register defines
typically associated with the static mappings, so you would still have
duplicated information.

> For example on Versatile. All of this map_io data is already in the
> device tree, it is just repeated here.
> 
> 
> DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
> 	.map_io		= versatile_map_io,
> 	.init_early	= versatile_init_early,
> ....
> MACHINE_END
> 
> void __init versatile_map_io(void)
> {
> 	iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
> }
> 
> static struct map_desc versatile_io_desc[] __initdata = {
> 	{
> 		.virtual	=  IO_ADDRESS(VERSATILE_SYS_BASE),
> 		.pfn		= __phys_to_pfn(VERSATILE_SYS_BASE),
> 		.length		= SZ_4K,
> 		.type		= MT_DEVICE
> 	}, {
> 		.virtual	=  IO_ADDRESS(VERSATILE_SIC_BASE),
> 		.pfn		= __phys_to_pfn(VERSATILE_SIC_BASE),
> 		.length		= SZ_4K,
> 		.type		= MT_DEVICE
> 	}, {
> 		.virtual	=  IO_ADDRESS(VERSATILE_VIC_BASE),
> 		.pfn		= __phys_to_pfn(VERSATILE_VIC_BASE),
> 		.length		= SZ_4K,
> 		.type		= MT_DEVICE

The SIC and VIC should get converted to ioremap and using of_irq_init.
There's already DT init support for the VIC at least, so the conversion
should be easy. I think Linus W was working on this.

Rob

> 	}, {
> ...
> 
