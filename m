From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 16:09:33 +0000
Subject: [RFC PATCH 01/13] picoxcell: add support for picoXcell
In-Reply-To: <1290506774-17895-2-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
	<1290506774-17895-2-git-send-email-jamie@jamieiles.com>
Message-ID: <20101208160933.GK9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 10:06:02AM +0000, Jamie Iles wrote:
> picoXcell is a family of femtocell SoC devices from Picochip [1] with an
> ARM subsystem.  The devices have an ARM1176JZ-S core and a DSP processor
> array.  Currently there are two sub families - PC3X2 and PC3X3. The
> latter includes extra power and performance control along with extra
> peripherals.
> 
> This initial patch adds the hardware definitions and a framework for
> adding device variants.
> 
> 1. http://www.picochip.com
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  arch/arm/Kconfig                                   |   17 ++
>  arch/arm/Makefile                                  |    1 +
>  arch/arm/mach-picoxcell/Kconfig                    |    4 +
>  arch/arm/mach-picoxcell/Makefile                   |    1 +
>  arch/arm/mach-picoxcell/Makefile.boot              |    3 +
>  arch/arm/mach-picoxcell/axi2cfg.c                  |  168 +++++++++++++++++
>  arch/arm/mach-picoxcell/include/mach/debug-macro.S |   18 ++
>  arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 ++
>  arch/arm/mach-picoxcell/include/mach/hardware.h    |   29 +++
>  arch/arm/mach-picoxcell/include/mach/io.h          |   32 +++
>  arch/arm/mach-picoxcell/include/mach/irqs.h        |   89 +++++++++
>  arch/arm/mach-picoxcell/include/mach/memory.h      |   27 +++
>  .../include/mach/picoxcell/axi2cfg.h               |  171 +++++++++++++++++
>  .../mach-picoxcell/include/mach/picoxcell/gpio.h   |   48 +++++
>  .../include/mach/picoxcell/picoxcell.h             |   61 ++++++
>  .../mach-picoxcell/include/mach/picoxcell/timer.h  |   36 ++++
>  .../mach-picoxcell/include/mach/picoxcell/wdog.h   |   43 +++++
>  arch/arm/mach-picoxcell/include/mach/platform.h    |   32 +++
>  arch/arm/mach-picoxcell/include/mach/system.h      |   51 +++++
>  arch/arm/mach-picoxcell/include/mach/timex.h       |   26 +++
>  arch/arm/mach-picoxcell/include/mach/uncompress.h  |   56 ++++++
>  arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 ++
>  arch/arm/mach-picoxcell/picoxcell_core.c           |  199 ++++++++++++++++++++
>  arch/arm/mach-picoxcell/picoxcell_core.h           |   21 ++
>  arch/arm/mach-picoxcell/soc.h                      |   60 ++++++
>  25 files changed, 1230 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 81c71da..9c252da 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -502,6 +502,21 @@ config ARCH_ORION5X
>  	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
>  	  Orion-2 (5281), Orion-1-90 (6183).
>  
> +config ARCH_PICOXCELL
> +	bool "Picochip picoXcell"
> +	select ARM_VIC
> +	select HAS_TLS_REG

This no longer exists.

> +	select GENERIC_TIME

Doesn't exist anymore.

> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_GPIO
> +	select ARCH_REQUIRE_GPIOLIB
> +	select COMMON_CLKDEV

Now called CLKDEV_LOOKUP.

> +#ifdef __ASSEMBLY__
> +# define IO_ADDRESS(x)		    (((x) & 0x00ffffff) | 0xfe000000)
> +#else /* __ASSEMBLY__ */
> +# define PHYS_TO_IO(x)		    (((x) & 0x00ffffff) | 0xfe000000)
> +# define IO_ADDRESS(x)		    __typesafe_io(PHYS_TO_IO((x)))

Not really what __typesafe_io is meant for - please use an explicit cast
instead.

> +#ifndef __ASSEMBLY__
> +
> +#include <linux/init.h>

You don't actually need this...

> +
> +/*
> + * axi2cfg_config_read - Read a number of 16 bit words from a picoArray axi2cfg.
> + *
> + * Returns the number of words read on success, negative errno on failure.
> + *
> + * @axi2cfg_base: The base address of the upper axi2cfg.
> + * @aeid: The CAEID of the AE to read from.
> + * @ae_addr: The address to begin reading from within the AE.
> + * @buf: The buffer to store the results in.
> + * @count: The number of 16 bit words to read.
> + */
> +extern int axi2cfg_config_read(u16 aeid, u16 ae_addr, u16 *buf, u16 count);
> +
> +/*
> + * axi2cfg_config_write - Write a number of 16 bit words to a picoArray axi2cfg.
> + *
> + * @axi2cfg_base: The base address of the upper axi2cfg.
> + * @aeid: The CAEID of the AE to write to.
> + * @ae_addr: The address to begin writing to within the AE.
> + * @buf: The buffer to read the words from.
> + * @count: The number of 16 bit words to write.
> + */
> +extern void axi2cfg_config_write(u16 aeid, u16 ae_addr, const u16 *buf,
> +				 u16 count);
> +
> +/*
> + * ax2cfg_write_buf - Write a series of configuration words to the AXI2CFG
> + *	config write port.
> + *
> + * @buf: The buffer to write.
> + * @nr_words: The number of 32 bit words to write.
> + */
> +extern void axi2cfg_write_buf(const u32 *buf, unsigned nr_words);
> +
> +/*
> + * axi2cfg_init - initialize the AXI2CFG hardware.
> + */
> +extern void __init axi2cfg_init(void);

As you don't need to tell the compiler which section functions are located.

> +/* The clock frequency for the timers on the various boards */
> +#define PICOXCELL_TIMER_FREQ	    200000000	/* 200 MHz */

I'd sugges this goes in timex.h, to avoid including this file unnecessarily.

> diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
> new file mode 100644
> index 0000000..ccaf3d5
> --- /dev/null
> +++ b/arch/arm/mach-picoxcell/include/mach/uncompress.h
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright (c) 2010 Picochip Ltd., Jamie Iles
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#include <asm/processor.h>

Should be after linux/ includes.

> +#define VMALLOC_END		(PAGE_OFFSET + 0x18000000)

Shouldn't be defined in terms of PAGE_OFFSET as this symbol can move.
