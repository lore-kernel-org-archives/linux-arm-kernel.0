From: jiada_wang@mentor.com (jiada)
Date: Sun, 20 Oct 2013 20:32:59 -0700
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <857E9EDCA6C0904DB3357321AA9123EB62506837@NA-MBX-01.mgc.mentorg.com>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <857E9EDCA6C0904DB3357321AA9123EB62506837@NA-MBX-01.mgc.mentorg.com>
Message-ID: <5264A06B.2040202@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn


> The imx6q_restart() works fine with normal reboot but will run into problem with emergency reboot like sysrq-b.  In that case, of_iomap() gets called from interrupt context and hence triggers the BUG_ON in __get_vm_area_node().
>
> Actually, since commit c1e31d1 (ARM: imx: create
> mxc_arch_reset_init_dt() for DT boot), imx6q/dl should try to use
> mxc_restart() by calling mxc_arch_reset_init_dt() beforehand, where things like of_iomap() can be done.
>
> The patch updates mxc_restart() a little bit to get it work for imx6q/dl and kill imx6q_restart() completely.
>
> Reported-by: Nathan Lynch <nathan_lynch@mentor.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>   arch/arm/mach-imx/common.h     |    4 ++++
>   arch/arm/mach-imx/mach-imx6q.c |   35 +++--------------------------------
>   arch/arm/mach-imx/system.c     |    5 +++++
>   3 files changed, 12 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h index 7230cf8..9ebca9e 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -130,7 +130,11 @@ static inline void imx_smp_prepare(void) {}  static inline void imx_scu_standby_enable(void) {}  #endif  extern void imx_src_init(void);
> +#ifdef CONFIG_HAVE_IMX_SRC
>   extern void imx_src_prepare_restart(void);
> +#else
> +extern inline void imx_src_prepare_restart(void) {} #endif
>   extern void imx_gpc_init(void);
>   extern void imx_gpc_pre_suspend(void);
>   extern void imx_gpc_post_resume(void);
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c index 398858b..53e70f4 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -15,7 +15,6 @@
>   #include <linux/clkdev.h>
>   #include <linux/clocksource.h>
>   #include <linux/cpu.h>
> -#include <linux/delay.h>
>   #include <linux/export.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
> @@ -40,36 +39,6 @@
>   #include "cpuidle.h"
>   #include "hardware.h"
>
> -static void imx6q_restart(enum reboot_mode mode, const char *cmd) -{
> -	struct device_node *np;
> -	void __iomem *wdog_base;
> -
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
> -	wdog_base = of_iomap(np, 0);
> -	if (!wdog_base)
> -		goto soft;
> -
> -	imx_src_prepare_restart();
> -
> -	/* enable wdog */
> -	writew_relaxed(1 << 2, wdog_base);
> -	/* write twice to ensure the request will not get ignored */
> -	writew_relaxed(1 << 2, wdog_base);
> -
> -	/* wait for reset to assert ... */
> -	mdelay(500);
> -
> -	pr_err("Watchdog reset failed to assert reset\n");
> -
> -	/* delay to allow the serial port to show the message */
> -	mdelay(50);
> -
> -soft:
> -	/* we'll take a jump through zero as a poor second */
> -	soft_restart(0);
> -}
> -
>   /* For imx6q sabrelite board: set KSZ9021RN RGMII pad skew */  static int ksz9021rn_phy_fixup(struct phy_device *phydev)  { @@ -166,6 +135,8 @@ static void __init imx6q_init_machine(void)  {
>   	struct device *parent;
>
> +	mxc_arch_reset_init_dt();
> +
>   	parent = imx_soc_device_init();
>   	if (parent == NULL)
>   		pr_warn("failed to initialize soc device\n"); @@ -293,5 +264,5 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
>   	.init_machine	= imx6q_init_machine,
>   	.init_late      = imx6q_init_late,
>   	.dt_compat	= imx6q_dt_compat,
> -	.restart	= imx6q_restart,
> +	.restart	= mxc_restart,
>   MACHINE_END
> diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c index 80c177c..e6edcd3 100644
> --- a/arch/arm/mach-imx/system.c
> +++ b/arch/arm/mach-imx/system.c
> @@ -42,6 +42,9 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)  {
>   	unsigned int wcr_enable;
>
> +	if (cpu_is_imx6q() || cpu_is_imx6dl())
> +		imx_src_prepare_restart();
> +
>   	if (wdog_clk)
>   		clk_enable(wdog_clk);
>
> @@ -52,6 +55,8 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
>
>   	/* Assert SRS signal */
>   	__raw_writew(wcr_enable, wdog_base);
> +	/* write twice to ensure the request will not get ignored */
> +	__raw_writew(wcr_enable, wdog_base);
>
>   	/* wait for reset to assert... */
>   	mdelay(500);
> --
> 1.7.9.5

By backporting your patch to our 3.5 kernel,
I can confirm the original issue reported by Nathan is fixed
but with your patch, sometimes "echo b > /proc/sysrq-trigger" may cause 
system hang.

The successful case:
root at mx6q:~# echo b > /proc/sysrq-trigger

[   23.038806] SysRq : Resetting
[   23.042081] CPU1: stopping
[   23.044832] Backtrace:
[   23.047361] [<800114d4>] (dump_backtrace+0x0/0x108) from [<80396fcc>] 
(dump_stack+0x18/0x1c)
[   23.055839]  r6:00000000 r5:00000006 r4:00000001 r3:600f0193
[   23.061620] [<80396fb4>] (dump_stack+0x0/0x1c) from [<80012a68>] 
(handle_IPI+0xfc/0x170)
[   23.069759] [<8001296c>] (handle_IPI+0x0/0x170) from [<800084e0>] 
(gic_handle_irq+0x60/0x68)
[   23.078236]  r7:ac0a1fa4 r6:804f8500 r5:f4000100 r4:ac0a1f70
[   23.084022] [<80008480>] (gic_handle_irq+0x0/0x68) from [<8039e000>] 
(__irq_svc+0x40/0x70)
[   23.092330] Exception stack(0xac0a1f70 to 0xac0a1fb8)
[   23.097425] 1f60:                                     00000001 
800f0093 ac0a1fa0 00000000
[   23.105649] 1f80: ac0a0000 803a5c4c 10c0387d 80538444 1000406a 
412fc09a 00000000 ac0a1fc4
[   23.113869] 1fa0: ac0a1fc8 ac0a1fb8 8000e700 8000e704 600f0013 ffffffff
[   23.120523]  r6:ffffffff r5:600f0013 r4:8000e704 r3:8000e700
[   23.126308] [<8000e6d8>] (default_idle+0x0/0x34) from [<8000e92c>] 
(cpu_idle+0xa8/0xf8)
[   23.134366] [<8000e884>] (cpu_idle+0x0/0xf8) from [<80393e14>] 
(secondary_start_kernel+0xf8/0x118)
[   23.143364]  r5:00000001 r4:8050b490
[   23.147028] [<80393d1c>] (secondary_start_kernel+0x0/0x118) from 
[<10393854>] (0x10393854)
[   23.155332]  r5:00000015 r4:3c08c06a
[   23.158988] CPU2: stopping
[   23.161738] Backtrace:
[   23.164257] [<800114d4>] (dump_backtrace+0x0/0x108) from [<80396fcc>] 
(dump_stack+0x18/0x1c)
[   23.172735]  r6:00000000 r5:00000006 r4:00000002 r3:60000193
[   23.178517] [<80396fb4>] (dump_stack+0x0/0x1c) from [<80012a68>] 
(handle_IPI+0xfc/0x170)
[   23.186655] [<8001296c>] (handle_IPI+0x0/0x170) from [<800084e0>] 
(gic_handle_irq+0x60/0x68)
[   23.195132]  r7:ac0a3fa4 r6:804f8500 r5:f4000100 r4:ac0a3f70
[   23.200915] [<80008480>] (gic_handle_irq+0x0/0x68) from [<8039e000>] 
(__irq_svc+0x40/0x70)
[   23.209221] Exception stack(0xac0a3f70 to 0xac0a3fb8)
[   23.214317] 3f60:                                     00000001 
80000093 ac0a3fa0 00000000
[   23.222541] 3f80: ac0a2000 803a5c4c 10c0387d 80538444 1000406a 
412fc09a 00000000 ac0a3fc4
[   23.230763] 3fa0: ac0a3fc8 ac0a3fb8 8000e700 8000e704 60000013 ffffffff
[   23.237417]  r6:ffffffff r5:60000013 r4:8000e704 r3:8000e700
[   23.243199] [<8000e6d8>] (default_idle+0x0/0x34) from [<8000e92c>] 
(cpu_idle+0xa8/0xf8)
[   23.251253] [<8000e884>] (cpu_idle+0x0/0xf8) from [<80393e14>] 
(secondary_start_kernel+0xf8/0x118)
[   23.260253]  r5:00000002 r4:8050b490
[   23.263913] [<80393d1c>] (secondary_start_kernel+0x0/0x118) from 
[<10393854>] (0x10393854)
[   23.272218]  r5:00000015 r4:3c08c06a
[   23.275872] CPU3: stopping
[   23.278622] Backtrace:
[   23.281142] [<800114d4>] (dump_backtrace+0x0/0x108) from [<80396fcc>] 
(dump_stack+0x18/0x1c)
[   23.289620]  r6:00000000 r5:00000006 r4:00000003 r3:600f0193
[   23.295400] [<80396fb4>] (dump_stack+0x0/0x1c) from [<80012a68>] 
(handle_IPI+0xfc/0x170)
[   23.303539] [<8001296c>] (handle_IPI+0x0/0x170) from [<800084e0>] 
(gic_handle_irq+0x60/0x68)
[   23.312016]  r7:ac0a9fa4 r6:804f8500 r5:f4000100 r4:ac0a9f70
[   23.317800] [<80008480>] (gic_handle_irq+0x0/0x68) from [<8039e000>] 
(__irq_svc+0x40/0x70)
[   23.326106] Exception stack(0xac0a9f70 to 0xac0a9fb8)
[   23.331201] 9f60:                                     00000001 
800f0093 ac0a9fa0 00000000
[   23.339425] 9f80: ac0a8000 803a5c4c 10c0387d 80538444 1000406a 
412fc09a 00000000 ac0a9fc4
[   23.347647] 9fa0: ac0a9fc8 ac0a9fb8 8000e700 8000e704 600f0013 ffffffff
[   23.354301]  r6:ffffffff r5:600f0013 r4:8000e704 r3:8000e700
[   23.360084] [<8000e6d8>] (default_idle+0x0/0x34) from [<8000e92c>] 
(cpu_idle+0xa8/0xf8)
[   23.368137] [<8000e884>] (cpu_idle+0x0/0xf8) from [<80393e14>] 
(secondary_start_kernel+0xf8/0x118)
[   23.377136]  r5:00000003 r4:8050b490
[   23.380798] [<80393d1c>] (secondary_start_kernel+0x0/0x118) from 
[<10393854>] (0x10393854)
[   23.389102]  r5:00000015 r4:3c08c06a

[    0.000254]
[    0.001733] U-Boot 2012.07-00103-g171bd0a (Sep 24 2013 - 20:19:22)
[    0.007910]
[    0.009441] CPU:   Freescale i.MX6Q rev1.0 at 792 MHz
[    0.014468] Reset cause: WDOG
[    0.017412] Board: MX6Q-Sabre Lite
[    0.020827] Board ID: 0x0000 (#0)
[    0.024140] DRAM:  1 GiB
[    0.037266] MMC:   FSL_SDHC: 0, FSL_SDHC: 1
[    0.133608] In:    serial
[    0.136144] Out:   serial
[    0.138755] Err:   serial
[    0.141381] Net:   FEC
[    0.170074] Hit any key to stop autoboot:  0
[    0.614926] MX6QSABRELITE U-Boot >


The failure case:
root at mx6q:~# echo b > /proc/sysrq-trigger

[   28.509913] SysRq : Resetting
[   28.513187] CPU1: stopping
[   28.515937] Backtrace:
[   28.518466] [<800114d4>] (dump_backtrace+0x0/0x108) from [<80396fcc>] 
(dump_stack+0x18/0x1c)
[   28.526946]  r6:00000000 r5:00000006 r4:00000001 r3:600f0193
[   28.532723] [<80396fb4>] (dump_stack+0x0/0x1c) from [<80012a68>] 
(handle_IPI+0xfc/0x170)
[   28.540860] [<8001296c>] (handle_IPI+0x0/0x170) from [<800084e0>] 
(gic_handle_irq+0x60/0x68)
[   28.549339]  r7:ac0a1fa4 r6:804f8500 r5:f4000100 r4:ac0a1f70
[   28.555124] [<80008480>] (gic_handle_irq+0x0/0x68) from [<8039e000>] 
(__irq_svc+0x40/0x70)
[   28.563430] Exception stack(0xac0a1f70 to 0xac0a1fb8)
[   28.568526] 1f60:                                     00000001 
800f0093 ac0a1fa0 00000000
[   28.576749] 1f80: ac0a0000 803a5c4c 10c0387d 80538444 1000406a 
412fc09a 00000000 ac0a1fc4
[   28.584970] 1fa0: ac0a1fc8 ac0a1fb8 8000e700 8000e704 600f0013 ffffffff
[   28.591624]  r6:ffffffff r5:600f0013 r4:8000e704 r3:8000e700
[   28.597408] [<8000e6d8>] (default_idle+0x0/0x34) from [<8000e92c>] 
(cpu_idle+0xa8/0xf8)
[   28.605467] [<8000e884>] (cpu_idle+0x0/0xf8) from [<80393e14>] 
(secondary_start_kernel+0xf8/0x118)
[   28.614466]  r5:00000001 r4:8050b490
[   28.618129] [<80393d1c>] (secondary_start_kernel+0x0/0x118) from 
[<10393854>] (0x10393854)
[   28.626433]  r5:00000015 r4:3c08c06a
[   28.630089] CPU2: stopping
[   28.632839] Backtrace:
[   28.635358] [<800114d4>] (dump_backtrace+0x0/0x108) from [<80396fcc>] 
(dump_stack+0x18/0x1c)
[   28.643836]  r6:00000000 r5:00000006 r4:00000002 r3:600f0193
[   28.649617] [<80396fb4>] (dump_stack+0x0/0x1c) from [<80012a68>] 
(handle_IPI+0xfc/0x170)
[   28.657755] [<8001296c>] (handle_IPI+0x0/0x170) from [<800084e0>] 
(gic_handle_irq+0x60/0x68)
[   28.666233]  r7:ac0a3fa4 r6:804f8500 r5:f4000100 r4:ac0a3f70
[   28.672017] [<80008480>] (gic_handle_irq+0x0/0x68) from [<8039e000>] 
(__irq_svc+0x40/0x70)
[   28.680323] Exception stack(0xac0a3f70 to 0xac0a3fb8)
[   28.685419] 3f60:                                     00000001 
800f0093 ac0a3fa0 00000000
[   28.693643] 3f80: ac0a2000 803a5c4c 10c0387d 80538444 1000406a 
412fc09a 00000000 ac0a3fc4
[   28.701865] 3fa0: ac0a3fc8 ac0a3fb8 8000e700 8000e704 600f0013 ffffffff
[   28.708519]  r6:ffffffff r5:600f0013 r4:8000e704 r3:8000e700
[   28.714300] [<8000e6d8>] (default_idle+0x0/0x34) from [<8000e92c>] 
(cpu_idle+0xa8/0xf8)
[   28.722353] [<8000e884>] (cpu_idle+0x0/0xf8) from [<80393e14>] 
(secondary_start_kernel+0xf8/0x118)
[   28.731352]  r5:00000002 r4:8050b490
[   28.735013] [<80393d1c>] (secondary_start_kernel+0x0/0x118) from 
[<10393854>] (0x10393854)
[   28.743318]  r5:00000015 r4:3c08c06a
[   28.746973] CPU0: stopping
[   28.749724] Backtrace:
[   28.752247] [<800114d4>] (dump_backtrace+0x0/0x108) from [<80396fcc>] 
(dump_stack+0x18/0x1c)
[   28.760725]  r6:00000000 r5:00000006 r4:00000000 r3:600f0193
[   28.766505] [<80396fb4>] (dump_stack+0x0/0x1c) from [<80012a68>] 
(handle_IPI+0xfc/0x170)
[   28.774643] [<8001296c>] (handle_IPI+0x0/0x170) from [<800084e0>] 
(gic_handle_irq+0x60/0x68)
[   28.783120]  r7:804f1e84 r6:804f8500 r5:f4000100 r4:804f1e50
[   28.788903] [<80008480>] (gic_handle_irq+0x0/0x68) from [<8039e000>] 
(__irq_svc+0x40/0x70)
[   28.797209] Exception stack(0x804f1e50 to 0x804f1e98)
[   28.802305] 1e40:                                     80ecb440 
804fb3b0 804f1ea8 00000000
[   28.810529] 1e60: ac1c3400 ac6ea8c0 80ecb440 ac1c3400 00000002 
00000000 ac1c3400 804f1ea4
[   28.818751] 1e80: 804f1ea8 804f1e98 8004ba38 8039d5fc 600f0013 ffffffff
[   28.825405]  r6:ffffffff r5:600f0013 r4:8039d5fc r3:8004ba38
[   28.831191] [<8039d5d8>] (_raw_spin_unlock_irq+0x0/0x4c) from 
[<8004ba38>] (finish_task_switch+0x58/0x130)
[   28.840892] [<8004b9e0>] (finish_task_switch+0x0/0x130) from 
[<8039c700>] (__schedule+0x5a4/0x714)
[   28.849890]  r8:804ef440 r7:ac1c3400 r6:804f0000 r5:804f8fc0 r4:804ef440
r3:ffffffff
[   28.857915] [<8039c15c>] (__schedule+0x0/0x714) from [<8039c9fc>] 
(schedule+0x8c/0x90)
[   28.865880] [<8039c970>] (schedule+0x0/0x90) from [<8039ccc4>] 
(schedule_preempt_disabled+0x18/0x24)
[   28.875059] [<8039ccac>] (schedule_preempt_disabled+0x0/0x24) from 
[<8000e964>] (cpu_idle+0xe0/0xf8)
[   28.884241] [<8000e884>] (cpu_idle+0x0/0xf8) from [<803896e4>] 
(rest_init+0x74/0x8c)
[   28.892024]  r5:805380c0 r4:00000002
[   28.895693] [<80389670>] (rest_init+0x0/0x8c) from [<804c3acc>] 
(start_kernel+0x2c8/0x320)
[   28.903998]  r4:804f8dd8 r3:60000153
[   28.907658] [<804c3804>] (start_kernel+0x0/0x320) from [<10008044>] 
(0x10008044)
[   28.915094]  r8:1000406a r7:804fc214 r6:804e6ae0 r5:804f84d8 r4:10c5387d

the difference between successful "echo b > /proc/sysrq-trigger" reboot 
and the failure one is:
whether CPU0 is firstly stopped or not

Do you have any idea?
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>


Thanks,
Jiada
