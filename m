From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Oct 2014 11:12:46 +0200
Subject: next build: 304 warnings 0 failures (next/next-20141013)
In-Reply-To: <20141013084618.GC27405@n2100.arm.linux.org.uk>
References: <543b63d2.a479420a.486e.ffffb6e2@mx.google.com>
 <20141013084618.GC27405@n2100.arm.linux.org.uk>
Message-ID: <8786463.d9VIC5J1Iz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 October 2014 09:46:18 Russell King - ARM Linux wrote:
> On Sun, Oct 12, 2014 at 10:32:02PM -0700, Olof's autobuilder wrote:
> >       1 arch/arm/mach-cns3xxx/pcie.c:313:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This should be fixed.

This is an ancient bug, both Mark Brown and I have suggested fixes,
we just need to apply one of them.

> >       1 arch/arm/mach-omap1/board-htcherald.c:296:2: warning: initialization makes pointer from integer without a cast [enabled by default]
> >       1 arch/arm/mach-omap1/board-htcherald.c:296:2: warning: (near initialization for 'gpio_leds[0].gpiod') [enabled by default]
> >       1 arch/arm/mach-omap1/board-htcherald.c:297:2: warning: initialization makes pointer from integer without a cast [enabled by default]
> >       1 arch/arm/mach-omap1/board-htcherald.c:297:2: warning: (near initialization for 'gpio_leds[1].gpiod') [enabled by default]
> ...
> 
> All of these need fixing.

Hadn't seen this one before, I guess it's because of
https://lkml.org/lkml/2014/9/16/222.

adding Mika and Linus to Cc, should be easy to fix using
named initializers like all other 120+ platforms do,
but to be on the safe side, we could also move the new
'gpiod' member to the end of 'struct gpio_led'.

> 
> >       2 drivers/base/dma-contiguous.c:244:2: warning: initialization from incompatible pointer type
> >       2 drivers/base/dma-contiguous.c:244:2: warning: (near initialization for 'rmem_cma_ops.device_init')
> 
> This does too.
> 
> >       3 drivers/base/dma-coherent.c:303:2: warning: initialization from incompatible pointer type
> >       3 drivers/base/dma-coherent.c:303:2: warning: (near initialization for 'rmem_dma_ops.device_init')
> >       8 drivers/base/dma-contiguous.c:244:2: warning: initialization from incompatible pointer type [enabled by default]
> >       8 drivers/base/dma-contiguous.c:244:2: warning: (near initialization for 'rmem_cma_ops.device_init') [enabled by default]
> >      50 drivers/base/dma-coherent.c:303:2: warning: initialization from incompatible pointer type [enabled by default]
> >      50 drivers/base/dma-coherent.c:303:2: warning: (near initialization for 'rmem_dma_ops.device_init') [enabled by default]
> 
> And these.
> 
> None of these warnings should hit mainline; they should all be fixed now,
> before any of the changes which caused them are merged.

Adding Marek as well. No idea how this slipped in, apparently the device_init
callback declaration has always used 'void' as the return type, while all
functions assigned to it have always returned 'int' and the caller
in __reserved_mem_init_node() actually evaluates the return code.

This seems to be the obvious fix:

diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 5b5efae09135..3c2cf6fc5e78 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -16,7 +16,7 @@ struct reserved_mem {
 };
 
 struct reserved_mem_ops {
-	void	(*device_init)(struct reserved_mem *rmem,
+	int	(*device_init)(struct reserved_mem *rmem,
 			       struct device *dev);
 	void	(*device_release)(struct reserved_mem *rmem,
 				  struct device *dev);


	Arnd
