From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 9 Oct 2013 11:20:58 +0800
Subject: [PATCH 8/8] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <1381235073-17134-9-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1381235073-17134-9-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131009112058.683739d0@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Tue, 8 Oct 2013 05:24:33 -0700
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> This adds initial support for the Marvell Berlin (88DE3xxx) SoC family
> and basic machine setup for Armada 1500 (88DE3100) SoCs.

First of all, thanks for these patches. I worked and is still working on Marvell
Berlin Linux kernel BSP at Marvell. As the person who brought up Linux kernel for
various Berlin SoCs since BG2, I have some comments to share with you.

> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reviewed-by: Jason Cooper <jason@lakedaemon.net>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changelog:
> RFCv2->v1:
> - remove custom .init_time, adds dependency for arch-wide of_clk_init call
> RFCv1->RFCv2:
> - nuke .map_io (Reported by Arnd Bergmann)
> - add copyright reference
> - switch to mach-berlin instead of mach-mvebu
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/Kconfig              |    2 ++
>  arch/arm/Makefile             |    1 +
>  arch/arm/mach-berlin/Kconfig  |   24 ++++++++++++++++++++++++
>  arch/arm/mach-berlin/Makefile |    1 +
>  arch/arm/mach-berlin/berlin.c |   39
> +++++++++++++++++++++++++++++++++++++++ 5 files changed, 67 insertions(+)
>  create mode 100644 arch/arm/mach-berlin/Kconfig
>  create mode 100644 arch/arm/mach-berlin/Makefile
>  create mode 100644 arch/arm/mach-berlin/berlin.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1ad6fb6..5692426 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -932,6 +932,8 @@ source "arch/arm/mach-bcm/Kconfig"
>  
>  source "arch/arm/mach-bcm2835/Kconfig"
>  
> +source "arch/arm/mach-berlin/Kconfig"
> +
>  source "arch/arm/mach-clps711x/Kconfig"
>  
>  source "arch/arm/mach-cns3xxx/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index a37a50f..3ba332b 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -147,6 +147,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
>  machine-$(CONFIG_ARCH_AT91)		+= at91
>  machine-$(CONFIG_ARCH_BCM)		+= bcm
>  machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
> +machine-$(CONFIG_ARCH_BERLIN)		+= berlin
>  machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
>  machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
>  machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> new file mode 100644
> index 0000000..56a671e
> --- /dev/null
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -0,0 +1,24 @@
> +config ARCH_BERLIN
> +	bool "Marvell Berlin (88DE3xxx) SoCs" if ARCH_MULTI_V7
> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_IRQ_CHIP
> +	select COMMON_CLK
> +	select DW_APB_ICTL
> +	select DW_APB_TIMER_OF
> +
> +if ARCH_BERLIN
> +
> +menu "Marvell Berlin (88DE3xxx) SoC variants"
It would be better to s/88DE3xxx/88DExxxx or remove 88DE3xxx totally
> +
> +config MACH_MV88DE3100
Can you please use MACH_BERLIN2? This is what we used internally in latest BSP
> +	bool "Marvell 88DE3100 (Armada 1500)"
> +	select ARM_GIC
> +	select CACHE_L2X0
The tauros3 and PL310 are different although the programming interface are
compatible. In PJ4B and Tauros3, the CP15 cache maintenance commands include
both L1 and L2, memory mapped PA-based maintenance operations in L2 are not needed.
How to handle this in cache-l2x0.c?
> +	select CPU_PJ4B
> +	select HAVE_ARM_TWD if LOCAL_TIMERS
> +	select HAVE_SMP
> +	select LOCAL_TIMERS if SMP
> +
> +endmenu
> +
> +endif
> diff --git a/arch/arm/mach-berlin/Makefile b/arch/arm/mach-berlin/Makefile
> new file mode 100644
> index 0000000..ab69fe9
> --- /dev/null
> +++ b/arch/arm/mach-berlin/Makefile
> @@ -0,0 +1 @@
> +obj-y += berlin.o
> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
> new file mode 100644
> index 0000000..54b3ba7
> --- /dev/null
> +++ b/arch/arm/mach-berlin/berlin.c
> @@ -0,0 +1,39 @@
> +/*
> + * Device Tree support for Marvell Berlin (88DE3xxx) platforms.
ditto
> + *
> + * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> + *
> + * based on GPL'ed 2.6 kernel sources
> + *  (c) Marvell International Ltd.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include <asm/mach/arch.h>
> +
> +static void __init berlin_init_machine(void)
> +{
> +	/*
> +	 * with DT probing for L2CCs, berlin_init_machine can be removed.
> +	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
> +	 */
> +	l2x0_of_init(0x70c00000, 0xfeffffff);
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char * const berlin_dt_compat[] = {
> +	"marvell,berlin",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(BERLIN_DT, "Marvell Berlin (88DE3xxx)")
ditto
> +	.dt_compat      = berlin_dt_compat,
> +	.init_machine   = berlin_init_machine,
> +MACHINE_END


>  create mode 100644 arch/arm/boot/dts/mv88de3100-sony-nsz-gs7.dts
>  create mode 100644 arch/arm/boot/dts/mv88de3100.dtsi

Armada 1500 == mv88de3100 == BG2

We always call BGx internally, so s/mv88de3100/berlin2 in all patches except
patch 4 would be better. IOW, I prefer to call berlin2/berlin2ct/berlin2cd etc
and never use mv88dexxxx or armada xxxx in code, dt bindings except documents.
This would remove unnecessary confusions. What do you think?


Thanks,
Jisheng
