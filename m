From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Apr 2017 12:47:39 +0200
Subject: [PATCH v9 09/12] ARM: EXYNOS: introduce exynos_cpu_info struct
In-Reply-To: <1490879826-16754-10-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170330131438epcas1p459ce93da17fcd05249eddaef18d5021e@epcas1p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-10-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAJKOXPddiZ3i9WgW3deg3pQ1CsbxuK1=HtO_DdT-VebTbREKxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 3:17 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> Various Exynos SoC has different CPU related information, such as CPU
> boot register, programming sequence making CPU up/down. Currently this
> is handled by adding lots of soc_is_exynosMMM checks in the code, in
> an attempt to remove the dependency of such helper functions specific to
> each SoC, let's separate this information pertaining to CPU by introducing
> a new "struct exynos_cpu_info". This struct will contain differences
> associated with CPU on various Exynos SoC. This can be matched by using
> generic API "soc_device_match".
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c | 146 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 135 insertions(+), 11 deletions(-)

(...)

>  static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>         unsigned long timeout;
> +       const struct soc_device_attribute *match;
>         u32 mpidr = cpu_logical_map(cpu);
>         u32 core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>         int ret = -ENOSYS;
>
> +       if (of_machine_is_compatible("samsung,exynos4210")) {
> +               match = soc_device_match(exynos_soc_revision);
> +               if (match)
> +                       cpu_info = (const struct exynos_cpu_info *) match->data;
> +       }
> +
>         /*
>          * Set synchronisation state between this boot processor
>          * and the secondary one
> @@ -387,6 +499,18 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
>
>  static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>  {
> +       const struct of_device_id *match;
> +       struct device_node *np;
> +
> +       if (!of_machine_is_compatible("samsung,exynos4210")) {

This differentiation is unnatural. It looks like the chipid
soc_device_match driver is not simplifying things but complicating.
Maybe the solution I mentioned in previous mails (initialize these in
proper order from some of machine init calls) would simplify it...

Best regards,
Krzysztof
