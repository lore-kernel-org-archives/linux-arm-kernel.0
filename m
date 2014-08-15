From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 15 Aug 2014 19:42:28 +0200
Subject: [PATCH v7] 8250-core based serial driver for OMAP + DMA
Message-ID: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is my complete queue fo the omap serial driver based on the 8250 core
code. I played with it on beagle bone, am335x-evm and dra7xx including DMA.
The uncertain remain the runtime-pm pieces.
I hacked a small serial testing application which sent 10x 4KiB of data in
raw mode. The number of interrupts in comparison:

    serial-omap | 8250 omap | 8250 omap + dma |
   --------------------------------------------
TX |       2558 |       641 |         0 +  30 |
RX |      40960 |       854 |         1 + 853 |

So the 8250 version uses less interrupts for the same amount of data.
The consequence is that in TX mode there should be "short" periods where
no data is sent (before the CPU gets to re-fill the FIFO). On RX we have
a smaller time frame where we have to start to purge the FIFO before it
overflows.

Sebastian
