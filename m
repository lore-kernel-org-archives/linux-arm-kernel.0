From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 28 May 2015 18:33:42 +0530
Subject: [PATCH 10/12] i2c: pxa: Update debug function to dump more info on
 error
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1432818224-17070-11-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update i2c_pxa_scream_blue_murder() fn to print more information
in case of error.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
[vaibhav.hiremath at linaro.org: Split patches into logical changes
and update the Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/i2c/busses/i2c-pxa.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index cf6c383..065e647 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -147,6 +147,7 @@ struct pxa_i2c {
 	unsigned int		msg_idx;
 	unsigned int		msg_ptr;
 	unsigned int		slave_addr;
+	unsigned int		req_slave_addr;
 
 	struct i2c_adapter	adap;
 	struct clk		*clk;
@@ -335,11 +336,13 @@ err_out:
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 {
 	unsigned int i;
-	printk(KERN_ERR "i2c: error: %s\n", why);
+	printk(KERN_ERR"i2c: <%s> slave_0x%x error: %s\n", i2c->adap.name,
+		i2c->req_slave_addr >> 1, why);
 	printk(KERN_ERR "i2c: msg_num: %d msg_idx: %d msg_ptr: %d\n",
 		i2c->msg_num, i2c->msg_idx, i2c->msg_ptr);
-	printk(KERN_ERR "i2c: ICR: %08x ISR: %08x\n",
-	       readl(_ICR(i2c)), readl(_ISR(i2c)));
+	printk(KERN_ERR "i2c: IBMR: %08x IDBR: %08x ICR: %08x ISR: %08x\n",
+		readl(_IBMR(i2c)), readl(_IDBR(i2c)), readl(_ICR(i2c)),
+		readl(_ISR(i2c)));
 	printk(KERN_DEBUG "i2c: log: ");
 	for (i = 0; i < i2c->irqlogidx; i++)
 		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
@@ -736,6 +739,7 @@ static inline void i2c_pxa_start_message(struct pxa_i2c *i2c)
 	 * Step 1: target slave address into IDBR
 	 */
 	writel(i2c_pxa_addr_byte(i2c->msg), _IDBR(i2c));
+	i2c->req_slave_addr = i2c_pxa_addr_byte(i2c->msg);
 
 	/*
 	 * Step 2: initiate the write.
@@ -1055,6 +1059,7 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32 isr)
 		 * Write the next address.
 		 */
 		writel(i2c_pxa_addr_byte(i2c->msg), _IDBR(i2c));
+		i2c->req_slave_addr = i2c_pxa_addr_byte(i2c->msg);
 
 		/*
 		 * And trigger a repeated start, and send the byte.
-- 
1.9.1
