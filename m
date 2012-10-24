From: chanho61.park@samsung.com (Chanho Park)
Date: Wed, 24 Oct 2012 14:34:49 +0900
Subject: [PATCH v5 0/5] Add support to enable ARM PMU for EXYNOS
Message-ID: <1351056894-5790-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes irq numbers of ARM Performance Monitoring unit and enable
it for Perf(Performance Counter) on the exynos 4 and 5. The exynos4 and 5 have 2
more cpu cores which has its own pmu.

The exynos uses combiner-irq type for arm-pmu. Especially, the exynos4412 has 4
extra combined irq groups. So, we need to change a max combiner number and to
retreive it according to each soc types.

To enable perf, we need also to implement a set_irq_affinity function for the
combiner-irq. After applying this patch, we can use the perf for the exynos
machine.

Changes from v4:
 - Use max_combiner_nr() in combiner_cascade_irq
 - Add EXYNOS4412_MAX_COMBINER_NR to clarify a meaning
 - Change combiner_extra_irq to exynos4x12_combiner_extra_irq

Changes from v3:
 - Define max_combiner_nr according to soc types
 - Add armpmu dt binding for exynos4210
 - Clean up soc types comparison from v2

Changes from v2:
 - Convert to dt binding of exynos5250

Changes from v1:
 - Split arm-pmu init of exynos from plat-samsung
 - Correct combined irqs of exynos4412
 - Use soc_is_xxx function instead of CONFIG_XXX to identify dynamically

Chanho Park (5):
  ARM: EXYNOS: Add set_irq_affinity function for combiner_irq
  ARM: EXYNOS: Correct combined IRQs for exynos4
  ARM: EXYNOS: Enable PMUs for exynos4
  ARM: EXYNOS: Add arm-pmu DT binding for exynos5250
  ARM: EXYNOS: Add arm-pmu DT binding for exynos421x

 arch/arm/boot/dts/exynos4210.dtsi        |    6 ++
 arch/arm/boot/dts/exynos5250.dtsi        |    6 ++
 arch/arm/mach-exynos/common.c            |  108 +++++++++++++++++++++++++-----
 arch/arm/mach-exynos/include/mach/irqs.h |   13 +++-
 arch/arm/plat-samsung/devs.c             |    2 +-
 5 files changed, 113 insertions(+), 22 deletions(-)

-- 
1.7.9.5
