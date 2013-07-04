From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 04 Jul 2013 17:02:30 +0200
Subject: [PATCH v3] ARM: shmobile: lager: Add DT reference
In-Reply-To: <1372838251-6314-1-git-send-email-horms+renesas@verge.net.au>
References: <1372838251-6314-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1438555.HIWtKGAp3v@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wednesday 03 July 2013 16:57:31 Simon Horman wrote:
> This is sufficient to allow boot of the Lager board with a console without
> boards-lager.c compiled into the kernel. This is an example of a minimal but
> still useful initialisation of the board using DT as much as possible.
> 
> As such it is the same as the boot of Lager that can be achieved without a
> board file. The intention of adding this file is to facilitate further work
> to allow board specific devices to be initialised via DT.

At some (hopefully not too distant) point we should stop adding both 
traditional and DT board files. DT is supposed to lower the number of board 
files, not multiply it by two.

Work is still needed in order to achieve this, as we lack DT bindings for core 
(and non core) devices. That's something we need to work on. As a first step, 
do we have a roadmap with a list of devices that lack DT support ? At the very 
least I see more work needed on

- Common clock framework
- SCI
- Timers

We shouldn't delay CCF much longer, v3.12 seems an achievable target to me. 
Who will work on that ?

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v3
> * Supply temporary machine_init call-back in lager-reference.c to
>   initialise clocks and bring up SCIF and CMT in C. Magnus
>   advised me that this is not desired in the SoC code.
> * Add lager-reference to Makefile.boot
> 
> v2
> * Use recently added r8a7790_init_delay()
> ---
>  arch/arm/boot/dts/Makefile                     |  1 +
>  arch/arm/boot/dts/r8a7790-lager-reference.dts  | 31 +++++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                 | 11 ++++++
>  arch/arm/mach-shmobile/Makefile                |  1 +
>  arch/arm/mach-shmobile/Makefile.boot           |  1 +
>  arch/arm/mach-shmobile/board-lager-reference.c | 46 +++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/r8a7790.h  |  1 +
>  arch/arm/mach-shmobile/setup-r8a7790.c         |  9 +++--
>  8 files changed, 99 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a7790-lager-reference.dts
>  create mode 100644 arch/arm/mach-shmobile/board-lager-reference.c
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index cb31259..f2dc697 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -165,6 +165,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
>  	r8a7740-armadillo800eva-reference.dtb \
>  	r8a7779-marzen-reference.dtb \
>  	r8a7790-lager.dtb \
> +	r8a7790-lager-reference.dtb \
>  	sh73a0-kzm9g.dtb \
>  	sh73a0-kzm9g-reference.dtb \
>  	r8a73a4-ape6evm.dtb \
> diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts
> b/arch/arm/boot/dts/r8a7790-lager-reference.dts new file mode 100644
> index 0000000..fa5b81b
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
> @@ -0,0 +1,31 @@
> +/*
> + * Device Tree Source for the Lager board
> + *
> + * Copyright (C) 2013 Renesas Solutions Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "r8a7790.dtsi"
> +
> +/ {
> +	model = "Lager";
> +	compatible = "renesas,lager-reference", "renesas,r8a7790";
> +
> +	chosen {
> +		bootargs = "console=ttySC6,115200 ignore_loglevel";
> +	};
> +
> +	memory at 40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	lbsc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 64dc24d..30c571b 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -150,6 +150,17 @@ config MACH_LAGER
>  	depends on ARCH_R8A7790
>  	select USE_OF
> 
> +config MACH_LAGER_REFERENCE
> +	bool "Lager board - Reference Device Tree Implementation"
> +	depends on ARCH_R8A7790
> +	select USE_OF
> +	---help---
> +	   Use reference implementation of Lager board support
> +	   which makes use of device tree at the expense
> +	   of not supporting a number of devices.
> +
> +	   This is intended to aid developers
> +
>  config MACH_KZM9D
>  	bool "KZM9D board"
>  	depends on ARCH_EMEV2
> diff --git a/arch/arm/mach-shmobile/Makefile
> b/arch/arm/mach-shmobile/Makefile index 6165a51..d813133 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
>  obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
>  obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
>  obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
> +obj-$(CONFIG_MACH_LAGER_REFERENCE)	+= board-lager-reference.o
>  obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
>  obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+=
> board-armadillo800eva-reference.o obj-$(CONFIG_MACH_KZM9D)	+= board-
kzm9d.o
> diff --git a/arch/arm/mach-shmobile/Makefile.boot
> b/arch/arm/mach-shmobile/Makefile.boot index 84c6868..16834d8 100644
> --- a/arch/arm/mach-shmobile/Makefile.boot
> +++ b/arch/arm/mach-shmobile/Makefile.boot
> @@ -10,6 +10,7 @@ loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000
>  loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
>  loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
>  loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
> +loadaddr-$(CONFIG_MACH_LAGER_REFERENCE) += 0x40008000
>  loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
>  loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
>  loadaddr-$(CONFIG_MACH_MARZEN_REFERENCE) += 0x60008000
> diff --git a/arch/arm/mach-shmobile/board-lager-reference.c
> b/arch/arm/mach-shmobile/board-lager-reference.c new file mode 100644
> index 0000000..eb6c55e
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/board-lager-reference.c
> @@ -0,0 +1,46 @@
> +/*
> + * Lager board support - Reference DT implementation
> + *
> + * Copyright (C) 2013  Renesas Solutions Corp.
> + * Copyright (C) 2013  Simon Horman
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 
> USA + */
> +
> +#include <linux/init.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_platform.h>
> +#include <mach/r8a7790.h>
> +#include <asm/mach/arch.h>
> +
> +void __init lager_add_standard_devices(void)
> +{
> +	/* clocks are setup late during boot in the case of DT */
> +	r8a7790_clock_init();
> +
> +	r8a7790_add_dt_devices();
> +        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char *lager_boards_compat_dt[] __initdata = {
> +	"renesas,lager-reference",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(LAGER_DT, "lager")
> +	.init_early	= r8a7790_init_delay,
> +	.init_machine	= lager_add_standard_devices,
> +	.init_time	= r8a7790_timer_init,
> +	.dt_compat	= lager_boards_compat_dt,
> +MACHINE_END
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h
> b/arch/arm/mach-shmobile/include/mach/r8a7790.h index 7851cc1..421d842
> 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
> @@ -2,6 +2,7 @@
>  #define __ASM_R8A7790_H__
> 
>  void r8a7790_add_standard_devices(void);
> +void r8a7790_add_dt_devices(void);
>  void r8a7790_clock_init(void);
>  void r8a7790_pinmux_init(void);
>  void r8a7790_init_delay(void);
> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c
> b/arch/arm/mach-shmobile/setup-r8a7790.c index f01542e..7f01178 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -179,7 +179,7 @@ static struct resource cmt00_resources[] = {
>  					  &cmt##idx##_platform_data,	\
>  					  sizeof(struct sh_timer_config))
> 
> -void __init r8a7790_add_standard_devices(void)
> +void __init r8a7790_add_dt_devices(void)
>  {
>  	r8a7790_register_scif(SCIFA0);
>  	r8a7790_register_scif(SCIFA1);
> @@ -191,9 +191,14 @@ void __init r8a7790_add_standard_devices(void)
>  	r8a7790_register_scif(SCIF1);
>  	r8a7790_register_scif(HSCIF0);
>  	r8a7790_register_scif(HSCIF1);
> +	r8a7790_register_cmt(00);
> +}
> +
> +void __init r8a7790_add_standard_devices(void)
> +{
> +	r8a7790_add_dt_devices();
>  	r8a7790_register_irqc(0);
>  	r8a7790_register_thermal();
> -	r8a7790_register_cmt(00);
>  }
> 
>  void __init r8a7790_timer_init(void)
-- 
Regards,

Laurent Pinchart
