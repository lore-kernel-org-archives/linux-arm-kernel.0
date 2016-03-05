From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 10:52:11 +0000
Subject: [PATCH v3 00/11] dmaengine: bcm2835: bugfix + enhancement of driver
Message-ID: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This patchset fixes several issues:
* missing residue_granularity to allow better support for I2S
* dma-channels are no longer artificially restricted (channel 0 and 2)
* added correct support for dma-channels 11-14 (changeable via
  the device tree) by using the correct shared irq line with index
  11 into the interrupts list (changeable via device tree)

With this now 11 DMA channels are available instead of 7 - the
additional HW-DMA-channels are:
* 0, 2 (masking of channels)
* 13, 14 (shared interrupts - see also note on channel 12)

It also adds several new features:
* slave_sg support
* dma_memcopy support

For these a consolidated method for creating standard control-block
chains was created to share common between cyclic, slave_sg and
memcopy.

Testing:
* slave_sg
  * spi-bcm2835:
    * fb_st7735r framebuffer
      * tested using mplayer
* cyclic
  * bcm2835-i2s
    * Audio output with a Hifiberry I2S card.
      * tested using mplayer and aplay
* memcopy
  * dmatest

Tests using both slave_sg and cyclic concurrently were also conducted
using mplayer to play BigBuckBunny.

Note that the bcm2835-i2s driver still requires the clock patch-set
enabling the pcm clock.

The last patches (expose registers via debugfs) is optional:
  dmaengine: bcm2835: expose dma registers via debugfs

Note: DMA channel 15 is still not supported because:
* it sits in a separate IO range
* it is used by the firmware
So unless the firmware no longer uses DMA 15, it is not worth
the effort.

Possibly future improvements:
* allow control over channel selection (Lite or normal)
  as well as AXI priorities via the device-tree
* support for memset, memset_sg and interleave
* using DREQ-names instead of magic numbers (via include/dt-binding/...)

Change-log:
  V1 -> V2: * rewrite of the original patch avoiding code duplication
            * splitting of changes into multiple patches
  V2 -> V3: * allow configuration to dma mapping va device tree.
            * adding names binging for DREQs to get used in device-trees
	    * move lite channel detection (via debug register) and using
	      limits of it into separate patch
	    * add debugfs support to see what is actually happening in
	      the dma registers.
	    * incorporated feedback from various people improving
	      code-readability (primarily Patch 7)

Martin Sperl (11):
  dmaengine: bcm2835: set residue_granularity field
  dmaengine: bcm2835: remove unnecessary masking of dma channels
  dmaengine: bcm2835: use shared interrupt for channel 11 to 14.
  ARM: bcm2835: dt: add bindings for shared interrupt properties
  dmaengine: bcm2835: add additional defines for DMA-registers
  dmaengine: bcm2835: move cyclic member from bcm2835_chan into
    bcm2835_desc
  dmaengine: bcm2835: move controlblock chain generation into separate
    method
  dmaengine: bcm2835: limit max length based on channel type
  dmaengine: bcm2835: add slave_sg support to bcm2835-dma
  dmaengine: bcm2835: add dma_memcopy support to bcm2835-dma
  dmaengine: bcm2835: expose dma registers via debugfs

 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   |   6 +
 drivers/dma/bcm2835-dma.c                          | 740 +++++++++++++++++----
 2 files changed, 623 insertions(+), 123 deletions(-)

--
2.1.4
