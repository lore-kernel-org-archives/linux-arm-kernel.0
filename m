From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 23 Feb 2012 00:24:10 -0600
Subject: [PATCH V6 1/5] ARM: exynos: Add support AFTR mode on EXYNOS4210
In-Reply-To: <1329805190-8874-2-git-send-email-amit.kachhap@linaro.org>
References: <1329805190-8874-1-git-send-email-amit.kachhap@linaro.org>
 <1329805190-8874-2-git-send-email-amit.kachhap@linaro.org>
Message-ID: <CAMXH7KHTgzY7XZ=4rOxsu-Ra8SRTOsCg=YWOLBD1QDTskRbygw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ?static struct cpuidle_state exynos4_cpuidle_set[] = {
> ? ? ? ?[0] = {
> @@ -27,9 +47,17 @@ static struct cpuidle_state exynos4_cpuidle_set[] = {
> ? ? ? ? ? ? ? ?.exit_latency ? ? ? ? ? = 1,
> ? ? ? ? ? ? ? ?.target_residency ? ? ? = 100000,
> ? ? ? ? ? ? ? ?.flags ? ? ? ? ? ? ? ? ?= CPUIDLE_FLAG_TIME_VALID,
> - ? ? ? ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "IDLE",
> + ? ? ? ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "C0",
> ? ? ? ? ? ? ? ?.desc ? ? ? ? ? ? ? ? ? = "ARM clock gating(WFI)",
> ? ? ? ?},
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .enter ? ? ? ? ? ? ? ? ?= exynos4_enter_lowpower,
> + ? ? ? ? ? ? ? .exit_latency ? ? ? ? ? = 300,
> + ? ? ? ? ? ? ? .target_residency ? ? ? = 100000,
> + ? ? ? ? ? ? ? .flags ? ? ? ? ? ? ? ? ?= CPUIDLE_FLAG_TIME_VALID,
> + ? ? ? ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "C1",
> + ? ? ? ? ? ? ? .desc ? ? ? ? ? ? ? ? ? = "ARM power down",
> + ? ? ? },
> ?};

It looks like you could make this __initdata because your are copying
this state data over to the cpuidle_driver object during
initialization.

