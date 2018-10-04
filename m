From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu,  4 Oct 2018 13:43:17 -0700
Subject: [PATCH i2c-next v6 0/5] i2c: aspeed: Add bus idle waiting logic for
 multi-master use cases
Message-ID: <20181004204322.20665-1-jae.hyun.yoo@linux.intel.com>
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

Changes since v5:
- Changed using of property reading API to device_property_read_u32.

Changes since v4:
- Moved the property reading code into i2c-base-core and changed the
  property name to 'timeout-ms'. Also, added '#retries' property reading
  code.
- Changed bus busy checking logic to make that check slave_state instead
  of 'Transfer Mode State Machine' reg value.

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
  i2c: Add support reading of 'timeout-ms' and '#retries' properties
  dt-bindings: i2c: aspeed: Add 'timeout-ms' property as an optional
    property
  i2c: aspeed: Remove hard-coded bus timeout value setting
  i2c: aspeed: Add bus idle waiting logic for multi-master use cases

 .../devicetree/bindings/i2c/i2c-aspeed.txt    |  3 ++
 Documentation/devicetree/bindings/i2c/i2c.txt |  6 +++
 drivers/i2c/busses/i2c-aspeed.c               | 54 +++++++++++++------
 drivers/i2c/i2c-core-base.c                   | 10 +++-
 4 files changed, 55 insertions(+), 18 deletions(-)

-- 
2.19.0
