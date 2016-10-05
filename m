From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 5 Oct 2016 14:34:39 +0530
Subject: [PATCH v3 0/4] Add DMA support for ti_am335x_adc driver
Message-ID: <20161005090443.24576-1-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADC has a 64 word depth fifo length which holds the ADC data
till the CPU reads. So when a user program needs a large ADC data
to operate on, then it has to do multiple reads to get its
buffer. Currently if the application asks for 4 samples per
channel with all 8 channels are enabled, kernel can provide only
3 samples per channel when all 8 channels are enabled (logs at
[1]). So with DMA support user can request for large number of
samples at a time (logs at [1]).

Tested the patch on AM437x-gp-evm and AM335x Boneblack with the
patch [2] to enable ADC and pushed a branch for testing [3]

Changes from v2:
* Fixed an issue on handling of error return from dma_request_chan().

Changes from Initial version:
* Changed DMA api from dma_request_slave_channel_compat() to
  dma_request_chan()
* Changed variable names to have more clear information as per
  comments from Peter.

[1] - http://pastebin.ubuntu.com/23278405/
[2] - http://pastebin.ubuntu.com/23211494/
[3] - git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git iio-dma-v2

Mugunthan V N (4):
  mfd: ti_am335x_tscadc: store physical address
  drivers: iio: ti_am335x_adc: add dma support
  ARM: dts: am33xx: add DMA properties for tscadc
  ARM: dts: am4372: add DMA properties for tscadc

 arch/arm/boot/dts/am33xx.dtsi        |   2 +
 arch/arm/boot/dts/am4372.dtsi        |   2 +
 drivers/iio/adc/ti_am335x_adc.c      | 148 ++++++++++++++++++++++++++++++++++-
 drivers/mfd/ti_am335x_tscadc.c       |   1 +
 include/linux/mfd/ti_am335x_tscadc.h |   8 ++
 5 files changed, 158 insertions(+), 3 deletions(-)

-- 
2.10.0.372.g6fe1b14
