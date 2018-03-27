From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 27 Mar 2018 11:20:23 +0200
Subject: [PATCH v3 0/8] ARM: davinci: complete the conversion to using the
 reset framework
Message-ID: <20180327092031.11251-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series converts the only user of the handcoded, mach-specific reset
routines in the davinci platform to using the reset framework.

Patches 1-3 add necessary lookups/DT-properties.

Patches 4-6 fix issues found in the remoteproc davinci driver.

Patch 7 converts the davinci-rproc driver to the reset framework.

Patch 8 removes now dead code.

Philipp: it turned out that it's indeed better to use the reset
controller's device name for the entry lookup.

Tested both in DT and legacy modes by booting the examples from
ti-ipc-rtos recipe in meta-ti.

This series applies on top of David Lechner's common-clk-v9 branch[1]
with Philipp Zabel's reset/next branch[2] pulled in.

It can be found in my github tree as well[3].

[1] git://github.com/dlech/ev3dev-kernel.git common-clk-v9
[2] git://git.pengutronix.de/git/pza/linux reset/next
[3] git at github.com:brgl/linux.git topic/davinci-reset

v1 -> v2:
- fixed the device tree patches the descriptions of which were mixed up
- return -EPROBE_DEFER from davinci-rproc's probe() if we can't get the
  reset provider, since it's possible that the lookup table was not yet
  registered
- made the local variable naming consistent in the davinci-rproc driver
- fixed a typo in PATCH 5/8

v2 -> v3:
- reworded the commit messages (s/remoteproc: da8xx/remoteproc\/davinci/)
- call clk_disable_unprepare() if reset_control_deassert() fails in
  da8xx_rproc_start()
- added a patch fixing the S_IRUGO checkpatch warning, since we're
  already modifying this driver anyway
- added a temp variable for code brevity in da8xx_rproc_stop()
- removed patch 1/8 (already applied to reset/next)

Bartosz Golaszewski (8):
  ARM: davinci: dts: make psc0 a reset provider
  ARM: davinci: dts: add a reset control to the dsp node
  clk: davinci: add a reset lookup table for psc0
  remoteproc/davinci: add the missing retval check for clk_enable()
  remoteproc/davinci: prepare and unprepare the clock where needed
  remoteproc/davinci: use octal permissions for module_param()
  remoteproc/davinci: use the reset framework
  clk: davinci: kill davinci_clk_reset_assert/deassert()

 arch/arm/boot/dts/da850.dtsi               |  2 ++
 arch/arm/mach-davinci/include/mach/clock.h | 21 --------------
 drivers/clk/davinci/psc-da850.c            |  7 +++++
 drivers/clk/davinci/psc.c                  | 19 +------------
 drivers/remoteproc/da8xx_remoteproc.c      | 45 ++++++++++++++++++++++++------
 5 files changed, 47 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h

-- 
2.16.1
