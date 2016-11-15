From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 15 Nov 2016 20:23:35 +0100
Subject: [GIT PULL] Reset controller changes for v4.10
Message-ID: <1479237815.2456.59.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

Please consider merging this tag which adds OX820 support, removes
unused modular code and obsolete STiH41[56] support, and adds support
for multiple devices sharing a pulsed reset, as long as their
requirement is just being reset once, some time before use.

regards
Philipp

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.10

for you to fetch changes up to 7da33a37b48f11ffcb4a718f29a3d4552423fea1:

  reset: allow using reset_control_reset with shared reset (2016-11-14 09:58:28 +0100)

----------------------------------------------------------------
Reset controller changes for v4.10

- remove obsolete STiH41[56] platform support
- add Oxford Semiconductor OX820 support
- add reset index include files for OX810SE and OX820
- make drivers with boolean Kconfig options explicitly
  non-modular
- allow shared pulsed resets via reset_control_reset, which
  in this case means that the reset must have been triggered
  once, but possibly earlier, after the function returns, and
  is never triggered again for the lifetime of the reset
  control

----------------------------------------------------------------
Martin Blumenstingl (1):
      reset: allow using reset_control_reset with shared resetany 

Neil Armstrong (3):
      reset: oxnas: Add OX820 support
      dt-bindings: reset: oxnas: Add include file with reset indexes
      dt-bindings: reset: oxnas: Update for OX820

Paul Gortmaker (5):
      reset: berlin: make it explicitly non-modular
      reset: socfpga: make it explicitly non-modular
      reset: sunxi: make it explicitly non-modular
      reset: zynq: make it explicitly non-modular
      reset: lpc18xx: make it explicitly non-modular

Peter Griffin (2):
      reset: sti: Remove STiH415/6 reset support
      reset: sti: softreset: Remove obsolete platforms from dt binding doc.

 .../devicetree/bindings/reset/oxnas,reset.txt      |  44 ++-----
 .../devicetree/bindings/reset/st,sti-softreset.txt |   8 +-
 arch/arm/mach-sti/Kconfig                          |   2 -
 drivers/reset/core.c                               |  43 ++++++-
 drivers/reset/reset-berlin.c                       |  12 +-
 drivers/reset/reset-lpc18xx.c                      |  32 +----
 drivers/reset/reset-oxnas.c                        |   1 +
 drivers/reset/reset-socfpga.c                      |  10 +-
 drivers/reset/reset-sunxi.c                        |   9 +-
 drivers/reset/reset-zynq.c                         |  10 +-
 drivers/reset/sti/Kconfig                          |   8 --
 drivers/reset/sti/Makefile                         |   2 -
 drivers/reset/sti/reset-stih415.c                  | 112 ----------------
 drivers/reset/sti/reset-stih416.c                  | 143 ---------------------
 include/dt-bindings/reset/oxsemi,ox810se.h         |  53 ++++++++
 include/dt-bindings/reset/oxsemi,ox820.h           |  53 ++++++++
 16 files changed, 175 insertions(+), 367 deletions(-)
 delete mode 100644 drivers/reset/sti/reset-stih415.c
 delete mode 100644 drivers/reset/sti/reset-stih416.c
 create mode 100644 include/dt-bindings/reset/oxsemi,ox810se.h
 create mode 100644 include/dt-bindings/reset/oxsemi,ox820.h
