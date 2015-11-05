From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  5 Nov 2015 20:15:21 +0900
Subject: [RFC PATCH 0/7] reset: make RESET_CONTROLLER a select'ed option
Message-ID: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I was implementing a new reset controller for my SoCs,
I struggled to make my sub-menu shown under the reset
controller menu.
I noticed the Kconfig in reset sub-system are screwed up due to two
config options (ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER).

I think only the former should be select'ed by relevant SoCs,
but in fact the latter is also select'ed here and there.
Mixing "select" to a user-configurable option is a mess.

Finally, I started to wonder whether it could be more simpler?

The first patch drops ARCH_HAS_RESET_CONTROLLER.
RESET_CONTROLLER should be directly selected by SoCs.

The rest of this series are minor clean ups in other
sub-systems.
I can postpone them if changes over cross sub-systems
are not preferred.



Masahiro Yamada (7):
  reset: drop ARCH_HAS_RESET_CONTROLLER
  spi: sunxi: remove redundant "depends on RESET_CONTROLLER"
  spi: tegra: remove redundant "depends on RESET_CONTROLLER"
  pinctrl: sunxi: remove redundant "depends on RESET_CONTROLLER"
  drm/sti: replace "select RESET_CONTROLLER" with "depends on ..."
  drm/rockchip: remove redundant "depends on RESET_CONTROLLER"
  drm/tegra: tegra: remove redundant "depends on RESET_CONTROLLER"

 arch/arm/Kconfig                 |  3 +--
 arch/arm/mach-berlin/Kconfig     |  2 +-
 arch/arm/mach-imx/Kconfig        |  2 +-
 arch/arm/mach-mmp/Kconfig        |  4 ++--
 arch/arm/mach-prima2/Kconfig     |  2 +-
 arch/arm/mach-rockchip/Kconfig   |  2 +-
 arch/arm/mach-sti/Kconfig        |  1 -
 arch/arm/mach-sunxi/Kconfig      |  1 -
 arch/arm/mach-tegra/Kconfig      |  1 -
 arch/arm64/Kconfig.platforms     |  3 +--
 arch/mips/Kconfig                |  4 +---
 drivers/gpu/drm/rockchip/Kconfig |  1 -
 drivers/gpu/drm/sti/Kconfig      |  4 ++--
 drivers/gpu/drm/tegra/Kconfig    |  1 -
 drivers/pinctrl/sunxi/Kconfig    |  2 --
 drivers/reset/Kconfig            | 12 +++++++-----
 drivers/reset/sti/Kconfig        |  1 -
 drivers/spi/Kconfig              |  6 ++----
 18 files changed, 20 insertions(+), 32 deletions(-)

-- 
1.9.1
