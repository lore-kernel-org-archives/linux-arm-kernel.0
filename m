From: olof@lixom.net (Olof Johansson)
Date: Wed, 28 Aug 2013 12:55:46 -0700
Subject: [PATCH] ARM: new platform for Energy Micro's EFM32 Cortex-M3 SoCs
In-Reply-To: <1376552964-16296-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1376552964-16296-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130828195546.GK8607@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 15, 2013 at 09:49:24AM +0200, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/Kconfig                               |  15 +-
>  arch/arm/Kconfig.debug                         |  16 ++
>  arch/arm/Makefile                              |   1 +
>  arch/arm/boot/dts/Makefile                     |   1 +
>  arch/arm/boot/dts/armv7-m.dtsi                 |  18 ++
>  arch/arm/boot/dts/efm32gg-dk3750.dts           |  63 ++++++
>  arch/arm/boot/dts/efm32gg.dtsi                 | 141 +++++++++++++
>  arch/arm/configs/efm32_defconfig               | 104 ++++++++++
>  arch/arm/mach-efm32/Makefile                   |   1 +
>  arch/arm/mach-efm32/Makefile.boot              |   2 +
>  arch/arm/mach-efm32/cmu.h                      |  15 ++
>  arch/arm/mach-efm32/common.h                   |   1 +
>  arch/arm/mach-efm32/dtmachine.c                |  31 +++
>  arch/arm/mach-efm32/include/mach/debug-macro.S |  48 +++++
>  arch/arm/mach-efm32/include/mach/entry-macro.S |   5 +
>  arch/arm/mach-efm32/include/mach/io.h          |   6 +
>  arch/arm/mach-efm32/include/mach/irqs.h        |   6 +
>  arch/arm/mach-efm32/include/mach/timex.h       |   7 +
>  arch/arm/mach-efm32/time.c                     | 261 +++++++++++++++++++++++++
>  19 files changed, 741 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/armv7-m.dtsi
>  create mode 100644 arch/arm/boot/dts/efm32gg-dk3750.dts
>  create mode 100644 arch/arm/boot/dts/efm32gg.dtsi
>  create mode 100644 arch/arm/configs/efm32_defconfig
>  create mode 100644 arch/arm/mach-efm32/Makefile
>  create mode 100644 arch/arm/mach-efm32/Makefile.boot
>  create mode 100644 arch/arm/mach-efm32/cmu.h
>  create mode 100644 arch/arm/mach-efm32/common.h
>  create mode 100644 arch/arm/mach-efm32/dtmachine.c
>  create mode 100644 arch/arm/mach-efm32/include/mach/debug-macro.S
>  create mode 100644 arch/arm/mach-efm32/include/mach/entry-macro.S
>  create mode 100644 arch/arm/mach-efm32/include/mach/io.h
>  create mode 100644 arch/arm/mach-efm32/include/mach/irqs.h
>  create mode 100644 arch/arm/mach-efm32/include/mach/timex.h
>  create mode 100644 arch/arm/mach-efm32/time.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 43594d5..d45cc5d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -404,6 +404,19 @@ config ARCH_EBSA110
>  	  Ethernet interface, two PCMCIA sockets, two serial ports and a
>  	  parallel port.
>  
> +config ARCH_EFM32
> +	bool "Energy Micro Cortex M3 Platform"
> +	depends on !MMU
> +	select ARM_NVIC
> +	select CLKSRC_MMIO
> +	select COMMON_CLK
> +	select CPU_V7M
> +	select GENERIC_CLOCKEVENTS
> +	select HAVE_CLK
> +	select NO_DMA
> +	select NO_IOPORT
> +	select USE_OF
> +
>  config ARCH_EP93XX
>  	bool "EP93xx-based"
>  	select ARCH_HAS_HOLES_MEMORYMODEL
> @@ -1762,7 +1775,7 @@ config FORCE_MAX_ZONEORDER
>  	int "Maximum zone order" if ARCH_SHMOBILE
>  	range 11 64 if ARCH_SHMOBILE
>  	default "12" if SOC_AM33XX
> -	default "9" if SA1111
> +	default "9" if SA1111 || ARCH_EFM32
>  	default "11"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 583f4a0..1d99e38 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -167,6 +167,22 @@ choice
>  		  Say Y here if you want the debug print routines to direct
>  		  their output to the serial port in the DC21285 (Footbridge).
>  
> +	config DEBUG_EFM32_UART1
> +		bool "Kernel low-level debugging messages via UART1 (ttyefm4)"
> +		depends on ARCH_EFM32
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to the second UART port on efm32 based
> +		  machines.
> +
> +	config DEBUG_EFM32_USART1
> +		bool "Kernel low-level debugging messages via USART1 (ttyefm1)"
> +		depends on ARCH_EFM32
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to the second USART port on efm32 based
> +		  machines.
> +
>  	config DEBUG_FOOTBRIDGE_COM1
>  		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
>  		depends on FOOTBRIDGE

