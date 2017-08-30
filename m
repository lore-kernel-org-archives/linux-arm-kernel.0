From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Wed, 30 Aug 2017 15:41:16 +0100
Subject: [PATCH 0/4] arm: remove cpu_efficiency
Message-ID: <20170830144120.9312-1-dietmar.eggemann@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Cortex-A15/A7 arm big.LITTLE systems there are currently two ways to
set the cpu capacity.

The first one (commit 06073ee26775 "ARM: 8621/3: parse cpu
capacity-dmips-mhz from DT") is based on dt 'cpu capacity-dmips-mhz'
bindings and the appropriate dt parsing code in
drivers/base/arch_topology.c. It further takes differences in maximum
cpu frequency values into consideration, normalizes the maximum cpu
capacity to SCHED_CAPACITY_SCALE (1024) and scales all the cpus
accordingly.

  cpu capacity = (capacity-dmips-mhz * max cpu frequency) / 
                 (max capacity-dmips-mhz * max (max cpu frequency)

This solution is shared between arm and arm64 and works for other
combinations of big and little cpus (besides Cortex-A15/A7) as well.

The second one (commit 339ca09d7ada "ARM: 7463/1: topology: Update
cpu_power according to DT information" is based on the 'struct
cpu_efficiency table_efficiency[]' and the dt parsing code in
arch/arm/kernel/topology.c. It further requires a clock-frequency
property per cpu node, calculates a so called middle frequency for an
average cpu in the system which is as close as possible to
SCHED_CAPACITY_SCALE (1024) and uses this to compute the cpu capacity
values.

  cpu capacity = (cpu efficiency * clock frequency) / middle capacity

This solution only works for Cortex-A15/A7 arm big.LITTLE systems.

The aim of this patch-set is to have only one solution for all arm and
arm64 big.LITTLE platforms.

(1) Therefore, it removes the code for the 'cpu_efficiency/
    clock-frequency dt property' (second) solution [patch 01/04] and
    migrates the arm big.LITTLE platforms currently using this approach
    [patch 02-04/04] to use the 'cpu capacity-dmips-mhz' (first)
    solution.

(2) Moreover, it will also assure that the highest original cpu capacity
    (rq->cpu_capacity_orig) in a non-smt system is SCHED_CAPACITY_SCALE
    (1024).

(3) And finally, another advantage is the dynamic detection of the max
    cpu frequency which comes with the first solution instead of the
    static clock-frequency dt property value.

Currently, the arm dt parsing code in parse_dt_topology() checks if the
dt uses the capacity-dmips-mhz property. If this is the case it uses
the first, otherwise the second solution. This patch-set removes the
code for the second solution from arch/arm/kernel/topology.c.

The following arm big.LITTLE platforms which use cpu node descriptions
with the 'compatible' properties "arm,cortex-a15" and "arm,cortex-a7"
as well as the "clock-frequency" are (theoretically*) affected:

(1) arndale-octa, peach-pi, peach-pit, smdk5420 (exynos5420-cpus.dtsi)

(2) odroidxu3, odroidxu3-lite, odroidxu4 (exynos5422-cpus.dtsi)

(3) r8a7790-lager (r8a7790.dtsi)

TC2 (vexpress-v2p-ca15_a7.dts) already has the capacity-dmips-mhz
properties (it never had "clock-frequency" properties per cpu node
though).

*Currently, these platforms are only theoretically affected. The reason
is because heterogeneous cpu capacity support on arm stopped with commit
8cd5601c5060 ("sched/fair: Convert arch_scale_cpu_capacity() from weak
function to #define") because the arch never defined
arch_scale_cpu_capacity so the task scheduler uses the default
implementation in kernel/sched/sched.h. This will change as soon the
patch "arm: wire cpu-invariant accounting support up to the task
scheduler" [1] is in mainline.

This patch-set has been tested on TC2 and Samsung Chromebook 2 13"
(peach-pi, Exynos 5800).

[1] https://marc.info/?l=linux-kernel&m=150367158111303&w=2

Dietmar Eggemann (4):
  arm: topology: remove cpu_efficiency
  arm: dts: exynos: add exynos5420 cpu capacity-dmips-mhz information
  arm: dts: exynos: add exynos5422 cpu capacity-dmips-mhz information
  arm: dts: r8a7790: add cpu capacity-dmips-mhz information

 arch/arm/boot/dts/exynos5420-cpus.dtsi |   8 +++
 arch/arm/boot/dts/exynos5422-cpus.dtsi |   8 +++
 arch/arm/boot/dts/r8a7790.dtsi         |   8 +++
 arch/arm/kernel/topology.c             | 113 +--------------------------------
 4 files changed, 27 insertions(+), 110 deletions(-)

-- 
2.11.0
