From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 Jul 2016 15:25:30 +0200
Subject: [PATCH v2] drivers/perf: arm-pmu: Handle per-interrupt affinity
 mask
In-Reply-To: <1467815627-4061-1-git-send-email-marc.zyngier@arm.com>
References: <1467815627-4061-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAMuHMdXU6C=jFD16Jj3NFNawiY0YEpQDZSbL+T4bLgUOG3nTUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, Catalin, Will,

On Wed, Jul 6, 2016 at 4:33 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On a big-little system, PMUs can be wired to CPUs using per CPU
> interrups (PPI). In this case, it is important to make sure that
> the enable/disable do happen on the right set of CPUs.
>
> So instead of relying on the interrupt-affinity property, we can
> use the actual percpu affinity that DT exposes as part of the
> interrupt specifier. The DT binding is also updated to reflect
> the fact that the interrupt-affinity property shouldn't be used
> in that case.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> * From v1:
>   - propagate the error if irq_get_percpu_devid_partition fails

This patch, which is commit 19a469a58720ea96 in arm64/for-next/core, broke
the PMU on r8a7740/armadillo800eva:

    -hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7
counters available
    +hw perfevents: /pmu: failed to probe PMU!
    +hw perfevents: /pmu: failed to register PMU devices!
    +armv7-pmu: probe of pmu failed with error -22

This is a single-core Cortex A9.

>  Documentation/devicetree/bindings/arm/pmu.txt |  4 +++-
>  drivers/perf/arm_pmu.c                        | 27 ++++++++++++++++++++++-----
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 74d5417..61c8b46 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -39,7 +39,9 @@ Optional properties:
>                         When using a PPI, specifies a list of phandles to CPU
>                        nodes corresponding to the set of CPUs which have
>                        a PMU of this type signalling the PPI listed in the
> -                      interrupts property.
> +                      interrupts property, unless this is already specified
> +                      by the PPI interrupt specifier itself (in which case
> +                      the interrupt-affinity property shouldn't be present).
>
>                         This property should be present when there is more than
>                        a single SPI.

On a single core, there's only a single SPI, hence there's no need for an
"interrupt-affinity" property.

> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 140436a..8e4d7f5 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -961,9 +964,23 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
>                 i++;
>         } while (1);
>
> -       /* If we didn't manage to parse anything, claim to support all CPUs */
> -       if (cpumask_weight(&pmu->supported_cpus) == 0)
> -               cpumask_setall(&pmu->supported_cpus);
> +       /* If we didn't manage to parse anything, try the interrupt affinity */
> +       if (cpumask_weight(&pmu->supported_cpus) == 0) {
> +               if (!using_spi) {

However, using_spi is never set to true in the absence of that property,
causing the wrong branch to be taken...

> +                       /* If using PPIs, check the affinity of the partition */
> +                       int ret, irq;
> +
> +                       irq = platform_get_irq(pdev, 0);
> +                       ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);

... and ret to become -22 here.

> +                       if (ret) {
> +                               kfree(irqs);
> +                               return ret;
> +                       }
> +               } else {
> +                       /* Otherwise default to all CPUs */
> +                       cpumask_setall(&pmu->supported_cpus);
> +               }
> +       }
>
>         /* If we matched up the IRQ affinities, use them to route the SPIs */
>         if (using_spi && i == pdev->num_resources)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
