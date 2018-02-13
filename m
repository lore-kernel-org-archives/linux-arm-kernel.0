From: s-anna@ti.com (Suman Anna)
Date: Mon, 12 Feb 2018 20:24:06 -0600
Subject: [PATCH v7 4/9] arm: OMAP: Move dmtimer driver out of plat-omap to
 drivers under clocksource
In-Reply-To: <1515478987-5786-5-git-send-email-j-keerthy@ti.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-5-git-send-email-j-keerthy@ti.com>
Message-ID: <ed5ed107-e17d-a568-3f21-17f710388ef2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Keerthy,

On 01/09/2018 12:23 AM, J, KEERTHY wrote:
> Move the dmtimer driver out of plat-omap to clocksource.
> So that non-omap devices also could use this.

What non-omap devices do you have in mind? I don't think this driver is
ready for that yet. It still has a lot of OMAP dependencies. So you
should defer this for later along with the rest of the cleanup and when
the driver is ready for that.

> 
> No Code changes done to the driver file only renamed to timer-dm.c.
> Also removed the config dependencies for OMAP_DM_TIMER.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Tested-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>   arch/arm/plat-omap/Kconfig                                     | 6 ------
>   arch/arm/plat-omap/Makefile                                    | 1 -
>   drivers/clocksource/Kconfig                                    | 3 +++
>   drivers/clocksource/Makefile                                   | 1 +
>   arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-dm.c | 0
>   5 files changed, 4 insertions(+), 7 deletions(-)
>   rename arch/arm/plat-omap/dmtimer.c => drivers/clocksource/timer-dm.c (100%)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 7276afe..afc1a1d 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -106,12 +106,6 @@ config OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
>           help
>             PPA routine service ID for setting L2 auxiliary control register.
> 
> -config OMAP_DM_TIMER
> -       bool "Use dual-mode timer"
> -       depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
> -       help
> -        Select this option if you want to use OMAP Dual-Mode timers.
> -
>   config OMAP_SERIAL_WAKE
>           bool "Enable wake-up events for serial ports"
>           depends on ARCH_OMAP1 && OMAP_MUX
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 47e1867..7215ada 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -9,5 +9,4 @@ obj-y := sram.o dma.o counter_32k.o
> 
>   # omap_device support (OMAP2+ only at the moment)
> 
> -obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
>   obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index c729a88..3f799b2 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -21,6 +21,9 @@ config CLKEVT_I8253
>   config I8253_LOCK
>           bool
> 
> +config OMAP_DM_TIMER
> +       bool
> +
>   config CLKBLD_I8253
>           def_bool y if CLKSRC_I8253 || CLKEVT_I8253 || I8253_LOCK
> 
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 72711f1..27b5497 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_EM_TIMER_STI)    += em_sti.o
>   obj-$(CONFIG_CLKBLD_I8253)      += i8253.o
>   obj-$(CONFIG_CLKSRC_MMIO)       += mmio.o
>   obj-$(CONFIG_DIGICOLOR_TIMER)   += timer-digicolor.o
> +obj-$(CONFIG_OMAP_DM_TIMER)    += timer-dm.o
>   obj-$(CONFIG_DW_APB_TIMER)      += dw_apb_timer.o
>   obj-$(CONFIG_DW_APB_TIMER_OF)   += dw_apb_timer_of.o
>   obj-$(CONFIG_FTTMR010_TIMER)    += timer-fttmr010.o
> diff --git a/arch/arm/plat-omap/dmtimer.c b/drivers/clocksource/timer-dm.c
> similarity index 100%
> rename from arch/arm/plat-omap/dmtimer.c
> rename to drivers/clocksource/timer-dm.c

Similar comments as in patch 3 about the file name at the top, and the
question about adding omap to the file name.

Also, I see that omap_dm_timer_get_fclk() is only defined for
!CONFIG_ARCH_OMAP1, but currently the function is declared in the header
file for both OMAP1 and OMAP2. You would want to inline that for OMAP1
in the header file (we currently get away with it because no one uses it).

regards
Suman

> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
