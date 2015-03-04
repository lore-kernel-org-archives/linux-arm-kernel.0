From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Mar 2015 16:20:56 +0000
Subject: [PATCH v2 1/3] arm64: pmu: add support for interrupt-affinity
 property
In-Reply-To: <1425065549-24661-1-git-send-email-will.deacon@arm.com>
References: <1425065549-24661-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150304162056.GA22156@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Feb 27, 2015 at 07:32:27PM +0000, Will Deacon wrote:
> Historically, the PMU devicetree bindings have expected SPIs to be
> listed in order of *logical* CPU number. This is problematic for
> bootloaders, especially when the boot CPU (logical ID 0) isn't listed
> first in the devicetree.
> 
> This patch adds a new optional property, interrupt-affinity, to the
> PMU node which allows the interrupt affinity to be described using
> a list of phandled to CPU nodes, with each entry in the list
> corresponding to the SPI at the same index in the interrupts property.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/pmu.txt |  6 +++
>  arch/arm64/include/asm/pmu.h                  |  1 +
>  arch/arm64/kernel/perf_event.c                | 57 +++++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 4 deletions(-)

Please split the DT portion out from the arm64 code; it's equally
applicable to the arm and arm64 patches.

> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 75ef91d08f3b..a9281fc48743 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -24,6 +24,12 @@ Required properties:
>  
>  Optional properties:
>  
> +- interrupt-affinity : Valid only when using SPIs, specifies a list of phandles
> +                       to CPU nodes corresponding directly to the affinity of
> +		       the SPIs listed in the interrupts property. If absent,
> +		       the interrupts are assumed to be listed in logical CPU
> +		       order.

I would prefer if this were: 

----
- interrupt-affinity : Valid only when using SPIs, specifies a list of phandles
		       to CPU nodes corresponding directly to the affinity of
		       the SPIs listed in the interrupts property.

		       This property should be present when there is more than
		       a single SPI.
----

That makes it clear that new DTs should be using the property. It also
gets rid of the mention of the logical CPU order, which DT authors
simply cannot know anything about.

There are cases I can think of that this doesn't cover:

* A single muxed SPI
* Muxed SPIs per-cluster
* Differing PPIs per-cluster

I can see how we can cover the first quite easily with a simple binding
extension, but I'm having difficulty with the last two. If they're
unlikely to appear in practice, then we are fine, but it's not clear to
me if that's the case.

If you think those are unlikely to appear in practice, then I think this
binding is sufficient. So, for the binding split out into a seaprate
patch, with those changes:

Acked-by: Mark Rutland <mark.rutland@arm.com>

[...]

Now, for the code...

[...]

>  static int armpmu_device_probe(struct platform_device *pdev)
>  {
> +	int i, *irqs;
> +
>  	if (!cpu_pmu)
>  		return -ENODEV;
>  

We should pull the affinity parsing into a function that we only bother
to call if there's an interrupt-affinity property present. That will
make it possible to error out if there is a property but it is
malformed.

> +	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
> +	if (!irqs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < pdev->num_resources; ++i) {
> +		struct device_node *dn;
> +		int cpu = -1;
> +
> +		dn = of_parse_phandle(pdev->dev.of_node, "interrupt-affinity",
> +				      i);
> +		if (!dn) {
> +			pr_warn("Failed to parse interrupt-affinity for idx %d\n",
> +				i);

This would be nicer with the node name:

			pr_warn("Failed to parse %s/interrupt-affinity[%d]",
				of_node_full_name(dn), i);

> +			break;
> +		}
> +
> +		for_each_possible_cpu(cpu)
> +			if (arch_find_n_match_cpu_physical_id(dn, cpu, NULL))
> +				break;
> +
> +		if (cpu == -1) {
> +			pr_warn("Failed to find logical CPU for %s\n",
> +				dn->name);
> +			break;
> +		}

Refcount leak on dn here. You can move the put immediately after the
for_each_possible_cpu.

> +
> +		irqs[i] = cpu;
> +		of_node_put(dn);
> +	}

Thanks,
Mark.
