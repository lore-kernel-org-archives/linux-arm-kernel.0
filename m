From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 18 Apr 2014 16:42:57 +0200
Subject: [PATCH 0/4] Fixes for DT CPU topology specification on Exynos
Message-ID: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to some parts of Exynos SoC support designed originally in a non-scalable
way, relying on 1:1 mapping between value returned by cpu_logical_map() and
CPU IDs as seen by PMU and GIC, trying to specify CPU topology in device tree
caused various boot-up issues on Exynos SoCs, ranging from CPUs other than 0
failing to boot to crashes due to GIC driver accessing registers out of range.

This series attempts to fix aforementioned issues by removing incorrect
assumptions from Exynos SoC core code and GIC driver and then adding CPU
topology data to device tree sources of Exynos4.

[On Exynos4210-based TRATS and Exynos4412-based TRATS2 board]
Tested-by: Tomasz Figa <t.figa@samsung.com>

Tomasz Figa (4):
  ARM: EXYNOS: Fix definitions of S5P_ARM_CORE_* registers
  ARM: EXYNOS: Fix core ID used by platsmp and hotplug code
  irqchip: gic: Add support for per CPU bank offset specification in DT
  ARM: dts: exynos4: Add CPU topology data

 Documentation/devicetree/bindings/arm/cpus.txt |  7 ++
 Documentation/devicetree/bindings/arm/gic.txt  | 34 +++++++++-
 arch/arm/boot/dts/exynos4210.dtsi              | 19 ++++++
 arch/arm/boot/dts/exynos4212.dtsi              | 19 ++++++
 arch/arm/boot/dts/exynos4412.dtsi              | 37 ++++++++--
 arch/arm/mach-exynos/hotplug.c                 | 10 +--
 arch/arm/mach-exynos/platsmp.c                 | 31 +++++----
 arch/arm/mach-exynos/regs-pmu.h                |  4 +-
 drivers/irqchip/irq-gic.c                      | 94 ++++++++++++++++++--------
 9 files changed, 202 insertions(+), 53 deletions(-)

-- 
1.9.2
