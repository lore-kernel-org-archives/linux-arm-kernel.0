From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Thu, 16 Jun 2016 11:10:18 -0500
Subject: [RFC] Fix D_CAN corrupted bytes by using 32 bit register r/w
Message-ID: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Corrupted bytes in CAN transmission on the Altera CycloneV seem
to be an issue because the D_CAN registers are 32 bits [1].
Changing to a 32 bit write fixes the problem and this patch
includes one method of fixing the problem by selecting 32 bit
writes for D_CAN or 16 bit writes for C_CAN.

Another option would be to remove the D_CAN if test and always use
the priv->read_reg32() and priv->write_reg32() for both C_CAN and
D_CAN. The C_CAN read_reg32() function performs two 16 bit writes.
The code is cleaner without the D_CAN if branch but it adds additional
overhead for C_CAN (2nd 16 bit write may not be needed in many cases).

This patch isolates the changes to D_CAN and has been tesed on
on the Altera CycloneV devkit using a flood write test.

[1] http://comments.gmane.org/gmane.linux.can/9402

Thor Thayer (1):
  can: c_can: Update D_CAN TX and RX functions to 32 bit.

 drivers/net/can/c_can/c_can.c |   38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

-- 
1.7.9.5
