From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu, 27 Apr 2017 15:34:07 +0200
Subject: [PATCH 1/3] ARM: at91: pm: Add sama5d2 backup mode
In-Reply-To: <20170426160419.22401-1-alexandre.belloni@free-electrons.com>
References: <20170426160419.22401-1-alexandre.belloni@free-electrons.com>
Message-ID: <CAMiSF3AZ9i2ywtTMYxjK8amaLEuez_0H_Jzy_pPS15CAe_FMRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexandre,

This series might also be of interest for the linux-pm mailing list.

2017-04-26 18:04 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> The sama5d2 has a mode were it is possible to cut power to the SoC while
> keeping the RAM in self refresh.
> Resuming from that mode needs support in the firmware/bootloader.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/Makefile          |   4 ++
>  arch/arm/mach-at91/generic.h         |   2 +
>  arch/arm/mach-at91/pm.c              | 103 ++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-at91/pm.h              |   4 ++
>  arch/arm/mach-at91/pm_data-offsets.c |   3 +
>  arch/arm/mach-at91/pm_suspend.S      |  86 ++++++++++++++++++++++-------
>  arch/arm/mach-at91/sama5.c           |  19 ++++++-
>  7 files changed, 198 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index cfd8f60a9268..87fe17dbdb56 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -14,6 +14,10 @@ obj-$(CONFIG_PM)             += pm_suspend.o
>  ifeq ($(CONFIG_CPU_V7),y)
>  AFLAGS_pm_suspend.o := -march=armv7-a
>  endif
> +# Backup mode will not compile for ARMv5 because of movt
> +ifeq ($(CONFIG_SOC_SAMA5D2),y)
> +AFLAGS_pm_suspend.o += -DBACKUP_MODE
> +endif
>  ifeq ($(CONFIG_PM_DEBUG),y)
>  CFLAGS_pm.o += -DDEBUG
>  endif

We can rewrite the assembly to avoid using movt, and remove some ifdefs
from the code.


> diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
> index f1ead0f13c19..e2bd17237964 100644
> --- a/arch/arm/mach-at91/generic.h
> +++ b/arch/arm/mach-at91/generic.h
> @@ -15,10 +15,12 @@
>  extern void __init at91rm9200_pm_init(void);
>  extern void __init at91sam9_pm_init(void);
>  extern void __init sama5_pm_init(void);
> +extern void __init sama5d2_pm_init(void);
>  #else
>  static inline void __init at91rm9200_pm_init(void) { }
>  static inline void __init at91sam9_pm_init(void) { }
>  static inline void __init sama5_pm_init(void) { }
> +static inline void __init sama5d2_pm_init(void) { }
>  #endif
>
>  #endif /* _AT91_GENERIC_H */
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 2cd27c830ab6..1e03f1277f14 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -22,6 +22,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/fncpy.h>
>  #include <asm/system_misc.h>
> +#include <asm/suspend.h>
>
>  #include "generic.h"
>  #include "pm.h"
> @@ -58,6 +59,14 @@ static int at91_pm_valid_state(suspend_state_t state)
>         }
>  }
>
> +static int canary = 0xA5A5A5A5;
> +
> +static struct at91_pm_bu {
> +       int suspended;
> +       unsigned long reserved;
> +       phys_addr_t canary;
> +       phys_addr_t resume;
> +} *pm_bu;
>
>  static suspend_state_t target_state;
>
> @@ -123,15 +132,39 @@ static void (*at91_suspend_sram_fn)(struct at91_pm_data *);
>  extern void at91_pm_suspend_in_sram(struct at91_pm_data *pm_data);
>  extern u32 at91_pm_suspend_in_sram_sz;
>
> -static void at91_pm_suspend(suspend_state_t state)
> +static int at91_suspend_finish(unsigned long val)
>  {
> -       pm_data.mode = (state == PM_SUSPEND_MEM) ? AT91_PM_SLOW_CLOCK : 0;
> -
>         flush_cache_all();
>         outer_disable();
>
>         at91_suspend_sram_fn(&pm_data);
>
> +       return 0;
> +}
> +
> +static void at91_pm_suspend(suspend_state_t state)
> +{
> +       if (pm_data.deepest_state == AT91_PM_BACKUP)
> +               if (state == PM_SUSPEND_MEM)
> +                       pm_data.mode = AT91_PM_BACKUP;
> +               else
> +                       pm_data.mode = AT91_PM_SLOW_CLOCK;
> +       else
> +               pm_data.mode = (state == PM_SUSPEND_MEM) ? AT91_PM_SLOW_CLOCK : 0;
> +
> +       if (pm_data.mode == AT91_PM_BACKUP) {
> +               pm_bu->suspended = 1;
> +
> +               cpu_suspend(0, at91_suspend_finish);
> +
> +               /* The SRAM is lost between suspend cycles */
> +               at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
> +                                            &at91_pm_suspend_in_sram,
> +                                            at91_pm_suspend_in_sram_sz);
> +       } else {
> +               at91_suspend_finish(0);
> +       }
> +
>         outer_resume();
>  }
>
> @@ -375,6 +408,25 @@ static __init void at91_dt_ramc(void)
>         at91_cpuidle_device.dev.platform_data = standby;
>  }
>
> +static __init void at91_dt_shdwc(void)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-shdwc");
> +       if (!np)
> +               return;
> +
> +       pm_data.shdwc = of_iomap(np, 0);
> +       of_node_put(np);
> +
> +       np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-sfrbu");
> +       if (!np)
> +               return;
> +
> +       pm_data.sfrbu = of_iomap(np, 0);
> +       of_node_put(np);
> +}
> +
>  static void at91rm9200_idle(void)
>  {
>         /*
> @@ -436,6 +488,44 @@ static void __init at91_pm_sram_init(void)
>                         &at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
>  }
>
> +static void __init at91_pm_bu_sram_init(void)
> +{
> +       struct gen_pool *sram_pool;
> +       struct device_node *node;
> +       struct platform_device *pdev = NULL;
> +
> +       pm_bu = NULL;
> +
> +       for_each_compatible_node(node, NULL, "atmel,sama5d2-securam") {
> +               pdev = of_find_device_by_node(node);
> +               if (pdev) {
> +                       of_node_put(node);
> +                       break;
> +               }
> +       }
> +

Do we really need to iterate over compatible nodes ?

> +       if (!pdev) {
> +               pr_warn("%s: failed to find securam device!\n", __func__);
> +               return;
> +       }
> +
> +       sram_pool = gen_pool_get(&pdev->dev, NULL);
> +       if (!sram_pool) {
> +               pr_warn("%s: securam pool unavailable!\n", __func__);
> +               return;
> +       }
> +
> +       pm_bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
> +       if (!pm_bu) {
> +               pr_warn("%s: unable to alloc securam!\n", __func__);
> +               return;
> +       }
> +
> +       pm_bu->suspended = 0;
> +       pm_bu->canary = virt_to_phys(&canary);
> +       pm_bu->resume = virt_to_phys(cpu_resume);
> +}
> +

at91_pm_bu_sram_init and at91_dt_shdwc are necessary to use backup mode.
But those functions do not return error codes, and do no cleanup in case
of error.  I believe that it would be simpler if we only had a single
function.

>  struct pmc_info {
>         unsigned long uhp_udp_mask;
>  };
> @@ -510,3 +600,10 @@ void __init sama5_pm_init(void)
>         at91_dt_ramc();
>         at91_pm_init(NULL);
>  }
> +
> +void __init sama5d2_pm_init(void)
> +{
> +       at91_dt_shdwc();
> +       at91_pm_bu_sram_init();
> +       sama5_pm_init();
> +}
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> index fc0f7d048187..d9c6612ef62f 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -22,6 +22,7 @@
>  #define AT91_MEMCTRL_DDRSDR    2
>
>  #define        AT91_PM_SLOW_CLOCK      0x01
> +#define        AT91_PM_BACKUP          0x02
>
>  #ifndef __ASSEMBLY__
>  struct at91_pm_data {
> @@ -30,6 +31,9 @@ struct at91_pm_data {
>         unsigned long uhp_udp_mask;
>         unsigned int memctrl;
>         unsigned int mode;
> +       void __iomem *shdwc;
> +       void __iomem *sfrbu;
> +       unsigned int deepest_state;
>  };
>  #endif
>
> diff --git a/arch/arm/mach-at91/pm_data-offsets.c b/arch/arm/mach-at91/pm_data-offsets.c
> index 30302cb16df0..c0a73e62b725 100644
> --- a/arch/arm/mach-at91/pm_data-offsets.c
> +++ b/arch/arm/mach-at91/pm_data-offsets.c
> @@ -9,5 +9,8 @@ int main(void)
>         DEFINE(PM_DATA_RAMC1,           offsetof(struct at91_pm_data, ramc[1]));
>         DEFINE(PM_DATA_MEMCTRL, offsetof(struct at91_pm_data, memctrl));
>         DEFINE(PM_DATA_MODE,            offsetof(struct at91_pm_data, mode));
> +       DEFINE(PM_DATA_SHDWC,           offsetof(struct at91_pm_data, shdwc));
> +       DEFINE(PM_DATA_SFRBU,           offsetof(struct at91_pm_data, sfrbu));
> +
>         return 0;
>  }
> diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> index 96781daa671a..b5ffa8e1f203 100644
> --- a/arch/arm/mach-at91/pm_suspend.S
> +++ b/arch/arm/mach-at91/pm_suspend.S
> @@ -97,15 +97,74 @@ ENTRY(at91_pm_suspend_in_sram)
>         str     tmp1, .memtype
>         ldr     tmp1, [r0, #PM_DATA_MODE]
>         str     tmp1, .pm_mode
> +       ldr     tmp1, [r0, #PM_DATA_SHDWC]
> +#if defined(BACKUP_MODE)
> +       str     tmp1, .shdwc
> +       cmp     tmp1, #0
> +       ldrne   tmp2, [tmp1, #0]
> +       ldr     tmp1, [r0, #PM_DATA_SFRBU]
> +       str     tmp1, .sfr
> +       cmp     tmp1, #0
> +       ldrne   tmp2, [tmp1, #0x10]
> +#endif

If I understand this well, we are doing this to fill the TLB in advance
before the external RAM is put in self-refresh. It might be worthy of a
comment. Moreover, .pm_mode and .memtype do not need to be protected as
they are accessed during the at91_sramc_self_refresh, but .pmc_base
may need to be loaded in the TLB as well.

>
>         /* Active the self-refresh mode */
>         mov     r0, #SRAMC_SELF_FRESH_ACTIVE
>         bl      at91_sramc_self_refresh
>
>         ldr     r0, .pm_mode
> -       tst     r0, #AT91_PM_SLOW_CLOCK
> -       beq     skip_disable_main_clock
> +       cmp     r0, #AT91_PM_SLOW_CLOCK
> +       beq     slow_clock
> +#if defined(BACKUP_MODE)
> +       cmp     r0, #AT91_PM_BACKUP
> +       beq     backup_mode
> +#endif
>
> +       /* Wait for interrupt */
> +       ldr     pmc, .pmc_base
> +       at91_cpu_idle
> +       b       exit_suspend
> +
> +slow_clock:
> +       bl      at91_slowck_mode
> +       b       exit_suspend
> +#if defined(BACKUP_MODE)
> +backup_mode:
> +       bl      at91_backup_mode
> +       b       exit_suspend
> +#endif
> +
> +exit_suspend:
> +       /* Exit the self-refresh mode */
> +       mov     r0, #SRAMC_SELF_FRESH_EXIT
> +       bl      at91_sramc_self_refresh
> +
> +       /* Restore registers, and return */
> +       ldmfd   sp!, {r4 - r12, pc}
> +ENDPROC(at91_pm_suspend_in_sram)
> +
> +#if defined(BACKUP_MODE)
> +ENTRY(at91_backup_mode)
> +       #if 0
> +       /* Read LPR */
> +       ldr     r2, .sramc_base
> +       ldr     r3, [r2, #AT91_DDRSDRC_LPR]
> +       #endif
> +

Do we need to keep this commented code ?

> +       /*BUMEN*/
> +       ldr     r0, .sfr
> +       mov     tmp1, #(0x1)

We don't need any parenthesis here

> +       str     tmp1, [r0, #0x10]
> +
> +       /* Shutdown */
> +       ldr     r0, .shdwc
> +       movw    tmp1, #0x1
> +       movt    tmp1, #0xA500

I believe the following assembly should do the same thing
without using v6+ instructions.

    mov    tmp1, #0xA5000000
    add    tmp1, tmp1, #0x1

> +       str     tmp1, [r0, #0]
> +ENDPROC(at91_backup_mode)
> +#endif
> +
> +ENTRY(at91_slowck_mode)
>         ldr     pmc, .pmc_base
>
>         /* Save Master clock setting */
> @@ -134,18 +193,9 @@ ENTRY(at91_pm_suspend_in_sram)
>         orr     tmp1, tmp1, #AT91_PMC_KEY
>         str     tmp1, [pmc, #AT91_CKGR_MOR]
>
> -skip_disable_main_clock:
> -       ldr     pmc, .pmc_base
> -
>         /* Wait for interrupt */
>         at91_cpu_idle
>
> -       ldr     r0, .pm_mode
> -       tst     r0, #AT91_PM_SLOW_CLOCK
> -       beq     skip_enable_main_clock
> -
> -       ldr     pmc, .pmc_base
> -
>         /* Turn on the main oscillator */
>         ldr     tmp1, [pmc, #AT91_CKGR_MOR]
>         orr     tmp1, tmp1, #AT91_PMC_MOSCEN
> @@ -174,14 +224,8 @@ skip_disable_main_clock:
>
>         wait_mckrdy
>
> -skip_enable_main_clock:
> -       /* Exit the self-refresh mode */
> -       mov     r0, #SRAMC_SELF_FRESH_EXIT
> -       bl      at91_sramc_self_refresh
> -
> -       /* Restore registers, and return */
> -       ldmfd   sp!, {r4 - r12, pc}
> -ENDPROC(at91_pm_suspend_in_sram)
> +       mov     pc, lr
> +ENDPROC(at91_slowck_mode)
>
>  /*
>   * void at91_sramc_self_refresh(unsigned int is_active)
> @@ -314,6 +358,10 @@ ENDPROC(at91_sramc_self_refresh)
>         .word 0
>  .sramc1_base:
>         .word 0
> +.shdwc:
> +       .word 0
> +.sfr:
> +       .word 0
>  .memtype:
>         .word 0
>  .pm_mode:
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index 6d157d0ead8e..3d0bf95a56ae 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -34,7 +34,6 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5")
>  MACHINE_END
>
>  static const char *const sama5_alt_dt_board_compat[] __initconst = {
> -       "atmel,sama5d2",
>         "atmel,sama5d4",
>         NULL
>  };
> @@ -45,3 +44,21 @@ DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
>         .dt_compat      = sama5_alt_dt_board_compat,
>         .l2c_aux_mask   = ~0UL,
>  MACHINE_END
> +
> +static void __init sama5d2_init(void)
> +{
> +       of_platform_default_populate(NULL, NULL, NULL);
> +       sama5d2_pm_init();
> +}
> +
> +static const char *const sama5d2_compat[] __initconst = {
> +       "atmel,sama5d2",
> +       NULL
> +};
> +
> +DT_MACHINE_START(sama5d2, "Atmel SAMA5")
> +       /* Maintainer: Atmel */
> +       .init_machine   = sama5d2_init,
> +       .dt_compat      = sama5d2_compat,
> +       .l2c_aux_mask   = ~0UL,
> +MACHINE_END

Best regards,
-- 
Romain Izard
