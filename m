From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 8 Oct 2013 18:24:59 -0500
Subject: [PATCH 8/8] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <1381235073-17134-9-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1381235073-17134-9-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1381274699.5184.2.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Tue, 2013-10-08 at 14:24 +0200, Sebastian Hesselbarth wrote:
> This adds initial support for the Marvell Berlin (88DE3xxx) SoC family
> and basic machine setup for Armada 1500 (88DE3100) SoCs.
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
>  arch/arm/mach-berlin/berlin.c |   39 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 67 insertions(+)
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
> +
> +config MACH_MV88DE3100
> +	bool "Marvell 88DE3100 (Armada 1500)"
> +	select ARM_GIC
> +	select CACHE_L2X0
> +	select CPU_PJ4B
> +	select HAVE_ARM_TWD if LOCAL_TIMERS
> +	select HAVE_SMP
> +	select LOCAL_TIMERS if SMP

I think because of commit: 

a894fcc2d [ARM: smp_twd: Divorce smp_twd from local timer API]

you can remove the LOCAL_TIMERS for HAVE_ARM_TWD.

Dinh
