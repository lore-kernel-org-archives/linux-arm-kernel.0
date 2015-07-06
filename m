From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue,  7 Jul 2015 00:54:49 +0530
Subject: [PATCH-v3 05/11] i2c: pxa: Update debug function to dump more info on
 error
In-Reply-To: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436210695-19159-6-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update i2c_pxa_scream_blue_murder() fn to print more information
in case of error.
Also, use dev_err variants instead of printk.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-pxa.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 4c92694..040effa 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -132,6 +132,7 @@ struct pxa_i2c {
 	unsigned int		msg_idx;
 	unsigned int		msg_ptr;
 	unsigned int		slave_addr;
+	unsigned int		req_slave_addr;
 
 	struct i2c_adapter	adap;
 	struct clk		*clk;
@@ -253,15 +254,20 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
 	unsigned int i;
-	printk(KERN_ERR "i2c: error: %s\n", why);
-	printk(KERN_ERR "i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
+	struct device *dev = &i2c->adap.dev;
+
+	dev_err(dev, "slave_0x%x error: %s\n",
+		i2c->req_slave_addr >> 1, why);
+	dev_err(dev, "msg_num: %d msg_idx: %d msg_ptr: %d\n",
 		i2c->msg_num, i2c->msg_idx, i2c->msg_ptr);
-	printk(KERN_ERR "i2c: ICR: %08x ISR: %08x\n",
-	       readl(_ICR(i2c)), readl(_ISR(i2c)));
-	printk(KERN_DEBUG "i2c: log: ");
+	dev_err(dev, "IBMR: %08x IDBR: %08x ICR: %08x ISR: %08x\n",
+		readl(_IBMR(i2c)), readl(_IDBR(i2c)), readl(_ICR(i2c)),
+		readl(_ISR(i2c)));
+	dev_dbg(dev, "log: ");
 	for (i = 0; i < i2c->irqlogidx; i++)
-		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
-	printk("\n");
+		pr_debug("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
+
+	pr_debug("\n");
 }
 
 #else /* ifdef DEBUG */
@@ -638,6 +644,7 @@ static inline void i2c_pxa_start_message(struct pxa_i2c *i2c)
 	 * Step 1: target slave address into IDBR
 	 */
 	writel(i2c_pxa_addr_byte(i2c->msg), _IDBR(i2c));
+	i2c->req_slave_addr = i2c_pxa_addr_byte(i2c->msg);
 
 	/*
 	 * Step 2: initiate the write.
@@ -951,6 +958,7 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32 isr)
 		 * Write the next address.
 		 */
 		writel(i2c_pxa_addr_byte(i2c->msg), _IDBR(i2c));
+		i2c->req_slave_addr = i2c_pxa_addr_byte(i2c->msg);
 
 		/*
 		 * And trigger a repeated start, and send the byte.
-- 
1.9.1
