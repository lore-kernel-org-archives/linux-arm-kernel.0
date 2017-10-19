From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu, 19 Oct 2017 18:42:04 +0200
Subject: [PATCH v5 0/3] Clock patches for SAMA5D2 backup mode
Message-ID: <20171019164207.32717-1-romain.izard.pro@gmail.com>
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

Changes in v3:
* drop dev_printk changes for PMECC
* rework the resume code for PMECC
* improve comments on PMC clock handling

Changes in v4:
* fix a bug in the PMECC resume code

Changes in v5:
* drop all patches already taken
* split the patch series by subsystem

Romain Izard (8):
  clk: at91: pmc: Wait for clocks when resuming
  clk: at91: pmc: Save SCSR during suspend
  clk: at91: pmc: Support backup for programmable clocks

 drivers/clk/at91/clk-programmable.c |  2 ++
 drivers/clk/at91/pmc.c              | 63 +++++++++++++++++++++++++++++++------
 drivers/clk/at91/pmc.h              |  2 ++
 3 files changed, 57 insertions(+), 10 deletions(-)

-- 
2.11.0
