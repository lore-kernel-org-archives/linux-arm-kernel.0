From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 9 Mar 2011 14:42:55 +0900
Subject: [PATCH 2/3] ARM: EXYNOS4: Suspend to RAM Support
In-Reply-To: <1299636521-4831-3-git-send-email-jc.lee@samsung.com>
References: <1299636521-4831-1-git-send-email-jc.lee@samsung.com>
	<1299636521-4831-3-git-send-email-jc.lee@samsung.com>
Message-ID: <AANLkTikNu89XxoZ70PVH1MPXA7FBOGaiViovxmO7=t_E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2011 at 11:08 AM, Jaecheol Lee <jc.lee@samsung.com> wrote:
> This patch adds support suspend to ram for EXYNOS4210.
> As a note, this includes function of outer cache flush
> because it is used before entering PM.
>
> Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
> ---
> ?arch/arm/mach-exynos4/Makefile ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-exynos4/include/mach/pm-core.h ? ?| ? 50 +++
> ?arch/arm/mach-exynos4/include/mach/regs-clock.h | ? ?9 +-
> ?arch/arm/mach-exynos4/pm.c ? ? ? ? ? ? ? ? ? ? ?| ?419 +++++++++++++++++++++++
> ?arch/arm/mach-exynos4/sleep.S ? ? ? ? ? ? ? ? ? | ?171 +++++++++
> ?arch/arm/plat-samsung/include/plat/cpu.h ? ? ? ?| ? ?1 +
> ?arch/arm/plat-samsung/pm.c ? ? ? ? ? ? ? ? ? ? ?| ? ?3 +
> ?7 files changed, 652 insertions(+), 2 deletions(-)
> ?create mode 100644 arch/arm/mach-exynos4/include/mach/pm-core.h
> ?create mode 100644 arch/arm/mach-exynos4/pm.c
> ?create mode 100644 arch/arm/mach-exynos4/sleep.S
>
> diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
[]

> diff --git a/arch/arm/mach-exynos4/include/mach/pm-core.h b/arch/arm/mach-exynos4/include/mach/pm-core.h
[]

> diff --git a/arch/arm/mach-exynos4/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
[]

> diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
> new file mode 100644
> index 0000000..fb5065b
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/pm.c
[]

> +       { .reg = S5P_PCIE_MEM_LOWPWR                    , .val = 0x0, },
> +       { .reg = S5P_SATA_MEM_LOWPWR                    , .val = 0x0, },
> +       { .reg = S5P_PAD_RETENTION_DRAM_LOWPWR          , .val = 0x0, },
> +       { .reg = S5P_PAD_RETENTION_MAUDIO_LOWPWR        , .val = 0x0, },

Probably, it's ok to choose not to write codes for exceptions of some
chip revisions, in EVT 1.0 (tested and not applied in EVT0, not tested
in EVT1.1), we had to set S5P_PAD_RETENTION_MAUDIO_LOWPWR 0x1.
Otherwise, the sound didn't work after an instance of resume (which
worked in EVT0)


[]

