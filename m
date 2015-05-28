From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 28 May 2015 15:54:35 -0700
Subject: [PATCH 0/2] imx6: Implement external watchdog reset
Message-ID: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMX6 watchdog supports assertion of a signal (WDOG_B) which
can be pinmux'd to an external pin. This is typically used for boards that
have PMIC's in control of the IMX6 power rails. In fact, failure to use
such an external reset on boards with external PMIC's can result in various
hangs due to the IMX6 not being fully reset [1] as well as the board failing
to reset because its PMIC has not been reset to provide adequate voltate for
the CPU when comming out of reset at 800Mhz when it was at 400Mhz prior to
reset.
 
This adds a new device-tree property 'ext-reset' to fsl-imx-wdt in order to
indicate the board has such a reset and to cause the watchdog to be
configured to assert WDOG_B instead of an internal reset both on a
watchdog timeout and in system_restart.
 
The second patch adds the watchdog configuration and pinmux for Gateworks
Ventana boards.

I would expect that maintainers of other IMX6 boards that use PMIC's that
are resettable via WDOG_B to follow-up with similar device-tree patches.
I've attempted to Cc those individuals here.
 
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Stefan Roese <sr@denx.de>
Cc: Iain Paton <ipaton0@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>

Tim Harvey (2):
  watchdog: imx2_wdt: add external reset support via 'ext-reset' dt
    property
  ARM: dts: ventana: Add ext-reset support

 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt       |  2 ++
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi                  | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi                  | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi                  | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi                  | 18 ++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi                  | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi                  | 13 +++++++++++++
 drivers/watchdog/imx2_wdt.c                            | 18 ++++++++++++++++--
 8 files changed, 100 insertions(+), 2 deletions(-)

-- 
1.9.1
