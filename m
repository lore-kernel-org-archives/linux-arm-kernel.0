From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 15 Sep 2017 16:04:02 +0200
Subject: [PATCH v2 0/9] Various patches for SAMA5D2 backup mode
Message-ID: <20170915140411.31716-1-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the core of the backup mode for SAMA5D2 has been integrated in
v4.13, it is far from complete. Individual controllers in the chip have
drivers that do not support the reset of the registers during suspend,
and they need to be adapted to handle it.

The first patch uses the clock wakeup code from the prototype backup
mode instead of the version integrated in the mainline, as the mainline
version is not stable. During a test loop with two-second backup
suspend, the mainline version will hang in less than one day, whereas
the prototype version has been running the same test for more than a
week without hanging.

Changes in v2:
* drop the IIO patch duplicating existing code
* determine the number of programmable clocks to save dynamically
* declare a required local variable in the tty/serial patch

Romain Izard (9):
  clk: at91: pmc: Wait for clocks when resuming
  clk: at91: pmc: Save SCSR during suspend
  clk: at91: pmc: Support backup for programmable clocks
  mtd: nand: atmel: Avoid ECC errors when leaving backup mode
  mtd: nand: atmel: Report PMECC failures as errors
  ehci-atmel: Power down during suspend is normal
  pwm: atmel-tcb: Support backup mode
  atmel_flexcom: Support backup mode
  tty/serial: atmel: Prevent a warning on suspend

 drivers/clk/at91/clk-programmable.c |  2 ++
 drivers/clk/at91/pmc.c              | 55 +++++++++++++++++++++++++------
 drivers/clk/at91/pmc.h              |  2 ++
 drivers/mfd/atmel-flexcom.c         | 65 ++++++++++++++++++++++++++++---------
 drivers/mtd/nand/atmel/pmecc.c      | 15 ++++-----
 drivers/pwm/pwm-atmel-tcb.c         | 63 +++++++++++++++++++++++++++++++++--
 drivers/tty/serial/atmel_serial.c   | 14 ++++++++
 drivers/usb/host/ehci-atmel.c       |  3 +-
 8 files changed, 182 insertions(+), 37 deletions(-)

-- 
2.11.0
