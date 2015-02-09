From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Mon,  9 Feb 2015 10:03:52 -0500
Subject: [PATCH v2] i2c: cadence: fixup of wait_for_completion_timeout return
 handling
Message-ID: <1423494232-24747-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

return type of wait_for_completion_timeout is unsigned long not int. The
return variable is renamed to reflect its use and the type adjusted to
unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

v2: int ret is an idiom not only a declaration - thus rather than just
    changing the type, rename the variable, as suggested by Wolfram Sang 
    <wsa@the-dreams.de>. 

Patch was only compile tested with multi_v7_defconfig
(implies CONFIG_I2C_CADENCE=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)

 drivers/i2c/busses/i2c-cadence.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 7d7a14c..8f92732f 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -475,7 +475,7 @@ static void cdns_i2c_master_reset(struct i2c_adapter *adap)
 static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 		struct i2c_adapter *adap)
 {
-	int ret;
+	unsigned long timeout;
 	u32 reg;
 
 	id->p_msg = msg;
@@ -501,8 +501,8 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
 		cdns_i2c_msend(id);
 
 	/* Wait for the signal of completion */
-	ret = wait_for_completion_timeout(&id->xfer_done, adap->timeout);
-	if (!ret) {
+	timeout = wait_for_completion_timeout(&id->xfer_done, adap->timeout);
+	if (!timeout) {
 		cdns_i2c_master_reset(adap);
 		dev_err(id->adap.dev.parent,
 				"timeout waiting on completion\n");
-- 
1.7.10.4
