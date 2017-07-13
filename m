From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Jul 2017 12:31:07 +0200
Subject: [PATCH v3 0/6] SMP and CPU hotplug support for Meson8/Meson8b
Message-ID: <20170713103113.21560-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for booting the secondary CPU cores (and
taking them offline again) on Amlogic Meson8 and Meson8b SoCs.
It is based on an earlier version from Carlo Caione - this helped me
a lot to get a better understanding of how SMP/CPU hotplug works
(compared to the code found in Amlogic's GPL kernel sources from
year 2015).


The .dts changes from series depend on:
- "add the reset controller to the Meson8b clkc", see [1]
- "ARM: dts: meson: add a node which describes the SRAM", see [2]


Changes since v2 from [0]
- added support for Meson8 (which requires a slightly different
  enable-method)
- implemented CPU hotplug support which allows taking a CPU core
  offline for both, Meson8 and Meson8b
- add a function to smp_scu.c which allows enabling a CPU core from
  a different CPU (previously only the power mode for the current CPU
  could be changed). Without this the CPU cores on Meson8 won't come
  up (Amlogic's vendor GPL kernel sources also enable power through
  SCU as very first step for Meson8b as well)
- add a function to smp_scu.c to get the power status of a CPU core
  (which is needed because the code in .cpu_kill needs to wait until
  the core is actually powered off)
- dropped patch "ARM: DTS: meson8b: Extend L2 cache controller node"
  as it is already applied (for both, Meson8 and Meson8b)
- dropped the patches which implement the reset controller which is
  built into the clock-controller, these are a separate series: [1]
- moved the enable-method property to each CPU node


[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390355.html
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004283.html
[2] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004282.html


Carlo Caione (2):
  dt-bindings: Amlogic: Add Meson8 and Meson8b SMP related documentation
  ARM: dts: meson8b: add support for booting the secondary CPU cores

Martin Blumenstingl (4):
  ARM: smp_scu: add a helper for powering on a specific CPU
  ARM: smp_scu: allow the platform code to read the SCU CPU status
  ARM: meson: Add SMP bringup code for Meson8 and Meson8b
  ARM: dts: meson8: add support for booting the secondary CPU cores

 .../devicetree/bindings/arm/amlogic/pmu.txt        |  18 +
 .../devicetree/bindings/arm/amlogic/smp-sram.txt   |  32 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/meson8.dtsi                      |  20 +
 arch/arm/boot/dts/meson8b.dtsi                     |  20 +
 arch/arm/include/asm/smp_scu.h                     |  12 +
 arch/arm/kernel/smp_scu.c                          |  47 +-
 arch/arm/mach-meson/Kconfig                        |   1 +
 arch/arm/mach-meson/Makefile                       |   1 +
 arch/arm/mach-meson/platsmp.c                      | 502 +++++++++++++++++++++
 11 files changed, 650 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
 create mode 100644 arch/arm/mach-meson/platsmp.c

-- 
2.13.2
