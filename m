From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Mon, 16 Nov 2009 20:40:14 +0900
Subject: [PATCH 23/22] i2c-designware: i2c_dw_handle_tx_abort: Use dev_dbg()
	for NOACK cases
In-Reply-To: <4AF419B6.1000802@necel.com>
References: <4AF419B6.1000802@necel.com>
Message-ID: <4B013A1E.2050206@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of no-ACKs, we don't want to see dev_err() messages in the
console, because some utilities like i2c-tools are capable of printing
decorated console output.  This patch will ease such situations.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

Hi Ben,

 This patch can be applied on the top of the v2 patchset (as 23/22).
 I've tested the patch with both no-ACK cases and arbitration case.
 As for errors other than NOACKs, it's worth doing dev_err().

 drivers/i2c/busses/i2c-designware.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 4534d45..9e18ef9 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -496,13 +496,18 @@ static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 	unsigned long abort_source = dev->abort_source;
 	int i;
 
+	if (abort_source & DW_IC_TX_ABRT_NOACK) {
+		for_each_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
+			dev_dbg(dev->dev,
+				"%s: %s\n", __func__, abort_sources[i]);
+		return -EREMOTEIO;
+	}
+
 	for_each_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
 		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);
 
 	if (abort_source & DW_IC_TX_ARB_LOST)
 		return -EAGAIN;
-	else if (abort_source & DW_IC_TX_ABRT_NOACK)
-		return -EREMOTEIO;
 	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
 		return -EINVAL; /* wrong msgs[] data */
 	else
-- 
1.6.5.2
