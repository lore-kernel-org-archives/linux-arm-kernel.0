From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Thu, 12 Oct 2017 15:00:27 +0100
Subject: [PATCH v2 0/1] arm: remove cpu_efficiency
Message-ID: <20171012140028.21599-1-dietmar.eggemann@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v1: review results [1]:

Vincent pointed out that there is a superfluous continue statement in
parse_dt_topology(). Got rid of it.
Krzysztof Kozlowski took the exynos and Simon Horman the renesas related
dt bits into their for-next (v4.15) branches.

***

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

The aim of this patch is to have only one solution for all arm and arm64
big.LITTLE platforms.

(1) Therefore, it removes the code for the 'cpu_efficiency/
    clock-frequency dt property' (second) solution.

(2) Moreover, it will also assure that the highest original cpu capacity
    (rq->cpu_capacity_orig) in a non-smt system is SCHED_CAPACITY_SCALE
    (1024).

(3) And finally, another advantage is the dynamic detection of the max
    cpu frequency which comes with the first solution instead of the
    static clock-frequency dt property value.

Currently, the arm dt parsing code in parse_dt_topology() checks if the
dt uses the capacity-dmips-mhz property. If this is the case it uses
the first, otherwise the second solution. This patch removes the code
for the second solution from arch/arm/kernel/topology.c.

With the dt related patches for exynos and renesas now in the
appropriated for-next branches for v4.15 there are no Cortex-A15/A7 arm
big.LITTLE systems left relying on the 'cpu_efficiency/clock-frequency
dt property' based solution anymore.

This patch has been tested on TC2 and Samsung Chromebook 2 13"
(peach-pi, Exynos 5800).

[1] https://marc.info/?l=linux-kernel&m=150410411807050&w=2

Changes v1->v2:

  - Rebase on top of v4.14-rc4
  - Remove superfluous continue statement in parse_dt_topology()
    [01/04]
  - Remove 'cpu capacity scale management' and 'cpu capacity table'
    related comments [01/04]
  - Remove dt related patches [02-04/04]

Dietmar Eggemann (1):
  arm: topology: remove cpu_efficiency

 arch/arm/kernel/topology.c | 132 ++-------------------------------------------
 1 file changed, 4 insertions(+), 128 deletions(-)

-- 
2.11.0
