From: harinik@xilinx.com (Harini Katakam)
Date: Fri,  5 Dec 2014 13:38:02 +0530
Subject: [PATCH v3 0/2] Cadence I2C driver fixes
Message-ID: <1417766884-8383-1-git-send-email-harinik@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements workarounds for some bugs in Cadence I2C controller.

- The I2C controller when configured in Master Mode generates invalid read transactions.
When HOLD bit is set and HW timeout occurs, invalid read transactions are
generated on the bus. This will affect repeated start conditions and large
data transfer condtions where transfer_size_register has to be updated again.
The transfer size register rolls over erroneously under these conditions.
Note that this HW timeout cannot be disabled even if the interrupt is unused.
Errata link: http://www.xilinx.com/support/answers/61664.html

-The I2C controller when configured in Master Mode is the missing master completion interrupt.
During repeated start condition, the driver has to set the HOLD bit for
the set of transfer being done together and clear the HOLD bit just before
the last transfer. But the controller does not indicate completion when
a read/receive transfer is done if the HOLD bit is set. This affects
all repeated start operation where a read/receive transfer is not
the last transfer.
Errata link: http://www.xilinx.com/support/answers/61665.html

To address the above,
- >252 byte transfers are done such that transfer_size never becomes zero.
- timeout register value is increased (even though the driver doesn't use this).
- A check is performed to see if there is any transfer following a
read/receive transfer in the set of messages using repeated start.
An error is returned in such cases because if we proceed, completion interrupt
is never obtained and a SW timeout will occur.

Harini Katakam (2):
  i2c: cadence: Handle > 252 byte transfers
  i2c: cadence: Check for errata condition involving master receive

 drivers/i2c/busses/i2c-cadence.c |  188 +++++++++++++++++++++++---------------
 1 file changed, 115 insertions(+), 73 deletions(-)

-- 
1.7.9.5
