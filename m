From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 09:49:10 +0100
Subject: [PATCH 00/11] ARM: at91: remove !DT support for at91rm9200
In-Reply-To: <1422574.pPO36BQRH8@kongar>
References: <cover.1417103399.git.nicolas.ferre@atmel.com>
 <20141128002822.GM4508@piout.net> <1422574.pPO36BQRH8@kongar>
Message-ID: <2770184.6f6RpLLlMS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 09:27:38 Alexander Stein wrote:
> Hi Alexandre,
> 
> On Friday 28 November 2014, 01:28:22 wrote Alexandre Belloni:
> > > >  - sound/atmel/ac97c.c (that one is still not converted to DT anyway...)
> > > 
> > > This one seems fairly straightforward to do, including a DT binding,
> > > but the result is still ugly as it supports the at32 chips that
> > > do things very differently.
> > > 
> > > The patch below gets it to compile and should be enough as a replacement
> > > once a compatible string gets added.
> > > 
> > 
> > Actually, some work was done but we never saw an other version of the
> > series. Alexander, are you still interested? Else we can take the patch
> > below.
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/246679.html

I see. Yes, the approach is similar, and there are actually multiple
independent problems:

- getting the current driver to build with multiplatform (trivial, 5 lines)
- changing the gpio handling to work with DT (simple, both of us did that)
- writing the binding (simple)
- changing the driver to ASoC (not that simple)

> Well, I tried to get a ac97c driver based on alsa soc framework as suggested 
> by Takashi. But I failed so far, I could not get my head around those 
> architecture.

Let's just start with the trivial first patch, that can probably just be merged
into 3.19, and then we can build on top of that later if anybody wants to
get ac97 working again on at91.

> When keeping my DT support on the current driver, the only thing which is open 
> that the bindings should be modifed that they are like soc-ac97link bindings.

Makes sense, if that binding works on the at91 hardware. I'm not sure
whether the pinctrl stuff or the first two gpio lines apply though.

	Arnd

8<---
ALSA: atmel: fix building the ac97 driver for at91-multiplatform

at91 will no longer export the mach/cpu.h and mach/hardware.h header files
in the future, which would break building the atmel ac97c driver.

Since the cpu_is_* check is only used to find out whether we are running
on avr32 or arm/at91, we can hardcode that check in the ARM case.

Unfortunately the driver is missing other work to be useful again on ARM,
if anyone wants to actually use it, they need to add a DT binding, and
the driver should really be converted to use the ASoC framework.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: http://www.spinics.net/lists/arm-kernel/msg382068.html

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index b59427d5a697..4eec216b7f92 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -34,10 +34,10 @@
 #include <linux/platform_data/dma-dw.h>
 #include <linux/dma/dw.h>
 
+#ifdef CONFIG_AVR32
 #include <mach/cpu.h>
-
-#ifdef CONFIG_ARCH_AT91
-#include <mach/hardware.h>
+#else
+#define cpu_is_at32ap7000() (0)
 #endif
 
 #include "ac97c.h"
