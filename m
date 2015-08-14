From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Aug 2015 11:09:21 -0500
Subject: [GIT PULL] SA1100/PXA RTC for 4.3
Message-ID: <CAL_JsqKMN1SEQoJRSPixih4ckDh1pGb4x3T_t+2oWVvW8fqzmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre,

Please pull SA1100/PXA changes for 4.3. This series has had several
rounds of review over several months without comment from PXA
maintainers other than Robert.

Rob

The following changes since commit 52721d9d3334c1cb1f76219a161084094ec634dc:

  Linux 4.2-rc3 (2015-07-19 14:45:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/pxa-rtc-for-4.3

for you to fetch changes up to e473ff0fe8548941ef67bf956a6b7943f4663ab1:

  ARM: config: Switch PXA27x platforms to use PXA RTC driver
(2015-08-14 10:53:44 -0500)

----------------------------------------------------------------
SA1100 and PXA RTC clean-ups

This series enables building the SA1100 RTC driver for ARM64 in
preparation for enabling CONFIG_ARCH_MMP on ARM64. This is needed for
supporting the PXA1928 SOC. Clean-up of SA1100 RTC is complicated by the
fact that some PXA chips use both sa1100-rtc and pxa-rtc drivers and
share the same registers. This does not work well with the Linux driver
model. So the first step is removing this sharing by the 2 drivers and
making sa1100-rtc and pxa-rtc mutually exclusive.

----------------------------------------------------------------
Rob Herring (7):
      rtc: sa1100: prepare to share sa1100_rtc_ops
      rtc: pxa: convert to use shared sa1100 functions
      ARM: pxa: add memory resource to SA1100 RTC device
      rtc: sa1100/pxa: convert to run-time register mapping
      ARM: sa1100: remove unused RTC register definitions
      ARM: mmp: remove unused RTC register definitions
      ARM: config: Switch PXA27x platforms to use PXA RTC driver

 arch/arm/configs/cm_x2xx_defconfig          |   2 +-
 arch/arm/configs/em_x270_defconfig          |   2 +-
 arch/arm/configs/magician_defconfig         |   2 +-
 arch/arm/configs/palmz72_defconfig          |   2 +-
 arch/arm/configs/pcm027_defconfig           |   2 +-
 arch/arm/configs/trizeps4_defconfig         |   2 +-
 arch/arm/mach-mmp/include/mach/regs-rtc.h   |  23 -----
 arch/arm/mach-pxa/devices.c                 |  18 +---
 arch/arm/mach-pxa/pxa27x.c                  |   1 -
 arch/arm/mach-pxa/pxa3xx.c                  |   1 -
 arch/arm/mach-sa1100/include/mach/SA-1100.h |  34 -------
 drivers/rtc/Kconfig                         |  12 ++-
 drivers/rtc/rtc-pxa.c                       |  55 +++++------
 drivers/rtc/rtc-sa1100.c                    | 139 +++++++++++++++++-----------
 drivers/rtc/rtc-sa1100.h                    |  23 +++++
 15 files changed, 150 insertions(+), 168 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h
 create mode 100644 drivers/rtc/rtc-sa1100.h
