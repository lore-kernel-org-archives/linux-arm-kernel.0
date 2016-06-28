From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 28 Jun 2016 11:41:10 +0900
Subject: [PATCH v2 0/5] s3c64xx: consider the case of a disconnected CS line
 and some code rework
Message-ID: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the main goal of the patchset is to support SPI cnnected device
without CS line link.

The first two patches make the s3c64xx driver to consider the
case of a disconnected CS line. This is done by adding a property
in the DTS ("no-cs-readback") which informs the device driver the
absence of a chip selection link.

The last three patches are just some code re-work and
beautification.

Changelog: V1 -> V2

 - the first version of the patchset was removing an 'if'
   statement on "!spi->chip_select" which was causing the SPI
   core to fail. In this case the drivers would have been able to
   set a chip_select = 0 in absence of a CS link. After a short
   discussion with Mark, this has been replaced, as described
   above, by a property in the DTS.

 - one more patch has been added which assigns to some variable
   the proper type

 - some typos fixed in the commit messages

Thanks,
Andi

Andi Shyti (5):
  spi: s3c64xx: group the CS signalling writes in a single function
  spi: s3c64xx: consider the case when the CS line is not connected
  spi: s3c64xx: do not configure the device twice
  spi: s3c64xx: simplify if statement in prepare_transfer function
  spi: s3c64xx: use unsigned type for fifo handling variables

 .../devicetree/bindings/spi/spi-samsung.txt        |   3 +
 drivers/spi/spi-s3c64xx.c                          | 114 +++++++++++----------
 include/linux/platform_data/spi-s3c64xx.h          |   1 +
 3 files changed, 65 insertions(+), 53 deletions(-)

-- 
2.8.1
