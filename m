From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 18 Aug 2017 12:10:46 +0200
Subject: [GIT PULL] Reset controller changes for v4.14
Message-ID: <1503051046.7730.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

please consider merging this tag for v4.14. It contains a new HSDKv1
reset driver, updates and fixes for the uniphier driver, a reset array
API to handle a number of resets together, and removes the Gemini reset
driver, which is replaced by a combined clock/reset driver in
drivers/clk.

regards
Philipp

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux tags/reset-for-4.14

for you to fetch changes up to ac0c735ac3dd6697055299cac01617527aa6a695:

  reset: uniphier: add analog amplifiers reset control (2017-08-14 09:29:47 +0200)

----------------------------------------------------------------
Reset controller changes for v4.14

- constify zx2967 reset_ops
- add a convenience API to manage an array of resets
- let deassert report success and let assert report success for shared resets
  if the reset controller driver does not implement (de)assert.
- add HSDKv1 reset driver
- remove Gemini reset controller, the driver is made obsolete
  by a combined clock/reset driver in drivers/clk
- fix the total number of reset lines in the sunxi driver
- various uniphier updates and fixes:
  - remove sLD3 SoC support
  - simplify system reset register and bit definitions
  - add audio systems, video input subsystem, and analog amplifiers reset
    controls

----------------------------------------------------------------
Arvind Yadav (1):
      reset: zx2967: constify zx2967_reset_ops.

Eugeniy Paltsev (1):
      ARC: reset: introduce HSDKv1 reset driver

Katsuhiro Suzuki (3):
      reset: uniphier: add audio systems reset control
      reset: uniphier: add video input subsystem reset control
      reset: uniphier: add analog amplifiers reset control

Linus Walleij (1):
      Revert "reset: Add a Gemini reset controller"

Masahiro Yamada (2):
      reset: uniphier: remove sLD3 SoC support
      reset: uniphier: do not use per-SoC macro for system reset block

Philipp Zabel (2):
      reset: make (de)assert report success for self-deasserting reset drivers
      reset: sunxi: fix number of reset lines

Vivek Gautam (1):
      reset: Add APIs to manage array of resets

 .../devicetree/bindings/reset/uniphier-reset.txt   |  27 ++-
 MAINTAINERS                                        |   7 +
 drivers/reset/Kconfig                              |   9 +-
 drivers/reset/Makefile                             |   2 +-
 drivers/reset/core.c                               | 238 ++++++++++++++++++++-
 drivers/reset/reset-gemini.c                       | 110 ----------
 drivers/reset/reset-hsdk-v1.c                      | 137 ++++++++++++
 drivers/reset/reset-sunxi.c                        |   4 +-
 drivers/reset/reset-uniphier.c                     | 117 +++++-----
 drivers/reset/reset-zx2967.c                       |   2 +-
 include/dt-bindings/reset/snps,hsdk-v1-reset.h     |  17 ++
 include/linux/reset.h                              |  68 ++++++
 12 files changed, 547 insertions(+), 191 deletions(-)
 delete mode 100644 drivers/reset/reset-gemini.c
 create mode 100644 drivers/reset/reset-hsdk-v1.c
 create mode 100644 include/dt-bindings/reset/snps,hsdk-v1-reset.h
