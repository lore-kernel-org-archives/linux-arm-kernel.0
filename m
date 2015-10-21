From: slash.tmp@free.fr (Mason)
Date: Wed, 21 Oct 2015 15:01:05 +0200
Subject: pmu: armv7_a9_pmu_init() fails with -ENXIO
Message-ID: <56278C91.8050605@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On my (dual-core) system, armv7_a9_pmu_init() fails with -ENXIO
(I'm running v4.2)

[    0.090148] cpu=4 nr_cpu_ids=2
[    0.090164] armv7_a9_pmu_init: ret=-6
[    0.090171] hw perfevents: failed to probe PMU!
[    0.090175] hw perfevents: failed to register PMU devices!

armv7_a9_pmu_init() eventually calls generic_exec_single()
which fails this test:

	if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu))

cpu = 4 looks fishy, doesn't it?
<grasping@straws> I'm wondering if commit 0e3038d18adce or
commit cc88116da0d18 might be related at all?

The value 4 comes from smp_call_function_any()

  /* Any online will do: smp_call_function_single handles nr_cpu_ids. */
  cpu = cpumask_any_and(mask, cpu_online_mask);

mask = &arm_pmu->supported_cpus
p arm_pmu->supported_cpus
$3 = {bits = {0}}

/**
 * cpumask_next_and - get the next cpu in *src1p & *src2p
 * @n: the cpu prior to the place to search (ie. return will be > @n)
 * @src1p: the first cpumask pointer
 * @src2p: the second cpumask pointer
 *
 * Returns >= nr_cpu_ids if no further cpus set in both.
 */

Shouldn't cpu_pmu->supported_cpus be cpu_present_mask or cpu_possible_mask?
Shouldn't armv7pmu_init() set arm_pmu->supported_cpus?

Regards.
