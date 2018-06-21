From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 21 Jun 2018 09:37:02 +0200
Subject: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the
 reset framework
Message-ID: <20180621073706.22812-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

These are the remaining patches that still need to be merged in order
to complete the conversion of the davinci dsp driver to using the reset
framework.

They apply on top of v4.18-rc1 with David Lechner's remaining patches
merged.

v1 -> v2:
- fixed the device tree patches the descriptions of which were mixed up
- return -EPROBE_DEFER from davinci-rproc's probe() if we can't get the
  reset provider, since it's possible that the lookup table was not yet
  registered
- made the local variable naming consistent in the davinci-rproc driver
- fixed a typo in PATCH 5/8

v2 -> v3:
- modify PATCH 1/8: drop the provider argument from the function adding
  lookup entries and instead pass the provider name to the RESET_LOOKUP
  macro, return -EPROBE_DEFER if we locate a correct lookup entry but
  cannot get the corresponding reset controller
- modify the reset lookup entry in psc-da850
- don't manually return -EPROBE_DEFER from davinci-rproc, instead don't
  emit an error message if devm_reset_control_get_exclusive() returns
  this error code

v3 -> v4:
- make index the second parameter in RESET_LOOKUP() (right after the
  provider name)

v4 -> v5:
- fix a bug where the dsp_reset object correctly stored in drproc struct

v5 -> v6:
- rebased on top of v4.17-rc1 and retested
- dropped patches that were applied during 4.17 merge window
- added relevant review and ack tags

v6 -> v7:
- rebased on top of v4.18-rc1 and dropped patches that were applied for
  v4.17

Bartosz Golaszewski (4):
  remoteproc/davinci: use the reset framework
  clk: davinci: kill davinci_clk_reset_assert/deassert()
  ARM: davinci: dts: make psc0 a reset provider
  ARM: davinci: dts: add a reset control to the dsp node

 arch/arm/boot/dts/da850.dtsi               |  2 ++
 arch/arm/mach-davinci/include/mach/clock.h | 21 -------------
 drivers/clk/davinci/psc.c                  | 18 ------------
 drivers/remoteproc/da8xx_remoteproc.c      | 34 ++++++++++++++++++----
 4 files changed, 31 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

-- 
2.17.1
