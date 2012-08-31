From: gerg@snapgear.com (Greg Ungerer)
Date: Fri, 31 Aug 2012 16:25:52 +1000
Subject: [PATCH 1/4] ARM: ks-8695: merge the timer header into the timer
 driver
In-Reply-To: <1346264802-20306-1-git-send-email-linus.walleij@linaro.org>
References: <1346264802-20306-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <504058F0.9060705@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2012 04:26 AM, Linus Walleij wrote:
> This <mach/regs-timer.h> is broadcasted in the entire kernel for
> no good reason, since it's only used by the timer driver. Merge
> it into the driver.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Greg Ungerer <gerg@snapgear.com>


> ---
>   arch/arm/mach-ks8695/include/mach/regs-timer.h |   40 ------------------------
>   arch/arm/mach-ks8695/time.c                    |   21 ++++++++++++-
>   2 files changed, 20 insertions(+), 41 deletions(-)
>   delete mode 100644 arch/arm/mach-ks8695/include/mach/regs-timer.h
>
> diff --git a/arch/arm/mach-ks8695/include/mach/regs-timer.h b/arch/arm/mach-ks8695/include/mach/regs-timer.h
> deleted file mode 100644
> index e620cda..0000000
> --- a/arch/arm/mach-ks8695/include/mach/regs-timer.h
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -/*
> - * arch/arm/mach-ks8695/include/mach/regs-timer.h
> - *
> - * Copyright (C) 2006 Ben Dooks <ben@simtec.co.uk>
> - * Copyright (C) 2006 Simtec Electronics
> - *
> - * KS8695 - Timer registers and bit definitions.
> - *
> - * This file is licensed under  the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef KS8695_TIMER_H
> -#define KS8695_TIMER_H
> -
> -#define KS8695_TMR_OFFSET	(0xF0000 + 0xE400)
> -#define KS8695_TMR_VA		(KS8695_IO_VA + KS8695_TMR_OFFSET)
> -#define KS8695_TMR_PA		(KS8695_IO_PA + KS8695_TMR_OFFSET)
> -
> -
> -/*
> - * Timer registers
> - */
> -#define KS8695_TMCON		(0x00)		/* Timer Control Register */
> -#define KS8695_T1TC		(0x04)		/* Timer 1 Timeout Count Register */
> -#define KS8695_T0TC		(0x08)		/* Timer 0 Timeout Count Register */
> -#define KS8695_T1PD		(0x0C)		/* Timer 1 Pulse Count Register */
> -#define KS8695_T0PD		(0x10)		/* Timer 0 Pulse Count Register */
> -
> -
> -/* Timer Control Register */
> -#define TMCON_T1EN		(1 << 1)	/* Timer 1 Enable */
> -#define TMCON_T0EN		(1 << 0)	/* Timer 0 Enable */
> -
> -/* Timer0 Timeout Counter Register */
> -#define T0TC_WATCHDOG		(0xff)		/* Enable watchdog mode */
> -
> -
> -#endif
> diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
> index ec783a3..6427b7c 100644
> --- a/arch/arm/mach-ks8695/time.c
> +++ b/arch/arm/mach-ks8695/time.c
> @@ -29,11 +29,30 @@
>   #include <asm/mach/time.h>
>   #include <asm/system_misc.h>
>
> -#include <mach/regs-timer.h>
>   #include <mach/regs-irq.h>
>
>   #include "generic.h"
>
> +#define KS8695_TMR_OFFSET	(0xF0000 + 0xE400)
> +#define KS8695_TMR_VA		(KS8695_IO_VA + KS8695_TMR_OFFSET)
> +#define KS8695_TMR_PA		(KS8695_IO_PA + KS8695_TMR_OFFSET)
> +
> +/*
> + * Timer registers
> + */
> +#define KS8695_TMCON		(0x00)		/* Timer Control Register */
> +#define KS8695_T1TC		(0x04)		/* Timer 1 Timeout Count Register */
> +#define KS8695_T0TC		(0x08)		/* Timer 0 Timeout Count Register */
> +#define KS8695_T1PD		(0x0C)		/* Timer 1 Pulse Count Register */
> +#define KS8695_T0PD		(0x10)		/* Timer 0 Pulse Count Register */
> +
> +/* Timer Control Register */
> +#define TMCON_T1EN		(1 << 1)	/* Timer 1 Enable */
> +#define TMCON_T0EN		(1 << 0)	/* Timer 0 Enable */
> +
> +/* Timer0 Timeout Counter Register */
> +#define T0TC_WATCHDOG		(0xff)		/* Enable watchdog mode */
> +
>   /*
>    * Returns number of ms since last clock interrupt.  Note that interrupts
>    * will have been disabled by do_gettimeoffset()
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