> +
> +static struct sleep_save exynos4_core_save[] = {
> + ? ? ? /* CMU side */
> + ? ? ? SAVE_ITEM(S5P_CLKDIV_LEFTBUS),
> + ? ? ? SAVE_ITEM(S5P_CLKDIV_RIGHTBUS),
...
> + ? ? ? SAVE_ITEM(S5P_CLKDIV_CPU),
> + ? ? ? SAVE_ITEM(S5P_CLKGATE_SCLKCPU),

In this list, how about adding the following CMU registers for core_save[]?
S5P_CLKSRC_LEFTBUS,
S5P_CLKGATE_IP_LEFTBUS,
S5P_CLKOUT_CMU_LEFTBUS,
S5P_CLKSRC_RIGHTBUS,
S5P_CLKGATE_IP_RIGHTBUS,
S5P_CLKOUT_CMU_RIGHTBUS,
S5P_EPLL_LOCK,
S5P_VPLL_LOCK,
S5P_VPLL_CON0,
S5P_VPLL_CON1,
S5P_CLKSRC_TV,
S5P_CLKSRC_G3D,
S5P_CLKDIV_TV,
S5P_CLKDIV_MFC,
S5P_CLKDIV_G3D,
S5P_CLKSRC_MASK_CAM,
S5P_CLKDIV2_RATIO,
S5P_CLKGATE_IP_TV,
S5P_CLKGATE_IP_G3D,
S5P_CLKGATE_IP_GPS,
S5P_CLKGATE_BLOCK,
S5P_CLKOUT_CMU_TOP,
S5P_CLKDIV_DMC1,
S5P_CLKGATE_IP_DMC,
S5P_CLKOUT_CMU_DMC,
S5P_APLL_LOCK,
S5P_MPLL_LOCK,
S5P_APLL_CON0,
S5P_APLL_CON1,
S5P_MPLL_CON0,
S5P_MPLL_CON1,
S5P_CLKDIV_CPU1,
S5P_CLKGATE_IP_CPU,
S5P_CLKOUT_CMU_CPU,

and some of PMU registers (mainly "CONTROL" and "CONFIGURATION" registers)?

> +
> + ? ? ? /* GIC side */
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_CPU + 0x000),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_CPU + 0x004),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_CPU + 0x008),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_CPU + 0x00C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_CPU + 0x014),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_CPU + 0x018),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x000),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x004),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x100),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x104),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x108),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x300),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x304),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x308),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x400),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x404),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x408),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x40C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x410),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x414),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x418),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x41C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x420),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x424),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x428),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x42C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x430),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x434),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x438),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x43C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x440),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x444),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x448),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x44C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x450),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x454),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x458),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x45C),
> +
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x800),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x804),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x808),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x80C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x810),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x814),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x818),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x81C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x820),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x824),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x828),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x82C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x830),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x834),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x838),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x83C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x840),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x844),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x848),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x84C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x850),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x854),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x858),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0x85C),
> +
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0xC00),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0xC04),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0xC08),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0xC0C),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0xC10),
> + ? ? ? SAVE_ITEM(S5P_VA_GIC_DIST + 0xC14),
> +
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x000),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x010),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x020),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x030),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x040),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x050),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x060),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x070),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x080),
> + ? ? ? SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x090),
> +};
> +
> +static struct sleep_save exynos4_l2cc_save[] = {
> + ? ? ? SAVE_ITEM(S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL),
> + ? ? ? SAVE_ITEM(S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL),
> + ? ? ? SAVE_ITEM(S5P_VA_L2CC + L2X0_PREFETCH_CTRL),
> + ? ? ? SAVE_ITEM(S5P_VA_L2CC + L2X0_POWER_CTRL),
> + ? ? ? SAVE_ITEM(S5P_VA_L2CC + L2X0_AUX_CTRL),
> +};
> +
> +void exynos4_cpu_suspend(void)
> +{
> + ? ? ? unsigned long tmp;
> + ? ? ? unsigned long mask = 0xFFFFFFFF;
> +
> + ? ? ? /* Before enter central sequence mode, clock src register have to set */
> +
> + ? ? ? s3c_pm_do_restore_core(exynos4_set_clksrc, ARRAY_SIZE(exynos4_set_clksrc));
> +
> + ? ? ? /* Setting Central Sequence Register for power down mode */
> +
> + ? ? ? tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> + ? ? ? tmp &= ~(S5P_CENTRAL_LOWPWR_CFG);
> + ? ? ? __raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> +
> + ? ? ? /* Setting Central Sequence option Register */
> +
> + ? ? ? tmp = __raw_readl(S5P_CENTRAL_SEQ_OPTION);
> + ? ? ? tmp &= ~(S5P_USE_MASK);
> + ? ? ? tmp |= S5P_USE_STANDBY_WFI0;
> + ? ? ? __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
> +
> + ? ? ? /* Clear all interrupt pending to avoid early wakeup */
> +
> + ? ? ? __raw_writel(mask, (S5P_VA_GIC_DIST + 0x280));
> + ? ? ? __raw_writel(mask, (S5P_VA_GIC_DIST + 0x284));
> + ? ? ? __raw_writel(mask, (S5P_VA_GIC_DIST + 0x288));
> +
> + ? ? ? /* Disable all interrupt */
> +
> + ? ? ? __raw_writel(0x0, (S5P_VA_GIC_CPU + 0x000));
> + ? ? ? __raw_writel(0x0, (S5P_VA_GIC_DIST + 0x000));
> + ? ? ? __raw_writel(mask, (S5P_VA_GIC_DIST + 0x184));
> + ? ? ? __raw_writel(mask, (S5P_VA_GIC_DIST + 0x188));
> +
> + ? ? ? /* issue the standby signal into the pm unit. */
> + ? ? ? cpu_do_idle();
> +
> + ? ? ? /* we should never get past here */
> + ? ? ? panic("sleep resumed to originator?");
> +}

