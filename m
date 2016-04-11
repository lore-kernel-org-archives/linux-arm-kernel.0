From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 11 Apr 2016 13:29:06 +0000
Subject: [PATCH V2 0/3] dmaengine: bcm2835: support dma channel 11 to 14
Message-ID: <1460381349-14408-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Right now the dma engine officially supports dma channel 11 and 12.
But the use of dma channel 12 immediately stalls the system.

The reason is that the interrupt assigned right now to dma channel 11
is actually a shared interrupt for dma channels 11 to 12.
So whenever the dma channel 12, 13 or 14 is used, it triggers the interrupt
for dma 11 which only clears the interrupt flag for dma channel 11.
This results in the interrupt 11 is triggered all the time.

On top the requesting dma channel12 (and the corresponding irq) triggers
an immeditate stall of the system, because for the 12th interrupt
any dma channel will trigger also this interrupt - even if the dma channel
is controlled by the firmware.

As the description in the default device-tree is (for the above reasons)
wrong a new means had to get devised that allows correct representation
of the mapping between interrupts and dma channels.

For this the existing (but unused) device-tree property "interrupt-names"
is used to define the mapping.

Implementing shared interrupts is another necessity when using dma channel
11 to 14, so it is a part of this patch.

This patchset requires: [PATCH 0/8 v4] bcm2835 DMA slave support
to be applied.

Tested playing BigBuckBunny on:
* fb-tft device (fb_st7735r)
  - via spi-bcm2835 using slave_sg dma
* I2S Hifiberry DAC (snd_soc_hifiberry_dac)
  - via bcm2835-i2s using cyclic dma
(with a few pending patches to make i2s work propperly)

Interrupt statistics after playing Big Buck Bunny:
root at raspcm:~# cat /proc/interrupts
           CPU0
 17:          0  ARMCTRL-level   1 Edge      2000b880.mailbox
 27:      47685  ARMCTRL-level  35 Edge      timer
 33:    6042130  ARMCTRL-level  41 Edge      20980000.usb, dwc2_hsotg:usb1
 40:      13250  ARMCTRL-level  48 Edge      DMA IRQ
 42:      13250  ARMCTRL-level  50 Edge      DMA IRQ
 44:      19087  ARMCTRL-level  52 Edge      DMA IRQ
 45:          0  ARMCTRL-level  53 Edge      DMA IRQ
 73:          0  ARMCTRL-level  81 Edge      20200000.gpio:bank0
 74:          0  ARMCTRL-level  82 Edge      20200000.gpio:bank1
 77:          0  ARMCTRL-level  85 Edge      20205000.i2c, 20804000.i2c, 20805000.i2c
 78:          0  ARMCTRL-level  86 Edge      20204000.spi
 81:        708  ARMCTRL-level  89 Edge      uart-pl011
 86:     277629  ARMCTRL-level  94 Edge      mmc0
Err:          0

Tested also with the following property set:
  brcm,dma-channel-mask = <0x7800>;
which results in only dma channels 11-14 being available
and thus all using the single shared irq.

Interrupt statistics for this case:
           CPU0
 17:          0  ARMCTRL-level   1 Edge      2000b880.mailbox
 27:      46843  ARMCTRL-level  35 Edge      timer
 33:    5412801  ARMCTRL-level  41 Edge      20980000.usb, dwc2_hsotg:usb1
 51:      45502  ARMCTRL-level  59 Edge      DMA IRQ, DMA IRQ, DMA IRQ, DMA IRQ
 73:          0  ARMCTRL-level  81 Edge      20200000.gpio:bank0
 74:          0  ARMCTRL-level  82 Edge      20200000.gpio:bank1
 77:          0  ARMCTRL-level  85 Edge      20205000.i2c, 20804000.i2c, 20805000.i2c
 78:          0  ARMCTRL-level  86 Edge      20204000.spi
 81:        706  ARMCTRL-level  89 Edge      uart-pl011
 86:     297235  ARMCTRL-level  94 Edge      mmc0
Err:          0

Note that support for more interrupts than irq 0 to 14
is not implemented (and this value is also hard-coded).

Allowing dma channel 15 to get controlled well would require
further extensive changes to the device-tree (separate register region).

Also as mentioned above dma-channel 15 is used by the firmware
and is - for all practical purposes - not available to
the kernel.

Only when this situation changes a valid effort can get made.

One major concern here is the fact that we have no dedicated interrupt
for dma channel 15. There is only the "catch all" interrupt, which - as
mentioned above - also triggers for dma channels used by the firmware,
which leads to an unnecessary amount of interrupts and can result
in system lockups...

The only potential usage would be for dma transfers where we do
not need an interrupt, but that may require further changes
to the dmaengine and more to support correctly.

One such "candidate" for the use of dma channel 15 could be
the tx-dma of spi-bcm2835, as for this specifically we only need
to get the interrupt when the rx-dma finishes, but that is a
very special case.

Avoiding the interrupt for the spi-tx-dma is still something that
could get investigated in a different patch-set.

Changelog:
  V1 -> V2: added explicit documentation for "dma-shared-all"
            to the dt-bindings documentation

Martin Sperl (3):
  dt/bindings: bcm2835: add interrupt-names property
  dmaengine: bcm2835: use platform_get_irq_byname
  ARM: bcm2835: add interrupt-names and apply correct mapping

 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 26 ++++++++
 arch/arm/boot/dts/bcm283x.dtsi                     | 22 ++++++-
 drivers/dma/bcm2835-dma.c                          | 77 ++++++++++++++++++----
 3 files changed, 110 insertions(+), 15 deletions(-)

--
2.1.4
