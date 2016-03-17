From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 17 Mar 2016 14:17:16 +0100
Subject: [PATCH 0/8 v4] bcm2835 DMA slave support
In-Reply-To: <1458156302-4359-1-git-send-email-eric@anholt.net>
References: <1458156302-4359-1-git-send-email-eric@anholt.net>
Message-ID: <56EAAE5C.9060401@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.03.2016 20:24, Eric Anholt wrote:
> Here's the series for DMA slave and memcpy support for 2835, with the
> DT changes to enable the remaining channels dropped out while that
> goes through review.  I had to do some minor conflict resolution, but
> it was pretty mechanical, and I tested again with dmatest on the last
> patch.
>
> Martin Sperl (8):
>    dmaengine: bcm2835: set residue_granularity field
>    dmaengine: bcm2835: remove unnecessary masking of dma channels
>    dmaengine: bcm2835: add additional defines for DMA-registers
>    dmaengine: bcm2835: move cyclic member from bcm2835_chan into
>      bcm2835_desc
>    dmaengine: bcm2835: move controlblock chain generation into separate
>      method
>    dmaengine: bcm2835: limit max length based on channel type
>    dmaengine: bcm2835: add slave_sg support to bcm2835-dma
>    dmaengine: bcm2835: add dma_memcopy support to bcm2835-dma
>
I have successfully tested this modified patch-series
playing BigBuckBunny on:
* fb-tft device (fb_st7735r) - via spi-bcm2835 using slave_sg dma
* I2S Hifiberry DAC (snd_soc_hifiberry_dac) - via bcm2835-i2s using 
cyclic dma

Required additional patches to make this work
(especially I2S support, which is non-working since ):
* the clock-patchsets:
  * [PATCH 0/6] clk: bcm2835: fixes clk-bcm2835 driver issues
     (most are reviewed by Eric)
  * [PATCH 0/3] reorganize clock initialization and add PCM clock
     (no reviewed/acked so far)
* i2s patchset to enable the use of the clock framework
  * [PATCH V2 0/3] ASOC: bcm2835: move bcm2835-i2s to use clock framework
     (if I remember correctly Mark Brown has merged the driver patches)
* out of tree drivers for Hifiberry DAC
    (I guess I should upstream those...)

Tested-by: Martin Sperl <kernel@martin.sperl.org>
