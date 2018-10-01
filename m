From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon,  1 Oct 2018 13:27:45 -0700
Subject: [PATCH i2c-next v4 0/3] i2c: aspeed: Add bus idle waiting logic for
 multi-master use cases
Message-ID: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-master environment, this driver's master cannot know
exactly when peer master sends data to this driver's slave so a
case can be happened that this master tries to send data through
the master_xfer function but slave data from peer master is still
being processed by this driver.

To prevent state corruption in the case, this patch adds checking
code if any slave operation is ongoing and it waits up to the
timeout duration before starting a master_xfer operation.

Please review this patch set.

Thanks,

-Jae

Changes since v3:
- Changed the property name to 'timeout' and made it use the
  default setting in i2c-core when not specified.

Changes since v2:
- Changed the property name to 'aspeed,timeout' and made it to
  update the adapter's timeout configuration.

Changes since v1:
- Changed define names of timeout related.

Jae Hyun Yoo (3):
  dt-bindings: i2c: aspeed: Add 'timeout' property as an optional
    property
  i2c: aspeed: Add 'timeout' DT property reading code
  i2c: aspeed: Add bus idle waiting logic for multi-master use cases

 .../devicetree/bindings/i2c/i2c-aspeed.txt    |  3 +
 drivers/i2c/busses/i2c-aspeed.c               | 70 ++++++++++++++-----
 2 files changed, 57 insertions(+), 16 deletions(-)

-- 
2.19.0
