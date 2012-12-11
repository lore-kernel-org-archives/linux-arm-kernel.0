From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 11 Dec 2012 12:07:28 +0900
Subject: [PATCH 0/6 v3] ARM: mach-shmobile: kzm9g: Reference DT implementation
Message-ID: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this is a third pass at at providing a refernce DT implementation
for the kzm9g baord which is intended to act as a guide for mach-shmobile
developers.

It provides a minimal setup of the board using as little C code as
possible.

It may be used by selecting CONFIG_MACH_KZM9G_REFERENCE
and using sh73a0-kzm9g-reference.dtb

*** Please note that the clock initialisation shcheme used in
    this series does not currently work with SMP as there
    is a yet to be resolved lock-up in workqueue initialisation.

    Resolving this problem is currently regarded as future-work.

    CONFIG_SMP must be disabled when using this code. ***

Major difference between v2 and v3:
* Allow UP boot to complete by initialiing CMT earlier.
  This is achieved by changing the position of clocsources/
  in drivers/Makefile

Major difference between v1 and v2:
* Drop touchscreen initialisation, it requires INTC
* Drop SDHI initialisation, the driver seems to need some work
* Add extra entries to clock-sh73a0.c:lookups[] and
  remove auxdata. Ultimtely the clocks will be described
  in DT, but the code isn't there yet.
* Drop MMCIF patch, it is not needed if regulators are enabled
* Drop PCF hacks, instead, the series is based on Laruent Pinchart's *
* series: [PATCH v2 00/77] SH pin control and GPIO rework with OF support
* Use shmobile_setup_delay()

Git and diffstat information provided to aid review.

----------------------------------------------------------------
The following changes since commit 940956fe1d8de5cbcc963214fe592f76d8354bef:

  ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree (2012-11-27 00:59:10 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git devel/of-kzm9g

for you to fetch changes up to e64ad872028f921a7a30be325fbdecc725958b40:

  ARM: mach-shmobile: kzm9g: Reference DT implementation (2012-12-11 11:51:56 +0900)

----------------------------------------------------------------
Simon Horman (6):
      ARM: clocksource: Initialise early
      ARM: mach-shmobile: sh73a0: Allow initialisation of GIC by DT
      ARM: mach-shmobile: sh73a0: Minimal setup using DT
      ARM: mach-shmobile: sh73a0: Initialise MMCIF using DT
      ARM: mach-shmobile: kzm9g: use voltage regulators by default
      ARM: mach-shmobile: kzm9g: Reference DT implementation

 arch/arm/boot/dts/Makefile                     |    3 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   37 +++++++++
 arch/arm/boot/dts/sh73a0-reference.dtsi        |   24 ++++++
 arch/arm/boot/dts/sh73a0.dtsi                  |   69 +++++++++++++++++
 arch/arm/configs/kzm9g_defconfig               |    2 +
 arch/arm/mach-shmobile/Kconfig                 |   10 +++
 arch/arm/mach-shmobile/Makefile                |    1 +
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   99 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c          |   13 ++++
 arch/arm/mach-shmobile/include/mach/common.h   |    3 +
 arch/arm/mach-shmobile/intc-sh73a0.c           |   14 ++++
 arch/arm/mach-shmobile/setup-sh73a0.c          |   68 +++++++++++++++-
 drivers/Makefile                               |    8 +-
 13 files changed, 346 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 create mode 100644 arch/arm/boot/dts/sh73a0-reference.dtsi
 create mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c
