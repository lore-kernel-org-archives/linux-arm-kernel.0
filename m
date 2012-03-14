From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 14 Mar 2012 16:56:23 +0100
Subject: [PATCH v4 00/10] Add PWM framework and device tree support.
Message-ID: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds very rudimentary device-tree support for PWM
devices. With all of these patches applied (plus one board-specific
patch that is not included), I'm able to control the backlight on the
device I'm working on using the sysfs interface provided by the pwm-bl
driver and the backlight class.

This series is based on Sascha Hauer's series of patches[0] to add a
generic PWM framework. The first patch in this series is taken from
Sascha's branch, while the second patch enables each PWM chip to provide
multiple PWM devices (the Blackfin and PXA drivers have been ported to
the framework for reference). Currently a global namespace is still
provided to keep backwards-compatibility with the legacy PWM API. In
order to achieve this, the number of global PWM devices is limited to
1024. However, patch 2 introduces per-chip indexing of PWM devices in
the core and adds an API to request a PWM device given the PWM chip or
the struct device associated with a PWM chip. They are supposed to
eventually replace pwm_request() and allow to get rid of the global
namespace. The device tree support code does not use the global
namespace.

Patch 3 adds some code to lookup a PWM chip given its device-tree
handle. This code will be used later on by the pwm-bl driver to find the
PWM device that it should be using. If the no corresponding PWM chip is
available yet, the code returns EPROBE_DEFER to have users automatically
probed again later when the PWM provider may have become available.
Device tree binding documentation is also provided.

Patch 4 was taken from the Chromium tree and is required to provide
proper clocking of the Tegra2 PWFM controller. All Chromium-specific
tags have been removed from the commit message. Some cleanup of the
clock registration for Tegra is done in patch 5 because a subsequent
patch will instantiate one PWFM controller device instead of four.

Patch 6 adds a generic PWM framework driver for the Tegra2 PWFM
controller. The code is taken from the Chromium tree with some
adjustments to integrate it with the PWM framework. Device tree based
probing of the driver is implemented in patch 7.

Patches 8 and 9 are ports of the Blackfin PWM and the PXA PWM drivers to
the PWM framework. These are only compile-tested as I do not have any
hardware to test them on. They are meant as test-bed for the framework.
Sascha already has patches that port all in-tree drivers to the
framework and will rebase them on top of this series when it is ready.

Patch 10 implements DT-based probing in the pwm-backlight driver. Note
that this code only handles the "pwm" property (by looking up the PWM
device via the new PWM DT binding). Switching power to the backlight via
GPIOs is not supported yet. The DT binding also deviates from the
platform data in that it requires a list of brightness levels to be
specified instead of assuming a linearily spaced range from 0 to a given
maximum brightness.

The whole series is based on the linux-next tree from 20120314. I think
I've addressed all of the concerns raised in the first three versions.

Thierry

[0]: http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/pwmlib

Sascha Hauer (1):
  PWM: add pwm framework support

Simon Que (1):
  ARM: tegra: Fix PWM clock programming

Thierry Reding (8):
  pwm: Allow chips to support multiple PWMs.
  pwm: Add device tree support
  ARM: tegra: Provide clock for only one PWM controller
  pwm: Add NVIDIA Tegra SoC support
  pwm: tegra: Add device tree support
  pwm: Add Blackfin support
  pwm: Add PXA support
  pwm-backlight: Add rudimentary device tree support

 Documentation/devicetree/bindings/pwm/pwm.txt      |   48 ++
 .../devicetree/bindings/pwm/tegra-pwm.txt          |   18 +
 .../bindings/video/backlight/pwm-backlight         |   19 +
 Documentation/pwm.txt                              |   56 ++
 MAINTAINERS                                        |    6 +
 arch/arm/boot/dts/tegra20.dtsi                     |    6 +
 arch/arm/boot/dts/tegra30.dtsi                     |    6 +
 arch/arm/mach-tegra/board-dt-tegra20.c             |    1 +
 arch/arm/mach-tegra/board-dt-tegra30.c             |    3 +
 arch/arm/mach-tegra/tegra2_clocks.c                |   37 +-
 arch/arm/plat-pxa/Makefile                         |    1 -
 arch/arm/plat-pxa/pwm.c                            |  304 -----------
 arch/blackfin/Kconfig                              |   10 -
 arch/blackfin/kernel/Makefile                      |    1 -
 arch/blackfin/kernel/pwm.c                         |  100 ----
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/of/Kconfig                                 |    6 +
 drivers/pwm/Kconfig                                |   40 ++
 drivers/pwm/Makefile                               |    4 +
 drivers/pwm/core.c                                 |  557 ++++++++++++++++++++
 drivers/pwm/pwm-bfin.c                             |  164 ++++++
 drivers/pwm/pwm-pxa.c                              |  244 +++++++++
 drivers/pwm/pwm-tegra.c                            |  267 ++++++++++
 drivers/video/backlight/Kconfig                    |    2 +-
 drivers/video/backlight/pwm_bl.c                   |  136 ++++-
 include/linux/of_pwm.h                             |   36 ++
 include/linux/pwm.h                                |   97 ++++
 include/linux/pwm_backlight.h                      |    2 +
 29 files changed, 1732 insertions(+), 442 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/tegra-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/video/backlight/pwm-backlight
 create mode 100644 Documentation/pwm.txt
 delete mode 100644 arch/arm/plat-pxa/pwm.c
 delete mode 100644 arch/blackfin/kernel/pwm.c
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/core.c
 create mode 100644 drivers/pwm/pwm-bfin.c
 create mode 100644 drivers/pwm/pwm-pxa.c
 create mode 100644 drivers/pwm/pwm-tegra.c
 create mode 100644 include/linux/of_pwm.h

-- 
1.7.9.4
