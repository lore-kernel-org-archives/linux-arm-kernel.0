From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed,  3 Oct 2018 15:31:02 -0700
Subject: [PATCH i2c-next v5 0/5] i2c: aspeed: Add bus idle waiting logic for
 multi-master use cases
Message-ID: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-master environment, this driver's master cannot know
exactly when peer master sends data to this driver's slave so a
case can be happened that this master tries to send data through
the master_xfer function but slave data from peer master is still
being processed by this driver. To prevent state corruption in the
case, this patch adds checking code if any slave operation is
ongoing and it waits up to the bus timeout duration before starting
a master_xfer operation.

To support this change, it introduces changes on i2c-core-base to
make that able to read the bus timeout and master transfer retries
count values from device tree properties.

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

Jae Hyun Yoo (5):
  dt-bindings: i2c: Add 'timeout-ms' and '#retries' properties as common
    optional
  i2c: Add support for 'timeout-ms' and '#retries' OF properties
  dt-bindings: i2c: aspeed: Add 'timeout-ms' property as an optional
    property
  i2c: aspeed: Remove hard-coded bus timeout value setting
  i2c: aspeed: Add bus idle waiting logic for multi-master use cases

 .../devicetree/bindings/i2c/i2c-aspeed.txt    |  3 ++
 Documentation/devicetree/bindings/i2c/i2c.txt |  6 +++
 drivers/i2c/busses/i2c-aspeed.c               | 54 +++++++++++++------
 drivers/i2c/i2c-core-base.c                   | 18 ++++++-
 4 files changed, 63 insertions(+), 18 deletions(-)

-- 
2.19.0
