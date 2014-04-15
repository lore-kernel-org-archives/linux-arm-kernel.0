From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Apr 2014 10:59:44 +0900
Subject: [PATCHv2 0/8] Support new Exynos3250 SoC based on Cortex-A7 dual core
Message-ID: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset support new Exynos3250 Samsung SoC based on Cortex-A7 dual core.
Exynos3250 is a System-On-Chip (SoC) that is based on 32-bit RISC processor
for Smartphone. It is desigend with the 28nm low-power high-K metal gate process
and provides the best performance features.

This patchset include some patches such as:
- Support secondary CPU of Exynos3250 (cpu up/down)
- Supoort uart/mct/adc/gic/i2c/spi/power-domain/pmu/mshc/pwm/amba
- Support the clock control for Exynos3250 using common clk framework

This patchset is completely tested and is based on following git repo/branch.
- git repo : git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
- branch   : for-next (Linux 3.15-rc1)

Additional patch description about static memory mapping:
Arnd Bergmann suggested that need proper driver instead of static memory mapping.
As Chanho Park reply[2], Sachin Kamat already posted the DT support patch[1]
for memory mapping for SYSRAM.
[1] http://www.spinics.net/lists/linux-samsung-soc/msg27647.html
[2] https://lkml.org/lkml/2014/4/10/161

So, I'm going to re-implement following patches related to static memory mapping
after merged Sachin Kamat patch[1].
  ARM: EXYNOS: Add IO mapping for non-secure SYSRAM of Exynos3250
  ARM: EXYNOS: Add IO mapping for PMU of Exynos3250

Changes from v1:
- Add new "samsung,exynos3" compatible name
- Add comment about exynos_cpu_boot in Exynos4212
- Remove unnecessary 'goto' statement in firmware.c
- Use read_cpuid_part_number() function instead of assembler directly
- Post separated pinctrl patch from this patchset
  : https://lkml.org/lkml/2014/4/13/156
- Remove unused pmu interrupts due to Exynos3250 dual-core
- Cosolidate all the patches related to exynos3250.dtsi into one patch
- Fix gic compatible name to "cortex-a15-gic" because Cortex-A7 GIC is same
- Add sign-off of sender to all this patches
- Fix minor typo

Chanwoo Choi (5):
  ARM: EXYNOS: Add Exynos3250 SoC ID
  ARM: EXYNOS: Add IO mapping for non-secure SYSRAM of Exynos3250
  ARM: EXYNOS: Add IO mapping for PMU of Exynos3250
  ARM: EXYNOS: Support secondary CPU boot of Exynos3250
  ARM: EXYNOS: Enter a15 lowpower mode for Exynos3250 based on Cortex-a7

Kyungmin Park (1):
  ARM: EXYNOS: Support secondary CPU boot of Exynos4212

Tomasz Figa (2):
  clk: samsung: exynos3250: Add clocks using common clock framework
  ARM: dts: Add device tree sources for Exynos3250

 arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 477 ++++++++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi         | 410 ++++++++++++++++
 arch/arm/mach-exynos/Kconfig              |  22 +
 arch/arm/mach-exynos/exynos.c             |  19 +
 arch/arm/mach-exynos/firmware.c           |  18 +-
 arch/arm/mach-exynos/hotplug.c            |  16 +-
 arch/arm/mach-exynos/include/mach/map.h   |   2 +
 arch/arm/plat-samsung/include/plat/cpu.h  |  10 +
 drivers/clk/samsung/Makefile              |   1 +
 drivers/clk/samsung/clk-exynos3250.c      | 785 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos3250.h    | 256 ++++++++++
 11 files changed, 2010 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos3250-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos3250.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos3250.c
 create mode 100644 include/dt-bindings/clock/exynos3250.h

-- 
1.8.0
