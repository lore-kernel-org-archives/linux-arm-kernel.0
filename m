From: csd_b@daudt.org (Christian Daudt)
Date: Wed, 3 Apr 2013 14:16:15 -0700
Subject: [PATCH V2 1/2] ARM: bcm281xx: Add L2 cache enable code
In-Reply-To: <1363299268-10506-1-git-send-email-csd@broadcom.com>
References: <1363299268-10506-1-git-send-email-csd@broadcom.com>
Message-ID: <CAGFynZ9pE_B8KQNQvWsyn4Yz7tdd5VQwm=c76S-SPsGKNgu9ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 3:14 PM, Christian Daudt <csd@broadcom.com> wrote:
> - Adds a module to provide calls into secure monitor mode
> - Uses this module to make secure monitor calls to enable L2 cache.
>
> Updates from V1:
> - Split DT portion into separate patch
> - replace #ifdef-ed L2 code with "if".
> - move init call to board init
>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
>
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index bbf4122..6adb6aec 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -10,4 +10,6 @@
>  # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  # GNU General Public License for more details.
>
> -obj-$(CONFIG_ARCH_BCM) := board_bcm.o
> +obj-$(CONFIG_ARCH_BCM)         := board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
> +plus_sec := $(call as-instr,.arch_extension sec,+sec)
> +AFLAGS_bcm_kona_smc_asm.o      :=-Wa,-march=armv7-a$(plus_sec)
> diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
> new file mode 100644
> index 0000000..5f1d131
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm_kona_smc.c
> @@ -0,0 +1,118 @@
> +/*
> + * Copyright (C) 2013 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <stdarg.h>
> +#include <linux/smp.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +
> +#include <asm/cacheflush.h>
> +#include <linux/of_address.h>
> +
> +#include "bcm_kona_smc.h"
> +
> +struct secure_bridge_data {
> +       void __iomem *bounce;           /* virtual address */
> +       u32 __iomem buffer_addr;        /* physical address */
> +       int initialized;
> +} bridge_data;
> +
> +struct bcm_kona_smc_data {
> +       unsigned service_id;
> +       unsigned arg0;
> +       unsigned arg1;
> +       unsigned arg2;
> +       unsigned arg3;
> +};
> +
> +static const struct of_device_id bcm_kona_smc_ids[] __initconst = {
> +       {.compatible = "bcm,kona-smc"},
> +       {},
> +};
> +
> +/* Map in the bounce area */
> +void bcm_kona_smc_init(void)
> +{
> +       struct device_node *node;
> +
> +       /* Read buffer addr and size from the device tree node */
> +       node = of_find_matching_node(NULL, bcm_kona_smc_ids);
> +       BUG_ON(!node);
> +
> +       /* Don't care about size or flags of the DT node */
> +       bridge_data.buffer_addr =
> +               be32_to_cpu(*of_get_address(node, 0, NULL, NULL));
> +       BUG_ON(!bridge_data.buffer_addr);
> +
> +       bridge_data.bounce = of_iomap(node, 0);
> +       BUG_ON(!bridge_data.bounce);
> +
> +       bridge_data.initialized = 1;
> +
> +       pr_info("Secure API initialized!\n");
> +}
> +
> +/* __bcm_kona_smc() should only run on CPU 0, with pre-emption disabled */
> +static void __bcm_kona_smc(void *info)
> +{
> +       struct bcm_kona_smc_data *data = info;
> +       u32 *args = bridge_data.bounce;
> +       int rc = 0;
> +
> +       /* Must run on CPU 0 */
> +       BUG_ON(smp_processor_id() != 0);
> +
> +       /* Check map in the bounce area */
> +       BUG_ON(!bridge_data.initialized);
> +
> +       /* Copy one 32 bit word into the bounce area */
> +       args[0] = data->arg0;
> +       args[1] = data->arg1;
> +       args[2] = data->arg2;
> +       args[3] = data->arg3;
> +
> +       /* Flush caches for input data passed to Secure Monitor */
> +       if (data->service_id != SSAPI_BRCM_START_VC_CORE)
> +               flush_cache_all();
> +
> +       /* Trap into Secure Monitor */
> +       rc = bcm_kona_smc_asm(data->service_id, bridge_data.buffer_addr);
> +
> +       if (rc != SEC_ROM_RET_OK)
> +               pr_err("Secure Monitor call failed (0x%x)!\n", rc);
> +}
> +
> +unsigned bcm_kona_smc(unsigned service_id, unsigned arg0, unsigned arg1,
> +                 unsigned arg2, unsigned arg3)
> +{
> +       struct bcm_kona_smc_data data;
> +
> +       data.service_id = service_id;
> +       data.arg0 = arg0;
> +       data.arg1 = arg1;
> +       data.arg2 = arg2;
> +       data.arg3 = arg3;
> +
> +       /*
> +        * Due to a limitation of the secure monitor, we must use the SMP
> +        * infrastructure to forward all secure monitor calls to Core 0.
> +        */
> +       if (get_cpu() != 0)
> +               smp_call_function_single(0, __bcm_kona_smc, (void *)&data, 1);
> +       else
> +               __bcm_kona_smc(&data);
> +
> +       put_cpu();
> +
> +       return 0;
> +}
> diff --git a/arch/arm/mach-bcm/bcm_kona_smc.h b/arch/arm/mach-bcm/bcm_kona_smc.h
> new file mode 100644
> index 0000000..3bedbed
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm_kona_smc.h
> @@ -0,0 +1,80 @@
> +/*
> + * Copyright (C) 2013 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef BCM_KONA_SMC_H
> +#define BCM_KONA_SMC_H
> +
> +#include <linux/types.h>
> +#define FLAGS  (SEC_ROM_ICACHE_ENABLE_MASK | SEC_ROM_DCACHE_ENABLE_MASK | \
> +                       SEC_ROM_IRQ_ENABLE_MASK | SEC_ROM_FIQ_ENABLE_MASK)
> +
> +/*!
> + * Definitions for IRQ & FIQ Mask for ARM
> + */
> +
> +#define FIQ_IRQ_MASK                                           0xC0
> +#define FIQ_MASK                                               0x40
> +#define IRQ_MASK                                               0x80
> +
> +/*!
> + * Secure Mode FLAGs
> + */
> +
> +/* When set, enables ICache within the secure mode */
> +#define SEC_ROM_ICACHE_ENABLE_MASK                        0x00000001
> +
> +/* When set, enables DCache within the secure mode */
> +#define SEC_ROM_DCACHE_ENABLE_MASK                        0x00000002
> +
> +/* When set, enables IRQ within the secure mode */
> +#define SEC_ROM_IRQ_ENABLE_MASK                           0x00000004
> +
> +/* When set, enables FIQ within the secure mode */
> +#define SEC_ROM_FIQ_ENABLE_MASK                           0x00000008
> +
> +/* When set, enables Unified L2 cache within the secure mode */
> +#define SEC_ROM_UL2_CACHE_ENABLE_MASK                     0x00000010
> +
> +/* Broadcom Secure Service API Service IDs */
> +#define SSAPI_DORMANT_ENTRY_SERV                          0x01000000
> +#define SSAPI_PUBLIC_OTP_SERV                             0x01000001
> +#define SSAPI_ENABLE_L2_CACHE                             0x01000002
> +#define SSAPI_DISABLE_L2_CACHE                            0x01000003
> +#define SSAPI_WRITE_SCU_STATUS                            0x01000004
> +#define SSAPI_WRITE_PWR_GATE                              0x01000005
> +
> +/* Broadcom Secure Service API Return Codes */
> +#define SEC_ROM_RET_OK                 0x00000001
> +#define SEC_ROM_RET_FAIL               0x00000009
> +
> +#define SSAPI_RET_FROM_INT_SERV                0x4
> +#define SEC_EXIT_NORMAL                        0x1
> +
> +#define SSAPI_ROW_AES                  0x0E000006
> +#define SSAPI_BRCM_START_VC_CORE       0x0E000008
> +
> +#ifndef        __ASSEMBLY__
> +extern void bcm_kona_smc_init(void);
> +
> +extern unsigned bcm_kona_smc(unsigned service_id,
> +                            unsigned arg0,
> +                            unsigned arg1,
> +                            unsigned arg2,
> +                            unsigned arg3);
> +
> +extern int bcm_kona_smc_asm(u32 service_id,
> +                           u32 buffer_addr);
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* BCM_KONA_SMC_H */
> diff --git a/arch/arm/mach-bcm/bcm_kona_smc_asm.S b/arch/arm/mach-bcm/bcm_kona_smc_asm.S
> new file mode 100644
> index 0000000..a160848
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm_kona_smc_asm.S
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright (C) 2013 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/linkage.h>
> +#include "bcm_kona_smc.h"
> +
> +/*
> + * int bcm_kona_smc_asm(u32 service_id, u32 buffer_addr)
> + */
> +
> +ENTRY(bcm_kona_smc_asm)
> +       stmfd   sp!, {r4-r12, lr}
> +       mov     r4, r0          @ service_id
> +       mov     r5, #3          @ Keep IRQ and FIQ off in SM
> +       /*
> +        * Since interrupts are disabled in the open mode, we must keep
> +        * interrupts disabled in secure mode by setting R5=0x3. If interrupts
> +        * are enabled in open mode, we can set R5=0x0 to allow interrupts in
> +        * secure mode.  If we did this, the secure monitor would return back
> +        * control to the open mode to handle the interrupt prior to completing
> +        * the secure service. If this happened, R12 would not be
> +        * SEC_EXIT_NORMAL and we would need to call SMC again after resetting
> +        * R5 (it gets clobbered by the secure monitor) and setting R4 to
> +        * SSAPI_RET_FROM_INT_SERV to indicate that we want the secure monitor
> +        * to finish up the previous uncompleted secure service.
> +        */
> +       mov     r6, r1          @ buffer_addr
> +       smc     #0
> +       /* Check r12 for SEC_EXIT_NORMAL here if interrupts are enabled */
> +       ldmfd   sp!, {r4-r12, pc}
> +ENDPROC(bcm_kona_smc_asm)
> diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
> index 2595935..e2ddfec 100644
> --- a/arch/arm/mach-bcm/board_bcm.c
> +++ b/arch/arm/mach-bcm/board_bcm.c
> @@ -16,16 +16,39 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/irqchip.h>
> +#include <asm/hardware/cache-l2x0.h>
>  #include <linux/clocksource.h>
>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>
>
> +#include "bcm_kona_smc.h"
> +
> +static int __init kona_l2_cache_init(void)
> +{
> +       if (!IS_ENABLED(CONFIG_CACHE_L2X0))
> +               return 0;
> +
> +       bcm_kona_smc(SSAPI_ENABLE_L2_CACHE, 0, 0, 0, 0);
> +
> +       /*
> +        * The aux_val and aux_mask have no effect since L2 cache is already
> +        * enabled.  Pass 0s for aux_val and 1s for aux_mask for default value.
> +        */
> +       l2x0_of_init(0, ~0);
> +
> +       return 0;
> +}
> +
>  static void __init board_init(void)
>  {
>         of_platform_populate(NULL, of_default_bus_match_table, NULL,
>                 &platform_bus);
> +
> +       bcm_kona_smc_init();
> +
> +       kona_l2_cache_init();
>  }
>
>  static const char * const bcm11351_dt_compat[] = { "bcm,bcm11351", NULL, };
> --
> 1.7.10.4
>
>

any willing reviewers ?

 Thanks,
   csd
