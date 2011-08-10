From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 10 Aug 2011 10:07:46 +0900
Subject: [RFC PATCH 4/8] ARM: exynos4: convert logical CPU numbers to
	physical numbers
In-Reply-To: <1312926162-22469-5-git-send-email-will.deacon@arm.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
	<1312926162-22469-5-git-send-email-will.deacon@arm.com>
Message-ID: <CAH9JG2WjHm2mypLR-9=1vNDz-h3PyRGwTP5Z-C1SsktRh+H6eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

On Wed, Aug 10, 2011 at 6:42 AM, Will Deacon <will.deacon@arm.com> wrote:
> This patch uses the new cpu_logical_map() macro for converting logical
> CPU numbers into physical numbers when dealing with the pen_release
> variable in the SMP boot and CPU hotplug paths.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/mach-exynos4/hotplug.c | ? ?2 +-
> ?arch/arm/mach-exynos4/platsmp.c | ? ?2 +-
> ?2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/hotplug.c b/arch/arm/mach-exynos4/hotplug.c
> index 7490789..da70e7e 100644
> --- a/arch/arm/mach-exynos4/hotplug.c
> +++ b/arch/arm/mach-exynos4/hotplug.c
> @@ -75,7 +75,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> ? ? ? ? ? ? ? ? ? ?:
> ? ? ? ? ? ? ? ? ? ?: "memory", "cc");
>
> - ? ? ? ? ? ? ? if (pen_release == cpu) {
> + ? ? ? ? ? ? ? if (pen_release == cpu_logical_map(cpu)) {
> ? ? ? ? ? ? ? ? ? ? ? ?/*
> ? ? ? ? ? ? ? ? ? ? ? ? * OK, proper wakeup, we're done
> ? ? ? ? ? ? ? ? ? ? ? ? */
> diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
> index 7c2282c..0733814 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -126,7 +126,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> ? ? ? ? * Note that "pen_release" is the hardware CPU ID, whereas
> ? ? ? ? * "cpu" is Linux's internal ID.
> ? ? ? ? */
> - ? ? ? write_pen_release(cpu);
> + ? ? ? write_pen_release(cpu_logical_map(cpu));
>
> ? ? ? ?if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
> ? ? ? ? ? ? ? ?__raw_writel(S5P_CORE_LOCAL_PWR_EN,
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
