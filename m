From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 21 Aug 2013 08:15:10 -0700
Subject: build warnings: multi_v7_defconfig + LPAE, printk with variable types
Message-ID: <87k3jfqdmp.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've started auto-building the multi_v7_defconfig with LPAE enabled, and
noticed a handful of warnings[1]

Several are due to using prink format on a type that changes with a
config option (e.g several below use %x to print a resource_size_t,
which is obviously different between 32- and 64-bit builds.

So this got me to wondering if there is "one true way" for using printk
on types that might change with config option (preferably without
ifdef.)

The one that comes to mind would be to just always cast to the larger of
the types and use the correspondig format.  For the ones below, it would
mean casting to (u64) and using '%llx'.

Is there a better way?

Kevin

[1] 
Warnings:
        arch/arm/mach-omap2/gpmc.c:1495:4: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' [-Wformat]
        net/ipv6/addrconf.c:2793:22: warning: 'link_dev' may be used uninitialized in this function [-Wuninitialized]
        drivers/dma/ste_dma40.c:3228:2: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' [-Wformat]
        drivers/dma/ste_dma40.c:3582:3: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' [-Wformat]
        drivers/dma/ste_dma40.c:3582:3: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t' [-Wformat]
        drivers/dma/ste_dma40.c:3593:5: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t' [-Wformat]
        drivers/spi/spi-pl022.c:2178:9: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'resource_size_t' [-Wformat]
        drivers/tty/serial/imx.c:1542:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
