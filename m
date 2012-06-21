From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 21 Jun 2012 10:36:51 +0200
Subject: [GIT PULL] PWM subsystem
Message-ID: <20120621083650.GA2529@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

The PWM subsystem patches have gone through a number of versions now and
all outstanding issues have been resolved. I believe that the subsystem
is ready for broader testing in linux-next. If all goes well I plan to
submit it to Linus during the 3.6 merge window.

I am not aware of any dependencies in linux-next. The two patches that
don't touch the PWM subsystem itself are OF related and have been acked
by Rob Herring who prefers that I take them through the PWM tree.

Please contact me if there are any issues with the tree.

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:

  git://gitorious.org/linux-pwm/linux-pwm.git for-next

for you to fetch changes up to b5156ca503f9471449b941364bb2bc34fa355d5d:

  pwm: Take over maintainership of the PWM subsystem (2012-06-15 12:57:07 +0200)

----------------------------------------------------------------
Sascha Hauer (4):
      pwm: Add PWM framework support
      ARM i.MX: Move i.MX pwm driver to pwm framework
      ARM Samsung: Move s3c pwm driver to pwm framework
      ARM vt8500: Move vt8500 pwm driver to pwm framework

Shawn Guo (1):
      pwm: add pwm-mxs support

Simon Que (1):
      ARM: tegra: Fix PWM clock programming

Thierry Reding (13):
      pwm: Allow chips to support multiple PWMs
      pwm: Add debugfs interface
      pwm: Add table-based lookup for static mappings
      dt: Add empty of_property_match_string() function
      dt: Add empty of_parse_phandle_with_args() function
      pwm: Add device tree support
      ARM: tegra: Provide clock for only one PWM controller
      pwm: Add NVIDIA Tegra SoC support
      pwm: tegra: Add device tree support
      pwm: Move Blackfin PWM driver to PWM framework
      pwm: Move PXA PWM driver to PWM framework
      pwm-backlight: Add rudimentary device tree support
      pwm: Take over maintainership of the PWM subsystem

 Documentation/devicetree/bindings/pwm/mxs-pwm.txt  |   17 +
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |   18 +
 Documentation/devicetree/bindings/pwm/pwm.txt      |   57 ++
 .../bindings/video/backlight/pwm-backlight         |   28 +
 Documentation/pwm.txt                              |   76 +++
 MAINTAINERS                                        |   12 +
 arch/arm/boot/dts/tegra20.dtsi                     |    6 +
 arch/arm/boot/dts/tegra30.dtsi                     |    6 +
 arch/arm/mach-tegra/board-dt-tegra20.c             |    1 +
 arch/arm/mach-tegra/board-dt-tegra30.c             |    3 +
 arch/arm/mach-tegra/tegra2_clocks.c                |   36 +-
 arch/arm/mach-tegra/tegra30_clocks.c               |    6 +-
 arch/arm/mach-vt8500/Makefile                      |    2 -
 arch/arm/plat-mxc/Kconfig                          |    6 -
 arch/arm/plat-mxc/Makefile                         |    1 -
 arch/arm/plat-pxa/Makefile                         |    1 -
 arch/arm/plat-samsung/Makefile                     |    4 -
 arch/blackfin/Kconfig                              |   10 -
 arch/blackfin/kernel/Makefile                      |    1 -
 arch/blackfin/kernel/pwm.c                         |  100 ---
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/pwm/Kconfig                                |   76 +++
 drivers/pwm/Makefile                               |    8 +
 drivers/pwm/core.c                                 |  713 ++++++++++++++++++++
 drivers/pwm/pwm-bfin.c                             |  164 +++++
 arch/arm/plat-mxc/pwm.c => drivers/pwm/pwm-imx.c   |  183 ++---
 drivers/pwm/pwm-mxs.c                              |  207 ++++++
 arch/arm/plat-pxa/pwm.c => drivers/pwm/pwm-pxa.c   |  172 ++---
 .../pwm.c => drivers/pwm/pwm-samsung.c             |  230 +++----
 drivers/pwm/pwm-tegra.c                            |  265 ++++++++
 .../mach-vt8500/pwm.c => drivers/pwm/pwm-vt8500.c  |  169 ++---
 drivers/video/backlight/Kconfig                    |    2 +-
 drivers/video/backlight/pwm_bl.c                   |  149 +++-
 include/linux/of.h                                 |   16 +
 include/linux/pwm.h                                |  117 ++++
 include/linux/pwm_backlight.h                      |    1 +
 37 files changed, 2227 insertions(+), 639 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm.txt
 create mode 100644 Documentation/devicetree/bindings/video/backlight/pwm-backlight
 create mode 100644 Documentation/pwm.txt
 delete mode 100644 arch/blackfin/kernel/pwm.c
 create mode 100644 drivers/pwm/Kconfig
 create mode 100644 drivers/pwm/Makefile
 create mode 100644 drivers/pwm/core.c
 create mode 100644 drivers/pwm/pwm-bfin.c
 rename arch/arm/plat-mxc/pwm.c => drivers/pwm/pwm-imx.c (58%)
 create mode 100644 drivers/pwm/pwm-mxs.c
 rename arch/arm/plat-pxa/pwm.c => drivers/pwm/pwm-pxa.c (57%)
 rename arch/arm/plat-samsung/pwm.c => drivers/pwm/pwm-samsung.c (58%)
 create mode 100644 drivers/pwm/pwm-tegra.c
 rename arch/arm/mach-vt8500/pwm.c => drivers/pwm/pwm-vt8500.c (52%)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120621/033e8eb2/attachment-0001.sig>
