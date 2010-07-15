From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 12:17:46 +0100
Subject: [PATCH 1/6] U6/U6715 ARM architecture files
In-Reply-To: <1278688913-26417-2-git-send-email-philippe.langlais@stericsson.com>
References: <1278688913-26417-1-git-send-email-philippe.langlais@stericsson.com>
	<1278688913-26417-2-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100715111746.GA29322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, there's a few more points here.

On Fri, Jul 09, 2010 at 05:21:48PM +0200, Philippe Langlais wrote:
> diff --git a/arch/arm/mach-u67xx/Kconfig b/arch/arm/mach-u67xx/Kconfig
> new file mode 100644
> index 0000000..48f53fb
> --- /dev/null
> +++ b/arch/arm/mach-u67xx/Kconfig
> @@ -0,0 +1,11 @@
> +comment "U67XX Board Type"
> +	depends on ARCH_U67XX
> +
> +choice
> +	prompt "Choose the U67XX Board type"
> +	default MACH_U67XX_WAVEC_2GB
> +	help
> +		"Choose the ST-Ericsson Reference Design Board"
> +	config MACH_U67XX_WAVEC_2GB
> +		bool "U67XX WaveC Board with 2Gb Micron combo"

I thought convention here was to have the "config" statements all starting
on column 1, and a blank line after 'help'.  help shouldn't need the text
quoted.

> diff --git a/arch/arm/plat-u6xxx/Kconfig b/arch/arm/plat-u6xxx/Kconfig
> new file mode 100644
> index 0000000..b01f77c
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/Kconfig
> @@ -0,0 +1,20 @@
> +menu "STE U6XXX Implementations"
> +
> +choice
> +	prompt "U67XX System Type"
> +	default ARCH_U67XX
> +
> +config ARCH_U67XX
> +	bool "U67XX"
> +	select PLAT_U6XXX
> +	select CPU_ARM926T
> +	select GENERIC_TIME
> +	select GENERIC_CLOCKEVENTS
> +	select U6_MTU_TIMER
> +endchoice
...
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cf30fc9..7045a05 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -739,6 +739,13 @@ config ARCH_U300
>  	help
>  	  Support for ST-Ericsson U300 series mobile platforms.
>  
> +config PLAT_U6XXX
> +	bool "ST-Ericsson U6XXX Series"
> +	select GENERIC_GPIO
> +	select ARCH_REQUIRE_GPIOLIB
> +	help
> +	  Support for ST-Ericsson's U6XXX architecture
> +
>  config ARCH_U8500
>  	bool "ST-Ericsson U8500 Series"
>  	select CPU_V7

Hmm.  So, we have PLAT_U6XXX to select support for the U6XXX platform
series on the main machine class menu.  We then have a globally visible
ARCH_U67XX option, which selects PLAT_U6XXX, and that then gives us a
MACH_U67XX_WAVEC_2GB option.

This seems to be rather obsure - what if I have some other machine class
selected, and I enable ARCH_U67XX ?

How about having ARCH_U67XX in the main machine class menu, which allows
us to see MACH_U67XX_WAVEC_2GB.  When MACH_U67XX_WAVEC_2GB is enabled,
this selects PLAT_U6XXX to pick up the plat-* stuff?

> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +	unsigned long flags;
> +	/*
> +	 * To reset, we hit the on-board reset register
> +	 * in the system FPGA
> +	 */
> +	/* diasble HW interruption */
> +	raw_local_irq_save(flags);
> +	/* load watchdog with reset value */
> +	outl(0x5, IO_ADDRESS(WDRU_BASE + WDRU_TIM_OFFSET));

s/outl/writel/ please.

> diff --git a/arch/arm/plat-u6xxx/include/mach/uncompress.h b/arch/arm/plat-u6xxx/include/mach/uncompress.h
> new file mode 100644
> index 0000000..7dae14d
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/include/mach/uncompress.h
...
> +static void putc(int c)
> +{
> +	if (c == '\n')
> +		putc('\r');

Hmm, so you want to output \r\r\n for each \n in the output stream?

> diff --git a/arch/arm/plat-u6xxx/timer.c b/arch/arm/plat-u6xxx/timer.c
> new file mode 100644
> index 0000000..90464b1
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/timer.c
...
> +struct mmtu_ctxt {
> +	unsigned long *base;

__iomem ?

> +	int autoreload;

Is this a write-only variable?  I couldn't find anything which reads it.

> +	uint32_t compvalue;
> +	uint32_t endvalue;
> +	struct clk *clk;
> +	int mode;
> +};
...
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		mmtu->autoreload = 0;
> +
> +		if (mmtu->clk == NULL) {
> +			mmtu->clk = clk_get(0, "MMTU");

	clk_get(NULL, "MMTU")

> +struct sys_timer u6_timer = {
> +	.init = u6_timer_init,
> +#ifndef CONFIG_GENERIC_TIME
> +	.offset = NULL,
> +#endif

There's no need to initialize .offset, so this ifdef and initializer can
be removed entirely.
