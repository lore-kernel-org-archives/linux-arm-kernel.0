From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 13:25:08 +0100
Subject: [PATCH 0/4] Power off drivers for QNAP and LSXL.
Message-ID: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains two power off driver, moving existing code
out of mach-kirkwood into drivers/power/reset.

QNAP NAS boards have a microcontroller connected to a UART. Sending
the command to it turns the power off. There are Orion5x QNAP boards
which can later use this driver, once they are converted to DT.

Kirkwood Buffalo Linkstation LSXL devices power off by restarting and
letting the boot loader idle until the user hits a switch. There are
again Orion5x devices which could use this driver in the future, once
they are converted to DT. It also looks like some PXA devices could
use it.

Patches #1 and #3 are the drivers, and #2 and #4 make use of the
driver, removing C code and adding DT nodes.

The QNAP driver has been tested on a QNAP TS119+. The LSXL driver is
currently untested.

git://github.com/lunn/linux.git v3.8-rc1-qnap-poweroff

Andrew Lunn (4):
  Power: Reset: Driver to turn QNAP board power off.
  ARM: Kirkwood: Make use of the QNAP Power off driver.
  Power: Reset: Power off by restarting
  ARM: Kirkwood: Convert LSXL to restart-poweroff driver.

 .../bindings/power_supply/qnap-poweroff.txt        |   14 +++
 .../bindings/power_supply/restart-poweroff.txt     |    9 ++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |    4 +
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |    5 +
 arch/arm/mach-kirkwood/Kconfig                     |    2 +
 arch/arm/mach-kirkwood/board-lsxl.c                |   16 ---
 arch/arm/mach-kirkwood/board-ts219.c               |    3 -
 drivers/power/reset/Kconfig                        |   17 +++
 drivers/power/reset/Makefile                       |    2 +
 drivers/power/reset/qnap-poweroff.c                |  124 ++++++++++++++++++++
 drivers/power/reset/restart-poweroff.c             |   67 +++++++++++
 11 files changed, 244 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/restart-poweroff.txt
 create mode 100644 drivers/power/reset/qnap-poweroff.c
 create mode 100644 drivers/power/reset/restart-poweroff.c

-- 
1.7.10.4
