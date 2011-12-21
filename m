From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Dec 2011 16:34:15 +0000
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201112211634.15954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 December 2011, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> currently this relies on the bootloader to enable all necessary clocks
> because there is no functional clk API, yet.
> 
> Other than that my machine comes up, but the 1 MiB of RAM is very tight,
> so I have to stick to XIP.
> 
> Also note that this depends on ARMv7M support that is picked from
> Catalin's repository. I didn't come around yet to rework them into a
> shape acceptable for mainline. I ported them to 3.2-rc and needed a few
> more hacks (e.g. I don't have a bootloader, so I added a little
> assembler bootloader that is included at the start of my xipImage).
> If you're interested in the details I can publish my tree I think.

Hi Uwe,

It's great to see you managed to get the port done using the device tree.
You mentioned earlier that you were worried about the object size overhead
in doing so. Do you have any numbers already about the actual memory
consumption of the DT based port compared to your earlier one?

> +	chosen {
> +		bootargs = "console=ttyefm1,115200 init=/linuxrc ignore_loglevel ihash_entries=64 dhash_entries=64";
> +	};

I don't know how we do this on other boards, but is it intentional to 
leave the bootargs in the device tree source? I would expect that they
normally would have to be changed by the boot loader.

> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&nvic>;
> +		ranges;
> +
> +		uart1: uart at 0x4000c400 { /* USART1 */
> +			compatible = "efm32,usart";
> +			reg = <0x4000c400 0x400>;
> +			interrupts = <15>;
> +			status = "ok";
> +		};
> +	};

This will have to grow to include the other devices for inclusion, right?

> diff --git a/arch/arm/mach-efm32/Makefile b/arch/arm/mach-efm32/Makefile
> new file mode 100644
> index 0000000..10a3426
> --- /dev/null
> +++ b/arch/arm/mach-efm32/Makefile
> @@ -0,0 +1,3 @@
> +obj-y += clk.o time.o
> +
> +obj-$(CONFIG_OF) += dtmachine.o

I think you can rename the dtmachine.c file into common.c or similar and build
it unconditionally, as we do on the other new platforms.

> diff --git a/arch/arm/mach-efm32/include/mach/io.h b/arch/arm/mach-efm32/include/mach/io.h
> new file mode 100644
> index 0000000..00b6af6
> --- /dev/null
> +++ b/arch/arm/mach-efm32/include/mach/io.h
> @@ -0,0 +1,7 @@
> +#ifndef __MACH_IO_H__
> +#define __MACH_IO_H__
> +
> +#define __io(a)			__typesafe_io(a)
> +#define __mem_pci(a)		(a)
> +
> +#endif /* __MACH_IO_H__ */

Can you already build with __io not defined? That should catch any drivers
that try to access the PC-style I/O ports.

> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +	/* XXX: move this to (say) cpuv7m_reset */
> +	dsb();
> +	__raw_writel(0x05fa0004, (void __iomem *)0xe000ed0c);
> +	dsb();
> +}

I'd like to hear other opinions on this one. It's clearly an ugly hack
to just poke a random MMIO register for reset, but we could decide
that it's useful enough to keep the implementation just like this
because a cleaner implementation using a device_node and io_iomap
just causes overhead that you don't want to spend a system that
is so limited on memory.

As Jamie mentioned, using writel_relaxed() would be better here
and cause no overhead.

> +/* just a bogus value */
> +#define CLOCK_TICK_RATE	12345678

I think you should actually pick a number that results in no rounding
in the jiffies code. 1000000 would be a reasonable choice, as would
any other multiple of HZ.

> diff --git a/arch/arm/mach-efm32/time.c b/arch/arm/mach-efm32/time.c
> new file mode 100644
> index 0000000..65f93a3
> --- /dev/null
> +++ b/arch/arm/mach-efm32/time.c

I think Jamie already said everything necessary about this file.

> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -432,7 +432,7 @@ config CPU_V7
>  # ARMv7
>  config CPU_V7M
>  	bool "Support ARMv7-M processors"
> -	depends on MACH_REALVIEW_EB && EXPERIMENTAL
> +	depends on (MACH_REALVIEW_EB && EXPERIMENTAL) || ARCH_EFM32
>  	select THUMB2_KERNEL
>  	select ARM_THUMB
>  	select CPU_32v7M

Hmm, since you *have* to enable this option for a successful build, wouldn't it
make more sense to 'select' this from ARCH_EFM32.

	Arnd
