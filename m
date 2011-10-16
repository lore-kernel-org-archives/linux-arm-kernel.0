From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Oct 2011 16:57:54 +0100
Subject: [PATCH 2/9] ARM: SPMP8000: Add machine base files
In-Reply-To: <CAGVye5PjCZRgdmP+VCXifw_MnW1rAN41BPWfJvk9CAuXBt4ggw@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-3-git-send-email-zoss@devai.org>
	<201110111644.56505.arnd@arndb.de>
	<CAGVye5PjCZRgdmP+VCXifw_MnW1rAN41BPWfJvk9CAuXBt4ggw@mail.gmail.com>
Message-ID: <20111016155754.GB21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 16, 2011 at 04:10:34PM +0200, Zoltan Devai wrote:
> 2011/10/11 Arnd Bergmann <arnd@arndb.de>:
> > I think this can become an empty file now, with Russell's latest cleanup
> > going into 3.2.
> I didn't find that in either your or Russell's tree, where should I look
> for it ?

It's definitely there - this is how asm/gpio.h is changed:

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 166a7a3..11ad0bf 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -4,4 +4,23 @@
 /* not all ARM platforms necessarily support this API ... */
 #include <mach/gpio.h>

+#ifndef __ARM_GPIOLIB_COMPLEX
+/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
+#include <asm-generic/gpio.h>
+
+/* The trivial gpiolib dispatchers */
+#define gpio_get_value  __gpio_get_value
+#define gpio_set_value  __gpio_set_value
+#define gpio_cansleep   __gpio_cansleep
+#endif
+
+/*
+ * Provide a default gpio_to_irq() which should satisfy every case.
+ * However, some platforms want to do this differently, so allow them
+ * to override it.
+ */
+#ifndef gpio_to_irq
+#define gpio_to_irq    __gpio_to_irq
+#endif
+
 #endif /* _ARCH_ARM_GPIO_H */

So, for the case where everything goes through gpiolib and there's no
platform accelerators for SoC GPIOs, there's no need to have anything
in mach/gpio.h.  If a platform does want to do something special, it
needs to define __ARM_GPIOLIB_COMPLEX.


> >> +/* Vitual to physical translation of statically mapped space */
> >> +#define IO_ADDRESS(x) ? ? ? ? ? ? ? ?((x) | 0xF0000000)
> >
> > Better make this return a 'void __iomem *', e.g. by doing
> >
> > #define IO_ADDRESS(x) ? (((x) & 0x0fffffff) + ((void __iomem *)0xf0000000)
> This is used by map_desc, so it needs to return an int.
> I use IO_PTR for the pointer version, but maybe the naming is misleading.

Much preferred to have macros returning virtual addresses as a pointer,
and then have the map_desc stuff cast.  This means if you end up using
IO_ADDRESS() with readl() etc, then you're going to be correct no matter
what.

> >> +/* FIXME This should go away */
> >> +#define IO_SPACE_LIMIT ?0
> >> +
> >> +#define __mem_pci(a) ? ?(a)
> >> +#define __io(a) ? ? ? ? __typesafe_io(a)
> >> +
> >
> > I think you should better define __io() to NULL.
> OK

Or if you don't have any PCI/ISA IO, don't define __io at all, which
means inb() et.al. will be undefined (note: the 8250 driver still wants
these.)  Also select NO_IOPORT as well in the config if you don't support
PCI/ISA IO.
