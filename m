From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jul 2012 12:31:09 +0100
Subject: [PATCH v2 1/2] ARM: sa1100: add missing include of linux/io.h
In-Reply-To: <201207070906.26270.arnd@arndb.de>
References: <201207070848.30706.arnd@arndb.de>
 <201207070906.26270.arnd@arndb.de>
Message-ID: <20120707113109.GM16319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 07, 2012 at 09:06:25AM +0000, Arnd Bergmann wrote:
> After c00184f9ab4 "ARM: sa11x0/pxa: convert OS timer registers to IOMEM",
> multiple defconfig files produce this new warning:
> 
> arch/arm/mach-sa1100/cpu-sa1100.c: In function 'sa1100_update_dram_timings':
> arch/arm/mach-sa1100/cpu-sa1100.c:153:3: error: implicit declaration of function 'IOMEM'
> 
> Adding linux/io.h to the file using the __REG() macro avoids the warning.
> In the long run, we still need to convert all register accesses to use
> readl/writel rather than directly derefencing the pointer, but this makes
> it compile again.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: actually fix all call sites, rather than just the first one
> 
> We might want to put the #include directly into mach/SA-1100.h
> instead, to be on the safe side.

I'd prefer not to.  If you want to get this into the patch system, I'll
merge it into c00184f9ab4.  Ditto for the second patch too.

> diff --git a/arch/arm/mach-sa1100/cpu-sa1100.c b/arch/arm/mach-sa1100/cpu-sa1100.c
> index 19b2053..e8f4d1e 100644
> --- a/arch/arm/mach-sa1100/cpu-sa1100.c
> +++ b/arch/arm/mach-sa1100/cpu-sa1100.c
> @@ -87,6 +87,7 @@
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/cpufreq.h>
> +#include <linux/io.h>
>  
>  #include <asm/cputype.h>
>  
> diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
> index b412fc0..7f07f08 100644
> --- a/arch/arm/mach-sa1100/jornada720_ssp.c
> +++ b/arch/arm/mach-sa1100/jornada720_ssp.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/sched.h>
> +#include <linux/io.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/jornada720.h>
> diff --git a/arch/arm/mach-sa1100/leds-lart.c b/arch/arm/mach-sa1100/leds-lart.c
> index a51830c..50a5b14 100644
> --- a/arch/arm/mach-sa1100/leds-lart.c
> +++ b/arch/arm/mach-sa1100/leds-lart.c
> @@ -10,6 +10,7 @@
>   *  pace of the LED.
>   */
>  #include <linux/init.h>
> +#include <linux/io.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/leds.h>
> diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
> index d9be6ea..7f03d1bd 100644
> --- a/drivers/input/touchscreen/jornada720_ts.c
> +++ b/drivers/input/touchscreen/jornada720_ts.c
> @@ -19,6 +19,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/io.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/jornada720.h>
> diff --git a/drivers/pcmcia/sa1100_shannon.c b/drivers/pcmcia/sa1100_shannon.c
> index decb347..56ab739 100644
> --- a/drivers/pcmcia/sa1100_shannon.c
> +++ b/drivers/pcmcia/sa1100_shannon.c
> @@ -8,6 +8,7 @@
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> +#include <linux/io.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> 
