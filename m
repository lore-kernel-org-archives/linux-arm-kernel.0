From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 25 Nov 2010 23:55:20 +0000
Subject: [PATCH 2/7] arm/pxa2xx: reorganize I2C files
In-Reply-To: <1290633617-15311-3-git-send-email-bigeasy@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-3-git-send-email-bigeasy@linutronix.de>
Message-ID: <20101125235520.GC15948@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 10:20:12PM +0100, Sebastian Andrzej Siewior wrote:
> This patch moves the register definitions into include/asm so it can be
> accessed from X86 the same way as on ARM. This move also alters the
> unused register offset definitins (IBMR, ...) and uses them in the
> calculation macros (_IBMR,...).
> The header file from plat-pxa is moved the include/linux for the same
> reason.
> This change should make no functional change to the PXA code. The move
> is verified by building the following defconfigs:
>   cm_x2xx_defconfig corgi_defconfig em_x270_defconfig ezx_defconfig
>   imote2_defconfig pxa3xx_defconfig spitz_defconfig zeus_defconfig
>   raumfeld_defconfig magician_defconfig mmp2_defconfig pxa168_defconfig
>   pxa910_defconfig
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
>  arch/arm/include/asm/pxa_i2c.h                     |   19 +++++++++++++++++++
>  arch/arm/mach-mmp/include/mach/mmp2.h              |    2 +-
>  arch/arm/mach-mmp/include/mach/pxa168.h            |    2 +-
>  arch/arm/mach-mmp/include/mach/pxa910.h            |    2 +-
>  arch/arm/mach-pxa/balloon3.c                       |    3 +--
>  arch/arm/mach-pxa/cm-x300.c                        |    2 +-
>  arch/arm/mach-pxa/colibri-pxa270-income.c          |    3 +--
>  arch/arm/mach-pxa/corgi.c                          |    2 +-
>  arch/arm/mach-pxa/csb726.c                         |    2 +-
>  arch/arm/mach-pxa/devices.c                        |    2 +-
>  arch/arm/mach-pxa/em-x270.c                        |    2 +-
>  arch/arm/mach-pxa/ezx.c                            |    2 +-
>  arch/arm/mach-pxa/hx4700.c                         |    2 +-
>  arch/arm/mach-pxa/littleton.c                      |    2 +-
>  arch/arm/mach-pxa/magician.c                       |    2 +-
>  arch/arm/mach-pxa/mainstone.c                      |    2 +-
>  arch/arm/mach-pxa/mioa701.c                        |    2 +-
>  arch/arm/mach-pxa/mxm8x10.c                        |    2 +-
>  arch/arm/mach-pxa/palm27x.c                        |    3 +--
>  arch/arm/mach-pxa/pcm990-baseboard.c               |    2 +-
>  arch/arm/mach-pxa/poodle.c                         |    2 +-
>  arch/arm/mach-pxa/pxa27x.c                         |    2 +-
>  arch/arm/mach-pxa/pxa3xx.c                         |    2 +-
>  arch/arm/mach-pxa/raumfeld.c                       |    2 +-
>  arch/arm/mach-pxa/saar.c                           |    2 +-
>  arch/arm/mach-pxa/spitz.c                          |    3 +--
>  arch/arm/mach-pxa/stargate2.c                      |    2 +-
>  arch/arm/mach-pxa/tavorevb3.c                      |    3 +--
>  arch/arm/mach-pxa/tosa.c                           |    2 +-
>  arch/arm/mach-pxa/trizeps4.c                       |    2 +-
>  arch/arm/mach-pxa/viper.c                          |    2 +-
>  arch/arm/mach-pxa/vpac270.c                        |    3 +--
>  arch/arm/mach-pxa/xcep.c                           |    3 +--
>  arch/arm/mach-pxa/z2.c                             |    3 +--
>  arch/arm/mach-pxa/zeus.c                           |    3 +--
>  arch/arm/mach-pxa/zylonite_pxa300.c                |    2 +-
>  drivers/i2c/busses/i2c-pxa.c                       |   16 ++--------------
>  .../plat/i2c.h => include/linux/i2c/pxa-i2c.h      |    1 +
>  38 files changed, 57 insertions(+), 58 deletions(-)
>  create mode 100644 arch/arm/include/asm/pxa_i2c.h
>  rename arch/arm/plat-pxa/include/plat/i2c.h => include/linux/i2c/pxa-i2c.h (99%)
> 
> diff --git a/arch/arm/include/asm/pxa_i2c.h b/arch/arm/include/asm/pxa_i2c.h
> new file mode 100644
> index 0000000..f6da8a1
> --- /dev/null
> +++ b/arch/arm/include/asm/pxa_i2c.h
> @@ -0,0 +1,19 @@
> +#ifndef __ASM_PXA_I2C_H__
> +#define __ASM_PXA_I2C_H__
> +
> +/*
> + * I2C registers definitions
> + */
> +#define IBMR		(0x00)
> +#define IDBR		(0x04)
> +#define ICR		(0x08)
> +#define ISR		(0x0c)
> +#define ISAR		(0x10)
> +
> +#define _IBMR(i2c)	((i2c)->reg_base + (IBMR << (i2c)->reg_shift))
> +#define _IDBR(i2c)	((i2c)->reg_base + (IDBR << (i2c)->reg_shift))
> +#define _ICR(i2c)	((i2c)->reg_base + (ICR << (i2c)->reg_shift))
> +#define _ISR(i2c)	((i2c)->reg_base + (ISR << (i2c)->reg_shift))
> +#define _ISAR(i2c)	((i2c)->reg_base + (ISAR << (i2c)->reg_shift))
> +
> +#endif
> diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
> index dbba6e8..95adfea 100644
> --- a/arch/arm/mach-mmp/include/mach/mmp2.h
> +++ b/arch/arm/mach-mmp/include/mach/mmp2.h
> @@ -9,8 +9,8 @@ extern void __init mmp2_init_irq(void);
>  extern void mmp2_clear_pmic_int(void);
>  
>  #include <linux/i2c.h>
> +#include <linux/i2c/pxa-i2c.h>
>  #include <mach/devices.h>
> -#include <plat/i2c.h>

Anyone an opinion on whther to alter all arch-arm machine includes
or add a re-direct of plat/i2c.h to linux/i2c/pxa-i2c.h


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
