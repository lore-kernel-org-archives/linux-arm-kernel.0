From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 23 Mar 2013 18:13:46 +1300
Subject: [PATCHv2 0/7] arm: vt8500: Add support for pinctrl/gpio module
Message-ID: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2 changes:
Rebased onto v3.9-rc2

Changes made as requested by Linus Walleij:
Moved the files into drivers/pinctrl/vt8500/ to keep them tidy.
Changed readl/writel to *_relaxed variants.
Comment indentation corrected and remove additional whitespace.
Changed wmt_pctl_find_group_by_pin() error code from -1 to -EINVAL.
Removed OF read indexed-u32 function to OF subsystem.
General code tidy up as requested.

Changes made as requested by Stephen Warren:
Add binding information for interrupt generation.
Move optional properties to correct location in document.


This patch series removes the existing GPIO driver and replaces it with
a combined pinctrl+gpio driver.

Patch 1 - Add an OF function to read the nth u32 value from a property
  listing multiple values.

Patch 2 - Increase the available GPIO space for the newly added gpios.
  Because there is no hardware documentation from Wondermedia we don't know
  how many GPIO's there actually are. New gpio pins have been located since
  the original GPIO driver was written, hence the increase.

Patch 3 - The main pinctrl/gpio driver and the data for the 5 supported SoCs.
  Each SoC is different, and therefore has its own data. This design was
  borrowed from the Tegra pinctrl driver. The pin numbering is based on a
  bank+pin encoding so that when other pin functions are found later on we can
  add them without having to renumber existing pins.

Patch 4 - Update the SoC dts(i) files to support the new pinctrl driver.

Patch 5 - Remove the existing GPIO driver nodes from the dtsi's.

Patch 6 - Remove the existing GPIO driver.

Patch 7 - Remove the pinmux configuration code from mach-vt8500/vt8500.c that
  was used to configure the graphics hardware at boot time. This is now done
  in the pinctrl node of the dtsi.


I suspect this series may need to be broken up since there are two arm-soc
patches, and 4 pinctrl/gpio patches.

Patch 1 is fairly independant, but is required for the new driver to function
properly.
Patches 2-5 are pinctrl/gpio patches.
Patch 6 relies on all the previous patches being available or the graphics
hardware will be non-functional.

Let me know how you want to handle this and I'll break it up if necessary.

Regards
Tony Prisk

Tony Prisk (7):
  of: Add support for reading a u32 from a multi-value property.
  arm: vt8500: Increase available GPIOs on arch-vt8500
  pinctrl: gpio: vt8500: Add pincontrol driver for arch-vt8500
  arm: dts: vt8500: Update Wondermedia SoC dtsi files for pinctrl
    driver
  arm: vt8500: Remove gpio devicetree nodes
  gpio: vt8500: Remove arch-vt8500 gpio driver
  arm: vt8500: Remove pinmux configuration from mach-vt8500/vt8500.c

 .../devicetree/bindings/pinctrl/pinctrl-vt8500.txt |   56 ++
 arch/arm/Kconfig                                   |    3 +-
 arch/arm/boot/dts/vt8500.dtsi                      |    7 +-
 arch/arm/boot/dts/wm8505.dtsi                      |    7 +-
 arch/arm/boot/dts/wm8650.dtsi                      |    7 +-
 arch/arm/boot/dts/wm8850.dtsi                      |    7 +-
 arch/arm/mach-vt8500/Kconfig                       |    1 +
 arch/arm/mach-vt8500/vt8500.c                      |   70 +--
 drivers/gpio/Kconfig                               |    6 -
 drivers/gpio/Makefile                              |    1 -
 drivers/gpio/gpio-vt8500.c                         |  355 -----------
 drivers/of/base.c                                  |   33 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/vt8500/Kconfig                     |   52 ++
 drivers/pinctrl/vt8500/Makefile                    |    8 +
 drivers/pinctrl/vt8500/pinctrl-vt8500.c            |  509 ++++++++++++++++
 drivers/pinctrl/vt8500/pinctrl-wm8505.c            |  540 +++++++++++++++++
 drivers/pinctrl/vt8500/pinctrl-wm8650.c            |  378 ++++++++++++
 drivers/pinctrl/vt8500/pinctrl-wm8750.c            |  417 +++++++++++++
 drivers/pinctrl/vt8500/pinctrl-wm8850.c            |  396 ++++++++++++
 drivers/pinctrl/vt8500/pinctrl-wmt.c               |  635 ++++++++++++++++++++
 drivers/pinctrl/vt8500/pinctrl-wmt.h               |   79 +++
 include/linux/of.h                                 |    9 +
 24 files changed, 3134 insertions(+), 444 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-vt8500.txt
 delete mode 100644 drivers/gpio/gpio-vt8500.c
 create mode 100644 drivers/pinctrl/vt8500/Kconfig
 create mode 100644 drivers/pinctrl/vt8500/Makefile
 create mode 100644 drivers/pinctrl/vt8500/pinctrl-vt8500.c
 create mode 100644 drivers/pinctrl/vt8500/pinctrl-wm8505.c
 create mode 100644 drivers/pinctrl/vt8500/pinctrl-wm8650.c
 create mode 100644 drivers/pinctrl/vt8500/pinctrl-wm8750.c
 create mode 100644 drivers/pinctrl/vt8500/pinctrl-wm8850.c
 create mode 100644 drivers/pinctrl/vt8500/pinctrl-wmt.c
 create mode 100644 drivers/pinctrl/vt8500/pinctrl-wmt.h

-- 
1.7.9.5
