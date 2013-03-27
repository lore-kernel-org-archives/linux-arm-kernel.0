From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Wed, 27 Mar 2013 09:35:59 +0100
Subject: [PATCH] ARM: ux500: move PM-related PRCMU functions to machine
In-Reply-To: <1364312860-8179-1-git-send-email-linus.walleij@stericsson.com>
References: <1364312860-8179-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5152AF6F.40800@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 04:47 PM, Linus WALLEIJ wrote:
> From: Linus Walleij<linus.walleij@linaro.org>
>
> We are trying to decompose and decentralize the code in
> the DB8500 PRCMU out into subdrivers. The code moved in
> this patch concerns a group of functions used for
> decoupling and recoupling the IRQs from the GIC. During
> sleep and idle the Ux500 system will transfer all IRQ
> handling to the PRCMU using these functions.
>
> Basically we are left with the two alternatives of code
> placement as:
>
> - arch/arm/mach-ux500/pm.c - this because the code is
>    closely related to the GIC, and takes ownership of
>    some of the registers from the PRCMU related to this
>    PM functionality.
>
> - drivers/mfd/db8500-prcmu-pm.c - because the code is
>    affecting stuff in the PRCMU register range. But then
>    this code needs to remap and handle GIC registers.
>
> This patch implementation is taking the first approach.
>
> Currently the cpuidle driver is the only piece of code
> using this set of functions, but it will later also be
> used by the suspend/resume code which is currently under
> review.
>
> The header file is moved to:
> <linux/platform_data/arm-ux500-pm.h>
> The function prototypes need to be placed in a globally
> visible header since the CPUidle code is planned to move
> out to drivers/cpuidle.
>
> Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
> Cc: Rickard Andersson<rickard.andersson@stericsson.com>
> Cc: Samuel Ortiz<sameo@linux.intel.com>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
> As things got silent in the last discussion thread I'm
> posting one solution to this dilemma. If you have better
> ideas, tell me.
>
> Sam, I'm requesting an ACK for taking this through the
> ARM SoC tree.
> ---
>   arch/arm/mach-ux500/Makefile               |   2 +-
>   arch/arm/mach-ux500/cpu.c                  |   4 +
>   arch/arm/mach-ux500/cpuidle.c              |   3 +-
>   arch/arm/mach-ux500/pm.c                   | 167 +++++++++++++++++++++++++++++
>   drivers/mfd/db8500-prcmu.c                 | 114 --------------------
>   include/linux/mfd/db8500-prcmu.h           |   6 --
>   include/linux/mfd/dbx500-prcmu.h           |  30 ------
>   include/linux/platform_data/arm-ux500-pm.h |  21 ++++
>   8 files changed, 195 insertions(+), 152 deletions(-)
>   create mode 100644 arch/arm/mach-ux500/pm.c
>   create mode 100644 include/linux/platform_data/arm-ux500-pm.h
>
> diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
> index f24710d..580a4db 100644
> --- a/arch/arm/mach-ux500/Makefile
> +++ b/arch/arm/mach-ux500/Makefile
> @@ -3,7 +3,7 @@
>   #
>
>   obj-y                          := cpu.o devices.o devices-common.o \
> -                                  id.o usb.o timer.o
> +                                  id.o usb.o timer.o pm.o
>   obj-$(CONFIG_CPU_IDLE)          += cpuidle.o
>   obj-$(CONFIG_CACHE_L2X0)       += cache-l2x0.o
>   obj-$(CONFIG_UX500_SOC_DB8500) += cpu-db8500.o devices-db8500.o
> diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
> index 38459e9..ee69439d 100644
> --- a/arch/arm/mach-ux500/cpu.c
> +++ b/arch/arm/mach-ux500/cpu.c
> @@ -20,6 +20,7 @@
>   #include<linux/irqchip.h>
>   #include<linux/irqchip/arm-gic.h>
>   #include<linux/platform_data/clk-ux500.h>
> +#include<linux/platform_data/arm-ux500-pm.h>
>
>   #include<asm/mach/map.h>
>
> @@ -68,16 +69,19 @@ void __init ux500_init_irq(void)
>           */
>          if (cpu_is_u8500_family()) {
>                  prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
> +               ux500_pm_init(U8500_PRCMU_BASE, SZ_8K - 1);
>                  u8500_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
>                                 U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
>                                 U8500_CLKRST6_BASE);
>          } else if (cpu_is_u9540()) {
>                  prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
> +               ux500_pm_init(U8500_PRCMU_BASE, SZ_8K - 1);
>                  u8500_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
>                                 U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
>                                 U8500_CLKRST6_BASE);
>          } else if (cpu_is_u8540()) {
>                  prcmu_early_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
> +               ux500_pm_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
>                  u8540_clk_init();
>          }
>   }
> diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
> index ce91493..1e5bb66 100644
> --- a/arch/arm/mach-ux500/cpuidle.c
> +++ b/arch/arm/mach-ux500/cpuidle.c
> @@ -16,6 +16,7 @@
>   #include<linux/atomic.h>
>   #include<linux/smp.h>
>   #include<linux/mfd/dbx500-prcmu.h>
> +#include<linux/platform_data/arm-ux500-pm.h>
>
>   #include<asm/cpuidle.h>
>   #include<asm/proc-fns.h>
> @@ -130,7 +131,7 @@ int __init ux500_idle_init(void)
>          int ret, cpu;
>          struct cpuidle_device *device;
>
> -        /* Configure wake up reasons */
> +       /* Configure wake up reasons */
>          prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
>                               PRCMU_WAKEUP(ABB));
>
> diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
> new file mode 100644
> index 0000000..6949a13
> --- /dev/null
> +++ b/arch/arm/mach-ux500/pm.c
> @@ -0,0 +1,167 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010-2013
> + * Author: Rickard Andersson<rickard.andersson@stericsson.com>  for
> + *         ST-Ericsson.
> + * Author: Daniel Lezcano<daniel.lezcano@linaro.org>  for Linaro.
> + * License terms: GNU General Public License (GPL) version 2
> + *
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/irqchip/arm-gic.h>
> +#include<linux/delay.h>
> +#include<linux/io.h>
> +#include<linux/platform_data/arm-ux500-pm.h>
> +
> +#include<mach/hardware.h>
> +
> +/* ARM WFI Standby signal register */
> +#define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
> +#define PRCM_ARM_WFI_STANDBY_WFI0              0x08
> +#define PRCM_ARM_WFI_STANDBY_WFI1              0x10
> +#define PRCM_IOCR              (prcmu_base + 0x310)
> +#define PRCM_IOCR_IOFORCE                      0x1
> +
> +/* Dual A9 core interrupt management unit registers */
> +#define PRCM_A9_MASK_REQ       (prcmu_base + 0x328)
> +#define PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ      0x1
> +
> +#define PRCM_A9_MASK_ACK       (prcmu_base + 0x32c)
> +#define PRCM_ARMITMSK31TO0     (prcmu_base + 0x11c)
> +#define PRCM_ARMITMSK63TO32    (prcmu_base + 0x120)
> +#define PRCM_ARMITMSK95TO64    (prcmu_base + 0x124)
> +#define PRCM_ARMITMSK127TO96   (prcmu_base + 0x128)
> +#define PRCM_POWER_STATE_VAL   (prcmu_base + 0x25C)
> +#define PRCM_ARMITVAL31TO0     (prcmu_base + 0x260)
> +#define PRCM_ARMITVAL63TO32    (prcmu_base + 0x264)
> +#define PRCM_ARMITVAL95TO64    (prcmu_base + 0x268)
> +#define PRCM_ARMITVAL127TO96   (prcmu_base + 0x26C)
> +
> +static void __iomem *prcmu_base;
> +
> +/* This function decouple the gic from the prcmu */
> +int prcmu_gic_decouple(void)
> +{
> +       u32 val = readl(PRCM_A9_MASK_REQ);
> +
> +       /* Set bit 0 register value to 1 */
> +       writel(val | PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ,
> +              PRCM_A9_MASK_REQ);
> +
> +       /* Make sure the register is updated */
> +       readl(PRCM_A9_MASK_REQ);
> +
> +       /* Wait a few cycles for the gic mask completion */
> +       udelay(1);
> +
> +       return 0;
> +}
> +
> +/* This function recouple the gic with the prcmu */
> +int prcmu_gic_recouple(void)
> +{
> +       u32 val = readl(PRCM_A9_MASK_REQ);
> +
> +       /* Set bit 0 register value to 0 */
> +       writel(val&  ~PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ, PRCM_A9_MASK_REQ);
> +
> +       return 0;
> +}
> +
> +#define PRCMU_GIC_NUMBER_REGS 5
> +
> +/*
> + * This function checks if there are pending irq on the gic. It only
> + * makes sense if the gic has been decoupled before with the
> + * db8500_prcmu_gic_decouple function. Disabling an interrupt only
> + * disables the forwarding of the interrupt to any CPU interface. It
> + * does not prevent the interrupt from changing state, for example
> + * becoming pending, or active and pending if it is already
> + * active. Hence, we have to check the interrupt is pending *and* is
> + * active.
> + */
> +bool prcmu_gic_pending_irq(void)
> +{
> +       u32 pr; /* Pending register */
> +       u32 er; /* Enable register */
> +       void __iomem *dist_base = __io_address(U8500_GIC_DIST_BASE);
> +       int i;
> +
> +       /* 5 registers. STI&  PPI not skipped */
> +       for (i = 0; i<  PRCMU_GIC_NUMBER_REGS; i++) {
> +
> +               pr = readl_relaxed(dist_base + GIC_DIST_PENDING_SET + i * 4);
> +               er = readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
> +
> +               if (pr&  er)
> +                       return true; /* There is a pending interrupt */
> +       }
> +
> +       return false;
> +}
> +
> +/*
> + * This function checks if there are pending interrupt on the
> + * prcmu which has been delegated to monitor the irqs with the
> + * db8500_prcmu_copy_gic_settings function.
> + */
> +bool prcmu_pending_irq(void)
> +{
> +       u32 it, im;
> +       int i;
> +
> +       for (i = 0; i<  PRCMU_GIC_NUMBER_REGS - 1; i++) {
> +               it = readl(PRCM_ARMITVAL31TO0 + i * 4);
> +               im = readl(PRCM_ARMITMSK31TO0 + i * 4);
> +               if (it&  im)
> +                       return true; /* There is a pending interrupt */
> +       }
> +
> +       return false;
> +}
> +
> +/*
> + * This function checks if the specified cpu is in in WFI. It's usage
> + * makes sense only if the gic is decoupled with the db8500_prcmu_gic_decouple
> + * function. Of course passing smp_processor_id() to this function will
> + * always return false...
> + */
> +bool prcmu_is_cpu_in_wfi(int cpu)
> +{
> +       return readl(PRCM_ARM_WFI_STANDBY)&  cpu ? PRCM_ARM_WFI_STANDBY_WFI1 :
> +                    PRCM_ARM_WFI_STANDBY_WFI0;
> +}
> +
> +/*
> + * This function copies the gic SPI settings to the prcmu in order to
> + * monitor them and abort/finish the retention/off sequence or state.
> + */
> +int prcmu_copy_gic_settings(void)
> +{
> +       u32 er; /* Enable register */
> +       void __iomem *dist_base = __io_address(U8500_GIC_DIST_BASE);
> +       int i;
> +
> +       /* We skip the STI and PPI */
> +       for (i = 0; i<  PRCMU_GIC_NUMBER_REGS - 1; i++) {
> +               er = readl_relaxed(dist_base +
> +                                  GIC_DIST_ENABLE_SET + (i + 1) * 4);
> +               writel(er, PRCM_ARMITMSK31TO0 + i * 4);
> +       }
> +
> +       return 0;
> +}
> +
> +void __init ux500_pm_init(u32 phy_base, u32 size)
> +{
> +       prcmu_base = ioremap(phy_base, size);
> +       if (!prcmu_base) {
> +               pr_err("could not remap PRCMU for PM functions\n");
> +               return;
> +       }
> +       /*
> +        * On watchdog reboot the GIC is in some cases decoupled.
> +        * This will make sure that the GIC is correctly configured.
> +        */
> +       prcmu_gic_recouple();
> +}
> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index acb8ef7..2d3a5f6 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -26,7 +26,6 @@
>   #include<linux/fs.h>
>   #include<linux/platform_device.h>
>   #include<linux/uaccess.h>
> -#include<linux/irqchip/arm-gic.h>
>   #include<linux/mfd/core.h>
>   #include<linux/mfd/dbx500-prcmu.h>
>   #include<linux/mfd/abx500/ab8500.h>
> @@ -794,119 +793,6 @@ u8 db8500_prcmu_get_power_state_result(void)
>          return readb(tcdm_base + PRCM_ACK_MB0_AP_PWRSTTR_STATUS);
>   }
>
> -/* This function decouple the gic from the prcmu */
> -int db8500_prcmu_gic_decouple(void)
> -{
> -       u32 val = readl(PRCM_A9_MASK_REQ);
> -
> -       /* Set bit 0 register value to 1 */
> -       writel(val | PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ,
> -              PRCM_A9_MASK_REQ);
> -
> -       /* Make sure the register is updated */
> -       readl(PRCM_A9_MASK_REQ);
> -
> -       /* Wait a few cycles for the gic mask completion */
> -       udelay(1);
> -
> -       return 0;
> -}
> -
> -/* This function recouple the gic with the prcmu */
> -int db8500_prcmu_gic_recouple(void)
> -{
> -       u32 val = readl(PRCM_A9_MASK_REQ);
> -
> -       /* Set bit 0 register value to 0 */
> -       writel(val&  ~PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ, PRCM_A9_MASK_REQ);
> -
> -       return 0;
> -}
> -
> -#define PRCMU_GIC_NUMBER_REGS 5
> -
> -/*
> - * This function checks if there are pending irq on the gic. It only
> - * makes sense if the gic has been decoupled before with the
> - * db8500_prcmu_gic_decouple function. Disabling an interrupt only
> - * disables the forwarding of the interrupt to any CPU interface. It
> - * does not prevent the interrupt from changing state, for example
> - * becoming pending, or active and pending if it is already
> - * active. Hence, we have to check the interrupt is pending *and* is
> - * active.
> - */
> -bool db8500_prcmu_gic_pending_irq(void)
> -{
> -       u32 pr; /* Pending register */
> -       u32 er; /* Enable register */
> -       void __iomem *dist_base = __io_address(U8500_GIC_DIST_BASE);
> -       int i;
> -
> -        /* 5 registers. STI&  PPI not skipped */
> -       for (i = 0; i<  PRCMU_GIC_NUMBER_REGS; i++) {
> -
> -               pr = readl_relaxed(dist_base + GIC_DIST_PENDING_SET + i * 4);
> -               er = readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
> -
> -               if (pr&  er)
> -                       return true; /* There is a pending interrupt */
> -       }
> -
> -       return false;
> -}
> -
> -/*
> - * This function checks if there are pending interrupt on the
> - * prcmu which has been delegated to monitor the irqs with the
> - * db8500_prcmu_copy_gic_settings function.
> - */
> -bool db8500_prcmu_pending_irq(void)
> -{
> -       u32 it, im;
> -       int i;
> -
> -       for (i = 0; i<  PRCMU_GIC_NUMBER_REGS - 1; i++) {
> -               it = readl(PRCM_ARMITVAL31TO0 + i * 4);
> -               im = readl(PRCM_ARMITMSK31TO0 + i * 4);
> -               if (it&  im)
> -                       return true; /* There is a pending interrupt */
> -       }
> -
> -       return false;
> -}
> -
> -/*
> - * This function checks if the specified cpu is in in WFI. It's usage
> - * makes sense only if the gic is decoupled with the db8500_prcmu_gic_decouple
> - * function. Of course passing smp_processor_id() to this function will
> - * always return false...
> - */
> -bool db8500_prcmu_is_cpu_in_wfi(int cpu)
> -{
> -       return readl(PRCM_ARM_WFI_STANDBY)&  cpu ? PRCM_ARM_WFI_STANDBY_WFI1 :
> -                    PRCM_ARM_WFI_STANDBY_WFI0;
> -}
> -
> -/*
> - * This function copies the gic SPI settings to the prcmu in order to
> - * monitor them and abort/finish the retention/off sequence or state.
> - */
> -int db8500_prcmu_copy_gic_settings(void)
> -{
> -       u32 er; /* Enable register */
> -       void __iomem *dist_base = __io_address(U8500_GIC_DIST_BASE);
> -       int i;
> -
> -        /* We skip the STI and PPI */
> -       for (i = 0; i<  PRCMU_GIC_NUMBER_REGS - 1; i++) {
> -               er = readl_relaxed(dist_base +
> -                                  GIC_DIST_ENABLE_SET + (i + 1) * 4);
> -               writel(er, PRCM_ARMITMSK31TO0 + i * 4);
> -       }
> -
> -       return 0;
> -}
> -
>   /* This function should only be called while mb0_transfer.lock is held. */
>   static void config_wakeups(void)
>   {
> diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
> index ac943df..0bd6944 100644
> --- a/include/linux/mfd/db8500-prcmu.h
> +++ b/include/linux/mfd/db8500-prcmu.h
> @@ -522,12 +522,6 @@ int db8500_prcmu_load_a9wdog(u8 id, u32 val);
>   void db8500_prcmu_system_reset(u16 reset_code);
>   int db8500_prcmu_set_power_state(u8 state, bool keep_ulp_clk, bool keep_ap_pll);
>   u8 db8500_prcmu_get_power_state_result(void);
> -int db8500_prcmu_gic_decouple(void);
> -int db8500_prcmu_gic_recouple(void);
> -int db8500_prcmu_copy_gic_settings(void);
> -bool db8500_prcmu_gic_pending_irq(void);
> -bool db8500_prcmu_pending_irq(void);
> -bool db8500_prcmu_is_cpu_in_wfi(int cpu);
>   void db8500_prcmu_enable_wakeups(u32 wakeups);
>   int db8500_prcmu_set_epod(u16 epod_id, u8 epod_state);
>   int db8500_prcmu_request_clock(u8 clock, bool enable);
> diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
> index 8c546cb..fc43cec 100644
> --- a/include/linux/mfd/dbx500-prcmu.h
> +++ b/include/linux/mfd/dbx500-prcmu.h
> @@ -293,36 +293,6 @@ static inline u8 prcmu_get_power_state_result(void)
>          return db8500_prcmu_get_power_state_result();
>   }
>
> -static inline int prcmu_gic_decouple(void)
> -{
> -       return db8500_prcmu_gic_decouple();
> -}
> -
> -static inline int prcmu_gic_recouple(void)
> -{
> -       return db8500_prcmu_gic_recouple();
> -}
> -
> -static inline bool prcmu_gic_pending_irq(void)
> -{
> -       return db8500_prcmu_gic_pending_irq();
> -}
> -
> -static inline bool prcmu_is_cpu_in_wfi(int cpu)
> -{
> -       return db8500_prcmu_is_cpu_in_wfi(cpu);
> -}
> -
> -static inline int prcmu_copy_gic_settings(void)
> -{
> -       return db8500_prcmu_copy_gic_settings();
> -}
> -
> -static inline bool prcmu_pending_irq(void)
> -{
> -       return db8500_prcmu_pending_irq();
> -}
> -
>   static inline int prcmu_set_epod(u16 epod_id, u8 epod_state)
>   {
>          return db8500_prcmu_set_epod(epod_id, epod_state);
> diff --git a/include/linux/platform_data/arm-ux500-pm.h b/include/linux/platform_data/arm-ux500-pm.h
> new file mode 100644
> index 0000000..8dff64b
> --- /dev/null
> +++ b/include/linux/platform_data/arm-ux500-pm.h
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010-2013
> + * Author: Rickard Andersson<rickard.andersson@stericsson.com>  for
> + *         ST-Ericsson.
> + * Author: Daniel Lezcano<daniel.lezcano@linaro.org>  for Linaro.
> + * License terms: GNU General Public License (GPL) version 2
> + *
> + */
> +
> +#ifndef ARM_UX500_PM_H
> +#define ARM_UX500_PM_H
> +
> +int prcmu_gic_decouple(void);
> +int prcmu_gic_recouple(void);
> +bool prcmu_gic_pending_irq(void);
> +bool prcmu_pending_irq(void);
> +bool prcmu_is_cpu_in_wfi(int cpu);
> +int prcmu_copy_gic_settings(void);
> +void ux500_pm_init(u32 phy_base, u32 size);
> +
> +#endif /* ARM_UX500_PM_H */
> --
> 1.7.11.3
>

Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
