From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Sep 2012 09:04:14 +0000
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201209060904.14903.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 September 2012, Stephen Warren wrote:
> The BCM2708 is an ARM SoC from Broadcom. It is the primary SoC in a
> series which contains the BCM2835 amongst other variants. This patch
> adds very basic support for this series of SoCs, under the BCM2708 name.

Very nice!

> ---
> To do:
> * Interrupt controller and timer aren't implemented, so the kernel only
>   boots as far as "Calibrating delay loop...". However, this patch is
>   intended solely to provide the very basic infra-structure so people
>   can start filling in the gaps in mainline rather than downstream.
> * No device drivers are implemented yet.

ok

> Questions:
> * It is asserted (I believe by Broadcom) that the BCM2835 is the only SoC
>   in the series likely to see Linux support. Irrespective, those working
>   on BCM2835 support downstream (see git URL above) have chosen to name
>   the kernel support after the primary SoC (BCM2708) rather than the
>   particular instance in use on the Raspberry Pi (BCM2835). I've followed
>   that here, although I wonder if it's really the correct thing to do?

Doesn't matter too much. Depending on how different the various broadcom
SoCs actually are, we might even name this mach-bcm and eventually try to
merge the existing bcmring into it.

> * Should bcm2708_map_io() map the entire peripheral address range, or
>   only the debug UART iff DEBUG_LL is enabled? Presumably anything other
>   than the UART should be using of_iomap(), so doesn't need to be
>   statically mapped; are the IRQ controller/timer set up before
>   of_iomap() will work with non-static mappings?

Mapping the entire range is fine, as long as it's not too large. This
will end up using large pages for the mapping, which is a bit more efficient,
and any call to of_iomap or ioremap will just return the same address
rather than adding another mapping.

> * Does the (currently somewhat arbitrary) value for BCM2708_PERIPH_VIRT
>   matter; should it be picked to align nicely with any particular part
>   of the kernel's virtual address layout?

The only requirement is that it's inside of the vmalloc area described in
Documentation/arm/memory.txt. 0xf0000000 is fine here.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 88ff698..3c11dce 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -349,6 +349,25 @@ config ARCH_AT91
>  	  This enables support for systems based on Atmel
>  	  AT91RM9200 and AT91SAM9* processors.
>  
> +config ARCH_BCM2708
> +	bool "Broadcom BCM2708 family"
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select ARM_AMBA
> +	select ARM_ERRATA_411920
> +	select ARM_TIMER_SP804
> +	select CLKDEV_LOOKUP
> +	select COMMON_CLK
> +	select CPU_V6
> +	select GENERIC_CLOCKEVENTS
> +	select MULTI_IRQ_HANDLER
> +	select SPARSE_IRQ
> +	select USE_OF
> +	select WATCHDOG

All the good things are there, but normally one does not select WATCHDOG here.

> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_NR_UARTS=48
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=32
> +CONFIG_SERIAL_8250_EXTENDED=y
> +CONFIG_SERIAL_8250_MANY_PORTS=y
> +CONFIG_SERIAL_8250_SHARE_IRQ=y
> +CONFIG_SERIAL_AMBA_PL010=y
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
> +CONFIG_SERIAL_AMBA_PL011=y
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=y

All three kinds of serial ports really?

> diff --git a/arch/arm/mach-bcm2708/common.c b/arch/arm/mach-bcm2708/common.c
> new file mode 100644
> index 0000000..85f19aa3
> --- /dev/null
> +++ b/arch/arm/mach-bcm2708/common.c

I think when this is the only file, we probably want to name this one bcm2708.c,
same as the platform.

> diff --git a/arch/arm/mach-bcm2708/include/mach/hardware.h b/arch/arm/mach-bcm2708/include/mach/hardware.h
> new file mode 100644
> index 0000000..2b15d0b
> --- /dev/null
> +++ b/arch/arm/mach-bcm2708/include/mach/hardware.h

No longer required.

> diff --git a/arch/arm/mach-bcm2708/include/mach/timex.h b/arch/arm/mach-bcm2708/include/mach/timex.h
> new file mode 100644
> index 0000000..ca67219
> --- /dev/null
> +++ b/arch/arm/mach-bcm2708/include/mach/timex.h

Very close to not being required any more, so you probably won't need it in 3.7.

	Arnd
