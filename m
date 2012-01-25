From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:36:52 +0000
Subject: [PATCH 20/33] MFD: ucb1x00-core: use mutexes instead of semaphores
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3y0-0000Z7-EX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the ucb1x00 driver to use mutexes rather than the depreciated
semaphores for exclusive access to the ADC.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c  |   15 +++++++--------
 include/linux/mfd/ucb1x00.h |    4 ++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index c2757c1..7386f82 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -27,7 +27,6 @@
 #include <linux/mutex.h>
 #include <linux/mfd/ucb1x00.h>
 #include <linux/gpio.h>
-#include <linux/semaphore.h>
 
 static DEFINE_MUTEX(ucb1x00_mutex);
 static LIST_HEAD(ucb1x00_drivers);
@@ -99,7 +98,7 @@ void ucb1x00_io_write(struct ucb1x00 *ucb, unsigned int set, unsigned int clear)
  *	ucb1x00_enable must have been called to enable the comms
  *	before using this function.
  *
- *	This function does not take any semaphores or spinlocks.
+ *	This function does not take any mutexes or spinlocks.
  */
 unsigned int ucb1x00_io_read(struct ucb1x00 *ucb)
 {
@@ -183,7 +182,7 @@ static int ucb1x00_gpio_direction_output(struct gpio_chip *chip, unsigned offset
  *	Any code wishing to use the ADC converter must call this
  *	function prior to using it.
  *
- *	This function takes the ADC semaphore to prevent two or more
+ *	This function takes the ADC mutex to prevent two or more
  *	concurrent uses, and therefore may sleep.  As a result, it
  *	can only be called from process context, not interrupt
  *	context.
@@ -193,7 +192,7 @@ static int ucb1x00_gpio_direction_output(struct gpio_chip *chip, unsigned offset
  */
 void ucb1x00_adc_enable(struct ucb1x00 *ucb)
 {
-	down(&ucb->adc_sem);
+	mutex_lock(&ucb->adc_mutex);
 
 	ucb->adc_cr |= UCB_ADC_ENA;
 
@@ -215,7 +214,7 @@ void ucb1x00_adc_enable(struct ucb1x00 *ucb)
  *	complete (2 frames max without sync).
  *
  *	If called for a synchronised ADC conversion, it may sleep
- *	with the ADC semaphore held.
+ *	with the ADC mutex held.
  */
 unsigned int ucb1x00_adc_read(struct ucb1x00 *ucb, int adc_channel, int sync)
 {
@@ -243,7 +242,7 @@ unsigned int ucb1x00_adc_read(struct ucb1x00 *ucb, int adc_channel, int sync)
  *	ucb1x00_adc_disable - disable the ADC converter
  *	@ucb: UCB1x00 structure describing chip
  *
- *	Disable the ADC converter and release the ADC semaphore.
+ *	Disable the ADC converter and release the ADC mutex.
  */
 void ucb1x00_adc_disable(struct ucb1x00 *ucb)
 {
@@ -251,7 +250,7 @@ void ucb1x00_adc_disable(struct ucb1x00 *ucb)
 	ucb1x00_reg_write(ucb, UCB_ADC_CR, ucb->adc_cr);
 	ucb1x00_disable(ucb);
 
-	up(&ucb->adc_sem);
+	mutex_unlock(&ucb->adc_mutex);
 }
 
 /*
@@ -560,7 +559,7 @@ static int ucb1x00_probe(struct mcp *mcp)
 
 	spin_lock_init(&ucb->lock);
 	spin_lock_init(&ucb->io_lock);
-	sema_init(&ucb->adc_sem, 1);
+	mutex_init(&ucb->adc_mutex);
 
 	ucb->id  = id;
 	ucb->mcp = mcp;
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index fd088cc..a4b9543 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -12,7 +12,7 @@
 
 #include <linux/mfd/mcp.h>
 #include <linux/gpio.h>
-#include <linux/semaphore.h>
+#include <linux/mutex.h>
 
 #define UCB_IO_DATA	0x00
 #define UCB_IO_DIR	0x01
@@ -124,7 +124,7 @@ struct ucb1x00 {
 	spinlock_t		lock;
 	struct mcp		*mcp;
 	unsigned int		irq;
-	struct semaphore	adc_sem;
+	struct mutex		adc_mutex;
 	spinlock_t		io_lock;
 	u16			id;
 	u16			io_dir;
-- 
1.7.4.4
