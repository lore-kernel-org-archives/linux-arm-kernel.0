From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 7 Dec 2010 09:09:27 +0100
Subject: [PATCH 11/14] OMAP4: PRCM: reorganize existing OMAP4 PRCM header
	files
In-Reply-To: <20101207012514.3708.87532.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012514.3708.87532.stgit@twilight.localdomain>
Message-ID: <4CFDEBB7.8040309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Paul,

On 12/7/2010 2:25 AM, Paul Walmsley wrote:
> Split the existing cm44xx.h file into cm1_44xx.h and cm2_44xx.h files
> so they match their underlying OMAP hardware modules.  Add clockdomain
> offset information.
>
> Add header files for the MPU local PRCM, prcm_mpu44xx.h, and for the
> SCRM, scrm44xx.h.  SCRM register offsets still need to be added; TI
> should do this.

And we did it :-)

I sent it last week along with clock data series:
https://patchwork.kernel.org/patch/373751/

OK, I've just realized that it was a little bit hidden in the clock data 
patch, and maybe we should have been sent two patches.
Sorry for that. Do you want to take it in that series, or should I 
re-sent the clock data one?

Regards,
Benoit

>
> Move the "_MOD" macros out of the prcm-common.h header file, into the
> header file of the hardware module that they belong to.  For example,
> OMAP4430_PRM_*_MOD macros have been moved into the prm44xx.h header.
>
> Adjust #includes of all files that used the old PRCM header file names
> to point to the new filenames.
>
> The autogeneration scripts have been updated accordingly.
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Beno?t Cousson<b-cousson@ti.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/clock44xx_data.c        |    4
>   arch/arm/mach-omap2/clockdomains44xx_data.c |    8
>   arch/arm/mach-omap2/cm.h                    |    5
>   arch/arm/mach-omap2/cm1_44xx.h              |  256 ++++++++++
>   arch/arm/mach-omap2/cm2_44xx.h              |  232 +--------
>   arch/arm/mach-omap2/cm44xx.h                |  667 +--------------------------
>   arch/arm/mach-omap2/omap_hwmod.c            |    1
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |    4
>   arch/arm/mach-omap2/powerdomain.c           |    1
>   arch/arm/mach-omap2/powerdomain44xx.c       |    2
>   arch/arm/mach-omap2/powerdomains44xx_data.c |    4
>   arch/arm/mach-omap2/prcm-common.h           |   79 ---
>   arch/arm/mach-omap2/prcm.c                  |    1
>   arch/arm/mach-omap2/prcm_mpu44xx.h          |   91 ++++
>   arch/arm/mach-omap2/prm.h                   |   17 -
>   arch/arm/mach-omap2/prm44xx.c               |    2
>   arch/arm/mach-omap2/prm44xx.h               |  107 ++--
>   arch/arm/mach-omap2/scrm44xx.h              |   32 +
>   18 files changed, 502 insertions(+), 1011 deletions(-)
>   create mode 100644 arch/arm/mach-omap2/cm1_44xx.h
>   copy arch/arm/mach-omap2/{cm44xx.h =>  cm2_44xx.h} (68%)
>   create mode 100644 arch/arm/mach-omap2/prcm_mpu44xx.h
>   create mode 100644 arch/arm/mach-omap2/scrm44xx.h
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 1599836..2605e2e 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -30,9 +30,11 @@
>
>   #include "clock.h"
>   #include "clock44xx.h"
> -#include "cm.h"
> +#include "cm1_44xx.h"
> +#include "cm2_44xx.h"
>   #include "cm-regbits-44xx.h"
>   #include "prm.h"
> +#include "prm44xx.h"
>   #include "prm-regbits-44xx.h"
>   #include "control.h"
>
> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
> index c847a8b..d4a5206 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -28,10 +28,12 @@
>
>   #include<plat/clockdomain.h>
>
> -#include "cm44xx.h"
> -#include "prm44xx.h"
> +#include "cm1_44xx.h"
> +#include "cm2_44xx.h"
>   #include "cm-regbits-44xx.h"
> -#include "prm-regbits-44xx.h"
> +#include "prm44xx.h"
> +#include "prcm_mpu44xx.h"
> +
>
>   static struct clockdomain l4_cefuse_44xx_clkdm = {
>          .name             = "l4_cefuse_clkdm",
> diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
> index a02ca30..bf21375 100644
> --- a/arch/arm/mach-omap2/cm.h
> +++ b/arch/arm/mach-omap2/cm.h
> @@ -22,10 +22,7 @@
>                          OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
>   #define OMAP34XX_CM_REGADDR(module, reg)                               \
>                          OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
> -#define OMAP44XX_CM1_REGADDR(module, reg)                              \
> -                       OMAP2_L4_IO_ADDRESS(OMAP4430_CM1_BASE + (module) + (reg))
> -#define OMAP44XX_CM2_REGADDR(module, reg)                              \
> -                       OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE + (module) + (reg))
> +
>
>   #include "cm44xx.h"
>
> diff --git a/arch/arm/mach-omap2/cm1_44xx.h b/arch/arm/mach-omap2/cm1_44xx.h
> new file mode 100644
> index 0000000..f3bba21
> --- /dev/null
> +++ b/arch/arm/mach-omap2/cm1_44xx.h
> @@ -0,0 +1,256 @@
> +/*
> + * OMAP44xx CM1 instance offset macros
> + *
> + * Copyright (C) 2009-2010 Texas Instruments, Inc.
> + * Copyright (C) 2009-2010 Nokia Corporation
> + *
> + * Paul Walmsley (paul at pwsan.com)
> + * Rajendra Nayak (rnayak at ti.com)
> + * Benoit Cousson (b-cousson at ti.com)
> + *
> + * This file is automatically generated from the OMAP hardware databases.
> + * We respectfully ask that any modifications to this file be coordinated
> + * with the public linux-omap at vger.kernel.org mailing list and the
> + * authors above to ensure that the autogeneration scripts are kept
> + * up-to-date with the file contents.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
> + *     or "OMAP4430".
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_CM1_44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_CM1_44XX_H
> +
> +/* CM1 base address */
> +#define OMAP4430_CM1_BASE              0x4a004000
> +
> +#define OMAP44XX_CM1_REGADDR(module, reg)                              \
> +       OMAP2_L4_IO_ADDRESS(OMAP4430_CM1_BASE + (module) + (reg))
> +
> +/* CM1 instances */
> +#define OMAP4430_CM1_OCP_SOCKET_MOD    0x0000
> +#define OMAP4430_CM1_CKGEN_MOD         0x0100
> +#define OMAP4430_CM1_MPU_MOD           0x0300
> +#define OMAP4430_CM1_TESLA_MOD         0x0400
> +#define OMAP4430_CM1_ABE_MOD           0x0500
> +#define OMAP4430_CM1_RESTORE_MOD       0x0e00
> +#define OMAP4430_CM1_INSTR_MOD         0x0f00
> +
> +/* CM1 */
> +
> +/* CM1.OCP_SOCKET_CM1 register offsets */
> +#define OMAP4_REVISION_CM1_OFFSET                      0x0000
> +#define OMAP4430_REVISION_CM1                          OMAP44XX_CM1_REGADDR(OMAP4430_CM1_OCP_SOCKET_MOD, 0x0000)
> +#define OMAP4_CM_CM1_PROFILING_CLKCTRL_OFFSET          0x0040
> +#define OMAP4430_CM_CM1_PROFILING_CLKCTRL              OMAP44XX_CM1_REGADDR(OMAP4430_CM1_OCP_SOCKET_MOD, 0x0040)
> +
> +/* CM1.CKGEN_CM1 register offsets */
> +#define OMAP4_CM_CLKSEL_CORE_OFFSET                    0x0000
> +#define OMAP4430_CM_CLKSEL_CORE                                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0000)
> +#define OMAP4_CM_CLKSEL_ABE_OFFSET                     0x0008
> +#define OMAP4430_CM_CLKSEL_ABE                         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0008)
> +#define OMAP4_CM_DLL_CTRL_OFFSET                       0x0010
> +#define OMAP4430_CM_DLL_CTRL                           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0010)
> +#define OMAP4_CM_CLKMODE_DPLL_CORE_OFFSET              0x0020
> +#define OMAP4430_CM_CLKMODE_DPLL_CORE                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0020)
> +#define OMAP4_CM_IDLEST_DPLL_CORE_OFFSET               0x0024
> +#define OMAP4430_CM_IDLEST_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0024)
> +#define OMAP4_CM_AUTOIDLE_DPLL_CORE_OFFSET             0x0028
> +#define OMAP4430_CM_AUTOIDLE_DPLL_CORE                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0028)
> +#define OMAP4_CM_CLKSEL_DPLL_CORE_OFFSET               0x002c
> +#define OMAP4430_CM_CLKSEL_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x002c)
> +#define OMAP4_CM_DIV_M2_DPLL_CORE_OFFSET               0x0030
> +#define OMAP4430_CM_DIV_M2_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0030)
> +#define OMAP4_CM_DIV_M3_DPLL_CORE_OFFSET               0x0034
> +#define OMAP4430_CM_DIV_M3_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0034)
> +#define OMAP4_CM_DIV_M4_DPLL_CORE_OFFSET               0x0038
> +#define OMAP4430_CM_DIV_M4_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0038)
> +#define OMAP4_CM_DIV_M5_DPLL_CORE_OFFSET               0x003c
> +#define OMAP4430_CM_DIV_M5_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x003c)
> +#define OMAP4_CM_DIV_M6_DPLL_CORE_OFFSET               0x0040
> +#define OMAP4430_CM_DIV_M6_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0040)
> +#define OMAP4_CM_DIV_M7_DPLL_CORE_OFFSET               0x0044
> +#define OMAP4430_CM_DIV_M7_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0044)
> +#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_CORE_OFFSET       0x0048
> +#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_CORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0048)
> +#define OMAP4_CM_SSC_MODFREQDIV_DPLL_CORE_OFFSET       0x004c
> +#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_CORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x004c)
> +#define OMAP4_CM_EMU_OVERRIDE_DPLL_CORE_OFFSET         0x0050
> +#define OMAP4430_CM_EMU_OVERRIDE_DPLL_CORE             OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0050)
> +#define OMAP4_CM_CLKMODE_DPLL_MPU_OFFSET               0x0060
> +#define OMAP4430_CM_CLKMODE_DPLL_MPU                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0060)
> +#define OMAP4_CM_IDLEST_DPLL_MPU_OFFSET                        0x0064
> +#define OMAP4430_CM_IDLEST_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0064)
> +#define OMAP4_CM_AUTOIDLE_DPLL_MPU_OFFSET              0x0068
> +#define OMAP4430_CM_AUTOIDLE_DPLL_MPU                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0068)
> +#define OMAP4_CM_CLKSEL_DPLL_MPU_OFFSET                        0x006c
> +#define OMAP4430_CM_CLKSEL_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x006c)
> +#define OMAP4_CM_DIV_M2_DPLL_MPU_OFFSET                        0x0070
> +#define OMAP4430_CM_DIV_M2_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0070)
> +#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_MPU_OFFSET                0x0088
> +#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_MPU            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0088)
> +#define OMAP4_CM_SSC_MODFREQDIV_DPLL_MPU_OFFSET                0x008c
> +#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_MPU            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x008c)
> +#define OMAP4_CM_BYPCLK_DPLL_MPU_OFFSET                        0x009c
> +#define OMAP4430_CM_BYPCLK_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x009c)
> +#define OMAP4_CM_CLKMODE_DPLL_IVA_OFFSET               0x00a0
> +#define OMAP4430_CM_CLKMODE_DPLL_IVA                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a0)
> +#define OMAP4_CM_IDLEST_DPLL_IVA_OFFSET                        0x00a4
> +#define OMAP4430_CM_IDLEST_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a4)
> +#define OMAP4_CM_AUTOIDLE_DPLL_IVA_OFFSET              0x00a8
> +#define OMAP4430_CM_AUTOIDLE_DPLL_IVA                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a8)
> +#define OMAP4_CM_CLKSEL_DPLL_IVA_OFFSET                        0x00ac
> +#define OMAP4430_CM_CLKSEL_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00ac)
> +#define OMAP4_CM_DIV_M4_DPLL_IVA_OFFSET                        0x00b8
> +#define OMAP4430_CM_DIV_M4_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00b8)
> +#define OMAP4_CM_DIV_M5_DPLL_IVA_OFFSET                        0x00bc
> +#define OMAP4430_CM_DIV_M5_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00bc)
> +#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_IVA_OFFSET                0x00c8
> +#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_IVA            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00c8)
> +#define OMAP4_CM_SSC_MODFREQDIV_DPLL_IVA_OFFSET                0x00cc
> +#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_IVA            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00cc)
> +#define OMAP4_CM_BYPCLK_DPLL_IVA_OFFSET                        0x00dc
> +#define OMAP4430_CM_BYPCLK_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00dc)
> +#define OMAP4_CM_CLKMODE_DPLL_ABE_OFFSET               0x00e0
> +#define OMAP4430_CM_CLKMODE_DPLL_ABE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e0)
> +#define OMAP4_CM_IDLEST_DPLL_ABE_OFFSET                        0x00e4
> +#define OMAP4430_CM_IDLEST_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e4)
> +#define OMAP4_CM_AUTOIDLE_DPLL_ABE_OFFSET              0x00e8
> +#define OMAP4430_CM_AUTOIDLE_DPLL_ABE                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e8)
> +#define OMAP4_CM_CLKSEL_DPLL_ABE_OFFSET                        0x00ec
> +#define OMAP4430_CM_CLKSEL_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00ec)
> +#define OMAP4_CM_DIV_M2_DPLL_ABE_OFFSET                        0x00f0
> +#define OMAP4430_CM_DIV_M2_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00f0)
> +#define OMAP4_CM_DIV_M3_DPLL_ABE_OFFSET                        0x00f4
> +#define OMAP4430_CM_DIV_M3_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00f4)
> +#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_ABE_OFFSET                0x0108
> +#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_ABE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0108)
> +#define OMAP4_CM_SSC_MODFREQDIV_DPLL_ABE_OFFSET                0x010c
> +#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_ABE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x010c)
> +#define OMAP4_CM_CLKMODE_DPLL_DDRPHY_OFFSET            0x0120
> +#define OMAP4430_CM_CLKMODE_DPLL_DDRPHY                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0120)
> +#define OMAP4_CM_IDLEST_DPLL_DDRPHY_OFFSET             0x0124
> +#define OMAP4430_CM_IDLEST_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0124)
> +#define OMAP4_CM_AUTOIDLE_DPLL_DDRPHY_OFFSET           0x0128
> +#define OMAP4430_CM_AUTOIDLE_DPLL_DDRPHY               OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0128)
> +#define OMAP4_CM_CLKSEL_DPLL_DDRPHY_OFFSET             0x012c
> +#define OMAP4430_CM_CLKSEL_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x012c)
> +#define OMAP4_CM_DIV_M2_DPLL_DDRPHY_OFFSET             0x0130
> +#define OMAP4430_CM_DIV_M2_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0130)
> +#define OMAP4_CM_DIV_M4_DPLL_DDRPHY_OFFSET             0x0138
> +#define OMAP4430_CM_DIV_M4_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0138)
> +#define OMAP4_CM_DIV_M5_DPLL_DDRPHY_OFFSET             0x013c
> +#define OMAP4430_CM_DIV_M5_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x013c)
> +#define OMAP4_CM_DIV_M6_DPLL_DDRPHY_OFFSET             0x0140
> +#define OMAP4430_CM_DIV_M6_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0140)
> +#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_DDRPHY_OFFSET     0x0148
> +#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_DDRPHY         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0148)
> +#define OMAP4_CM_SSC_MODFREQDIV_DPLL_DDRPHY_OFFSET     0x014c
> +#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_DDRPHY         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x014c)
> +#define OMAP4_CM_SHADOW_FREQ_CONFIG1_OFFSET            0x0160
> +#define OMAP4430_CM_SHADOW_FREQ_CONFIG1                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0160)
> +#define OMAP4_CM_SHADOW_FREQ_CONFIG2_OFFSET            0x0164
> +#define OMAP4430_CM_SHADOW_FREQ_CONFIG2                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0164)
> +#define OMAP4_CM_DYN_DEP_PRESCAL_OFFSET                        0x0170
> +#define OMAP4430_CM_DYN_DEP_PRESCAL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0170)
> +#define OMAP4_CM_RESTORE_ST_OFFSET                     0x0180
> +#define OMAP4430_CM_RESTORE_ST                         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0180)
> +
> +/* CM1.MPU_CM1 register offsets */
> +#define OMAP4_CM_MPU_CLKSTCTRL_OFFSET                  0x0000
> +#define OMAP4430_CM_MPU_CLKSTCTRL                      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0000)
> +#define OMAP4_CM_MPU_STATICDEP_OFFSET                  0x0004
> +#define OMAP4430_CM_MPU_STATICDEP                      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0004)
> +#define OMAP4_CM_MPU_DYNAMICDEP_OFFSET                 0x0008
> +#define OMAP4430_CM_MPU_DYNAMICDEP                     OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0008)
> +#define OMAP4_CM_MPU_MPU_CLKCTRL_OFFSET                        0x0020
> +#define OMAP4430_CM_MPU_MPU_CLKCTRL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0020)
> +
> +/* CM1.TESLA_CM1 register offsets */
> +#define OMAP4_CM_TESLA_CLKSTCTRL_OFFSET                        0x0000
> +#define OMAP4430_CM_TESLA_CLKSTCTRL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0000)
> +#define OMAP4_CM_TESLA_STATICDEP_OFFSET                        0x0004
> +#define OMAP4430_CM_TESLA_STATICDEP                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0004)
> +#define OMAP4_CM_TESLA_DYNAMICDEP_OFFSET               0x0008
> +#define OMAP4430_CM_TESLA_DYNAMICDEP                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0008)
> +#define OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET            0x0020
> +#define OMAP4430_CM_TESLA_TESLA_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0020)
> +
> +/* CM1.ABE_CM1 register offsets */
> +#define OMAP4_CM1_ABE_CLKSTCTRL_OFFSET                 0x0000
> +#define OMAP4430_CM1_ABE_CLKSTCTRL                     OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0000)
> +#define OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET             0x0020
> +#define OMAP4430_CM1_ABE_L4ABE_CLKCTRL                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0020)
> +#define OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET              0x0028
> +#define OMAP4430_CM1_ABE_AESS_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0028)
> +#define OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET               0x0030
> +#define OMAP4430_CM1_ABE_PDM_CLKCTRL                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0030)
> +#define OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET              0x0038
> +#define OMAP4430_CM1_ABE_DMIC_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0038)
> +#define OMAP4_CM1_ABE_MCASP_CLKCTRL_OFFSET             0x0040
> +#define OMAP4430_CM1_ABE_MCASP_CLKCTRL                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0040)
> +#define OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET            0x0048
> +#define OMAP4430_CM1_ABE_MCBSP1_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0048)
> +#define OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET            0x0050
> +#define OMAP4430_CM1_ABE_MCBSP2_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0050)
> +#define OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET            0x0058
> +#define OMAP4430_CM1_ABE_MCBSP3_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0058)
> +#define OMAP4_CM1_ABE_SLIMBUS_CLKCTRL_OFFSET           0x0060
> +#define OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL               OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0060)
> +#define OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET            0x0068
> +#define OMAP4430_CM1_ABE_TIMER5_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0068)
> +#define OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET            0x0070
> +#define OMAP4430_CM1_ABE_TIMER6_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0070)
> +#define OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET            0x0078
> +#define OMAP4430_CM1_ABE_TIMER7_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0078)
> +#define OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET            0x0080
> +#define OMAP4430_CM1_ABE_TIMER8_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0080)
> +#define OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET              0x0088
> +#define OMAP4430_CM1_ABE_WDT3_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0088)
> +
> +/* CM1.RESTORE_CM1 register offsets */
> +#define OMAP4_CM_CLKSEL_CORE_RESTORE_OFFSET            0x0000
> +#define OMAP4430_CM_CLKSEL_CORE_RESTORE                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0000)
> +#define OMAP4_CM_DIV_M2_DPLL_CORE_RESTORE_OFFSET       0x0004
> +#define OMAP4430_CM_DIV_M2_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0004)
> +#define OMAP4_CM_DIV_M3_DPLL_CORE_RESTORE_OFFSET       0x0008
> +#define OMAP4430_CM_DIV_M3_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0008)
> +#define OMAP4_CM_DIV_M4_DPLL_CORE_RESTORE_OFFSET       0x000c
> +#define OMAP4430_CM_DIV_M4_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x000c)
> +#define OMAP4_CM_DIV_M5_DPLL_CORE_RESTORE_OFFSET       0x0010
> +#define OMAP4430_CM_DIV_M5_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0010)
> +#define OMAP4_CM_DIV_M6_DPLL_CORE_RESTORE_OFFSET       0x0014
> +#define OMAP4430_CM_DIV_M6_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0014)
> +#define OMAP4_CM_DIV_M7_DPLL_CORE_RESTORE_OFFSET       0x0018
> +#define OMAP4430_CM_DIV_M7_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0018)
> +#define OMAP4_CM_CLKSEL_DPLL_CORE_RESTORE_OFFSET       0x001c
> +#define OMAP4430_CM_CLKSEL_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x001c)
> +#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_CORE_RESTORE_OFFSET       0x0020
> +#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_CORE_RESTORE   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0020)
> +#define OMAP4_CM_SSC_MODFREQDIV_DPLL_CORE_RESTORE_OFFSET       0x0024
> +#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_CORE_RESTORE   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0024)
> +#define OMAP4_CM_CLKMODE_DPLL_CORE_RESTORE_OFFSET      0x0028
> +#define OMAP4430_CM_CLKMODE_DPLL_CORE_RESTORE          OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0028)
> +#define OMAP4_CM_SHADOW_FREQ_CONFIG2_RESTORE_OFFSET    0x002c
> +#define OMAP4430_CM_SHADOW_FREQ_CONFIG2_RESTORE                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x002c)
> +#define OMAP4_CM_SHADOW_FREQ_CONFIG1_RESTORE_OFFSET    0x0030
> +#define OMAP4430_CM_SHADOW_FREQ_CONFIG1_RESTORE                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0030)
> +#define OMAP4_CM_AUTOIDLE_DPLL_CORE_RESTORE_OFFSET     0x0034
> +#define OMAP4430_CM_AUTOIDLE_DPLL_CORE_RESTORE         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0034)
> +#define OMAP4_CM_MPU_CLKSTCTRL_RESTORE_OFFSET          0x0038
> +#define OMAP4430_CM_MPU_CLKSTCTRL_RESTORE              OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0038)
> +#define OMAP4_CM_CM1_PROFILING_CLKCTRL_RESTORE_OFFSET  0x003c
> +#define OMAP4430_CM_CM1_PROFILING_CLKCTRL_RESTORE      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x003c)
> +#define OMAP4_CM_DYN_DEP_PRESCAL_RESTORE_OFFSET                0x0040
> +#define OMAP4430_CM_DYN_DEP_PRESCAL_RESTORE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0040)
> +
> +/* Function prototypes */
> +extern u32 omap4_cm1_read_mod_reg(s16 module, u16 idx);
> +extern void omap4_cm1_write_mod_reg(u32 val, s16 module, u16 idx);
> +extern u32 omap4_cm1_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm2_44xx.h
> similarity index 68%
> copy from arch/arm/mach-omap2/cm44xx.h
> copy to arch/arm/mach-omap2/cm2_44xx.h
> index 3c35a87..678cff6 100644
> --- a/arch/arm/mach-omap2/cm44xx.h
> +++ b/arch/arm/mach-omap2/cm2_44xx.h
> @@ -1,5 +1,5 @@
>   /*
> - * OMAP44xx CM1&  CM2 instance offset macros
> + * OMAP44xx CM2 instance offset macros
>    *
>    * Copyright (C) 2009-2010 Texas Instruments, Inc.
>    * Copyright (C) 2009-2010 Nokia Corporation
> @@ -17,219 +17,35 @@
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
>    * published by the Free Software Foundation.
> + *
> + * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
> + *     or "OMAP4430".
>    */
>
> -#ifndef __ARCH_ARM_MACH_OMAP2_CM44XX_H
> -#define __ARCH_ARM_MACH_OMAP2_CM44XX_H
> -
> -
> -/* CM1 */
> -
> -/* CM1.OCP_SOCKET_CM1 register offsets */
> -#define OMAP4_REVISION_CM1_OFFSET                      0x0000
> -#define OMAP4430_REVISION_CM1                          OMAP44XX_CM1_REGADDR(OMAP4430_CM1_OCP_SOCKET_MOD, 0x0000)
> -#define OMAP4_CM_CM1_PROFILING_CLKCTRL_OFFSET          0x0040
> -#define OMAP4430_CM_CM1_PROFILING_CLKCTRL              OMAP44XX_CM1_REGADDR(OMAP4430_CM1_OCP_SOCKET_MOD, 0x0040)
> -
> -/* CM1.CKGEN_CM1 register offsets */
> -#define OMAP4_CM_CLKSEL_CORE_OFFSET                    0x0000
> -#define OMAP4430_CM_CLKSEL_CORE                                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0000)
> -#define OMAP4_CM_CLKSEL_ABE_OFFSET                     0x0008
> -#define OMAP4430_CM_CLKSEL_ABE                         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0008)
> -#define OMAP4_CM_DLL_CTRL_OFFSET                       0x0010
> -#define OMAP4430_CM_DLL_CTRL                           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0010)
> -#define OMAP4_CM_CLKMODE_DPLL_CORE_OFFSET              0x0020
> -#define OMAP4430_CM_CLKMODE_DPLL_CORE                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0020)
> -#define OMAP4_CM_IDLEST_DPLL_CORE_OFFSET               0x0024
> -#define OMAP4430_CM_IDLEST_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0024)
> -#define OMAP4_CM_AUTOIDLE_DPLL_CORE_OFFSET             0x0028
> -#define OMAP4430_CM_AUTOIDLE_DPLL_CORE                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0028)
> -#define OMAP4_CM_CLKSEL_DPLL_CORE_OFFSET               0x002c
> -#define OMAP4430_CM_CLKSEL_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x002c)
> -#define OMAP4_CM_DIV_M2_DPLL_CORE_OFFSET               0x0030
> -#define OMAP4430_CM_DIV_M2_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0030)
> -#define OMAP4_CM_DIV_M3_DPLL_CORE_OFFSET               0x0034
> -#define OMAP4430_CM_DIV_M3_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0034)
> -#define OMAP4_CM_DIV_M4_DPLL_CORE_OFFSET               0x0038
> -#define OMAP4430_CM_DIV_M4_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0038)
> -#define OMAP4_CM_DIV_M5_DPLL_CORE_OFFSET               0x003c
> -#define OMAP4430_CM_DIV_M5_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x003c)
> -#define OMAP4_CM_DIV_M6_DPLL_CORE_OFFSET               0x0040
> -#define OMAP4430_CM_DIV_M6_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0040)
> -#define OMAP4_CM_DIV_M7_DPLL_CORE_OFFSET               0x0044
> -#define OMAP4430_CM_DIV_M7_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0044)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_CORE_OFFSET       0x0048
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_CORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0048)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_CORE_OFFSET       0x004c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_CORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x004c)
> -#define OMAP4_CM_EMU_OVERRIDE_DPLL_CORE_OFFSET         0x0050
> -#define OMAP4430_CM_EMU_OVERRIDE_DPLL_CORE             OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0050)
> -#define OMAP4_CM_CLKMODE_DPLL_MPU_OFFSET               0x0060
> -#define OMAP4430_CM_CLKMODE_DPLL_MPU                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0060)
> -#define OMAP4_CM_IDLEST_DPLL_MPU_OFFSET                        0x0064
> -#define OMAP4430_CM_IDLEST_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0064)
> -#define OMAP4_CM_AUTOIDLE_DPLL_MPU_OFFSET              0x0068
> -#define OMAP4430_CM_AUTOIDLE_DPLL_MPU                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0068)
> -#define OMAP4_CM_CLKSEL_DPLL_MPU_OFFSET                        0x006c
> -#define OMAP4430_CM_CLKSEL_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x006c)
> -#define OMAP4_CM_DIV_M2_DPLL_MPU_OFFSET                        0x0070
> -#define OMAP4430_CM_DIV_M2_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0070)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_MPU_OFFSET                0x0088
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_MPU            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0088)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_MPU_OFFSET                0x008c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_MPU            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x008c)
> -#define OMAP4_CM_BYPCLK_DPLL_MPU_OFFSET                        0x009c
> -#define OMAP4430_CM_BYPCLK_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x009c)
> -#define OMAP4_CM_CLKMODE_DPLL_IVA_OFFSET               0x00a0
> -#define OMAP4430_CM_CLKMODE_DPLL_IVA                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a0)
> -#define OMAP4_CM_IDLEST_DPLL_IVA_OFFSET                        0x00a4
> -#define OMAP4430_CM_IDLEST_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a4)
> -#define OMAP4_CM_AUTOIDLE_DPLL_IVA_OFFSET              0x00a8
> -#define OMAP4430_CM_AUTOIDLE_DPLL_IVA                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a8)
> -#define OMAP4_CM_CLKSEL_DPLL_IVA_OFFSET                        0x00ac
> -#define OMAP4430_CM_CLKSEL_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00ac)
> -#define OMAP4_CM_DIV_M4_DPLL_IVA_OFFSET                        0x00b8
> -#define OMAP4430_CM_DIV_M4_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00b8)
> -#define OMAP4_CM_DIV_M5_DPLL_IVA_OFFSET                        0x00bc
> -#define OMAP4430_CM_DIV_M5_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00bc)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_IVA_OFFSET                0x00c8
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_IVA            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00c8)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_IVA_OFFSET                0x00cc
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_IVA            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00cc)
> -#define OMAP4_CM_BYPCLK_DPLL_IVA_OFFSET                        0x00dc
> -#define OMAP4430_CM_BYPCLK_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00dc)
> -#define OMAP4_CM_CLKMODE_DPLL_ABE_OFFSET               0x00e0
> -#define OMAP4430_CM_CLKMODE_DPLL_ABE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e0)
> -#define OMAP4_CM_IDLEST_DPLL_ABE_OFFSET                        0x00e4
> -#define OMAP4430_CM_IDLEST_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e4)
> -#define OMAP4_CM_AUTOIDLE_DPLL_ABE_OFFSET              0x00e8
> -#define OMAP4430_CM_AUTOIDLE_DPLL_ABE                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e8)
> -#define OMAP4_CM_CLKSEL_DPLL_ABE_OFFSET                        0x00ec
> -#define OMAP4430_CM_CLKSEL_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00ec)
> -#define OMAP4_CM_DIV_M2_DPLL_ABE_OFFSET                        0x00f0
> -#define OMAP4430_CM_DIV_M2_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00f0)
> -#define OMAP4_CM_DIV_M3_DPLL_ABE_OFFSET                        0x00f4
> -#define OMAP4430_CM_DIV_M3_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00f4)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_ABE_OFFSET                0x0108
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_ABE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0108)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_ABE_OFFSET                0x010c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_ABE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x010c)
> -#define OMAP4_CM_CLKMODE_DPLL_DDRPHY_OFFSET            0x0120
> -#define OMAP4430_CM_CLKMODE_DPLL_DDRPHY                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0120)
> -#define OMAP4_CM_IDLEST_DPLL_DDRPHY_OFFSET             0x0124
> -#define OMAP4430_CM_IDLEST_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0124)
> -#define OMAP4_CM_AUTOIDLE_DPLL_DDRPHY_OFFSET           0x0128
> -#define OMAP4430_CM_AUTOIDLE_DPLL_DDRPHY               OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0128)
> -#define OMAP4_CM_CLKSEL_DPLL_DDRPHY_OFFSET             0x012c
> -#define OMAP4430_CM_CLKSEL_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x012c)
> -#define OMAP4_CM_DIV_M2_DPLL_DDRPHY_OFFSET             0x0130
> -#define OMAP4430_CM_DIV_M2_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0130)
> -#define OMAP4_CM_DIV_M4_DPLL_DDRPHY_OFFSET             0x0138
> -#define OMAP4430_CM_DIV_M4_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0138)
> -#define OMAP4_CM_DIV_M5_DPLL_DDRPHY_OFFSET             0x013c
> -#define OMAP4430_CM_DIV_M5_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x013c)
> -#define OMAP4_CM_DIV_M6_DPLL_DDRPHY_OFFSET             0x0140
> -#define OMAP4430_CM_DIV_M6_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0140)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_DDRPHY_OFFSET     0x0148
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_DDRPHY         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0148)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_DDRPHY_OFFSET     0x014c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_DDRPHY         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x014c)
> -#define OMAP4_CM_SHADOW_FREQ_CONFIG1_OFFSET            0x0160
> -#define OMAP4430_CM_SHADOW_FREQ_CONFIG1                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0160)
> -#define OMAP4_CM_SHADOW_FREQ_CONFIG2_OFFSET            0x0164
> -#define OMAP4430_CM_SHADOW_FREQ_CONFIG2                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0164)
> -#define OMAP4_CM_DYN_DEP_PRESCAL_OFFSET                        0x0170
> -#define OMAP4430_CM_DYN_DEP_PRESCAL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0170)
> -#define OMAP4_CM_RESTORE_ST_OFFSET                     0x0180
> -#define OMAP4430_CM_RESTORE_ST                         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0180)
> +#ifndef __ARCH_ARM_MACH_OMAP2_CM2_44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_CM2_44XX_H
>
> -/* CM1.MPU_CM1 register offsets */
> -#define OMAP4_CM_MPU_CLKSTCTRL_OFFSET                  0x0000
> -#define OMAP4430_CM_MPU_CLKSTCTRL                      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0000)
> -#define OMAP4_CM_MPU_STATICDEP_OFFSET                  0x0004
> -#define OMAP4430_CM_MPU_STATICDEP                      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0004)
> -#define OMAP4_CM_MPU_DYNAMICDEP_OFFSET                 0x0008
> -#define OMAP4430_CM_MPU_DYNAMICDEP                     OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0008)
> -#define OMAP4_CM_MPU_MPU_CLKCTRL_OFFSET                        0x0020
> -#define OMAP4430_CM_MPU_MPU_CLKCTRL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0020)
> +/* CM2 base address */
> +#define OMAP4430_CM2_BASE              0x4a008000
>
> -/* CM1.TESLA_CM1 register offsets */
> -#define OMAP4_CM_TESLA_CLKSTCTRL_OFFSET                        0x0000
> -#define OMAP4430_CM_TESLA_CLKSTCTRL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0000)
> -#define OMAP4_CM_TESLA_STATICDEP_OFFSET                        0x0004
> -#define OMAP4430_CM_TESLA_STATICDEP                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0004)
> -#define OMAP4_CM_TESLA_DYNAMICDEP_OFFSET               0x0008
> -#define OMAP4430_CM_TESLA_DYNAMICDEP                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0008)
> -#define OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET            0x0020
> -#define OMAP4430_CM_TESLA_TESLA_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0020)
> +#define OMAP44XX_CM2_REGADDR(module, reg)                              \
> +       OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE + (module) + (reg))
>
> -/* CM1.ABE_CM1 register offsets */
> -#define OMAP4_CM1_ABE_CLKSTCTRL_OFFSET                 0x0000
> -#define OMAP4430_CM1_ABE_CLKSTCTRL                     OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0000)
> -#define OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET             0x0020
> -#define OMAP4430_CM1_ABE_L4ABE_CLKCTRL                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0020)
> -#define OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET              0x0028
> -#define OMAP4430_CM1_ABE_AESS_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0028)
> -#define OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET               0x0030
> -#define OMAP4430_CM1_ABE_PDM_CLKCTRL                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0030)
> -#define OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET              0x0038
> -#define OMAP4430_CM1_ABE_DMIC_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0038)
> -#define OMAP4_CM1_ABE_MCASP_CLKCTRL_OFFSET             0x0040
> -#define OMAP4430_CM1_ABE_MCASP_CLKCTRL                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0040)
> -#define OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET            0x0048
> -#define OMAP4430_CM1_ABE_MCBSP1_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0048)
> -#define OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET            0x0050
> -#define OMAP4430_CM1_ABE_MCBSP2_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0050)
> -#define OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET            0x0058
> -#define OMAP4430_CM1_ABE_MCBSP3_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0058)
> -#define OMAP4_CM1_ABE_SLIMBUS_CLKCTRL_OFFSET           0x0060
> -#define OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL               OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0060)
> -#define OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET            0x0068
> -#define OMAP4430_CM1_ABE_TIMER5_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0068)
> -#define OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET            0x0070
> -#define OMAP4430_CM1_ABE_TIMER6_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0070)
> -#define OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET            0x0078
> -#define OMAP4430_CM1_ABE_TIMER7_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0078)
> -#define OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET            0x0080
> -#define OMAP4430_CM1_ABE_TIMER8_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0080)
> -#define OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET              0x0088
> -#define OMAP4430_CM1_ABE_WDT3_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0088)
> +/* CM2 instances */
> +#define OMAP4430_CM2_OCP_SOCKET_MOD    0x0000
> +#define OMAP4430_CM2_CKGEN_MOD         0x0100
> +#define OMAP4430_CM2_ALWAYS_ON_MOD     0x0600
> +#define OMAP4430_CM2_CORE_MOD          0x0700
> +#define OMAP4430_CM2_IVAHD_MOD         0x0f00
> +#define OMAP4430_CM2_CAM_MOD           0x1000
> +#define OMAP4430_CM2_DSS_MOD           0x1100
> +#define OMAP4430_CM2_GFX_MOD           0x1200
> +#define OMAP4430_CM2_L3INIT_MOD                0x1300
> +#define OMAP4430_CM2_L4PER_MOD         0x1400
> +#define OMAP4430_CM2_CEFUSE_MOD                0x1600
> +#define OMAP4430_CM2_RESTORE_MOD       0x1e00
> +#define OMAP4430_CM2_INSTR_MOD         0x1f00
>
> -/* CM1.RESTORE_CM1 register offsets */
> -#define OMAP4_CM_CLKSEL_CORE_RESTORE_OFFSET            0x0000
> -#define OMAP4430_CM_CLKSEL_CORE_RESTORE                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0000)
> -#define OMAP4_CM_DIV_M2_DPLL_CORE_RESTORE_OFFSET       0x0004
> -#define OMAP4430_CM_DIV_M2_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0004)
> -#define OMAP4_CM_DIV_M3_DPLL_CORE_RESTORE_OFFSET       0x0008
> -#define OMAP4430_CM_DIV_M3_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0008)
> -#define OMAP4_CM_DIV_M4_DPLL_CORE_RESTORE_OFFSET       0x000c
> -#define OMAP4430_CM_DIV_M4_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x000c)
> -#define OMAP4_CM_DIV_M5_DPLL_CORE_RESTORE_OFFSET       0x0010
> -#define OMAP4430_CM_DIV_M5_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0010)
> -#define OMAP4_CM_DIV_M6_DPLL_CORE_RESTORE_OFFSET       0x0014
> -#define OMAP4430_CM_DIV_M6_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0014)
> -#define OMAP4_CM_DIV_M7_DPLL_CORE_RESTORE_OFFSET       0x0018
> -#define OMAP4430_CM_DIV_M7_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0018)
> -#define OMAP4_CM_CLKSEL_DPLL_CORE_RESTORE_OFFSET       0x001c
> -#define OMAP4430_CM_CLKSEL_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x001c)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_CORE_RESTORE_OFFSET       0x0020
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_CORE_RESTORE   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0020)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_CORE_RESTORE_OFFSET       0x0024
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_CORE_RESTORE   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0024)
> -#define OMAP4_CM_CLKMODE_DPLL_CORE_RESTORE_OFFSET      0x0028
> -#define OMAP4430_CM_CLKMODE_DPLL_CORE_RESTORE          OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0028)
> -#define OMAP4_CM_SHADOW_FREQ_CONFIG2_RESTORE_OFFSET    0x002c
> -#define OMAP4430_CM_SHADOW_FREQ_CONFIG2_RESTORE                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x002c)
> -#define OMAP4_CM_SHADOW_FREQ_CONFIG1_RESTORE_OFFSET    0x0030
> -#define OMAP4430_CM_SHADOW_FREQ_CONFIG1_RESTORE                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0030)
> -#define OMAP4_CM_AUTOIDLE_DPLL_CORE_RESTORE_OFFSET     0x0034
> -#define OMAP4430_CM_AUTOIDLE_DPLL_CORE_RESTORE         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0034)
> -#define OMAP4_CM_MPU_CLKSTCTRL_RESTORE_OFFSET          0x0038
> -#define OMAP4430_CM_MPU_CLKSTCTRL_RESTORE              OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0038)
> -#define OMAP4_CM_CM1_PROFILING_CLKCTRL_RESTORE_OFFSET  0x003c
> -#define OMAP4430_CM_CM1_PROFILING_CLKCTRL_RESTORE      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x003c)
> -#define OMAP4_CM_DYN_DEP_PRESCAL_RESTORE_OFFSET                0x0040
> -#define OMAP4430_CM_DYN_DEP_PRESCAL_RESTORE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0040)
>
>   /* CM2 */
>
> diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
> index 3c35a87..d390526 100644
> --- a/arch/arm/mach-omap2/cm44xx.h
> +++ b/arch/arm/mach-omap2/cm44xx.h
> @@ -1,667 +1,30 @@
>   /*
> - * OMAP44xx CM1&  CM2 instance offset macros
> + * OMAP4 Clock Management (CM) definitions
>    *
> - * Copyright (C) 2009-2010 Texas Instruments, Inc.
> - * Copyright (C) 2009-2010 Nokia Corporation
> + * Copyright (C) 2007-2009 Texas Instruments, Inc.
> + * Copyright (C) 2007-2009 Nokia Corporation
>    *
> - * Paul Walmsley (paul at pwsan.com)
> - * Rajendra Nayak (rnayak at ti.com)
> - * Benoit Cousson (b-cousson at ti.com)
> - *
> - * This file is automatically generated from the OMAP hardware databases.
> - * We respectfully ask that any modifications to this file be coordinated
> - * with the public linux-omap at vger.kernel.org mailing list and the
> - * authors above to ensure that the autogeneration scripts are kept
> - * up-to-date with the file contents.
> + * Written by Paul Walmsley
>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
>    * published by the Free Software Foundation.
> + *
> + * OMAP4 has two separate CM blocks, CM1 and CM2.  This file contains
> + * macros and function prototypes that are applicable to both.
>    */
> +#ifndef __ARCH_ASM_MACH_OMAP2_CM44XX_H
> +#define __ARCH_ASM_MACH_OMAP2_CM44XX_H
>
> -#ifndef __ARCH_ARM_MACH_OMAP2_CM44XX_H
> -#define __ARCH_ARM_MACH_OMAP2_CM44XX_H
> -
> -
> -/* CM1 */
> -
> -/* CM1.OCP_SOCKET_CM1 register offsets */
> -#define OMAP4_REVISION_CM1_OFFSET                      0x0000
> -#define OMAP4430_REVISION_CM1                          OMAP44XX_CM1_REGADDR(OMAP4430_CM1_OCP_SOCKET_MOD, 0x0000)
> -#define OMAP4_CM_CM1_PROFILING_CLKCTRL_OFFSET          0x0040
> -#define OMAP4430_CM_CM1_PROFILING_CLKCTRL              OMAP44XX_CM1_REGADDR(OMAP4430_CM1_OCP_SOCKET_MOD, 0x0040)
> -
> -/* CM1.CKGEN_CM1 register offsets */
> -#define OMAP4_CM_CLKSEL_CORE_OFFSET                    0x0000
> -#define OMAP4430_CM_CLKSEL_CORE                                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0000)
> -#define OMAP4_CM_CLKSEL_ABE_OFFSET                     0x0008
> -#define OMAP4430_CM_CLKSEL_ABE                         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0008)
> -#define OMAP4_CM_DLL_CTRL_OFFSET                       0x0010
> -#define OMAP4430_CM_DLL_CTRL                           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0010)
> -#define OMAP4_CM_CLKMODE_DPLL_CORE_OFFSET              0x0020
> -#define OMAP4430_CM_CLKMODE_DPLL_CORE                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0020)
> -#define OMAP4_CM_IDLEST_DPLL_CORE_OFFSET               0x0024
> -#define OMAP4430_CM_IDLEST_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0024)
> -#define OMAP4_CM_AUTOIDLE_DPLL_CORE_OFFSET             0x0028
> -#define OMAP4430_CM_AUTOIDLE_DPLL_CORE                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0028)
> -#define OMAP4_CM_CLKSEL_DPLL_CORE_OFFSET               0x002c
> -#define OMAP4430_CM_CLKSEL_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x002c)
> -#define OMAP4_CM_DIV_M2_DPLL_CORE_OFFSET               0x0030
> -#define OMAP4430_CM_DIV_M2_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0030)
> -#define OMAP4_CM_DIV_M3_DPLL_CORE_OFFSET               0x0034
> -#define OMAP4430_CM_DIV_M3_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0034)
> -#define OMAP4_CM_DIV_M4_DPLL_CORE_OFFSET               0x0038
> -#define OMAP4430_CM_DIV_M4_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0038)
> -#define OMAP4_CM_DIV_M5_DPLL_CORE_OFFSET               0x003c
> -#define OMAP4430_CM_DIV_M5_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x003c)
> -#define OMAP4_CM_DIV_M6_DPLL_CORE_OFFSET               0x0040
> -#define OMAP4430_CM_DIV_M6_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0040)
> -#define OMAP4_CM_DIV_M7_DPLL_CORE_OFFSET               0x0044
> -#define OMAP4430_CM_DIV_M7_DPLL_CORE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0044)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_CORE_OFFSET       0x0048
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_CORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0048)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_CORE_OFFSET       0x004c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_CORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x004c)
> -#define OMAP4_CM_EMU_OVERRIDE_DPLL_CORE_OFFSET         0x0050
> -#define OMAP4430_CM_EMU_OVERRIDE_DPLL_CORE             OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0050)
> -#define OMAP4_CM_CLKMODE_DPLL_MPU_OFFSET               0x0060
> -#define OMAP4430_CM_CLKMODE_DPLL_MPU                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0060)
> -#define OMAP4_CM_IDLEST_DPLL_MPU_OFFSET                        0x0064
> -#define OMAP4430_CM_IDLEST_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0064)
> -#define OMAP4_CM_AUTOIDLE_DPLL_MPU_OFFSET              0x0068
> -#define OMAP4430_CM_AUTOIDLE_DPLL_MPU                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0068)
> -#define OMAP4_CM_CLKSEL_DPLL_MPU_OFFSET                        0x006c
> -#define OMAP4430_CM_CLKSEL_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x006c)
> -#define OMAP4_CM_DIV_M2_DPLL_MPU_OFFSET                        0x0070
> -#define OMAP4430_CM_DIV_M2_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0070)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_MPU_OFFSET                0x0088
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_MPU            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0088)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_MPU_OFFSET                0x008c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_MPU            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x008c)
> -#define OMAP4_CM_BYPCLK_DPLL_MPU_OFFSET                        0x009c
> -#define OMAP4430_CM_BYPCLK_DPLL_MPU                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x009c)
> -#define OMAP4_CM_CLKMODE_DPLL_IVA_OFFSET               0x00a0
> -#define OMAP4430_CM_CLKMODE_DPLL_IVA                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a0)
> -#define OMAP4_CM_IDLEST_DPLL_IVA_OFFSET                        0x00a4
> -#define OMAP4430_CM_IDLEST_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a4)
> -#define OMAP4_CM_AUTOIDLE_DPLL_IVA_OFFSET              0x00a8
> -#define OMAP4430_CM_AUTOIDLE_DPLL_IVA                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00a8)
> -#define OMAP4_CM_CLKSEL_DPLL_IVA_OFFSET                        0x00ac
> -#define OMAP4430_CM_CLKSEL_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00ac)
> -#define OMAP4_CM_DIV_M4_DPLL_IVA_OFFSET                        0x00b8
> -#define OMAP4430_CM_DIV_M4_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00b8)
> -#define OMAP4_CM_DIV_M5_DPLL_IVA_OFFSET                        0x00bc
> -#define OMAP4430_CM_DIV_M5_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00bc)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_IVA_OFFSET                0x00c8
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_IVA            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00c8)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_IVA_OFFSET                0x00cc
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_IVA            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00cc)
> -#define OMAP4_CM_BYPCLK_DPLL_IVA_OFFSET                        0x00dc
> -#define OMAP4430_CM_BYPCLK_DPLL_IVA                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00dc)
> -#define OMAP4_CM_CLKMODE_DPLL_ABE_OFFSET               0x00e0
> -#define OMAP4430_CM_CLKMODE_DPLL_ABE                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e0)
> -#define OMAP4_CM_IDLEST_DPLL_ABE_OFFSET                        0x00e4
> -#define OMAP4430_CM_IDLEST_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e4)
> -#define OMAP4_CM_AUTOIDLE_DPLL_ABE_OFFSET              0x00e8
> -#define OMAP4430_CM_AUTOIDLE_DPLL_ABE                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00e8)
> -#define OMAP4_CM_CLKSEL_DPLL_ABE_OFFSET                        0x00ec
> -#define OMAP4430_CM_CLKSEL_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00ec)
> -#define OMAP4_CM_DIV_M2_DPLL_ABE_OFFSET                        0x00f0
> -#define OMAP4430_CM_DIV_M2_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00f0)
> -#define OMAP4_CM_DIV_M3_DPLL_ABE_OFFSET                        0x00f4
> -#define OMAP4430_CM_DIV_M3_DPLL_ABE                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x00f4)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_ABE_OFFSET                0x0108
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_ABE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0108)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_ABE_OFFSET                0x010c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_ABE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x010c)
> -#define OMAP4_CM_CLKMODE_DPLL_DDRPHY_OFFSET            0x0120
> -#define OMAP4430_CM_CLKMODE_DPLL_DDRPHY                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0120)
> -#define OMAP4_CM_IDLEST_DPLL_DDRPHY_OFFSET             0x0124
> -#define OMAP4430_CM_IDLEST_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0124)
> -#define OMAP4_CM_AUTOIDLE_DPLL_DDRPHY_OFFSET           0x0128
> -#define OMAP4430_CM_AUTOIDLE_DPLL_DDRPHY               OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0128)
> -#define OMAP4_CM_CLKSEL_DPLL_DDRPHY_OFFSET             0x012c
> -#define OMAP4430_CM_CLKSEL_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x012c)
> -#define OMAP4_CM_DIV_M2_DPLL_DDRPHY_OFFSET             0x0130
> -#define OMAP4430_CM_DIV_M2_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0130)
> -#define OMAP4_CM_DIV_M4_DPLL_DDRPHY_OFFSET             0x0138
> -#define OMAP4430_CM_DIV_M4_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0138)
> -#define OMAP4_CM_DIV_M5_DPLL_DDRPHY_OFFSET             0x013c
> -#define OMAP4430_CM_DIV_M5_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x013c)
> -#define OMAP4_CM_DIV_M6_DPLL_DDRPHY_OFFSET             0x0140
> -#define OMAP4430_CM_DIV_M6_DPLL_DDRPHY                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0140)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_DDRPHY_OFFSET     0x0148
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_DDRPHY         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0148)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_DDRPHY_OFFSET     0x014c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_DDRPHY         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x014c)
> -#define OMAP4_CM_SHADOW_FREQ_CONFIG1_OFFSET            0x0160
> -#define OMAP4430_CM_SHADOW_FREQ_CONFIG1                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0160)
> -#define OMAP4_CM_SHADOW_FREQ_CONFIG2_OFFSET            0x0164
> -#define OMAP4430_CM_SHADOW_FREQ_CONFIG2                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0164)
> -#define OMAP4_CM_DYN_DEP_PRESCAL_OFFSET                        0x0170
> -#define OMAP4430_CM_DYN_DEP_PRESCAL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0170)
> -#define OMAP4_CM_RESTORE_ST_OFFSET                     0x0180
> -#define OMAP4430_CM_RESTORE_ST                         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_CKGEN_MOD, 0x0180)
> -
> -/* CM1.MPU_CM1 register offsets */
> -#define OMAP4_CM_MPU_CLKSTCTRL_OFFSET                  0x0000
> -#define OMAP4430_CM_MPU_CLKSTCTRL                      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0000)
> -#define OMAP4_CM_MPU_STATICDEP_OFFSET                  0x0004
> -#define OMAP4430_CM_MPU_STATICDEP                      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0004)
> -#define OMAP4_CM_MPU_DYNAMICDEP_OFFSET                 0x0008
> -#define OMAP4430_CM_MPU_DYNAMICDEP                     OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0008)
> -#define OMAP4_CM_MPU_MPU_CLKCTRL_OFFSET                        0x0020
> -#define OMAP4430_CM_MPU_MPU_CLKCTRL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_MPU_MOD, 0x0020)
> -
> -/* CM1.TESLA_CM1 register offsets */
> -#define OMAP4_CM_TESLA_CLKSTCTRL_OFFSET                        0x0000
> -#define OMAP4430_CM_TESLA_CLKSTCTRL                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0000)
> -#define OMAP4_CM_TESLA_STATICDEP_OFFSET                        0x0004
> -#define OMAP4430_CM_TESLA_STATICDEP                    OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0004)
> -#define OMAP4_CM_TESLA_DYNAMICDEP_OFFSET               0x0008
> -#define OMAP4430_CM_TESLA_DYNAMICDEP                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0008)
> -#define OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET            0x0020
> -#define OMAP4430_CM_TESLA_TESLA_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_TESLA_MOD, 0x0020)
> -
> -/* CM1.ABE_CM1 register offsets */
> -#define OMAP4_CM1_ABE_CLKSTCTRL_OFFSET                 0x0000
> -#define OMAP4430_CM1_ABE_CLKSTCTRL                     OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0000)
> -#define OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET             0x0020
> -#define OMAP4430_CM1_ABE_L4ABE_CLKCTRL                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0020)
> -#define OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET              0x0028
> -#define OMAP4430_CM1_ABE_AESS_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0028)
> -#define OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET               0x0030
> -#define OMAP4430_CM1_ABE_PDM_CLKCTRL                   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0030)
> -#define OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET              0x0038
> -#define OMAP4430_CM1_ABE_DMIC_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0038)
> -#define OMAP4_CM1_ABE_MCASP_CLKCTRL_OFFSET             0x0040
> -#define OMAP4430_CM1_ABE_MCASP_CLKCTRL                 OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0040)
> -#define OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET            0x0048
> -#define OMAP4430_CM1_ABE_MCBSP1_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0048)
> -#define OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET            0x0050
> -#define OMAP4430_CM1_ABE_MCBSP2_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0050)
> -#define OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET            0x0058
> -#define OMAP4430_CM1_ABE_MCBSP3_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0058)
> -#define OMAP4_CM1_ABE_SLIMBUS_CLKCTRL_OFFSET           0x0060
> -#define OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL               OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0060)
> -#define OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET            0x0068
> -#define OMAP4430_CM1_ABE_TIMER5_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0068)
> -#define OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET            0x0070
> -#define OMAP4430_CM1_ABE_TIMER6_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0070)
> -#define OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET            0x0078
> -#define OMAP4430_CM1_ABE_TIMER7_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0078)
> -#define OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET            0x0080
> -#define OMAP4430_CM1_ABE_TIMER8_CLKCTRL                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0080)
> -#define OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET              0x0088
> -#define OMAP4430_CM1_ABE_WDT3_CLKCTRL                  OMAP44XX_CM1_REGADDR(OMAP4430_CM1_ABE_MOD, 0x0088)
> -
> -/* CM1.RESTORE_CM1 register offsets */
> -#define OMAP4_CM_CLKSEL_CORE_RESTORE_OFFSET            0x0000
> -#define OMAP4430_CM_CLKSEL_CORE_RESTORE                        OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0000)
> -#define OMAP4_CM_DIV_M2_DPLL_CORE_RESTORE_OFFSET       0x0004
> -#define OMAP4430_CM_DIV_M2_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0004)
> -#define OMAP4_CM_DIV_M3_DPLL_CORE_RESTORE_OFFSET       0x0008
> -#define OMAP4430_CM_DIV_M3_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0008)
> -#define OMAP4_CM_DIV_M4_DPLL_CORE_RESTORE_OFFSET       0x000c
> -#define OMAP4430_CM_DIV_M4_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x000c)
> -#define OMAP4_CM_DIV_M5_DPLL_CORE_RESTORE_OFFSET       0x0010
> -#define OMAP4430_CM_DIV_M5_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0010)
> -#define OMAP4_CM_DIV_M6_DPLL_CORE_RESTORE_OFFSET       0x0014
> -#define OMAP4430_CM_DIV_M6_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0014)
> -#define OMAP4_CM_DIV_M7_DPLL_CORE_RESTORE_OFFSET       0x0018
> -#define OMAP4430_CM_DIV_M7_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0018)
> -#define OMAP4_CM_CLKSEL_DPLL_CORE_RESTORE_OFFSET       0x001c
> -#define OMAP4430_CM_CLKSEL_DPLL_CORE_RESTORE           OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x001c)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_CORE_RESTORE_OFFSET       0x0020
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_CORE_RESTORE   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0020)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_CORE_RESTORE_OFFSET       0x0024
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_CORE_RESTORE   OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0024)
> -#define OMAP4_CM_CLKMODE_DPLL_CORE_RESTORE_OFFSET      0x0028
> -#define OMAP4430_CM_CLKMODE_DPLL_CORE_RESTORE          OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0028)
> -#define OMAP4_CM_SHADOW_FREQ_CONFIG2_RESTORE_OFFSET    0x002c
> -#define OMAP4430_CM_SHADOW_FREQ_CONFIG2_RESTORE                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x002c)
> -#define OMAP4_CM_SHADOW_FREQ_CONFIG1_RESTORE_OFFSET    0x0030
> -#define OMAP4430_CM_SHADOW_FREQ_CONFIG1_RESTORE                OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0030)
> -#define OMAP4_CM_AUTOIDLE_DPLL_CORE_RESTORE_OFFSET     0x0034
> -#define OMAP4430_CM_AUTOIDLE_DPLL_CORE_RESTORE         OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0034)
> -#define OMAP4_CM_MPU_CLKSTCTRL_RESTORE_OFFSET          0x0038
> -#define OMAP4430_CM_MPU_CLKSTCTRL_RESTORE              OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0038)
> -#define OMAP4_CM_CM1_PROFILING_CLKCTRL_RESTORE_OFFSET  0x003c
> -#define OMAP4430_CM_CM1_PROFILING_CLKCTRL_RESTORE      OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x003c)
> -#define OMAP4_CM_DYN_DEP_PRESCAL_RESTORE_OFFSET                0x0040
> -#define OMAP4430_CM_DYN_DEP_PRESCAL_RESTORE            OMAP44XX_CM1_REGADDR(OMAP4430_CM1_RESTORE_MOD, 0x0040)
> -
> -/* CM2 */
> -
> -/* CM2.OCP_SOCKET_CM2 register offsets */
> -#define OMAP4_REVISION_CM2_OFFSET                      0x0000
> -#define OMAP4430_REVISION_CM2                          OMAP44XX_CM2_REGADDR(OMAP4430_CM2_OCP_SOCKET_MOD, 0x0000)
> -#define OMAP4_CM_CM2_PROFILING_CLKCTRL_OFFSET          0x0040
> -#define OMAP4430_CM_CM2_PROFILING_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_OCP_SOCKET_MOD, 0x0040)
> -
> -/* CM2.CKGEN_CM2 register offsets */
> -#define OMAP4_CM_CLKSEL_DUCATI_ISS_ROOT_OFFSET         0x0000
> -#define OMAP4430_CM_CLKSEL_DUCATI_ISS_ROOT             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0000)
> -#define OMAP4_CM_CLKSEL_USB_60MHZ_OFFSET               0x0004
> -#define OMAP4430_CM_CLKSEL_USB_60MHZ                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0004)
> -#define OMAP4_CM_SCALE_FCLK_OFFSET                     0x0008
> -#define OMAP4430_CM_SCALE_FCLK                         OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0008)
> -#define OMAP4_CM_CORE_DVFS_PERF1_OFFSET                        0x0010
> -#define OMAP4430_CM_CORE_DVFS_PERF1                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0010)
> -#define OMAP4_CM_CORE_DVFS_PERF2_OFFSET                        0x0014
> -#define OMAP4430_CM_CORE_DVFS_PERF2                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0014)
> -#define OMAP4_CM_CORE_DVFS_PERF3_OFFSET                        0x0018
> -#define OMAP4430_CM_CORE_DVFS_PERF3                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0018)
> -#define OMAP4_CM_CORE_DVFS_PERF4_OFFSET                        0x001c
> -#define OMAP4430_CM_CORE_DVFS_PERF4                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x001c)
> -#define OMAP4_CM_CORE_DVFS_CURRENT_OFFSET              0x0024
> -#define OMAP4430_CM_CORE_DVFS_CURRENT                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0024)
> -#define OMAP4_CM_IVA_DVFS_PERF_TESLA_OFFSET            0x0028
> -#define OMAP4430_CM_IVA_DVFS_PERF_TESLA                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0028)
> -#define OMAP4_CM_IVA_DVFS_PERF_IVAHD_OFFSET            0x002c
> -#define OMAP4430_CM_IVA_DVFS_PERF_IVAHD                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x002c)
> -#define OMAP4_CM_IVA_DVFS_PERF_ABE_OFFSET              0x0030
> -#define OMAP4430_CM_IVA_DVFS_PERF_ABE                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0030)
> -#define OMAP4_CM_IVA_DVFS_CURRENT_OFFSET               0x0038
> -#define OMAP4430_CM_IVA_DVFS_CURRENT                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0038)
> -#define OMAP4_CM_CLKMODE_DPLL_PER_OFFSET               0x0040
> -#define OMAP4430_CM_CLKMODE_DPLL_PER                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0040)
> -#define OMAP4_CM_IDLEST_DPLL_PER_OFFSET                        0x0044
> -#define OMAP4430_CM_IDLEST_DPLL_PER                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0044)
> -#define OMAP4_CM_AUTOIDLE_DPLL_PER_OFFSET              0x0048
> -#define OMAP4430_CM_AUTOIDLE_DPLL_PER                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0048)
> -#define OMAP4_CM_CLKSEL_DPLL_PER_OFFSET                        0x004c
> -#define OMAP4430_CM_CLKSEL_DPLL_PER                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x004c)
> -#define OMAP4_CM_DIV_M2_DPLL_PER_OFFSET                        0x0050
> -#define OMAP4430_CM_DIV_M2_DPLL_PER                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0050)
> -#define OMAP4_CM_DIV_M3_DPLL_PER_OFFSET                        0x0054
> -#define OMAP4430_CM_DIV_M3_DPLL_PER                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0054)
> -#define OMAP4_CM_DIV_M4_DPLL_PER_OFFSET                        0x0058
> -#define OMAP4430_CM_DIV_M4_DPLL_PER                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0058)
> -#define OMAP4_CM_DIV_M5_DPLL_PER_OFFSET                        0x005c
> -#define OMAP4430_CM_DIV_M5_DPLL_PER                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x005c)
> -#define OMAP4_CM_DIV_M6_DPLL_PER_OFFSET                        0x0060
> -#define OMAP4430_CM_DIV_M6_DPLL_PER                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0060)
> -#define OMAP4_CM_DIV_M7_DPLL_PER_OFFSET                        0x0064
> -#define OMAP4430_CM_DIV_M7_DPLL_PER                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0064)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_PER_OFFSET                0x0068
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_PER            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0068)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_PER_OFFSET                0x006c
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_PER            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x006c)
> -#define OMAP4_CM_CLKMODE_DPLL_USB_OFFSET               0x0080
> -#define OMAP4430_CM_CLKMODE_DPLL_USB                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0080)
> -#define OMAP4_CM_IDLEST_DPLL_USB_OFFSET                        0x0084
> -#define OMAP4430_CM_IDLEST_DPLL_USB                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0084)
> -#define OMAP4_CM_AUTOIDLE_DPLL_USB_OFFSET              0x0088
> -#define OMAP4430_CM_AUTOIDLE_DPLL_USB                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0088)
> -#define OMAP4_CM_CLKSEL_DPLL_USB_OFFSET                        0x008c
> -#define OMAP4430_CM_CLKSEL_DPLL_USB                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x008c)
> -#define OMAP4_CM_DIV_M2_DPLL_USB_OFFSET                        0x0090
> -#define OMAP4430_CM_DIV_M2_DPLL_USB                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x0090)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_USB_OFFSET                0x00a8
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_USB            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00a8)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_USB_OFFSET                0x00ac
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_USB            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00ac)
> -#define OMAP4_CM_CLKDCOLDO_DPLL_USB_OFFSET             0x00b4
> -#define OMAP4430_CM_CLKDCOLDO_DPLL_USB                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00b4)
> -#define OMAP4_CM_CLKMODE_DPLL_UNIPRO_OFFSET            0x00c0
> -#define OMAP4430_CM_CLKMODE_DPLL_UNIPRO                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00c0)
> -#define OMAP4_CM_IDLEST_DPLL_UNIPRO_OFFSET             0x00c4
> -#define OMAP4430_CM_IDLEST_DPLL_UNIPRO                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00c4)
> -#define OMAP4_CM_AUTOIDLE_DPLL_UNIPRO_OFFSET           0x00c8
> -#define OMAP4430_CM_AUTOIDLE_DPLL_UNIPRO               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00c8)
> -#define OMAP4_CM_CLKSEL_DPLL_UNIPRO_OFFSET             0x00cc
> -#define OMAP4430_CM_CLKSEL_DPLL_UNIPRO                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00cc)
> -#define OMAP4_CM_DIV_M2_DPLL_UNIPRO_OFFSET             0x00d0
> -#define OMAP4430_CM_DIV_M2_DPLL_UNIPRO                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00d0)
> -#define OMAP4_CM_SSC_DELTAMSTEP_DPLL_UNIPRO_OFFSET     0x00e8
> -#define OMAP4430_CM_SSC_DELTAMSTEP_DPLL_UNIPRO         OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00e8)
> -#define OMAP4_CM_SSC_MODFREQDIV_DPLL_UNIPRO_OFFSET     0x00ec
> -#define OMAP4430_CM_SSC_MODFREQDIV_DPLL_UNIPRO         OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CKGEN_MOD, 0x00ec)
> -
> -/* CM2.ALWAYS_ON_CM2 register offsets */
> -#define OMAP4_CM_ALWON_CLKSTCTRL_OFFSET                        0x0000
> -#define OMAP4430_CM_ALWON_CLKSTCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_ALWAYS_ON_MOD, 0x0000)
> -#define OMAP4_CM_ALWON_MDMINTC_CLKCTRL_OFFSET          0x0020
> -#define OMAP4430_CM_ALWON_MDMINTC_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_ALWAYS_ON_MOD, 0x0020)
> -#define OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET           0x0028
> -#define OMAP4430_CM_ALWON_SR_MPU_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_ALWAYS_ON_MOD, 0x0028)
> -#define OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET           0x0030
> -#define OMAP4430_CM_ALWON_SR_IVA_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_ALWAYS_ON_MOD, 0x0030)
> -#define OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET          0x0038
> -#define OMAP4430_CM_ALWON_SR_CORE_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_ALWAYS_ON_MOD, 0x0038)
> -#define OMAP4_CM_ALWON_USBPHY_CLKCTRL_OFFSET           0x0040
> -#define OMAP4430_CM_ALWON_USBPHY_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_ALWAYS_ON_MOD, 0x0040)
> -
> -/* CM2.CORE_CM2 register offsets */
> -#define OMAP4_CM_L3_1_CLKSTCTRL_OFFSET                 0x0000
> -#define OMAP4430_CM_L3_1_CLKSTCTRL                     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0000)
> -#define OMAP4_CM_L3_1_DYNAMICDEP_OFFSET                        0x0008
> -#define OMAP4430_CM_L3_1_DYNAMICDEP                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0008)
> -#define OMAP4_CM_L3_1_L3_1_CLKCTRL_OFFSET              0x0020
> -#define OMAP4430_CM_L3_1_L3_1_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0020)
> -#define OMAP4_CM_L3_2_CLKSTCTRL_OFFSET                 0x0100
> -#define OMAP4430_CM_L3_2_CLKSTCTRL                     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0100)
> -#define OMAP4_CM_L3_2_DYNAMICDEP_OFFSET                        0x0108
> -#define OMAP4430_CM_L3_2_DYNAMICDEP                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0108)
> -#define OMAP4_CM_L3_2_L3_2_CLKCTRL_OFFSET              0x0120
> -#define OMAP4430_CM_L3_2_L3_2_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0120)
> -#define OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET              0x0128
> -#define OMAP4430_CM_L3_2_GPMC_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0128)
> -#define OMAP4_CM_L3_2_OCMC_RAM_CLKCTRL_OFFSET          0x0130
> -#define OMAP4430_CM_L3_2_OCMC_RAM_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0130)
> -#define OMAP4_CM_DUCATI_CLKSTCTRL_OFFSET               0x0200
> -#define OMAP4430_CM_DUCATI_CLKSTCTRL                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0200)
> -#define OMAP4_CM_DUCATI_STATICDEP_OFFSET               0x0204
> -#define OMAP4430_CM_DUCATI_STATICDEP                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0204)
> -#define OMAP4_CM_DUCATI_DYNAMICDEP_OFFSET              0x0208
> -#define OMAP4430_CM_DUCATI_DYNAMICDEP                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0208)
> -#define OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET          0x0220
> -#define OMAP4430_CM_DUCATI_DUCATI_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0220)
> -#define OMAP4_CM_SDMA_CLKSTCTRL_OFFSET                 0x0300
> -#define OMAP4430_CM_SDMA_CLKSTCTRL                     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0300)
> -#define OMAP4_CM_SDMA_STATICDEP_OFFSET                 0x0304
> -#define OMAP4430_CM_SDMA_STATICDEP                     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0304)
> -#define OMAP4_CM_SDMA_DYNAMICDEP_OFFSET                        0x0308
> -#define OMAP4430_CM_SDMA_DYNAMICDEP                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0308)
> -#define OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET              0x0320
> -#define OMAP4430_CM_SDMA_SDMA_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0320)
> -#define OMAP4_CM_MEMIF_CLKSTCTRL_OFFSET                        0x0400
> -#define OMAP4430_CM_MEMIF_CLKSTCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0400)
> -#define OMAP4_CM_MEMIF_DMM_CLKCTRL_OFFSET              0x0420
> -#define OMAP4430_CM_MEMIF_DMM_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0420)
> -#define OMAP4_CM_MEMIF_EMIF_FW_CLKCTRL_OFFSET          0x0428
> -#define OMAP4430_CM_MEMIF_EMIF_FW_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0428)
> -#define OMAP4_CM_MEMIF_EMIF_1_CLKCTRL_OFFSET           0x0430
> -#define OMAP4430_CM_MEMIF_EMIF_1_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0430)
> -#define OMAP4_CM_MEMIF_EMIF_2_CLKCTRL_OFFSET           0x0438
> -#define OMAP4430_CM_MEMIF_EMIF_2_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0438)
> -#define OMAP4_CM_MEMIF_DLL_CLKCTRL_OFFSET              0x0440
> -#define OMAP4430_CM_MEMIF_DLL_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0440)
> -#define OMAP4_CM_MEMIF_EMIF_H1_CLKCTRL_OFFSET          0x0450
> -#define OMAP4430_CM_MEMIF_EMIF_H1_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0450)
> -#define OMAP4_CM_MEMIF_EMIF_H2_CLKCTRL_OFFSET          0x0458
> -#define OMAP4430_CM_MEMIF_EMIF_H2_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0458)
> -#define OMAP4_CM_MEMIF_DLL_H_CLKCTRL_OFFSET            0x0460
> -#define OMAP4430_CM_MEMIF_DLL_H_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0460)
> -#define OMAP4_CM_D2D_CLKSTCTRL_OFFSET                  0x0500
> -#define OMAP4430_CM_D2D_CLKSTCTRL                      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0500)
> -#define OMAP4_CM_D2D_STATICDEP_OFFSET                  0x0504
> -#define OMAP4430_CM_D2D_STATICDEP                      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0504)
> -#define OMAP4_CM_D2D_DYNAMICDEP_OFFSET                 0x0508
> -#define OMAP4430_CM_D2D_DYNAMICDEP                     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0508)
> -#define OMAP4_CM_D2D_SAD2D_CLKCTRL_OFFSET              0x0520
> -#define OMAP4430_CM_D2D_SAD2D_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0520)
> -#define OMAP4_CM_D2D_MODEM_ICR_CLKCTRL_OFFSET          0x0528
> -#define OMAP4430_CM_D2D_MODEM_ICR_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0528)
> -#define OMAP4_CM_D2D_SAD2D_FW_CLKCTRL_OFFSET           0x0530
> -#define OMAP4430_CM_D2D_SAD2D_FW_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0530)
> -#define OMAP4_CM_L4CFG_CLKSTCTRL_OFFSET                        0x0600
> -#define OMAP4430_CM_L4CFG_CLKSTCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0600)
> -#define OMAP4_CM_L4CFG_DYNAMICDEP_OFFSET               0x0608
> -#define OMAP4430_CM_L4CFG_DYNAMICDEP                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0608)
> -#define OMAP4_CM_L4CFG_L4_CFG_CLKCTRL_OFFSET           0x0620
> -#define OMAP4430_CM_L4CFG_L4_CFG_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0620)
> -#define OMAP4_CM_L4CFG_HW_SEM_CLKCTRL_OFFSET           0x0628
> -#define OMAP4430_CM_L4CFG_HW_SEM_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0628)
> -#define OMAP4_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET          0x0630
> -#define OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0630)
> -#define OMAP4_CM_L4CFG_SAR_ROM_CLKCTRL_OFFSET          0x0638
> -#define OMAP4430_CM_L4CFG_SAR_ROM_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0638)
> -#define OMAP4_CM_L3INSTR_CLKSTCTRL_OFFSET              0x0700
> -#define OMAP4430_CM_L3INSTR_CLKSTCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0700)
> -#define OMAP4_CM_L3INSTR_L3_3_CLKCTRL_OFFSET           0x0720
> -#define OMAP4430_CM_L3INSTR_L3_3_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0720)
> -#define OMAP4_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET       0x0728
> -#define OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL           OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0728)
> -#define OMAP4_CM_L3INSTR_OCP_WP1_CLKCTRL_OFFSET                0x0740
> -#define OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CORE_MOD, 0x0740)
> -
> -/* CM2.IVAHD_CM2 register offsets */
> -#define OMAP4_CM_IVAHD_CLKSTCTRL_OFFSET                        0x0000
> -#define OMAP4430_CM_IVAHD_CLKSTCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_IVAHD_MOD, 0x0000)
> -#define OMAP4_CM_IVAHD_STATICDEP_OFFSET                        0x0004
> -#define OMAP4430_CM_IVAHD_STATICDEP                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_IVAHD_MOD, 0x0004)
> -#define OMAP4_CM_IVAHD_DYNAMICDEP_OFFSET               0x0008
> -#define OMAP4430_CM_IVAHD_DYNAMICDEP                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_IVAHD_MOD, 0x0008)
> -#define OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET            0x0020
> -#define OMAP4430_CM_IVAHD_IVAHD_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_IVAHD_MOD, 0x0020)
> -#define OMAP4_CM_IVAHD_SL2_CLKCTRL_OFFSET              0x0028
> -#define OMAP4430_CM_IVAHD_SL2_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_IVAHD_MOD, 0x0028)
> -
> -/* CM2.CAM_CM2 register offsets */
> -#define OMAP4_CM_CAM_CLKSTCTRL_OFFSET                  0x0000
> -#define OMAP4430_CM_CAM_CLKSTCTRL                      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CAM_MOD, 0x0000)
> -#define OMAP4_CM_CAM_STATICDEP_OFFSET                  0x0004
> -#define OMAP4430_CM_CAM_STATICDEP                      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CAM_MOD, 0x0004)
> -#define OMAP4_CM_CAM_DYNAMICDEP_OFFSET                 0x0008
> -#define OMAP4430_CM_CAM_DYNAMICDEP                     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CAM_MOD, 0x0008)
> -#define OMAP4_CM_CAM_ISS_CLKCTRL_OFFSET                        0x0020
> -#define OMAP4430_CM_CAM_ISS_CLKCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CAM_MOD, 0x0020)
> -#define OMAP4_CM_CAM_FDIF_CLKCTRL_OFFSET               0x0028
> -#define OMAP4430_CM_CAM_FDIF_CLKCTRL                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CAM_MOD, 0x0028)
> -
> -/* CM2.DSS_CM2 register offsets */
> -#define OMAP4_CM_DSS_CLKSTCTRL_OFFSET                  0x0000
> -#define OMAP4430_CM_DSS_CLKSTCTRL                      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_DSS_MOD, 0x0000)
> -#define OMAP4_CM_DSS_STATICDEP_OFFSET                  0x0004
> -#define OMAP4430_CM_DSS_STATICDEP                      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_DSS_MOD, 0x0004)
> -#define OMAP4_CM_DSS_DYNAMICDEP_OFFSET                 0x0008
> -#define OMAP4430_CM_DSS_DYNAMICDEP                     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_DSS_MOD, 0x0008)
> -#define OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET                        0x0020
> -#define OMAP4430_CM_DSS_DSS_CLKCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_DSS_MOD, 0x0020)
> -#define OMAP4_CM_DSS_DEISS_CLKCTRL_OFFSET              0x0028
> -#define OMAP4430_CM_DSS_DEISS_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_DSS_MOD, 0x0028)
>
> -/* CM2.GFX_CM2 register offsets */
> -#define OMAP4_CM_GFX_CLKSTCTRL_OFFSET                  0x0000
> -#define OMAP4430_CM_GFX_CLKSTCTRL                      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_GFX_MOD, 0x0000)
> -#define OMAP4_CM_GFX_STATICDEP_OFFSET                  0x0004
> -#define OMAP4430_CM_GFX_STATICDEP                      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_GFX_MOD, 0x0004)
> -#define OMAP4_CM_GFX_DYNAMICDEP_OFFSET                 0x0008
> -#define OMAP4430_CM_GFX_DYNAMICDEP                     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_GFX_MOD, 0x0008)
> -#define OMAP4_CM_GFX_GFX_CLKCTRL_OFFSET                        0x0020
> -#define OMAP4430_CM_GFX_GFX_CLKCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_GFX_MOD, 0x0020)
> +#include "prcm-common.h"
>
> -/* CM2.L3INIT_CM2 register offsets */
> -#define OMAP4_CM_L3INIT_CLKSTCTRL_OFFSET               0x0000
> -#define OMAP4430_CM_L3INIT_CLKSTCTRL                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0000)
> -#define OMAP4_CM_L3INIT_STATICDEP_OFFSET               0x0004
> -#define OMAP4430_CM_L3INIT_STATICDEP                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0004)
> -#define OMAP4_CM_L3INIT_DYNAMICDEP_OFFSET              0x0008
> -#define OMAP4430_CM_L3INIT_DYNAMICDEP                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0008)
> -#define OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET            0x0028
> -#define OMAP4430_CM_L3INIT_MMC1_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0028)
> -#define OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET            0x0030
> -#define OMAP4430_CM_L3INIT_MMC2_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0030)
> -#define OMAP4_CM_L3INIT_HSI_CLKCTRL_OFFSET             0x0038
> -#define OMAP4430_CM_L3INIT_HSI_CLKCTRL                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0038)
> -#define OMAP4_CM_L3INIT_UNIPRO1_CLKCTRL_OFFSET         0x0040
> -#define OMAP4430_CM_L3INIT_UNIPRO1_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0040)
> -#define OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET                0x0058
> -#define OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0058)
> -#define OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET         0x0060
> -#define OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0060)
> -#define OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET         0x0068
> -#define OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0068)
> -#define OMAP4_CM_L3INIT_P1500_CLKCTRL_OFFSET           0x0078
> -#define OMAP4430_CM_L3INIT_P1500_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0078)
> -#define OMAP4_CM_L3INIT_EMAC_CLKCTRL_OFFSET            0x0080
> -#define OMAP4430_CM_L3INIT_EMAC_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0080)
> -#define OMAP4_CM_L3INIT_SATA_CLKCTRL_OFFSET            0x0088
> -#define OMAP4430_CM_L3INIT_SATA_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0088)
> -#define OMAP4_CM_L3INIT_TPPSS_CLKCTRL_OFFSET           0x0090
> -#define OMAP4430_CM_L3INIT_TPPSS_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0090)
> -#define OMAP4_CM_L3INIT_PCIESS_CLKCTRL_OFFSET          0x0098
> -#define OMAP4430_CM_L3INIT_PCIESS_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x0098)
> -#define OMAP4_CM_L3INIT_CCPTX_CLKCTRL_OFFSET           0x00a8
> -#define OMAP4430_CM_L3INIT_CCPTX_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x00a8)
> -#define OMAP4_CM_L3INIT_XHPI_CLKCTRL_OFFSET            0x00c0
> -#define OMAP4430_CM_L3INIT_XHPI_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x00c0)
> -#define OMAP4_CM_L3INIT_MMC6_CLKCTRL_OFFSET            0x00c8
> -#define OMAP4430_CM_L3INIT_MMC6_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x00c8)
> -#define OMAP4_CM_L3INIT_USB_HOST_FS_CLKCTRL_OFFSET     0x00d0
> -#define OMAP4430_CM_L3INIT_USB_HOST_FS_CLKCTRL         OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x00d0)
> -#define OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET   0x00e0
> -#define OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL       OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L3INIT_MOD, 0x00e0)
> +#define OMAP4_CM_CLKSTCTRL                             0x0000
>
> -/* CM2.L4PER_CM2 register offsets */
> -#define OMAP4_CM_L4PER_CLKSTCTRL_OFFSET                        0x0000
> -#define OMAP4430_CM_L4PER_CLKSTCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0000)
> -#define OMAP4_CM_L4PER_DYNAMICDEP_OFFSET               0x0008
> -#define OMAP4430_CM_L4PER_DYNAMICDEP                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0008)
> -#define OMAP4_CM_L4PER_ADC_CLKCTRL_OFFSET              0x0020
> -#define OMAP4430_CM_L4PER_ADC_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0020)
> -#define OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET                0x0028
> -#define OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0028)
> -#define OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET                0x0030
> -#define OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0030)
> -#define OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET         0x0038
> -#define OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0038)
> -#define OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET         0x0040
> -#define OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0040)
> -#define OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET         0x0048
> -#define OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0048)
> -#define OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET         0x0050
> -#define OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0050)
> -#define OMAP4_CM_L4PER_ELM_CLKCTRL_OFFSET              0x0058
> -#define OMAP4430_CM_L4PER_ELM_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0058)
> -#define OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET            0x0060
> -#define OMAP4430_CM_L4PER_GPIO2_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0060)
> -#define OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET            0x0068
> -#define OMAP4430_CM_L4PER_GPIO3_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0068)
> -#define OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET            0x0070
> -#define OMAP4430_CM_L4PER_GPIO4_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0070)
> -#define OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET            0x0078
> -#define OMAP4430_CM_L4PER_GPIO5_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0078)
> -#define OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET            0x0080
> -#define OMAP4430_CM_L4PER_GPIO6_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0080)
> -#define OMAP4_CM_L4PER_HDQ1W_CLKCTRL_OFFSET            0x0088
> -#define OMAP4430_CM_L4PER_HDQ1W_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0088)
> -#define OMAP4_CM_L4PER_HECC1_CLKCTRL_OFFSET            0x0090
> -#define OMAP4430_CM_L4PER_HECC1_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0090)
> -#define OMAP4_CM_L4PER_HECC2_CLKCTRL_OFFSET            0x0098
> -#define OMAP4430_CM_L4PER_HECC2_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0098)
> -#define OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET             0x00a0
> -#define OMAP4430_CM_L4PER_I2C1_CLKCTRL                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00a0)
> -#define OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET             0x00a8
> -#define OMAP4430_CM_L4PER_I2C2_CLKCTRL                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00a8)
> -#define OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET             0x00b0
> -#define OMAP4430_CM_L4PER_I2C3_CLKCTRL                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00b0)
> -#define OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET             0x00b8
> -#define OMAP4430_CM_L4PER_I2C4_CLKCTRL                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00b8)
> -#define OMAP4_CM_L4PER_L4PER_CLKCTRL_OFFSET            0x00c0
> -#define OMAP4430_CM_L4PER_L4PER_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00c0)
> -#define OMAP4_CM_L4PER_MCASP2_CLKCTRL_OFFSET           0x00d0
> -#define OMAP4430_CM_L4PER_MCASP2_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00d0)
> -#define OMAP4_CM_L4PER_MCASP3_CLKCTRL_OFFSET           0x00d8
> -#define OMAP4430_CM_L4PER_MCASP3_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00d8)
> -#define OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET           0x00e0
> -#define OMAP4430_CM_L4PER_MCBSP4_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00e0)
> -#define OMAP4_CM_L4PER_MGATE_CLKCTRL_OFFSET            0x00e8
> -#define OMAP4430_CM_L4PER_MGATE_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00e8)
> -#define OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET           0x00f0
> -#define OMAP4430_CM_L4PER_MCSPI1_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00f0)
> -#define OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET           0x00f8
> -#define OMAP4430_CM_L4PER_MCSPI2_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x00f8)
> -#define OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET           0x0100
> -#define OMAP4430_CM_L4PER_MCSPI3_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0100)
> -#define OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET           0x0108
> -#define OMAP4430_CM_L4PER_MCSPI4_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0108)
> -#define OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET           0x0120
> -#define OMAP4430_CM_L4PER_MMCSD3_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0120)
> -#define OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET           0x0128
> -#define OMAP4430_CM_L4PER_MMCSD4_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0128)
> -#define OMAP4_CM_L4PER_MSPROHG_CLKCTRL_OFFSET          0x0130
> -#define OMAP4430_CM_L4PER_MSPROHG_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0130)
> -#define OMAP4_CM_L4PER_SLIMBUS2_CLKCTRL_OFFSET         0x0138
> -#define OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0138)
> -#define OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET            0x0140
> -#define OMAP4430_CM_L4PER_UART1_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0140)
> -#define OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET            0x0148
> -#define OMAP4430_CM_L4PER_UART2_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0148)
> -#define OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET            0x0150
> -#define OMAP4430_CM_L4PER_UART3_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0150)
> -#define OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET            0x0158
> -#define OMAP4430_CM_L4PER_UART4_CLKCTRL                        OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0158)
> -#define OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET           0x0160
> -#define OMAP4430_CM_L4PER_MMCSD5_CLKCTRL               OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0160)
> -#define OMAP4_CM_L4PER_I2C5_CLKCTRL_OFFSET             0x0168
> -#define OMAP4430_CM_L4PER_I2C5_CLKCTRL                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0168)
> -#define OMAP4_CM_L4SEC_CLKSTCTRL_OFFSET                        0x0180
> -#define OMAP4430_CM_L4SEC_CLKSTCTRL                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0180)
> -#define OMAP4_CM_L4SEC_STATICDEP_OFFSET                        0x0184
> -#define OMAP4430_CM_L4SEC_STATICDEP                    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0184)
> -#define OMAP4_CM_L4SEC_DYNAMICDEP_OFFSET               0x0188
> -#define OMAP4430_CM_L4SEC_DYNAMICDEP                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x0188)
> -#define OMAP4_CM_L4SEC_AES1_CLKCTRL_OFFSET             0x01a0
> -#define OMAP4430_CM_L4SEC_AES1_CLKCTRL                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x01a0)
> -#define OMAP4_CM_L4SEC_AES2_CLKCTRL_OFFSET             0x01a8
> -#define OMAP4430_CM_L4SEC_AES2_CLKCTRL                 OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x01a8)
> -#define OMAP4_CM_L4SEC_DES3DES_CLKCTRL_OFFSET          0x01b0
> -#define OMAP4430_CM_L4SEC_DES3DES_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x01b0)
> -#define OMAP4_CM_L4SEC_PKAEIP29_CLKCTRL_OFFSET         0x01b8
> -#define OMAP4430_CM_L4SEC_PKAEIP29_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x01b8)
> -#define OMAP4_CM_L4SEC_RNG_CLKCTRL_OFFSET              0x01c0
> -#define OMAP4430_CM_L4SEC_RNG_CLKCTRL                  OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x01c0)
> -#define OMAP4_CM_L4SEC_SHA2MD51_CLKCTRL_OFFSET         0x01c8
> -#define OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x01c8)
> -#define OMAP4_CM_L4SEC_CRYPTODMA_CLKCTRL_OFFSET                0x01d8
> -#define OMAP4430_CM_L4SEC_CRYPTODMA_CLKCTRL            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_L4PER_MOD, 0x01d8)
> +/* Function prototypes */
> +# ifndef __ASSEMBLER__
>
> -/* CM2.CEFUSE_CM2 register offsets */
> -#define OMAP4_CM_CEFUSE_CLKSTCTRL_OFFSET               0x0000
> -#define OMAP4430_CM_CEFUSE_CLKSTCTRL                   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CEFUSE_MOD, 0x0000)
> -#define OMAP4_CM_CEFUSE_CEFUSE_CLKCTRL_OFFSET          0x0020
> -#define OMAP4430_CM_CEFUSE_CEFUSE_CLKCTRL              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_CEFUSE_MOD, 0x0020)
> +extern int omap4_cm_wait_module_ready(void __iomem *clkctrl_reg);
>
> -/* CM2.RESTORE_CM2 register offsets */
> -#define OMAP4_CM_L3_1_CLKSTCTRL_RESTORE_OFFSET         0x0000
> -#define OMAP4430_CM_L3_1_CLKSTCTRL_RESTORE             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0000)
> -#define OMAP4_CM_L3_2_CLKSTCTRL_RESTORE_OFFSET         0x0004
> -#define OMAP4430_CM_L3_2_CLKSTCTRL_RESTORE             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0004)
> -#define OMAP4_CM_L4CFG_CLKSTCTRL_RESTORE_OFFSET                0x0008
> -#define OMAP4430_CM_L4CFG_CLKSTCTRL_RESTORE            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0008)
> -#define OMAP4_CM_MEMIF_CLKSTCTRL_RESTORE_OFFSET                0x000c
> -#define OMAP4430_CM_MEMIF_CLKSTCTRL_RESTORE            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x000c)
> -#define OMAP4_CM_L4PER_CLKSTCTRL_RESTORE_OFFSET                0x0010
> -#define OMAP4430_CM_L4PER_CLKSTCTRL_RESTORE            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0010)
> -#define OMAP4_CM_L3INIT_CLKSTCTRL_RESTORE_OFFSET       0x0014
> -#define OMAP4430_CM_L3INIT_CLKSTCTRL_RESTORE           OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0014)
> -#define OMAP4_CM_L3INSTR_L3_3_CLKCTRL_RESTORE_OFFSET   0x0018
> -#define OMAP4430_CM_L3INSTR_L3_3_CLKCTRL_RESTORE       OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0018)
> -#define OMAP4_CM_L3INSTR_L3_INSTR_CLKCTRL_RESTORE_OFFSET       0x001c
> -#define OMAP4430_CM_L3INSTR_L3_INSTR_CLKCTRL_RESTORE   OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x001c)
> -#define OMAP4_CM_L3INSTR_OCP_WP1_CLKCTRL_RESTORE_OFFSET        0x0020
> -#define OMAP4430_CM_L3INSTR_OCP_WP1_CLKCTRL_RESTORE    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0020)
> -#define OMAP4_CM_CM2_PROFILING_CLKCTRL_RESTORE_OFFSET  0x0024
> -#define OMAP4430_CM_CM2_PROFILING_CLKCTRL_RESTORE      OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0024)
> -#define OMAP4_CM_D2D_STATICDEP_RESTORE_OFFSET          0x0028
> -#define OMAP4430_CM_D2D_STATICDEP_RESTORE              OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0028)
> -#define OMAP4_CM_L3_1_DYNAMICDEP_RESTORE_OFFSET                0x002c
> -#define OMAP4430_CM_L3_1_DYNAMICDEP_RESTORE            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x002c)
> -#define OMAP4_CM_L3_2_DYNAMICDEP_RESTORE_OFFSET                0x0030
> -#define OMAP4430_CM_L3_2_DYNAMICDEP_RESTORE            OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0030)
> -#define OMAP4_CM_D2D_DYNAMICDEP_RESTORE_OFFSET         0x0034
> -#define OMAP4430_CM_D2D_DYNAMICDEP_RESTORE             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0034)
> -#define OMAP4_CM_L4CFG_DYNAMICDEP_RESTORE_OFFSET       0x0038
> -#define OMAP4430_CM_L4CFG_DYNAMICDEP_RESTORE           OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0038)
> -#define OMAP4_CM_L4PER_DYNAMICDEP_RESTORE_OFFSET       0x003c
> -#define OMAP4430_CM_L4PER_DYNAMICDEP_RESTORE           OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x003c)
> -#define OMAP4_CM_L4PER_GPIO2_CLKCTRL_RESTORE_OFFSET    0x0040
> -#define OMAP4430_CM_L4PER_GPIO2_CLKCTRL_RESTORE                OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0040)
> -#define OMAP4_CM_L4PER_GPIO3_CLKCTRL_RESTORE_OFFSET    0x0044
> -#define OMAP4430_CM_L4PER_GPIO3_CLKCTRL_RESTORE                OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0044)
> -#define OMAP4_CM_L4PER_GPIO4_CLKCTRL_RESTORE_OFFSET    0x0048
> -#define OMAP4430_CM_L4PER_GPIO4_CLKCTRL_RESTORE                OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0048)
> -#define OMAP4_CM_L4PER_GPIO5_CLKCTRL_RESTORE_OFFSET    0x004c
> -#define OMAP4430_CM_L4PER_GPIO5_CLKCTRL_RESTORE                OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x004c)
> -#define OMAP4_CM_L4PER_GPIO6_CLKCTRL_RESTORE_OFFSET    0x0050
> -#define OMAP4430_CM_L4PER_GPIO6_CLKCTRL_RESTORE                OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0050)
> -#define OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_RESTORE_OFFSET        0x0054
> -#define OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL_RESTORE    OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0054)
> -#define OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_RESTORE_OFFSET 0x0058
> -#define OMAP4430_CM_L3INIT_USB_TLL_CLKCTRL_RESTORE     OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x0058)
> -#define OMAP4_CM_SDMA_STATICDEP_RESTORE_OFFSET         0x005c
> -#define OMAP4430_CM_SDMA_STATICDEP_RESTORE             OMAP44XX_CM2_REGADDR(OMAP4430_CM2_RESTORE_MOD, 0x005c)
> +# endif
>   #endif
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5a30658..cafcd87 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -146,6 +146,7 @@
>
>   #include "cm.h"
>   #include "prm.h"
> +#include "prm44xx.h"
>
>   /* Maximum microseconds to wait for OMAP module to softreset */
>   #define MAX_MODULE_SOFTRESET_WAIT      10000
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 7274db4..a29bd00 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -25,7 +25,9 @@
>
>   #include "omap_hwmod_common_data.h"
>
> -#include "cm.h"
> +#include "cm1_44xx.h"
> +#include "cm2_44xx.h"
> +#include "prm44xx.h"
>   #include "prm-regbits-44xx.h"
>
>   /* Base offset for all OMAP4 interrupts external to MPUSS */
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 6206721..77f42b9 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,6 +19,7 @@
>   #include<linux/list.h>
>   #include<linux/errno.h>
>   #include<linux/string.h>
> +#include "prm44xx.h"
>
>   #include<plat/cpu.h>
>   #include<plat/powerdomain.h>
> diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
> index 366e869..7efdf68 100644
> --- a/arch/arm/mach-omap2/powerdomain44xx.c
> +++ b/arch/arm/mach-omap2/powerdomain44xx.c
> @@ -18,7 +18,7 @@
>
>   #include<plat/powerdomain.h>
>   #include<plat/prcm.h>
> -#include "prm.h"
> +#include "prm44xx.h"
>   #include "prm-regbits-44xx.h"
>   #include "powerdomains.h"
>
> diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
> index 2512f69..d078c88 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> @@ -26,10 +26,10 @@
>   #include "powerdomains.h"
>
>   #include "prcm-common.h"
> -#include "cm.h"
> -#include "cm-regbits-44xx.h"
>   #include "prm.h"
>   #include "prm-regbits-44xx.h"
> +#include "prm44xx.h"
> +#include "prcm_mpu44xx.h"
>
>   /* core_44xx_pwrdm: CORE power domain */
>   static struct powerdomain core_44xx_pwrdm = {
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index 298a22a..4979160 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -8,15 +8,12 @@
>    * Copyright (C) 2007-2009 Nokia Corporation
>    *
>    * Written by Paul Walmsley
> - * OMAP4 defines in this file are automatically generated from the OMAP hardware
> - * databases.
>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
>    * published by the Free Software Foundation.
>    */
>
> -
>   /* Module offsets from both CM_BASE&  PRM_BASE */
>
>   /*
> @@ -51,75 +48,6 @@
>   #define OMAP3430_NEON_MOD                              0xb00
>   #define OMAP3430ES2_USBHOST_MOD                                0xc00
>
> -#define BITS(n_bit)    \
> -       (((1<<  n_bit) - 1) | (1<<  n_bit))
> -
> -#define BITFIELD(l_bit, u_bit) \
> -       (BITS(u_bit)&  ~((BITS(l_bit))>>  1))
> -
> -/* OMAP44XX specific module offsets */
> -
> -/* CM1 instances */
> -
> -#define OMAP4430_CM1_OCP_SOCKET_MOD    0x0000
> -#define OMAP4430_CM1_CKGEN_MOD         0x0100
> -#define OMAP4430_CM1_MPU_MOD           0x0300
> -#define OMAP4430_CM1_TESLA_MOD         0x0400
> -#define OMAP4430_CM1_ABE_MOD           0x0500
> -#define OMAP4430_CM1_RESTORE_MOD       0x0e00
> -#define OMAP4430_CM1_INSTR_MOD         0x0f00
> -
> -/* CM2 instances */
> -
> -#define OMAP4430_CM2_OCP_SOCKET_MOD    0x0000
> -#define OMAP4430_CM2_CKGEN_MOD         0x0100
> -#define OMAP4430_CM2_ALWAYS_ON_MOD     0x0600
> -#define OMAP4430_CM2_CORE_MOD          0x0700
> -#define OMAP4430_CM2_IVAHD_MOD         0x0f00
> -#define OMAP4430_CM2_CAM_MOD           0x1000
> -#define OMAP4430_CM2_DSS_MOD           0x1100
> -#define OMAP4430_CM2_GFX_MOD           0x1200
> -#define OMAP4430_CM2_L3INIT_MOD                0x1300
> -#define OMAP4430_CM2_L4PER_MOD         0x1400
> -#define OMAP4430_CM2_CEFUSE_MOD                0x1600
> -#define OMAP4430_CM2_RESTORE_MOD       0x1e00
> -#define OMAP4430_CM2_INSTR_MOD         0x1f00
> -
> -/* PRM instances */
> -
> -#define OMAP4430_PRM_OCP_SOCKET_MOD    0x0000
> -#define OMAP4430_PRM_CKGEN_MOD         0x0100
> -#define OMAP4430_PRM_MPU_MOD           0x0300
> -#define OMAP4430_PRM_TESLA_MOD         0x0400
> -#define OMAP4430_PRM_ABE_MOD           0x0500
> -#define OMAP4430_PRM_ALWAYS_ON_MOD     0x0600
> -#define OMAP4430_PRM_CORE_MOD          0x0700
> -#define OMAP4430_PRM_IVAHD_MOD         0x0f00
> -#define OMAP4430_PRM_CAM_MOD           0x1000
> -#define OMAP4430_PRM_DSS_MOD           0x1100
> -#define OMAP4430_PRM_GFX_MOD           0x1200
> -#define OMAP4430_PRM_L3INIT_MOD                0x1300
> -#define OMAP4430_PRM_L4PER_MOD         0x1400
> -#define OMAP4430_PRM_CEFUSE_MOD                0x1600
> -#define OMAP4430_PRM_WKUP_MOD          0x1700
> -#define OMAP4430_PRM_WKUP_CM_MOD       0x1800
> -#define OMAP4430_PRM_EMU_MOD           0x1900
> -#define OMAP4430_PRM_EMU_CM_MOD                0x1a00
> -#define OMAP4430_PRM_DEVICE_MOD                0x1b00
> -#define OMAP4430_PRM_INSTR_MOD         0x1f00
> -
> -/* SCRM instances */
> -
> -#define OMAP4430_SCRM_SCRM_MOD 0x0000
> -
> -/* PRCM_MPU instances */
> -
> -#define OMAP4430_PRCM_MPU_OCP_SOCKET_PRCM_MOD  0x0000
> -#define OMAP4430_PRCM_MPU_DEVICE_PRM_MOD       0x0200
> -#define OMAP4430_PRCM_MPU_CPU0_MOD             0x0400
> -#define OMAP4430_PRCM_MPU_CPU1_MOD             0x0800
> -
> -
>   /* 24XX register bits shared between CM&  PRM registers */
>
>   /* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
> @@ -460,5 +388,12 @@
>   #define OMAP3430_EN_CORE_SHIFT                         0
>   #define OMAP3430_EN_CORE_MASK                          (1<<  0)
>
> +
> +/*
> + * MAX_MODULE_HARDRESET_WAIT: Maximum microseconds to wait for an OMAP
> + * submodule to exit hardreset
> + */
> +#define MAX_MODULE_HARDRESET_WAIT              10000
> +
>   #endif
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index d27cdba..df55fdf 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -31,6 +31,7 @@
>   #include "clock2xxx.h"
>   #include "cm.h"
>   #include "prm.h"
> +#include "prm44xx.h"
>   #include "prm-regbits-24xx.h"
>   #include "prm-regbits-44xx.h"
>   #include "control.h"
> diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
> new file mode 100644
> index 0000000..5b828df
> --- /dev/null
> +++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
> @@ -0,0 +1,91 @@
> +/*
> + * OMAP44xx PRCM MPU instance offset macros
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright (C) 2010 Nokia Corporation
> + *
> + * Paul Walmsley (paul at pwsan.com)
> + * Rajendra Nayak (rnayak at ti.com)
> + * Benoit Cousson (b-cousson at ti.com)
> + *
> + * This file is automatically generated from the OMAP hardware databases.
> + * We respectfully ask that any modifications to this file be coordinated
> + * with the public linux-omap at vger.kernel.org mailing list and the
> + * authors above to ensure that the autogeneration scripts are kept
> + * up-to-date with the file contents.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
> + *     or "OMAP4430".
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_PRCM_MPU44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_PRCM_MPU44XX_H
> +
> +#define OMAP4430_PRCM_MPU_BASE                 0x48243000
> +
> +#define OMAP44XX_PRCM_MPU_REGADDR(module, reg)                         \
> +       OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE + (module) + (reg))
> +
> +/* PRCM_MPU instances */
> +
> +#define OMAP4430_PRCM_MPU_OCP_SOCKET_PRCM_MOD  0x0000
> +#define OMAP4430_PRCM_MPU_DEVICE_PRM_MOD       0x0200
> +#define OMAP4430_PRCM_MPU_CPU0_MOD             0x0400
> +#define OMAP4430_PRCM_MPU_CPU1_MOD             0x0800
> +
> +/*
> + * PRCM_MPU
> + *
> + * The PRCM_MPU is a local PRCM inside the MPU subsystem. For the PRCM (global)
> + * point of view the PRCM_MPU is a single entity. It shares the same
> + * programming model as the global PRCM and thus can be assimilate as two new
> + * MOD inside the PRCM
> + */
> +
> +/* PRCM_MPU.OCP_SOCKET_PRCM register offsets */
> +#define OMAP4_REVISION_PRCM_OFFSET                     0x0000
> +#define OMAP4430_REVISION_PRCM                         OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_OCP_SOCKET_PRCM_MOD, 0x0000)
> +
> +/* PRCM_MPU.DEVICE_PRM register offsets */
> +#define OMAP4_PRCM_MPU_PRM_RSTST_OFFSET                        0x0000
> +#define OMAP4430_PRCM_MPU_PRM_RSTST                    OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_DEVICE_PRM_MOD, 0x0000)
> +#define OMAP4_PRCM_MPU_PRM_PSCON_COUNT_OFFSET          0x0004
> +#define OMAP4430_PRCM_MPU_PRM_PSCON_COUNT              OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_DEVICE_PRM_MOD, 0x0004)
> +
> +/* PRCM_MPU.CPU0 register offsets */
> +#define OMAP4_PM_CPU0_PWRSTCTRL_OFFSET                 0x0000
> +#define OMAP4430_PM_CPU0_PWRSTCTRL                     OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0000)
> +#define OMAP4_PM_CPU0_PWRSTST_OFFSET                   0x0004
> +#define OMAP4430_PM_CPU0_PWRSTST                       OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0004)
> +#define OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET              0x0008
> +#define OMAP4430_RM_CPU0_CPU0_CONTEXT                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0008)
> +#define OMAP4_RM_CPU0_CPU0_RSTCTRL_OFFSET              0x000c
> +#define OMAP4430_RM_CPU0_CPU0_RSTCTRL                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x000c)
> +#define OMAP4_RM_CPU0_CPU0_RSTST_OFFSET                        0x0010
> +#define OMAP4430_RM_CPU0_CPU0_RSTST                    OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0010)
> +#define OMAP4_CM_CPU0_CPU0_CLKCTRL_OFFSET              0x0014
> +#define OMAP4430_CM_CPU0_CPU0_CLKCTRL                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0014)
> +#define OMAP4_CM_CPU0_CLKSTCTRL_OFFSET                 0x0018
> +#define OMAP4430_CM_CPU0_CLKSTCTRL                     OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0018)
> +
> +/* PRCM_MPU.CPU1 register offsets */
> +#define OMAP4_PM_CPU1_PWRSTCTRL_OFFSET                 0x0000
> +#define OMAP4430_PM_CPU1_PWRSTCTRL                     OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0000)
> +#define OMAP4_PM_CPU1_PWRSTST_OFFSET                   0x0004
> +#define OMAP4430_PM_CPU1_PWRSTST                       OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0004)
> +#define OMAP4_RM_CPU1_CPU1_CONTEXT_OFFSET              0x0008
> +#define OMAP4430_RM_CPU1_CPU1_CONTEXT                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0008)
> +#define OMAP4_RM_CPU1_CPU1_RSTCTRL_OFFSET              0x000c
> +#define OMAP4430_RM_CPU1_CPU1_RSTCTRL                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x000c)
> +#define OMAP4_RM_CPU1_CPU1_RSTST_OFFSET                        0x0010
> +#define OMAP4430_RM_CPU1_CPU1_RSTST                    OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0010)
> +#define OMAP4_CM_CPU1_CPU1_CLKCTRL_OFFSET              0x0014
> +#define OMAP4430_CM_CPU1_CPU1_CLKCTRL                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0014)
> +#define OMAP4_CM_CPU1_CLKSTCTRL_OFFSET                 0x0018
> +#define OMAP4430_CM_CPU1_CLKSTCTRL                     OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0018)
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
> index 7be040b..10a24ca 100644
> --- a/arch/arm/mach-omap2/prm.h
> +++ b/arch/arm/mach-omap2/prm.h
> @@ -22,12 +22,6 @@
>                  OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
>   #define OMAP34XX_PRM_REGADDR(module, reg)                              \
>                  OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
> -#define OMAP44XX_PRM_REGADDR(module, reg)                              \
> -               OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE + (module) + (reg))
> -#define OMAP44XX_PRCM_MPU_REGADDR(module, reg)                         \
> -               OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE + (module) + (reg))
> -
> -#include "prm44xx.h"
>
>   /*
>    * Architecture-specific global PRM registers
> @@ -220,13 +214,6 @@
>   #define OMAP3430_PRM_IRQSTATUS_IVA2                    0x00f8
>   #define OMAP3430_PRM_IRQENABLE_IVA2                    0x00fc
>
> -/* Omap4 specific registers */
> -#define OMAP4_RM_RSTCTRL                               0x0000
> -#define OMAP4_RM_RSTTIME                               0x0004
> -#define OMAP4_RM_RSTST                                 0x0008
> -#define OMAP4_PM_PWSTCTRL                              0x0000
> -#define OMAP4_PM_PWSTST                                        0x0004
> -
>
>   #ifndef __ASSEMBLER__
>
> @@ -251,10 +238,6 @@ int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
>   int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
>   int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
>
> -int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 shift);
> -int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift);
> -int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift);
> -
>   #endif
>
>   /*
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
> index a1ff918..697b58f 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -20,7 +20,7 @@
>   #include<plat/cpu.h>
>   #include<plat/prcm.h>
>
> -#include "prm.h"
> +#include "prm44xx.h"
>   #include "prm-regbits-44xx.h"
>
>   /*
> diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
> index 59839db..4343881 100644
> --- a/arch/arm/mach-omap2/prm44xx.h
> +++ b/arch/arm/mach-omap2/prm44xx.h
> @@ -17,11 +17,52 @@
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
>    * published by the Free Software Foundation.
> + *
> + * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
> + *     or "OMAP4430".
>    */
>
>   #ifndef __ARCH_ARM_MACH_OMAP2_PRM44XX_H
>   #define __ARCH_ARM_MACH_OMAP2_PRM44XX_H
>
> +#include "prcm-common.h"
> +
> +#define OMAP4430_PRM_BASE              0x4a306000
> +
> +#define OMAP44XX_PRM_REGADDR(module, reg)                              \
> +       OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE + (module) + (reg))
> +
> +
> +/* PRM instances */
> +#define OMAP4430_PRM_OCP_SOCKET_MOD    0x0000
> +#define OMAP4430_PRM_CKGEN_MOD         0x0100
> +#define OMAP4430_PRM_MPU_MOD           0x0300
> +#define OMAP4430_PRM_TESLA_MOD         0x0400
> +#define OMAP4430_PRM_ABE_MOD           0x0500
> +#define OMAP4430_PRM_ALWAYS_ON_MOD     0x0600
> +#define OMAP4430_PRM_CORE_MOD          0x0700
> +#define OMAP4430_PRM_IVAHD_MOD         0x0f00
> +#define OMAP4430_PRM_CAM_MOD           0x1000
> +#define OMAP4430_PRM_DSS_MOD           0x1100
> +#define OMAP4430_PRM_GFX_MOD           0x1200
> +#define OMAP4430_PRM_L3INIT_MOD                0x1300
> +#define OMAP4430_PRM_L4PER_MOD         0x1400
> +#define OMAP4430_PRM_CEFUSE_MOD                0x1600
> +#define OMAP4430_PRM_WKUP_MOD          0x1700
> +#define OMAP4430_PRM_WKUP_CM_MOD       0x1800
> +#define OMAP4430_PRM_EMU_MOD           0x1900
> +#define OMAP4430_PRM_EMU_CM_MOD                0x1a00
> +#define OMAP4430_PRM_DEVICE_MOD                0x1b00
> +#define OMAP4430_PRM_INSTR_MOD         0x1f00
> +
> +
> +/* OMAP4 specific register offsets */
> +#define OMAP4_RM_RSTCTRL                               0x0000
> +#define OMAP4_RM_RSTTIME                               0x0004
> +#define OMAP4_RM_RSTST                                 0x0008
> +#define OMAP4_PM_PWSTCTRL                              0x0000
> +#define OMAP4_PM_PWSTST                                        0x0004
> +
>
>   /* PRM */
>
> @@ -699,54 +740,22 @@
>   #define OMAP4_PRM_VC_ERRST_OFFSET                      0x00f8
>   #define OMAP4430_PRM_VC_ERRST                          OMAP44XX_PRM_REGADDR(OMAP4430_PRM_DEVICE_MOD, 0x00f8)
>
> -/*
> - * PRCM_MPU
> - *
> - * The PRCM_MPU is a local PRCM inside the MPU subsystem. For the PRCM (global)
> - * point of view the PRCM_MPU is a single entity. It shares the same
> - * programming model as the global PRCM and thus can be assimilate as two new
> - * MOD inside the PRCM
> - */
> +/* Function prototypes */
> +# ifndef __ASSEMBLER__
> +
> +extern u32 omap4_prm_read_mod_reg(s16 module, u16 idx);
> +extern void omap4_prm_write_mod_reg(u32 val, s16 module, u16 idx);
> +extern u32 omap4_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
> +extern u32 omap4_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
> +extern u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
> +extern u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
> +extern u32 omap4_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
> +extern u32 omap4_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
> +
> +extern int omap4_prm_is_hardreset_asserted(void __iomem *rstctrl_reg, u8 shift);
> +extern int omap4_prm_assert_hardreset(void __iomem *rstctrl_reg, u8 shift);
> +extern int omap4_prm_deassert_hardreset(void __iomem *rstctrl_reg, u8 shift);
> +
> +# endif
>
> -/* PRCM_MPU.OCP_SOCKET_PRCM register offsets */
> -#define OMAP4_REVISION_PRCM_OFFSET                     0x0000
> -#define OMAP4430_REVISION_PRCM                         OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_OCP_SOCKET_PRCM_MOD, 0x0000)
> -
> -/* PRCM_MPU.DEVICE_PRM register offsets */
> -#define OMAP4_PRCM_MPU_PRM_RSTST_OFFSET                        0x0000
> -#define OMAP4430_PRCM_MPU_PRM_RSTST                    OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_DEVICE_PRM_MOD, 0x0000)
> -#define OMAP4_PRCM_MPU_PRM_PSCON_COUNT_OFFSET          0x0004
> -#define OMAP4430_PRCM_MPU_PRM_PSCON_COUNT              OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_DEVICE_PRM_MOD, 0x0004)
> -
> -/* PRCM_MPU.CPU0 register offsets */
> -#define OMAP4_PM_CPU0_PWRSTCTRL_OFFSET                 0x0000
> -#define OMAP4430_PM_CPU0_PWRSTCTRL                     OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0000)
> -#define OMAP4_PM_CPU0_PWRSTST_OFFSET                   0x0004
> -#define OMAP4430_PM_CPU0_PWRSTST                       OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0004)
> -#define OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET              0x0008
> -#define OMAP4430_RM_CPU0_CPU0_CONTEXT                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0008)
> -#define OMAP4_RM_CPU0_CPU0_RSTCTRL_OFFSET              0x000c
> -#define OMAP4430_RM_CPU0_CPU0_RSTCTRL                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x000c)
> -#define OMAP4_RM_CPU0_CPU0_RSTST_OFFSET                        0x0010
> -#define OMAP4430_RM_CPU0_CPU0_RSTST                    OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0010)
> -#define OMAP4_CM_CPU0_CPU0_CLKCTRL_OFFSET              0x0014
> -#define OMAP4430_CM_CPU0_CPU0_CLKCTRL                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0014)
> -#define OMAP4_CM_CPU0_CLKSTCTRL_OFFSET                 0x0018
> -#define OMAP4430_CM_CPU0_CLKSTCTRL                     OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU0_MOD, 0x0018)
> -
> -/* PRCM_MPU.CPU1 register offsets */
> -#define OMAP4_PM_CPU1_PWRSTCTRL_OFFSET                 0x0000
> -#define OMAP4430_PM_CPU1_PWRSTCTRL                     OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0000)
> -#define OMAP4_PM_CPU1_PWRSTST_OFFSET                   0x0004
> -#define OMAP4430_PM_CPU1_PWRSTST                       OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0004)
> -#define OMAP4_RM_CPU1_CPU1_CONTEXT_OFFSET              0x0008
> -#define OMAP4430_RM_CPU1_CPU1_CONTEXT                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0008)
> -#define OMAP4_RM_CPU1_CPU1_RSTCTRL_OFFSET              0x000c
> -#define OMAP4430_RM_CPU1_CPU1_RSTCTRL                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x000c)
> -#define OMAP4_RM_CPU1_CPU1_RSTST_OFFSET                        0x0010
> -#define OMAP4430_RM_CPU1_CPU1_RSTST                    OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0010)
> -#define OMAP4_CM_CPU1_CPU1_CLKCTRL_OFFSET              0x0014
> -#define OMAP4430_CM_CPU1_CPU1_CLKCTRL                  OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0014)
> -#define OMAP4_CM_CPU1_CLKSTCTRL_OFFSET                 0x0018
> -#define OMAP4430_CM_CPU1_CLKSTCTRL                     OMAP44XX_PRCM_MPU_REGADDR(OMAP4430_PRCM_MPU_CPU1_MOD, 0x0018)
>   #endif
> diff --git a/arch/arm/mach-omap2/scrm44xx.h b/arch/arm/mach-omap2/scrm44xx.h
> new file mode 100644
> index 0000000..53ea8e8
> --- /dev/null
> +++ b/arch/arm/mach-omap2/scrm44xx.h
> @@ -0,0 +1,32 @@
> +/*
> + * OMAP44xx SCRM instance offset macros
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright (C) 2010 Nokia Corporation
> + *
> + * Paul Walmsley (paul at pwsan.com)
> + * Rajendra Nayak (rnayak at ti.com)
> + * Benoit Cousson (b-cousson at ti.com)
> + *
> + * This file is automatically generated from the OMAP hardware databases.
> + * We respectfully ask that any modifications to this file be coordinated
> + * with the public linux-omap at vger.kernel.org mailing list and the
> + * authors above to ensure that the autogeneration scripts are kept
> + * up-to-date with the file contents.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_SCRM44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_SCRM44XX_H
> +
> +#define OMAP4430_SCRM_BASE             0x4a30a000
> +
> +/* SCRM instances */
> +#define OMAP4430_SCRM_SCRM_MOD         0x0000
> +
> +/* XXX SCRM registers should go here */
> +
> +#endif
>
>
