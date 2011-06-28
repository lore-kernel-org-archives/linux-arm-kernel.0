From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 28 Jun 2011 09:57:13 +0200
Subject: [PATCH 0/4] MMCI patches for 3.1
Message-ID: <1309247833-17061-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This is a collection of ST-Ericsson patches for MMCI for 3.1.

They are arranged in rising controversy-order for incremental
handling...

[1/4] is pretty straight-formward handling of a missing error
 bit.

[2/4] adjusts the min frequency for the card in accordance with
 needs we have on the ST Micro based platforms.

[3/4] is a reqrite of the earlier discussed patch that
 synchronize DMA termination callbacks with the DATAEND IRQ,
 but now we have added a timeout so that failed transactions
 can be handled.

[4/4] rewrites the pio_write function to work properly with
 non-4-byte aligned accesses, and replaces an earlier
 workaround. For regular MMC/SD accesses which are always
 evenly divisible by 4 it should have no effect, the
 difference is in the handling of odd transactions, such as
 can be seen when processing SDIO requests.

All patches have been tested on U8500, U300 and RealView
PB1176 with mounted filesystems exercising read and write,
so as to assure there are no obvious regressions.

Ulf Hansson (4):
  mmci: use StartBitErr to detect bad connections
  mmci: adjust calculation of f_min
  mmci: sync DATAEND irq with dma|pio transfer done
  mmci: fixup sg buffer handling in pio_write

 drivers/mmc/host/mmci.c |  324 +++++++++++++++++++++++++++++-----------------
 drivers/mmc/host/mmci.h |   13 ++-
 2 files changed, 216 insertions(+), 121 deletions(-)

-- 
1.7.3.2
