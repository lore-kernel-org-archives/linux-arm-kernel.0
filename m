From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 17 Apr 2018 19:30:31 +0200
Subject: [PATCH v6 0/7] ARM: davinci: complete the conversion to using the
 reset framework
Message-ID: <20180417173038.25510-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series converts the only user of the handcoded, mach-specific reset
routines in the davinci platform to using the reset framework.

Patches 1-2 add necessary lookups/DT-properties.

Patches 3-5 fix issues found in the remoteproc davinci driver.

Patch 6 converts the davinci-rproc driver to the reset framework.

Patch 7 removes now dead code.

Tested both in DT and legacy modes by booting the examples from
ti-ipc-rtos recipe in meta-ti.

This series applies on top of David Lechner's common-clk-v9 branch[1].

[1] git://github.com/dlech/ev3dev-kernel.git common-clk-v9

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

Bartosz Golaszewski (7):
  ARM: davinci: dts: make psc0 a reset provider
  ARM: davinci: dts: add a reset control to the dsp node
  remoteproc/davinci: add the missing retval check for clk_enable()
  remoteproc/davinci: prepare and unprepare the clock where needed
  remoteproc/davinci: use octal permissions for module_param()
  remoteproc/davinci: use the reset framework
  clk: davinci: kill davinci_clk_reset_assert/deassert()

 arch/arm/boot/dts/da850.dtsi               |  2 +
 arch/arm/mach-davinci/include/mach/clock.h | 21 ----------
 drivers/clk/davinci/psc.c                  | 18 ---------
 drivers/remoteproc/da8xx_remoteproc.c      | 46 ++++++++++++++++++----
 4 files changed, 40 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

-- 
2.17.0
