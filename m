From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 14 Mar 2017 11:30:17 +0530
Subject: [PATCH 14/14] arm64: pmuv3: use arm_pmu ACPI framework
In-Reply-To: <1489143891-11596-15-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <1489143891-11596-15-git-send-email-mark.rutland@arm.com>
Message-ID: <CAFpQJXUQm84-DTCAng1RQq-wv-nqw=+MTe=vGTL7Sw=yL2sd+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Mar 10, 2017 at 4:34 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Now that we have a framework to handle the ACPI bits, make the PMUv3
> code use this. The framework is a little different to what was
> originally envisaged, and we can drop some unused support code in the
> process of moving over to it.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> One thing I'm not sure about here is how to verify that PMUv3 is supported. I
> can put a test in armv8_pmuv3_init(), but it feels like that should be verified
> earlier.
>
> Mark.
>
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 57ae9d9..daf95919 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1081,24 +1081,9 @@ static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
>         {},
>  };
>
> -/*
> - * Non DT systems have their micro/arch events probed at run-time.
> - * A fairly complete list of generic events are provided and ones that
> - * aren't supported by the current PMU are disabled.
> - */
> -static const struct pmu_probe_info armv8_pmu_probe_table[] = {
> -       PMU_PROBE(0, 0, armv8_pmuv3_init), /* enable all defined counters */
> -       { /* sentinel value */ }
> -};
> -
>  static int armv8_pmu_device_probe(struct platform_device *pdev)
>  {
> -       if (acpi_disabled)
> -               return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids,
> -                                           NULL);
> -
> -       return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids,
> -                                   armv8_pmu_probe_table);
> +       return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids, NULL);
>  }
>
>  static struct platform_driver armv8_pmu_driver = {
> @@ -1109,4 +1094,11 @@ static int armv8_pmu_device_probe(struct platform_device *pdev)
>         .probe          = armv8_pmu_device_probe,
>  };
>
> -builtin_platform_driver(armv8_pmu_driver);
> +int __init armv8_pmu_driver_init(void)
> +{
> +       if (acpi_disabled)
> +               return platform_driver_register(&armv8_pmu_driver);
> +       else
> +               return arm_pmu_acpi_probe(armv8_pmuv3_init);

i think this function needs to be updated to
probe SoC specific init (armv8_a53_pmu_init, armv8_vulcan_pmu_init
etc)  as well.

> +}
> +device_initcall(armv8_pmu_driver_init)
> --
> 1.9.1

thanks
Ganapat
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
