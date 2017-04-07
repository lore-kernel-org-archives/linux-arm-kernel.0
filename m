From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Apr 2017 14:23:07 +0200
Subject: [PATCH v9 11/12] ARM: EXYNOS: move cpu_restart as a SoC specific
 hook to exynos_cpu_info
In-Reply-To: <1490879826-16754-12-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170330131442epcas5p4f2be72cb3ec506847d8e832675e682c4@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-12-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAJKOXPdejfBQDtSv-r+kaUDHwYbYu=YzHxHh8AeaYO8wzAE4Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 3:17 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> To handle differences in cpu_restart functionality among various Exynos SoC
> let's move cpu_restart as a SoC specific function hook to exynos_cpu_info.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 6f08b15..af9332c 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -39,11 +39,13 @@ extern void exynos4_secondary_startup(void);
>   * @cpu_boot_reg: computes cpu boot address for requested cpu
>   * @cpu_power_down: handles cpu power down routine for requested cpu
>   * @cpu_power_up: handles cpu power up routine for requested cpu
> + * @cpu_restart: handles cpu restart routine for requested cpu
>   */
>  struct exynos_cpu_info {
>         void __iomem* (*cpu_boot_reg)(u32 cpu);
>         void (*cpu_power_down)(u32 cpu);
>         void (*cpu_power_up)(u32 cpu);
> +       void (*cpu_restart)(u32 cpu);
>  };
>
>  static const struct exynos_cpu_info *cpu_info;
> @@ -252,16 +254,19 @@ static inline void __iomem *cpu_boot_reg(int cpu)
>  }
>
>  /*
> - * Set wake up by local power mode and execute software reset for given core.
> - *
> + * exynos_core_restart : restart the specified cpu
> + * @core_id : the cpu to be restarted
>   * Currently this is needed only when booting secondary CPU on Exynos3250.
>   */
>  void exynos_core_restart(u32 core_id)
>  {
> -       u32 val;
> +       if (cpu_info && cpu_info->cpu_restart)
> +               cpu_info->cpu_restart(core_id);
> +}
>
> -       if (!of_machine_is_compatible("samsung,exynos3250"))
> -               return;
> +static void exynos3250_core_restart(u32 core_id)
> +{
> +       u32 val;
>
>         while (!pmu_raw_readl(S5P_PMU_SPARE2))
>                 udelay(10);
> @@ -362,6 +367,7 @@ static const struct exynos_cpu_info exynos3250_cpu_info = {
>         .cpu_boot_reg = exynos_common_cpu_boot_reg,
>         .cpu_power_down = exynos_common_cpu_power_down,
>         .cpu_power_up = exynos3250_cpu_power_up,
> +       .cpu_restart = exynos3250_core_restart,

This is actually not a CPU restart but poking a CPU after power up. It
is called right after enabling power to given CPU but before setting
boot addr. For Exynos3250 in fact we do a restart but before we wait
for bootloader flag and we set local wakeup mode.

Putting this under cpu_restart will be misleading because:
1. I am not sure this is a valid restart method even for Exynos3250
(although it might work because the bootloader flag would be set
anyway).
2. It is called in specific moment.

I think this should not be made generic... or the naming should be
different, like: cpu_post_power_up().

Best regards,
Krzysztof
