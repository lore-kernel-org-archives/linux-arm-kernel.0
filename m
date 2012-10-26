From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Oct 2012 15:48:43 +0100
Subject: [RFC 0/2] Representing interrupt affinity in devicetree
Message-ID: <1351262925-10306-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current devicetree bindings for devices which use cpu-affine shared interrupts
assume that interrupts are listed in ascending order of physical cpu id
(MPIDR.Aff{2,1,0}). This is problematic for drivers because:

(1) The driver must convert each physical id to a logical id for the purpose of
    managing interrupts.

(2) In multi-cluster systems the physical ids are not necessarily contiguous,
    and drivers cannot simply iterate over ids from 0 to NR_CPUS.

(3) It is not possible to specify sets of interrupts which are wired to a
    subset of cpus (i.e. clusters) not starting at physical id 0, as we can't
    specify which cpu to start from, and can't skip cpus. This makes it
    impossible to represent some devices (e.g. cpu PMUs) which may not exist
    in the first cluster.

(4) Some devices may either be wired with PPIs or SPIs. It is not possible to
    differentiate the two cases in general from the interrupts list (e.g. when
    a device has multiple PPIs wired to all cpus).

To represent the general case, we require a mechanism to describe the cpu
affinity of a device, and a consistent way to map each interrupt to a cpu (or
set of cpus). So far, the only usable mechanism I've been able to come up with
is the following:

In addition to the interrupts list, we add an optional 'affinity' list - a list
of phandles, where each phandle points to a cpu node or a cluster node (from
Lorenzo Pieralisi's cpu topology bindings [1]). Each element in the interrupts
list has a corresponding element in the affinity list, at the same index.
Interrupts defined as cluster affine are PPIs, and those defined cpu-affine are
SPIs. This would look something like:

> device at 0 {
> 	compatible = "example,example-affine-device"
> 	interrupts = <0 130 4>,
> 	             <0 131 4>,
> 	             <1 12 4>;
> 	affinity   = <&cpu0>,
>                    <&cpu1>,
> 	             <&cluster1>;
> };

To request/free interrupts, drivers would walk over all interrupts, and request
the affine cpu(s), which can be automatically mapped to logical ids by common
code. This fixes issues 1, 2, and 3. While 4 is partially solved, it doesn't
provide any additional information when you may have multiple interrupts for a
cpu.

The following patches implement common code that could be used by drivers,
assuming the devicetree uses the cluster topology bindings. To not break
existing bindings, when an affinity parameter is not present, interrupts are
assumed to be in increasing order of MPIDR.Aff0, starting at 0. Logical mapping
is always applied to cpu ids.

The patches are based on v3.7-rc2, with Lorenzo Pieralisi's logical mappings
look-up patch [2] applied.

Using this code, an interrupt registration loop would look something like:

> void request_irqs(...)
> {
> 	int i, irqs, irq, c, cpus, cpu;
>
> 	irqs = pdev->num_resources;
> 	for (i = 0; i < irqs; i++) {
> 		irq = platform_get_irq(pdev, i);
> 		cpus = count_irq_affine_cpus(pdev, i);
>
>		/* SPI if affine to 1 cpu */
>		if (cpus == 1) {
>			cpu = get_irq_affine_cpu(pdev, i, 1);
>			if (cpu < 0)
>				continue;
>			irq_set_affinity(irq, cpumask_of(cpu));
>			request_irq(...);
>
>			continue;
>		}
>
>		/* PPI, build cpumask and register */
> 		for (c = 0; c < cpus; c++) {
> 			cpu = get_irq_affine_cpu(pdev, i, c);
>
> 			/* test, add to mask */
> 			...
> 		}
>		
>		request_percpu_irq(...);
> 	}
> }

Does anyone have any better ideas?

Any and all feedback welcome.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/080869.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/125882.html

Mark Rutland (2):
  of: add of_property_count_phandles
  ARM: Add functions to parse dt irq affinity

 arch/arm/include/asm/dt_irq.h |   64 ++++++++++++++++
 arch/arm/kernel/devtree.c     |  165 +++++++++++++++++++++++++++++++++++++++++
 drivers/of/base.c             |   39 ++++++++++
 include/linux/of.h            |    8 ++
 4 files changed, 276 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/dt_irq.h
