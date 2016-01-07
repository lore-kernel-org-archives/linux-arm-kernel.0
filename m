From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu,  7 Jan 2016 17:32:58 +0000
Subject: [PATCH V2 0/8] dmaengine: bcm2835: enhancement of driver
Message-ID: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This patchset fixes several issues:
* missing residue_granularity to allow better support for I2S
* dma-channels are artificially restricted (channel 0 and 2)
* added correct support for dma-channels 11-14 by using the correct
  shared irq line
  * dma-channel 12 used the "trigger for all" irq resulting in
    a lockup when used
  * note that care was taken so that no change to the device-tree
    was necessary to avoid a break...

With this now 11 DMA channels available instead of 7 - the
additional HW-DMA-channels are:
* 0, 2 (masking of channels)
* 13, 14 (shared interrupts - see also note on channel 12)

It also adds several new features:
* slave_sg support
* dma_memcopy support

For these a consolidated method for creating standard control-block
chains was created to share common between cyclic, slave_sg and
memcopy.

Additional support for memset, memset_sg and interleave
are in the pipeline.

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

To test that interrupt line sharing was working propperly the same
audio/video test was run only using dma channel 11 to 14 - these
channels are sharing the same interrupt line -

Note that the bcm2835-i2s driver that is currenlty in the kernel
fails to work since:
commit 94cb7f76caa0b337 ("Switch to using the new clock driver support")
and requires modifications to use the clock-driver framework.

For testing a quick and dirty patch had to be used - a patch to use
the clock framework is in the pipeline.

Martin Sperl (8):
  dmaengine: bcm2835: set residue_granularity field
  dmaengine: bcm2835: remove unnecessary masking of dma channels
  dmaengine: bcm2835: use shared interrupt for channel 11 to 14.
  dmaengine: bcm2835: add additional defines for DMA-registers
  dmaengine: bcm2835: move cyclic member from bcm2835_chan into
    bcm2835_desc
  dmaengine: bcm2835: move controlblock chain generation into separate
    method
  dmaengine: bcm2835: add slave_sg support to bcm2835-dma
  dmaengine: bcm2835: add dma_memcopy support to bcm2835-dma

 drivers/dma/bcm2835-dma.c |  541 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 419 insertions(+), 122 deletions(-)

--
1.7.10.4
