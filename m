From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 9 Dec 2009 12:41:43 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <20091208224550.GA26915@n2100.arm.linux.org.uk>
References: <20091208102842.GH12264@elf.ucw.cz>
	<20091208224550.GA26915@n2100.arm.linux.org.uk>
Message-ID: <20091209114143.GD22752@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2009-12-08 22:45:50, Russell King - ARM Linux wrote:
> On Tue, Dec 08, 2009 at 11:28:43AM +0100, Pavel Machek wrote:
> > Add GPIO support for HTC Dream.
> >     
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
> > index f780086..774c50e 100644
> > --- a/arch/arm/mach-msm/Kconfig
> > +++ b/arch/arm/mach-msm/Kconfig
> > @@ -40,4 +40,8 @@ config MACH_TROUT
> >  	help
> >  	  Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
> >  
> > +config GENERIC_GPIO
> > +	bool
> > +	default y
> 
> Please arrange for this to be handled just like every other ARM
> platform via a 'select' statement - eg:
> 
> config ARCH_AT91
>         bool "Atmel AT91"
>         select GENERIC_GPIO
>         select ARCH_REQUIRE_GPIOLIB
>         select HAVE_CLK
> 
> It is not nice to have multiple definitions of the same symbol scattered
> throughout the Kconfig files.

Ok, fixed.

> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/irq.h>
> > +#include <linux/pm.h>
> > +#include <linux/sysdev.h>
> > +#include <linux/io.h> 
> > +
> > +#include <asm/gpio.h>
> 
> linux/gpio.h is preferred over asm/gpio.h

Ok.

> > +++ b/arch/arm/mach-msm/board-dream.c
> > @@ -18,11 +18,13 @@
> >  #include <asm/setup.h>
> > +#include <asm/gpio.h>
> 
> ditto.

Ok.

> > +++ b/arch/arm/mach-msm/generic_gpio.c
> > @@ -0,0 +1,274 @@
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/errno.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <asm/gpio.h>
> 
> ditto.

Ok. Incremental patch looks like:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..db622a5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -565,6 +565,7 @@ config ARCH_MSM
 	select CPU_V6
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
 	help
 	  Support for Qualcomm MSM7K based systems.  This runs on the ARM11
 	  apps processor of the MSM7K and depends on a shared memory
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 774c50e..f780086 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -40,8 +40,4 @@ config MACH_TROUT
 	help
 	  Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
 
-config GENERIC_GPIO
-	bool
-	default y
-
 endif
diff --git a/arch/arm/mach-msm/board-dream-gpio.c b/arch/arm/mach-msm/board-dream-gpio.c
index 7796254..d9201f9 100644
--- a/arch/arm/mach-msm/board-dream-gpio.c
+++ b/arch/arm/mach-msm/board-dream-gpio.c
@@ -19,15 +19,16 @@
 #include <linux/pm.h>
 #include <linux/sysdev.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
-#include <asm/gpio.h>
 #include <asm/mach-types.h>
 
 #include "board-dream.h"
 #include "gpio_chip.h"
 
+/* We want to be compatible with existing bootloaders */
 #undef MODULE_PARAM_PREFIX
-#define MODULE_PARAM_PREFIX "board_dream."
+#define MODULE_PARAM_PREFIX "board_trout."
 
 static uint cpld_usb_h2w_sw;
 module_param_named(usb_h2w_sw, cpld_usb_h2w_sw, uint, 0);
diff --git a/arch/arm/mach-msm/board-dream.c b/arch/arm/mach-msm/board-dream.c
index 3e8e54a..edefacf 100644
--- a/arch/arm/mach-msm/board-dream.c
+++ b/arch/arm/mach-msm/board-dream.c
@@ -19,12 +19,12 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/setup.h>
-#include <asm/gpio.h>
 
 #include <mach/board.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-msm/generic_gpio.c b/arch/arm/mach-msm/generic_gpio.c
index 8ee7bd5..5164c77 100644
--- a/arch/arm/mach-msm/generic_gpio.c
+++ b/arch/arm/mach-msm/generic_gpio.c
@@ -18,7 +18,8 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <asm/gpio.h>
+#include <linux/gpio.h>
+
 #include "gpio_chip.h"
 
 #define GPIO_NUM_TO_CHIP_INDEX(gpio) ((gpio)>>5)




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
