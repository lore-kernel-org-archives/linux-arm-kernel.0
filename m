From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Mar 2012 17:50:17 +0000
Subject: [PATCH 0/5 v2] ARM: kirkwood: fdt: convert kirkwood init funcs to fdt
In-Reply-To: <cover.1330625877.git.jason@lakedaemon.net>
Message-ID: <cover.1330709314.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series begins the process of converting all of the drivers initialized
from kirkwood_init() to devicetree.

The first patch converts an off-SoC driver (spi) to device tree and moves flash
partition definitions to the device tree.  This was previously it's own
submission, but I've included it here since I want this series to match the
subsequent pull request against arm-soc/kirkwood/board.

The second patch cleans up kirkwood_init() by moving a flag setting to it's
appropriate location.  This will help later when converting the audio driver.

Next, I pull the functionality of kirkwood_init() into kirkwood_dt_init() in
board-dt.c  This way, as drivers are converted, their init calls can be removed
from kirkwood_dt_init() and non-fdt users won't be affected (they call
kirkwood_init()).

Last, I converted the two easiest drivers, rtc and wdt.  The xor and crypto
drivers remain for a later patch series.

Jason Cooper (5):
  ARM: kirkwood: covert orion-spi to fdt.
  ARM: kirkwood: move var setting to correct location.
  ARM: kirkwood: fdt: absorb kirkwood_init()
  ARM: kirkwood: convert rtc-mv to fdt.
  ARM: kirkwood: convert orion-wdt to fdt.

 arch/arm/boot/dts/kirkwood-dreamplug.dts |   34 +++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi          |   12 +++++
 arch/arm/mach-kirkwood/board-dt.c        |   67 +++++++++++------------------
 arch/arm/mach-kirkwood/common.c          |   21 +++++++--
 arch/arm/mach-kirkwood/common.h          |    6 +++
 drivers/rtc/rtc-mv.c                     |    7 +++
 drivers/spi/spi-orion.c                  |   37 +++++++++++++++--
 drivers/watchdog/orion_wdt.c             |   48 ++++++++++++++++-----
 8 files changed, 170 insertions(+), 62 deletions(-)

-- 
1.7.3.4
