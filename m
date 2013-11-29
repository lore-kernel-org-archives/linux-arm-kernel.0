From: hector.palacios@digi.com (Hector Palacios)
Date: Fri, 29 Nov 2013 17:35:24 +0100
Subject: [PATCH 0/3] serial: mxs-auart: flush_buffer hook and interrupt
 processing
Message-ID: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series implement several fixes to the mxs-auart serial driver.

The first patch implements the flush_buffer hook. Currently the driver
can be shut down and pending data in the FIFO will be lost.

The second patchs adds a check of the BUSY flag in the tx_empty hook
to make sure the UART is not about to fill data into the FIFO.

The third patch moves the interrupt handling from the ISR out to a
tasklet. This was motivated due to different transmission problems
with hardware and software flow control at high baudrates whereby
transmission was interrupted or data lost. 
The problem can be reproduced by setting two AUARTs at 576000/N/8 
with CRTSCTS and sending a large file from one port to the other
 with 'cat'.

Hector Palacios (3):
  serial: mxs-auart: implement flush_buffer hook
  serial: mxs-auart: check BUSY flag on tx_empty hook
  serial: mxs-auart: move irq handling to a tasklet

 drivers/tty/serial/mxs-auart.c | 93 ++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 25 deletions(-)
