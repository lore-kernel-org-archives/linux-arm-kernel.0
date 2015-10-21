From: slash.tmp@free.fr (Mason)
Date: Wed, 21 Oct 2015 15:46:59 +0200
Subject: pmu: armv7_a9_pmu_init() fails with -ENXIO
In-Reply-To: <56278C91.8050605@free.fr>
References: <56278C91.8050605@free.fr>
Message-ID: <56279753.5000107@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/2015 15:01, Mason wrote:

> On my (dual-core) system, armv7_a9_pmu_init() fails with -ENXIO
> (I'm running v4.2)
> 
> [    0.090148] cpu=4 nr_cpu_ids=2
> [    0.090164] armv7_a9_pmu_init: ret=-6
> [    0.090171] hw perfevents: failed to probe PMU!
> [    0.090175] hw perfevents: failed to register PMU devices!
> 
> armv7_a9_pmu_init() eventually calls generic_exec_single()
> which fails this test:
> 
> 	if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu))
> 
> cpu = 4 looks fishy, doesn't it?
> <grasping@straws> I'm wondering if commit 0e3038d18adce or
> commit cc88116da0d18 might be related at all?
> 
> The value 4 comes from smp_call_function_any()
> 
>   /* Any online will do: smp_call_function_single handles nr_cpu_ids. */
>   cpu = cpumask_any_and(mask, cpu_online_mask);
> 
> mask = &arm_pmu->supported_cpus
> p arm_pmu->supported_cpus
> $3 = {bits = {0}}
> 
> /**
>  * cpumask_next_and - get the next cpu in *src1p & *src2p
>  * @n: the cpu prior to the place to search (ie. return will be > @n)
>  * @src1p: the first cpumask pointer
>  * @src2p: the second cpumask pointer
>  *
>  * Returns >= nr_cpu_ids if no further cpus set in both.
>  */
> 
> Shouldn't cpu_pmu->supported_cpus be cpu_present_mask or cpu_possible_mask?
> Shouldn't armv7pmu_init() set arm_pmu->supported_cpus?

Looking more closely at Documentation/devicetree/bindings/arm/pmu.txt
I now see commit 71bbf038eaa44

- interrupt-affinity : Valid only when using SPIs, specifies a list of phandles
                       to CPU nodes corresponding directly to the affinity of
		       the SPIs listed in the interrupts property.

		       This property should be present when there is more than
		       a single SPI.

I currently have

	pmu {
		compatible = "arm,cortex-a9-pmu";
		interrupts =
			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
			<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
	};

<confused> I wrote the above node by sampling other platforms,
and they don't define any interrupt-affinity property, e.g.

exynos4415.dtsi:

		pmu {
			compatible = "arm,cortex-a9-pmu";
			interrupts = <0 18 0>, <0 19 0>, <0 20 0>, <0 21 0>;
		};

exynos5440.dtsi:

	arm-pmu {
		compatible = "arm,cortex-a15-pmu", "arm,cortex-a9-pmu";
		interrupts = <0 52 4>,
			     <0 53 4>,
			     <0 54 4>,
			     <0 55 4>;
	};

highbank.dts:

		pmu {
			compatible = "arm,cortex-a9-pmu";
			interrupts = <0 76 4  0 75 4  0 74 4  0 73 4>;
		};

omap4460.dtsi:

	pmu {
		compatible = "arm,cortex-a9-pmu";
		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
		ti,hwmods = "debugss";
	};


I also looked more closely at of_pmu_irq_cfg()

platform_get_irq(pdev, 0); returns -6
pdev->num_resources is 0 therefore...

	if (i == pdev->num_resources) {
		pmu->irq_affinity = irqs;
	} else {
		kfree(irqs);
		cpumask_setall(&pmu->supported_cpus);
	}

pmu->irq_affinity gets set to an invalid pointer (0x00000010)
and cpumask_setall() is not called.

Something is not working as expected, right?

Regards.
