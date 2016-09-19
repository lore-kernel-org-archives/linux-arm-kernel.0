From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 04:36:28 +0300
Subject: [PATCH 00/19] ARM: imx legacy: move peripheral initializations to
 .init_late
Message-ID: <1474248988-10626-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series moves registrations and initializations of all peripherals
which are GPIO line consumers for all legacy (prior to DT) i.MX powered
boards from .init_machine to .init_late init level. This is needed to
proactively prevent boot time issues on the legacy boards due to the
deprioritized init level of the GPIO controller driver (set lower than
IOMUX controller driver init level), which is shared among all i.MX
SoCs. The problem was reported and discussed on

  https://lkml.org/lkml/2016/9/13/810

The changes are based on v4.8.0-rc1, please let me know if the series
should be rebased or squashed. Some of the changes are quite simple,
e.g. a one line change for qong board, and some of them are more
sophisticated, thus to simplify review process and potential creation
of revert commits the changes are split into separate patches one per
board.

Uwe suggested to add necessary error checks for all gpio_request()
calls, which are missing on kzm, mx27-3ds, mx31lilly, mx31lite,
mx31moboard, mx35-3ds and pca100 targets, this is out of the scope
of this change, which is intended to move some registration and
initialization calls only from one place to another. Adding error
checks can be done later on, however for example -EPROBE_DEFER errors
won't be handled as expected, because .init_machine and .init_late
callbacks are one-shot.

Only two legacy targets are tested, i.MX31 kzm qemu machine and
changes for i.MX31 powered Logic PD mx31lite board. The rest of
the legacy boards are compilation tested only, probably some of
the proposed changes are excessive or may be insufficient.

Vladimir Zapolskiy (19):
  ARM: imx legacy: kzm: move peripheral initialization to .init_late
  ARM: imx legacy: mx31lite: move peripheral initialization to .init_late
  ARM: imx legacy: mx31ads: move peripheral initialization to .init_late
  ARM: imx legacy: mx31lilly: move peripheral initialization to .init_late
  ARM: imx legacy: pcm037: move peripheral initialization to .init_late
  ARM: imx legacy: mx31-3ds: move peripheral initialization to .init_late
  ARM: imx legacy: qong: move peripheral initialization to .init_late
  ARM: imx legacy: armadillo5x0: move peripheral initialization to .init_late
  ARM: imx legacy: mx31moboard: move peripheral initialization to .init_late
  ARM: imx legacy: vpr200: move peripheral initialization to .init_late
  ARM: imx legacy: imx27-visstrim-m10: move peripheral initialization to .init_late
  ARM: imx legacy: mx27-3ds: move peripheral initialization to .init_late
  ARM: imx legacy: mx35-3ds: move peripheral initialization to .init_late
  ARM: imx legacy: apf9328: move peripheral initialization to .init_late
  ARM: imx legacy: scb9328: move peripheral initialization to .init_late
  ARM: imx legacy: pcm043: move peripheral initialization to .init_late
  ARM: imx legacy: mx21ads: move peripheral initialization to .init_late
  ARM: imx legacy: mx27ads: move peripheral initialization to .init_late
  ARM: imx legacy: pca100: move peripheral initialization to .init_late

 arch/arm/mach-imx/mach-apf9328.c            |  6 ++-
 arch/arm/mach-imx/mach-armadillo5x0.c       | 39 ++++++++++-------
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c | 24 +++++++---
 arch/arm/mach-imx/mach-kzm_arm11_01.c       |  9 +++-
 arch/arm/mach-imx/mach-mx21ads.c            | 13 ++++--
 arch/arm/mach-imx/mach-mx27_3ds.c           | 30 ++++++++-----
 arch/arm/mach-imx/mach-mx27ads.c            | 13 ++++--
 arch/arm/mach-imx/mach-mx31_3ds.c           | 39 ++++++++++-------
 arch/arm/mach-imx/mach-mx31ads.c            | 18 ++++----
 arch/arm/mach-imx/mach-mx31lilly.c          | 50 +++++++++++++++------
 arch/arm/mach-imx/mach-mx31lite.c           | 68 ++++++++++++++++++++---------
 arch/arm/mach-imx/mach-mx31moboard.c        | 23 ++++++----
 arch/arm/mach-imx/mach-mx35_3ds.c           | 15 ++++---
 arch/arm/mach-imx/mach-pca100.c             | 26 ++++++-----
 arch/arm/mach-imx/mach-pcm037.c             | 67 ++++++++++++++--------------
 arch/arm/mach-imx/mach-pcm043.c             | 10 ++++-
 arch/arm/mach-imx/mach-qong.c               |  2 +-
 arch/arm/mach-imx/mach-scb9328.c            |  7 ++-
 arch/arm/mach-imx/mach-vpr200.c             | 29 +++++++-----
 arch/arm/mach-imx/mx31lilly-db.c            | 20 ---------
 arch/arm/mach-imx/mx31lite-db.c             | 33 --------------
 21 files changed, 312 insertions(+), 229 deletions(-)

-- 
2.8.1
