From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Fri, 06 Nov 2009 21:42:30 +0900
Subject: [PATCH v2] i2c-designware updates
Message-ID: <4AF419B6.1000802@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch and Ben,

here's v2 patchset of DesignWare I2C driver (i2c-designware.c).
I did all test I can do for now (including arbitration tests), and
fixed more issues left in the v1 patchset.  I think now the driver is
in reasonable shape for the mainline, and hope gets merged.

The patches which already have Baruch's Acked-by: line are logically
same as the previous v1 patches.  For the rest are revised version of
v1 patches, or newly added in v2.

There are 22 patches in total and might be slightly annoying.  I'll
send subsequent patches only to linux-i2c.


Changes in v2
==============

* i2c-designware: Set a clock name to DW I2C clock source

  -> dropped.

* 02/22: Don't use the IC_CLR_INTR register to clear interrupts

  We need to preserve IC_TX_ABRT_SOURCE value before clearing
  interrupts, or we can't get correct abort_source.  ->Fixed

* 08/22: i2c_dw_xfer_msg: Fix i2c_msg search bug

  The intr_mask handling is folded into the for-loop.

* 15/22: i2c_dw_func: Set I2C_FUNC_SMBUS_foo bits

  Commit log is updated.

* 01--15 (except for 02, 08, and 15) are logically same as the
  previous v1 patches.

* For the rest (16--22) are newly added.


Shinya Kuribayashi (22):
      i2c-designware: Consolidate to use 32-bit word accesses
      i2c-designware: Don't use the IC_CLR_INTR register to clear interrupts
      i2c-designware: Use platform_get_irq helper
      i2c-designware: i2c_dw_read: Use "struct dw_i2c_dev" pointer
      i2c-designware: i2c_dw_xfer_msg: Use "struct dw_i2c_dev" pointer
      i2c-designware: Remove an useless local variable "num"
      i2c-designware: Improved _HCNT/_LCNT calculation
      i2c-designware: i2c_dw_xfer_msg: Fix i2c_msg search bug
      i2c-designware: Process i2c_msg messages in the interrupt handler
      i2c-designware: Set Tx/Rx FIFO threshold levels
      i2c-designware: Enable RX_FULL interrupt
      i2c-designware: Divide i2c_dw_xfer_msg into two functions
      i2c-designware: i2c_dw_xfer_msg: Introduce a local "buf" pointer
      i2c-designware: Initialize byte count variables just prior to being used
      i2c-designware: i2c_dw_func: Set I2C_FUNC_SMBUS_foo bits
      i2c-designware: i2c_dw_read: Remove redundant target address checker
      i2c-designware: Process all i2c_msg messages in the interrupt handler
      i2c-designware: Disable TX_EMPTY when all i2c_msg msgs has been processed
      i2c-designware: i2c_dw_xfer_msg: Fix error handling procedures
      i2c-designware: Skip RX_FULL and TX_EMPTY bits on tx abort errors
      i2c-designware: Tx abort cleanups
      i2c-designware: Cosmetic cleanups

 drivers/i2c/busses/i2c-designware.c |  483 +++++++++++++++++++++++++----------
 1 files changed, 350 insertions(+), 133 deletions(-)

-- 
Shinya Kuribayashi
NEC Electronics
