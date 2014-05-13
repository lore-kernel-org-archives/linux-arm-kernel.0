From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 13 May 2014 22:05:03 +0900
Subject: [PATCHv5 0/5] Support new Exynos3250 SoC based on Cortex-A7 dual core
Message-ID: <1399986308-23744-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset support new Exynos3250 Samsung SoC based on Cortex-A7 dual core.
Exynos3250 is a System-On-Chip (SoC) that is based on 32-bit RISC processor
for Smartphone. It is desigend with the 28nm low-power high-K metal gate process
and provides the best performance features.

This patchset include some patches such as:
- Support booting of Exynos3250
- Supoort uart/mct/adc/gic/i2c/spi/power-domain/pmu/mshc/pwm/amba
- Support the clock control for Exynos3250 using common clk framework

This patchset is based on following git repo/branch.
- git repo : git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
- branch   : for-next (2ca8b247775d7c24fa8c2524a5562bad7e88f84b)

Changes from v4:
- Rebase this patch on latest for-next branch in linux-samsung.git
- Post separated secondary CPU boot patch for Exynos4212 and merged it
 : https://lkml.org/lkml/2014/5/8/745
- Drop following patch[1] and use alternative patch[2] to turn off Cortex-A7
  [1] ARM: EXYNOS: Enter a15 lowpower mode for Exynos3250 based on Cortex-a7
  [2] http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg29064.html
- Modify clock driver of exynos3250
- Add 'soc' dt node and move all dt nodes under 'soc' dt node in exynos3250.dtsi
- Add missing CPU1 dt node in exynos3250.dtsi
- Fix minor issue about coding style

Changes from v3:
- Remove all dependency about following patchset to remove static memory
  mapping for SYSRAM[1] / PMU ([2] or [3]). If following patchset merged,
  I'll send a further patches to support SYSRAM/PMU for secondary CPU.
  [1] http://www.spinics.net/lists/arm-kernel/msg323011.html
  [2] https://lkml.org/lkml/2014/4/2/48
  [3] http://www.spinics.net/lists/arm-kernel/msg316013.html

Changes from v2:
- Remove static memory mapping about SYSRAM/PMU such as following patches:
  ARM: EXYNOS: Add IO mapping for non-secure SYSRAM of Exynos3250
  ARM: EXYNOS: Add IO mapping for PMU of Exynos3250
- Add description for secondary CPU boot of Exynos4212/Exynos3250
- Fix description in exynos_cpu_die() to remove particular SoC series
- Fix minor coding style
- Add documentation for Exynos3250 clock controller

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

Chanwoo Choi (3):
  ARM: EXYNOS: Add Exynos3250 SoC ID
  ARM: EXYNOS: Support secondary CPU boot of Exynos3250
  dt-bindings: add documentation for Exynos3250 clock controller

Tomasz Figa (2):
  clk: samsung: exynos3250: Add clocks using common clock framework
  ARM: dts: Add device tree sources for Exynos3250

 .../devicetree/bindings/clock/exynos3250-clock.txt |  41 ++
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 475 +++++++++++++
 arch/arm/boot/dts/exynos3250.dtsi                  | 439 ++++++++++++
 arch/arm/mach-exynos/Kconfig                       |  22 +
 arch/arm/mach-exynos/common.h                      |  10 +
 arch/arm/mach-exynos/exynos.c                      |   2 +
 arch/arm/mach-exynos/firmware.c                    |   9 +-
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-exynos3250.c               | 782 +++++++++++++++++++++
 include/dt-bindings/clock/exynos3250.h             | 258 +++++++
 10 files changed, 2038 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos3250-clock.txt
 create mode 100644 arch/arm/boot/dts/exynos3250-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos3250.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos3250.c
 create mode 100644 include/dt-bindings/clock/exynos3250.h

-- 
1.8.0
