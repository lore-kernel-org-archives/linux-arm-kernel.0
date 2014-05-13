From: agross@codeaurora.org (Andy Gross)
Date: Tue, 13 May 2014 16:34:40 -0500
Subject: [PATCH 0/4] spi: qup: Fixes and new version support
Message-ID: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches provides a few fixes for the SPI QUP driver and support for
an earlier version of the QUP.

The first patch removes the use of the controller's own chip select
functionality.  The user should instead use GPIOs and make use of the SPI core's
GPIO chip select feature.

The second patch fixes the calculation that determines whether the FIFO or BLOCK
mode is used.  SPI transactions greater than 16 bytes but less than FIFO size
were failing.

The third patch addresses failures during probing of slave devices that required
SPI transactions.  The spi_register_master needs to be called after the runtime
pm is initialized.

The last patch adds support for V1.1.1 of the QUP.  This version of the
controller is present in earlier devices (APQ8064, IPQ8064, and MSM8960).

Andy Gross (4):
  spi: qup: Remove chip select function
  spi: qup: Correct selection of FIFO/Block mode
  spi: qup: Fix order of spi_register_master
  spi: qup: Add support for v1.1.1

 .../devicetree/bindings/spi/qcom,spi-qup.txt       |    6 ++
 drivers/spi/spi-qup.c                              |   75 ++++++++------------
 2 files changed, 37 insertions(+), 44 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