You may need to ensure EPLL and VPLL are ON when you entering sleep.
When I've tested with "NURI" board, it was ok to turn them off while
the system is running; however, when entering a suspend-to-RAM, they
should be turned on.

> +
> +static void exynos4_pm_prepare(void)
> +{
> + ? ? ? u32 tmp;
> +
> + ? ? ? s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
> + ? ? ? s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
> +
> + ? ? ? tmp = __raw_readl(S5P_INFORM1);
> +
> + ? ? ? /* Set value of power down register for sleep mode */
> +
> + ? ? ? s3c_pm_do_restore_core(exynos4_sleep, ARRAY_SIZE(exynos4_sleep));
> + ? ? ? __raw_writel(S5P_CHECK_SLEEP, S5P_INFORM1);
> +
> + ? ? ? /* ensure at least INFORM0 has the resume address */
> +
> + ? ? ? __raw_writel(virt_to_phys(s3c_cpu_resume), S5P_INFORM0);
> +}
> +
> +static int exynos4_pm_add(struct sys_device *sysdev)
> +{
> + ? ? ? pm_cpu_prep = exynos4_pm_prepare;
> + ? ? ? pm_cpu_sleep = exynos4_cpu_suspend;
> +
> + ? ? ? return 0;
> +}
> +
> +/* This function copy from linux/arch/arm/kernel/smp_scu.c */
> +
> +void exynos4_scu_enable(void __iomem *scu_base)
> +{
> + ? ? ? u32 scu_ctrl;
> +
> + ? ? ? scu_ctrl = __raw_readl(scu_base);
> + ? ? ? /* already enabled? */
> + ? ? ? if (scu_ctrl & 1)
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? scu_ctrl |= 1;
> + ? ? ? __raw_writel(scu_ctrl, scu_base);
> +
> + ? ? ? /*
> + ? ? ? ?* Ensure that the data accessed by CPU0 before the SCU was
> + ? ? ? ?* initialised is visible to the other CPUs.
> + ? ? ? ?*/
> + ? ? ? flush_cache_all();
> +}
> +
> +static int exynos4_pm_resume(struct sys_device *dev)
> +{
> + ? ? ? unsigned int tmp;
> + ? ? ? unsigned long mask = 0xFFFFFFFF;
> +
> + ? ? ? /* For release retention */
> +
> + ? ? ? __raw_writel((1 << 28), S5P_PAD_RET_GPIO_OPTION);
> + ? ? ? __raw_writel((1 << 28), S5P_PAD_RET_UART_OPTION);
> + ? ? ? __raw_writel((1 << 28), S5P_PAD_RET_MMCA_OPTION);
> + ? ? ? __raw_writel((1 << 28), S5P_PAD_RET_MMCB_OPTION);
> + ? ? ? __raw_writel((1 << 28), S5P_PAD_RET_EBIA_OPTION);
> + ? ? ? __raw_writel((1 << 28), S5P_PAD_RET_EBIB_OPTION);
> +
> + ? ? ? s3c_pm_do_restore_core(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
> +
> + ? ? ? /* Clear External Interrupt Pending */
> +
> + ? ? ? __raw_writel(mask, S5P_EINT_PEND(0));
> + ? ? ? __raw_writel(mask, S5P_EINT_PEND(1));
> + ? ? ? __raw_writel(mask, S5P_EINT_PEND(2));
> + ? ? ? __raw_writel(mask, S5P_EINT_PEND(3));
> +
> + ? ? ? exynos4_scu_enable(S5P_VA_SCU);
> +
> +#ifdef CONFIG_CACHE_L2X0
> + ? ? ? s3c_pm_do_restore_core(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
> + ? ? ? outer_cache.inv_all();
> + ? ? ? /* enable L2X0*/
> + ? ? ? writel_relaxed(1, S5P_VA_L2CC + L2X0_CTRL);
> +#endif
> +
> + ? ? ? return 0;
> +}
> +
> +static struct sysdev_driver exynos4_pm_driver = {
> + ? ? ? .add ? ? ? ? ? ?= exynos4_pm_add,
> + ? ? ? .resume ? ? ? ? = exynos4_pm_resume,
> +};
> +
> +static __init int exynos4_pm_drvinit(void)
> +{
> + ? ? ? unsigned int tmp;
> +
> + ? ? ? s3c_pm_init();
> +
> + ? ? ? /* All wakeup disable */
> +
> + ? ? ? tmp = __raw_readl(S5P_WAKEUP_MASK);
> + ? ? ? tmp |= ((0xFF << 8) | (0x1F << 1));
> + ? ? ? __raw_writel(tmp, S5P_WAKEUP_MASK);
> +
> + ? ? ? return sysdev_driver_register(&exynos4_sysclass, &exynos4_pm_driver);
> +}
> +arch_initcall(exynos4_pm_drvinit);
> diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
> new file mode 100644
> index 0000000..dd6d31e
> --- /dev/null
> +++ b/arch/arm/mach-exynos4/sleep.S
> @@ -0,0 +1,171 @@
> +/* linux/arch/arm/mach-exynos4/sleep.S
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com
> + *
> + * EXYNOS4210 power Manager (Suspend-To-RAM) support
> + * Based on S3C2410 sleep code by:
> + * ? ? Ben Dooks, (c) 2004 Simtec Electronics
> + *
> + * Based on PXA/SA1100 sleep code by:
> + * ? ? Nicolas Pitre, (c) 2002 Monta Vista Software Inc
> + * ? ? Cliff Brake, (c) 2001
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> +*/
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +#include <asm/memory.h>
> +
> + ? ? ? .text
> +
> + ? ? ? /*
> + ? ? ? ?* s3c_cpu_save
> + ? ? ? ?*
> + ? ? ? ?* entry:
> + ? ? ? ?* ? ? ?r0 = save address (virtual addr of s3c_sleep_save_phys)
> + ? ? ? ?*/
> +
> +ENTRY(s3c_cpu_save)
> +
> + ? ? ? stmfd ? sp!, { r3 - r12, lr }
> +
> + ? ? ? mrc ? ? p15, 0, r4, c13, c0, 0 ?@ FCSE/PID
> + ? ? ? mrc ? ? p15, 0, r5, c3, c0, 0 ? @ Domain ID
> + ? ? ? mrc ? ? p15, 0, r6, c2, c0, 0 ? @ Translation Table BASE0
> + ? ? ? mrc ? ? p15, 0, r7, c2, c0, 1 ? @ Translation Table BASE1
> + ? ? ? mrc ? ? p15, 0, r8, c2, c0, 2 ? @ Translation Table Control
> + ? ? ? mrc ? ? p15, 0, r9, c1, c0, 0 ? @ Control register
> + ? ? ? mrc ? ? p15, 0, r10, c1, c0, 1 ?@ Auxiliary control register
> + ? ? ? mrc ? ? p15, 0, r11, c1, c0, 2 ?@ Co-processor access controls
> + ? ? ? mrc ? ? p15, 0, r12, c10, c2, 0 @ Read PRRR
> + ? ? ? mrc ? ? p15, 0, r3, c10, c2, 1 ?@ READ NMRR
> +
> + ? ? ? stmia ? r0, { r3 - r13 }
> +
> + ? ? ? bl ? ? ?s3c_pm_cb_flushcache
> +
> + ? ? ? ldr ? ? r0, =pm_cpu_sleep
> + ? ? ? ldr ? ? r0, [ r0 ]
> + ? ? ? mov ? ? pc, r0
> +
> +resume_with_mmu:
> + ? ? ? /* After MMU is turned on, restore the previous MMU table */
> + ? ? ? ldr ? ? r9 , =(PAGE_OFFSET - PHYS_OFFSET)
> + ? ? ? add ? ? r4, r4, r9
> + ? ? ? str ? ? r12, [r4]
> +
> + ? ? ? ldmfd ? sp!, { r3 - r12, pc }
> +
> + ? ? ? .ltorg
> +
> + ? ? ? .data
> +
> + ? ? ? .global s3c_sleep_save_phys
> +s3c_sleep_save_phys:
> + ? ? ? .word ? 0
> +
> + ? ? ? /*
> + ? ? ? ?* sleep magic, to allow the bootloader to check for an valid
> + ? ? ? ?* image to resume to. Must be the first word before the
> + ? ? ? ?* s3c_cpu_resume entry.
> + ? ? ? ?*/
> +
> + ? ? ? .word ? 0x2bedf00d
> +
> + ? ? ? /*
> + ? ? ? ?* s3c_cpu_resume
> + ? ? ? ?*
> + ? ? ? ?* resume code entry for bootloader to call
> + ? ? ? ?*
> + ? ? ? ?* we must put this code here in the data segment as we have no
> + ? ? ? ?* other way of restoring the stack pointer after sleep, and we
> + ? ? ? ?* must not write to the code segment (code is read-only)
> + ? ? ? ?*/
> +
> +ENTRY(s3c_cpu_resume)
> + ? ? ? mov ? ? r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
> + ? ? ? msr ? ? cpsr_c, r0
> +
> + ? ? ? mov ? ? r1, #0
> + ? ? ? mcr ? ? p15, 0, r1, c8, c7, 0 ? ? ? ? ? @ invalidate TLBs
> + ? ? ? mcr ? ? p15, 0, r1, c7, c5, 0 ? ? ? ? ? @ invalidate I Cache
> +
> + ? ? ? ldr ? ? r0, s3c_sleep_save_phys ? ? ? ? @ address of restore block
> + ? ? ? ldmia ? r0, { r3 - r13 }
> +
> + ? ? ? mcr ? ? p15, 0, r4, c13, c0, 0 ? ? ? ? ?@ FCSE/PID
> + ? ? ? mcr ? ? p15, 0, r5, c3, c0, 0 ? ? ? ? ? @ Domain ID
> +
> + ? ? ? mcr ? ? p15, 0, r8, c2, c0, 2 ? ? ? ? ? @ Translation Table Control
> + ? ? ? mcr ? ? p15, 0, r7, c2, c0, 1 ? ? ? ? ? @ Translation Table BASE1
> + ? ? ? mcr ? ? p15, 0, r6, c2, c0, 0 ? ? ? ? ? @ Translation Table BASE0
> +
> + ? ? ? mcr ? ? p15, 0, r10, c1, c0, 1 ? ? ? ? ?@ Auxiliary control register
> +
> + ? ? ? mov ? ? r0, #0
> + ? ? ? mcr ? ? p15, 0, r0, c8, c7, 0 ? ? ? ? ? @ Invalidate I & D TLB
> +
> + ? ? ? mov ? ? r0, #0 ? ? ? ? ? ? ? ? ? ? ? ? ?@ restore copro access
> + ? ? ? mcr ? ? p15, 0, r11, c1, c0, 2 ? ? ? ? ?@ Co-processor access
> + ? ? ? mcr ? ? p15, 0, r0, c7, c5, 4
> +
> + ? ? ? mcr ? ? p15, 0, r12, c10, c2, 0 ? ? ? ? @ write PRRR
> + ? ? ? mcr ? ? p15, 0, r3, c10, c2, 1 ? ? ? ? ?@ write NMRR
> +
> + ? ? ? /*
> + ? ? ? ?* In Cortex-A8, when MMU is turned on, the pipeline is flushed.
> + ? ? ? ?* And there are no valid entries in the MMU table at this point.
> + ? ? ? ?* So before turning on the MMU, the MMU entry for the DRAM address
> + ? ? ? ?* range is added. After the MMU is turned on, the other entries
> + ? ? ? ?* in the MMU table will be restored.
> + ? ? ? ?*/
> +
> + ? ? ? /* r6 = Translation Table BASE0 */
> + ? ? ? mov ? ? r4, r6
> + ? ? ? mov ? ? r4, r4, LSR #14
> + ? ? ? mov ? ? r4, r4, LSL #14
> +
> + ? ? ? /* Load address for adding to MMU table list */
> + ? ? ? ldr ? ? r11, =0x10020800 ? ? ? ? ? ? ? ?@ INFORM0 reg.
> + ? ? ? ldr ? ? r10, [r11, #0]
> + ? ? ? mov ? ? r10, r10, LSR #18
> + ? ? ? bic ? ? r10, r10, #0x3
> + ? ? ? orr ? ? r4, r4, r10
> +
> + ? ? ? /* Calculate MMU table entry */
> + ? ? ? mov ? ? r10, r10, LSL #18
> + ? ? ? ldr ? ? r5, =0x40E
> + ? ? ? orr ? ? r10, r10, r5
> +
> + ? ? ? /* Back up originally data */
> + ? ? ? ldr ? ? r12, [r4]
> +
> + ? ? ? /* Add calculated MMU table entry into MMU table list */
> + ? ? ? str ? ? r10, [r4]
> +
> + ? ? ? ldr ? ? r2, =resume_with_mmu
> + ? ? ? mcr ? ? p15, 0, r9, c1, c0, 0 ? ? ? ? ? @ turn on MMU, etc
> +
> + ? ? ? nop
> + ? ? ? nop
> + ? ? ? nop
> + ? ? ? nop
> + ? ? ? nop ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ second-to-last before mmu
> +
> + ? ? ? mov ? ? pc, r2 ? ? ? ? ? ? ? ? ? ? ? ? ?@ go back to virtual address
> +
> + ? ? ? .ltorg
> diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
> index 9addb3d..cedfff5 100644
> --- a/arch/arm/plat-samsung/include/plat/cpu.h
> +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> @@ -82,6 +82,7 @@ extern struct sysdev_class s3c64xx_sysclass;
> ?extern struct sysdev_class s5p64x0_sysclass;
> ?extern struct sysdev_class s5p6442_sysclass;
> ?extern struct sysdev_class s5pv210_sysclass;
> +extern struct sysdev_class exynos4_sysclass;
>
> ?extern void (*s5pc1xx_idle)(void);
>
> diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
> index 02d531f..c24b6c2 100644
> --- a/arch/arm/plat-samsung/pm.c
> +++ b/arch/arm/plat-samsung/pm.c
> @@ -340,6 +340,9 @@ static int s3c_pm_enter(suspend_state_t state)
> ?void s3c_pm_cb_flushcache(void)
> ?{
> ? ? ? ?flush_cache_all();
> +#ifdef CONFIG_OUTER_CACHE
> + ? ? ? outer_flush_all();
> +#endif
> ?}
>
> ?static int s3c_pm_prepare(void)
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