>
> ?static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
> @@ -39,9 +67,100 @@ static struct cpuidle_driver exynos4_idle_driver = {
> ? ? ? ?.owner ? ? ? ? ?= THIS_MODULE,
> ?};
>
> +/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
> +static void exynos4_set_wakeupmask(void)
> +{
> + ? ? ? __raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
> +}
> +
> +static unsigned int g_pwr_ctrl, g_diag_reg;
> +
> +static void save_cpu_arch_register(void)
> +{
> + ? ? ? /*read power control register*/
> + ? ? ? asm("mrc p15, 0, %0, c15, c0, 0" : "=r"(g_pwr_ctrl) : : "cc");
> + ? ? ? /*read diagnostic register*/
> + ? ? ? asm("mrc p15, 0, %0, c15, c0, 1" : "=r"(g_diag_reg) : : "cc");
> + ? ? ? return;
> +}
> +
> +static void restore_cpu_arch_register(void)
> +{
> + ? ? ? /*write power control register*/
> + ? ? ? asm("mcr p15, 0, %0, c15, c0, 0" : : "r"(g_pwr_ctrl) : "cc");
> + ? ? ? /*write diagnostic register*/
> + ? ? ? asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
> + ? ? ? return;
> +}
> +
> +static int idle_finisher(unsigned long flags)
> +{
> + ? ? ? cpu_do_idle();
> + ? ? ? return 1;
> +}
> +
> +static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index)
> +{
> + ? ? ? struct timeval before, after;
> + ? ? ? int idle_time;
> + ? ? ? unsigned long tmp;
> +
> + ? ? ? local_irq_disable();
> + ? ? ? do_gettimeofday(&before);
> +
> + ? ? ? exynos4_set_wakeupmask();
> +
> + ? ? ? /* Set value of power down register for aftr mode */
> + ? ? ? exynos4_sys_powerdown_conf(SYS_AFTR);
> +
> + ? ? ? __raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
> + ? ? ? __raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
> +
> + ? ? ? save_cpu_arch_register();
> +
> + ? ? ? /* Setting Central Sequence Register for power down mode */
> + ? ? ? tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> + ? ? ? tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
> + ? ? ? __raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> +
> + ? ? ? cpu_pm_enter();
> + ? ? ? cpu_suspend(0, idle_finisher);
> +
> + ? ? ? scu_enable(S5P_VA_SCU);
> + ? ? ? cpu_pm_exit();
> +
> + ? ? ? restore_cpu_arch_register();
> +
> + ? ? ? /*
> + ? ? ? ?* If PMU failed while entering sleep mode, WFI will be
> + ? ? ? ?* ignored by PMU and then exiting cpu_do_idle().
> + ? ? ? ?* S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
> + ? ? ? ?* in this situation.
> + ? ? ? ?*/
> + ? ? ? tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> + ? ? ? if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
> + ? ? ? ? ? ? ? tmp |= S5P_CENTRAL_LOWPWR_CFG;
> + ? ? ? ? ? ? ? __raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> + ? ? ? }
> +
> + ? ? ? /* Clear wakeup state register */
> + ? ? ? __raw_writel(0x0, S5P_WAKEUP_STAT);
> +
> + ? ? ? do_gettimeofday(&after);
> +
> + ? ? ? local_irq_enable();
> + ? ? ? idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
> + ? ? ? ? ? ? ? ? ? (after.tv_usec - before.tv_usec);
> +
> + ? ? ? dev->last_residency = idle_time;
> + ? ? ? return index;
> +}
> +
> ?static int exynos4_enter_idle(struct cpuidle_device *dev,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index)
> ?{
> ? ? ? ?struct timeval before, after;
> ? ? ? ?int idle_time;
> @@ -60,6 +179,22 @@ static int exynos4_enter_idle(struct cpuidle_device *dev,
> ? ? ? ?return index;
> ?}
>
> +static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index)
> +{
> + ? ? ? int new_index = index;
> +
> + ? ? ? /* This mode only can be entered when other core's are offline */
> + ? ? ? if (num_online_cpus() > 1)
> + ? ? ? ? ? ? ? new_index = drv->safe_state_index;
> +
> + ? ? ? if (new_index == 0)
> + ? ? ? ? ? ? ? return exynos4_enter_idle(dev, drv, new_index);
> + ? ? ? else
> + ? ? ? ? ? ? ? return exynos4_enter_core0_aftr(dev, drv, new_index);
> +}
> +
> ?static int __init exynos4_init_cpuidle(void)
> ?{
> ? ? ? ?int i, max_cpuidle_state, cpu_id;
> @@ -74,19 +209,25 @@ static int __init exynos4_init_cpuidle(void)
> ? ? ? ? ? ? ? ?memcpy(&drv->states[i], &exynos4_cpuidle_set[i],
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?sizeof(struct cpuidle_state));
> ? ? ? ?}
> + ? ? ? drv->safe_state_index = 0;
> ? ? ? ?cpuidle_register_driver(&exynos4_idle_driver);
>
> ? ? ? ?for_each_cpu(cpu_id, cpu_online_mask) {
> ? ? ? ? ? ? ? ?device = &per_cpu(exynos4_cpuidle_device, cpu_id);
> ? ? ? ? ? ? ? ?device->cpu = cpu_id;
>
> - ? ? ? ? ? ? ? device->state_count = drv->state_count;
> + ? ? ? ? ? ? ? if (cpu_id == 0)
> + ? ? ? ? ? ? ? ? ? ? ? device->state_count = (sizeof(exynos4_cpuidle_set) /
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?sizeof(struct cpuidle_state));
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? device->state_count = 1; ? ? ? ?/* Support IDLE only */
>
> ? ? ? ? ? ? ? ?if (cpuidle_register_device(device)) {
> ? ? ? ? ? ? ? ? ? ? ? ?printk(KERN_ERR "CPUidle register device failed\n,");
> ? ? ? ? ? ? ? ? ? ? ? ?return -EIO;
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
> +
> ? ? ? ?return 0;
> ?}
> ?device_initcall(exynos4_init_cpuidle);
> diff --git a/arch/arm/mach-exynos/include/mach/pmu.h b/arch/arm/mach-exynos/include/mach/pmu.h
> index 632dd56..e76b7fa 100644
> --- a/arch/arm/mach-exynos/include/mach/pmu.h
> +++ b/arch/arm/mach-exynos/include/mach/pmu.h
> @@ -22,11 +22,13 @@ enum sys_powerdown {
> ? ? ? ?NUM_SYS_POWERDOWN,
> ?};
>
> +extern unsigned long l2x0_regs_phys;
> ?struct exynos4_pmu_conf {
> ? ? ? ?void __iomem *reg;
> ? ? ? ?unsigned int val[NUM_SYS_POWERDOWN];
> ?};
>
> ?extern void exynos4_sys_powerdown_conf(enum sys_powerdown mode);
> +extern void s3c_cpu_resume(void);
>
> ?#endif /* __ASM_ARCH_PMU_H */
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
