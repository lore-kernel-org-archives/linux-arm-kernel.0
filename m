From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 29 May 2015 15:50:07 +0200
Subject: [PATCH 0/3] i2c: at91: add support to FIFOs and alternative command
Message-ID: <cover.1432907105.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches adds support of two new features which will be
introduced with Atmel sama5d2x SoC.

First, the alternative command mode eases the sending of STOP conditions.
Before starting an I2C transaction, the size data to be transfered is
written into the new Alternative Command Register. For each byte transferred,
the I2C controller decreases this counter and automatically sends a STOP
condition when the counter value reaches 0, that is to say when the last byte
of the transaction has been sent/received. So there is no longer need to set
the STOP bit into the Control Register.

Then the use of FIFOs allows to reduce number I/O accesses: for instance,
the TX FIFO allows to write up to 4 data in a single access to the Transmit
Holding Register. Also the RX FIFO allows to read up to 4 data in a single
access to the Receive Holding Register. Currently only DMA transfers take
advantage of FIFOs.

Cyrille Pitchen (3):
  i2c: at91: add support for new alternative command mode
  i2c: at91: print hardware version
  i2c: at91: add support to FIFOs

 drivers/i2c/busses/i2c-at91.c | 347 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 288 insertions(+), 59 deletions(-)

-- 
1.8.2.2
