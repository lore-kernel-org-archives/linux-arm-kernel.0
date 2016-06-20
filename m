From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 20 Jun 2016 18:01:45 +0100
Subject: [PATCH 5/8] arm: arm64: pmu: Assign platform PMU CPU affinity
In-Reply-To: <DB5PR08MB12227A8B98AD708F7C780324F72A0@DB5PR08MB1222.eurprd08.prod.outlook.com>
 (Jeremy Linton's message of "Mon, 20 Jun 2016 16:49:11 +0000")
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
 <1465511013-10742-6-git-send-email-jeremy.linton@arm.com>
 <87fus76cff.fsf@e105922-lin.cambridge.arm.com>
 <DB5PR08MB12227A8B98AD708F7C780324F72A0@DB5PR08MB1222.eurprd08.prod.outlook.com>
Message-ID: <878txz6bgm.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy Linton <Jeremy.Linton@arm.com> writes:

> |-----Original Message-----
> |From: Punit Agrawal [mailto:punit.agrawal at arm.com]
> |Sent: Monday, June 20, 2016 11:41 AM
> |To: Jeremy Linton
> |Cc: linux-arm-kernel at lists.infradead.org; Mark Rutland; Lorenzo Pieralisi;
> |mlangsdorf at redhat.com; peterz at infradead.org; Catalin Marinas; Will
> |Deacon; acme at kernel.org; linux-acpi at vger.kernel.org;
> |alexander.shishkin at linux.intel.com; mingo at redhat.com
> |Subject: Re: [PATCH 5/8] arm: arm64: pmu: Assign platform PMU CPU affinity
> |
> |Jeremy Linton <jeremy.linton@arm.com> writes:
> |
> |> On systems with multiple PMU types the PMU to CPU affinity needs to be
> |> detected and set. The CPU to interrupt affinity should also be set.
> |>
> |
> |One comment below.
> |
> |> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> |> ---
> |>  drivers/perf/arm_pmu.c | 52
> |++++++++++++++++++++++++++++++++++++++++----------
> |>  1 file changed, 42 insertions(+), 10 deletions(-)
> |>
> |> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> |> index fee4be0e8..865a9db 100644
> |> --- a/drivers/perf/arm_pmu.c
> |> +++ b/drivers/perf/arm_pmu.c
> |
> |[...]
> |
> |> @@ -872,25 +874,56 @@ static void cpu_pmu_destroy(struct arm_pmu
> |*cpu_pmu)
> |>  }
> |>
> |>  /*
> |> - * CPU PMU identification and probing.
> |> + * CPU PMU identification and probing. Its possible to have
> |> + * multiple CPU types in an ARM machine. Assure that we are
> |> + * picking the right PMU types based on the CPU in question
> |>   */
> |> -static int probe_current_pmu(struct arm_pmu *pmu,
> |> -     const struct pmu_probe_info *info)
> |> +static int probe_plat_pmu(struct arm_pmu *pmu,
> |> +     const struct pmu_probe_info *info,
> |> +     unsigned int pmuid)
> |>  {
> |> -int cpu = get_cpu();
> |> -unsigned int cpuid = read_cpuid_id();
> |>  int ret = -ENODEV;
> |> +int cpu;
> |> +int aff_ctr = 0;
> |> +struct platform_device *pdev = pmu->plat_device;
> |> +int irq = platform_get_irq(pdev, 0);
> |>
> |> -pr_info("probing PMU on CPU %d\n", cpu);
> |> +if (irq >= 0 && !irq_is_percpu(irq)) {
> |> +pmu->irq_affinity = kcalloc(pdev->num_resources,
> |sizeof(int),
> |> +    GFP_KERNEL);
> |> +if (!pmu->irq_affinity)
> |> +return -ENOMEM;
> |> +}
> |> +
> |> +for_each_possible_cpu(cpu) {
> |> +unsigned int cpuid = read_specific_cpuid(cpu);
> |> +
> |> +if (cpuid == pmuid) {
> |> +cpumask_set_cpu(cpu, &pmu->supported_cpus);
> |> +pr_devel("enable pmu on cpu %d\n", cpu);
> |> +if (pmu->irq_affinity) {
> |
> |The check for irq_affinity can be dropped as you already do that earlier.
>
> There isn't an irq_affinity structure for machines with PMU's using
> PPI's, that is why the check is there...

You're right. I missed the PPIs case. Apologies for the noise.

>
> Thanks,
>
> IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended
> recipient, please notify the sender immediately and do not disclose
> the contents to any other person, use it for any purpose, or store or
> copy the information in any medium. Thank you.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
