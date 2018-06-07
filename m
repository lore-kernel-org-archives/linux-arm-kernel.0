From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 7 Jun 2018 16:25:47 +0200
Subject: [PATCH v2] arm64: topology: Avoid checking numa mask for
 scheduler MC selection
In-Reply-To: <20180606163846.495725-1-jeremy.linton@arm.com>
References: <20180606163846.495725-1-jeremy.linton@arm.com>
Message-ID: <CAMuHMdXW4M5CNS3wvb1R8v7ioGX7Q3ODcfgcdn2Ok3FRedTMZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On Wed, Jun 6, 2018 at 6:38 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> The numa mask subset check can often lead to system hang or crash during
> CPU hotplug and system suspend operation if NUMA is disabled. This is

Also during boot, if CONFIG_ARM_PSCI_CHECKER=y.

> mostly observed on HMP systems where the CPU compute capacities are
> different and ends up in different scheduler domains. Since
> cpumask_of_node is returned instead core_sibling, the scheduler is
> confused with incorrect cpumasks(e.g. one CPU in two different sched
> domains at the same time) on CPU hotplug.
>
> Lets disable the NUMA siblings checks for the time being, as NUMA in
> socket machines have LLC's that will assure that the scheduler topology
> isn't "borken".
>
> The NUMA check exists to assure that if a LLC within a socket crosses
> NUMA nodes/chiplets the scheduler domains remain consistent. This code will
> likely have to be re-enabled in the near future once the NUMA mask story
> is sorted.  At the moment its not necessary because the NUMA in socket
> machines LLC's are contained within the NUMA domains.
>
> Further, as a defensive mechanism during hot-plug, lets assure that the
> LLC siblings are also masked.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  arch/arm64/kernel/topology.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 7415c166281f..f845a8617812 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -215,13 +215,8 @@ EXPORT_SYMBOL_GPL(cpu_topology);
>
>  const struct cpumask *cpu_coregroup_mask(int cpu)
>  {
> -       const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
> +       const cpumask_t *core_mask = &cpu_topology[cpu].core_sibling;
>
> -       /* Find the smaller of NUMA, core or LLC siblings */
> -       if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
> -               /* not numa in package, lets use the package siblings */
> -               core_mask = &cpu_topology[cpu].core_sibling;
> -       }
>         if (cpu_topology[cpu].llc_id != -1) {
>                 if (cpumask_subset(&cpu_topology[cpu].llc_siblings, core_mask))
>                         core_mask = &cpu_topology[cpu].llc_siblings;
> @@ -239,8 +234,10 @@ static void update_siblings_masks(unsigned int cpuid)
>         for_each_possible_cpu(cpu) {
>                 cpu_topo = &cpu_topology[cpu];
>
> -               if (cpuid_topo->llc_id == cpu_topo->llc_id)
> +               if (cpuid_topo->llc_id == cpu_topo->llc_id) {
>                         cpumask_set_cpu(cpu, &cpuid_topo->llc_siblings);
> +                       cpumask_set_cpu(cpuid, &cpu_topo->llc_siblings);
> +               }
>
>                 if (cpuid_topo->package_id != cpu_topo->package_id)
>                         continue;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