Make sure this doesn't conflict with the rework that Russell has done for
Kconfig.debug in his for-3.12 branch. It might be better to either merge
a separate patch for it through him, or just hold off one release with it.

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 6fd2cea..ae48049 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -152,6 +152,7 @@ machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
>  machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
>  machine-$(CONFIG_ARCH_DOVE)		+= dove
>  machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
> +machine-$(CONFIG_ARCH_EFM32)		+= efm32
>  machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
>  machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
>  machine-$(CONFIG_ARCH_GEMINI)		+= gemini
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..dd3b47e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -48,6 +48,7 @@ dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
>  dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
>  	dove-cubox.dtb \
>  	dove-dove-db.dtb
> +dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
>  dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>  	exynos4210-smdkv310.dtb \
>  	exynos4210-trats.dtb \
> diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
> new file mode 100644
> index 0000000..dc2cf8d
> --- /dev/null
> +++ b/arch/arm/boot/dts/armv7-m.dtsi
> @@ -0,0 +1,18 @@
> +#include "skeleton.dtsi"
> +
> +/ {
> +	nvic: nv-interrupt-controller at 0xe0000000  {

No 0x in unit specifiers here and elsewhere.

> +		compatible = "arm,armv7m-nvic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0xe000e100 0xc00>;

If reg is 0xe000e100, then so should the unit specifier. Or it shouldn't be
there at all (i.e. it's not needed unless there are multiple nodes with the
same name).

> diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
> new file mode 100644
> index 0000000..4ae1ffc
> --- /dev/null
> +++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
> @@ -0,0 +1,63 @@
> +/dts-v1/;
> +#include "efm32gg.dtsi"
> +
> +/ {
> +	model = "Energy Micro Giant Gecko Development Kit";
> +	compatible = "efm32,dk3750";
> +
> +	chosen {
> +		bootargs = "console=ttyefm4,115200 init=/linuxrc ignore_loglevel ihash_entries=64 dhash_entries=64 earlyprintk uclinux.physaddr=0x8c400000 root=/dev/mtdblock0";
> +	};
> +
> +	memory {
> +		reg = <0x88000000 0x400000>;
> +	};
> +
> +	soc {
> +		adc at 0x40002000 {
> +			status = "ok";
> +		};
> +
> +		spi0: spi at 0x4000c000 { /* USART0 */
> +			cs-gpios = <&gpio 68 1>; // E4
> +			location = <1>;
> +			status = "ok";
> +
> +			microsd at 0 {
> +				compatible = "mmc-spi-slot";
> +				spi-max-frequency = <100000>;
> +				voltage-ranges = <3200 3400>;
> +				broken-cd;
> +				reg = <0>;
> +			};
> +		};
> +
> +		spi1: spi at 0x4000c400 { /* USART1 */
> +			cs-gpios = <&gpio 51 1>; // D3
> +			location = <1>;
> +			status = "ok";
> +
> +			ks8851 at 0 {
> +				compatible = "ks8851";
> +				spi-max-frequency = <6000000>;
> +				reg = <0>;
> +				interrupt-parent = <&boardfpga>;
> +				interrupts = <4>;
> +			};
> +		};
> +
> +		uart4: uart at 0x4000e400 { /* UART1 */
> +			location = <2>;
> +			status = "ok";
> +		};
> +
> +		boardfpga: boardfpga at 0x80000000 {
> +			compatible = "efm32board";
> +			reg = <0x80000000 0x400>;
> +			irq-gpios = <&gpio 64 1>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			status = "ok";
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-efm32/include/mach/debug-macro.S b/arch/arm/mach-efm32/include/mach/debug-macro.S
> new file mode 100644
> index 0000000..c58915c
> --- /dev/null
> +++ b/arch/arm/mach-efm32/include/mach/debug-macro.S
> @@ -0,0 +1,48 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define UARTn_CMD		0x000c
> +#define UARTn_CMD_TXEN			0x0004
> +
> +#define	UARTn_STATUS		0x0010
> +#define	UARTn_STATUS_TXC		0x0020
> +#define	UARTn_STATUS_TXBL		0x0040
> +
> +#define	UARTn_TXDATA		0x0034
> +
> +		.macro	addruart, rx, tmp
> +#if defined(CONFIG_DEBUG_EFM32_USART1)
> +		ldr	\rx, =(0x4000c400)		/* USART1 */
> +#elif defined(CONFIG_DEBUG_EFM32_UART1)
> +		ldr	\rx, =(0x4000e400)		/* UART1 */
> +#else
> +#error "No debug port configured"
> +#endif
> +		/*
> +		 * enable TX. The driver might disable that to save energy. We
> +		 * don't care about disabling at the end as during debug power
> +		 * consumption isn't that important.
> +		 */
> +		ldr	\tmp, =(UARTn_CMD_TXEN)
> +		str	\tmp, [\rx, #UARTn_CMD]
> +		.endm
> +
> +
> +		.macro	senduart,rd,rx
> +		strb	\rd, [\rx, #UARTn_TXDATA]
> +		.endm
> +
> +		.macro	waituart,rd,rx
> +1001:		ldr	\rd, [\rx, #UARTn_STATUS]
> +		tst	\rd, #UARTn_STATUS_TXBL
> +		beq	1001b
> +		.endm
> +
> +		.macro	busyuart,rd,rx
> +1001:		ldr	\rd, [\rx, UARTn_STATUS]
> +		tst	\rd, #UARTn_STATUS_TXC
> +		bne	1001b
> +		.endm

Same with this w.r.t. coordinating with Russell's cleanups.

> diff --git a/arch/arm/mach-efm32/time.c b/arch/arm/mach-efm32/time.c
> new file mode 100644
> index 0000000..db96dfb
> --- /dev/null
> +++ b/arch/arm/mach-efm32/time.c

Shouldn't this be a drivers/clocksource driver instead?



-Olof
