From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 12 Jan 2016 12:35:45 +0000
Subject: [PATCH V2 0/3] ASOC: bcm2835: move bcm2835-i2s to use clock framework
Message-ID: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This patchset enables the bcm2835-i2s driver to use the clock
framework which was introduced with commit 94cb7f76caa0
("ARM: bcm2835: Switch to using the new clock driver support.").

This commit resulted in the fact that the bcm2835-i2s driver was
no longer working due to some register addresses used by 2 drivers
(clk-bcm2835 and bcm2835-i2s).

This patchset requires that the patchset for PCM-clock
support as well as fractional/mash support is applied to
the clk-bcm2835 driver and the corresponding device tree,
but as the current version of the driver is not working,
that should not be a problem.

Note that there is one change:
right now the current driver tries to calculate an optimal
bclk_ratio based on its knowledge that it is using the 19.2Mhz
oscillator. This computation would recommend the use of 40
or 80 bits instead of 32/64 bits that are required.

Some of the DACs can not handle this, so most downstream
drivers would set snd_soc_dai_set_bclk_ratio explicitly to
disable this "non-power-of-2" automatic selection.

So it seems wise to leave it out of the current patchset.

If it is deemed necessary, then I can provide a separate
patch that implements this again.

Changelog:
  V1->V2: * moving clock patches into a separate patchset,
            which fixes also other issues in the clock framework
          * remove unnecessary bclk_size assignments

Martin Sperl (3):
  ASoC: bcm2835: move to use the clock framework
  ARM: bcm2835: I2S: use new register-range and clock framework
  dt-bindings: bsm2835: fix bindings documentation to use new clock
    framework

 .../devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |    5 +-
 sound/soc/bcm/bcm2835-i2s.c                        |  284 +++++---------------
 3 files changed, 69 insertions(+), 227 deletions(-)

--
1.7.10.4
