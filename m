From: horms@verge.net.au (Simon Horman)
Date: Fri, 30 Nov 2012 17:44:40 +0900
Subject: [PATCH 0/7 v2] ARM: mach-shmobile: kzm9g: Reference DT implementation
Message-ID: <1354265085-2444-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


*** This series is wip and does not currently function
    I am posting to provide a status update and ask for help ***

this is a second pass at at providing a refernce DT implementation
for the kzm9g baord which is intended to act as a guide for mach-shmobile
developers.

Major difference to v1:

* Drop touchscreen initialisation, it requires INTC
* Drop SDHI initialisation, the driver seems to need some work
* Add extra entries to clock-sh73a0.c:lookups[] and
  remove auxdata. Ultimtely the clocks will be described
  in DT, but the code isn't there yet.
* Drop MMCIF patch, it is not needed if regulators are enabled
* Drop PCF hacks, instead, the series is based on Laruent Pinchart's * series:
  [PATCH v2 00/77] SH pin control and GPIO rework with OF support
* Use shmobile_setup_delay()


Unfortunately the last point seems to introduce problems.
It seems to prevent SMP from booting to the point of printing
anything on the early console. And with CONFIG_SMP disabled
the boot halts when the MMCIF driver initialisation calls mmc_delay().

I've poked around a bit but I haven't had any luck working out
why this is the case. I would appreciate any pointers on what to
investigate.

Git and diffstat information provided to aid review.


----------------------------------------------------------------
The following changes since commit 940956fe1d8de5cbcc963214fe592f76d8354bef:

  ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree (2012-11-27 00:59:10 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git devel/of-kzm9g

for you to fetch changes up to 7018db4354c445d401782dc38df5e2d8afb43bc2:

  ARM: mach-shmobile: kzm9g: Reference DT implementation (2012-11-30 16:55:46 +0900)

----------------------------------------------------------------
Simon Horman (5):
      ARM: mach-shmobile: sh73a0: Allow initialisation of GIC by DT
      ARM: mach-shmobile: sh73a0: Minimal setup using DT
      ARM: mach-shmobile: sh73a0: Initialise MMCIF using DT
      ARM: shmobile: kzm9g: use voltage regulators by default
      ARM: mach-shmobile: kzm9g: Reference DT implementation

 arch/arm/boot/dts/Makefile                     |    3 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   37 ++++++++++
 arch/arm/boot/dts/sh73a0-reference.dtsi        |   24 +++++++
 arch/arm/boot/dts/sh73a0.dtsi                  |   69 ++++++++++++++++++
 arch/arm/configs/kzm9g_defconfig               |    1 +
 arch/arm/mach-shmobile/Kconfig                 |   10 +++
 arch/arm/mach-shmobile/Makefile                |    8 ++-
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   92 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c          |    6 ++
 arch/arm/mach-shmobile/include/mach/common.h   |    3 +
 arch/arm/mach-shmobile/intc-sh73a0.c           |   14 ++++
 arch/arm/mach-shmobile/setup-sh73a0.c          |   39 +++++++++-
 12 files changed, 303 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 create mode 100644 arch/arm/boot/dts/sh73a0-reference.dtsi
 create mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c
