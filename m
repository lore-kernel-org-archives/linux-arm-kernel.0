From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 May 2010 10:34:53 +0100
Subject: [PATCH 2/4] ARM: SAMSUNG: Make ADC client SMP safe
In-Reply-To: <1274348095-9390-1-git-send-email-ben-linux@fluff.org>
References: <1274348095-9390-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274348095-9390-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change local_irq disable calls to use spinlocks to ensure that the
ADC driver data is protected against multiple access..

Note, this does not protect the client's data, and the client should
ensure it does not make multiple calls to the ADC driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/adc.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 210030d..04d9521 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -66,6 +66,7 @@ struct adc_device {
 	struct s3c_adc_client	*cur;
 	struct s3c_adc_client	*ts_pend;
 	void __iomem		*regs;
+	spinlock_t		 lock;
 
 	unsigned int		 prescale;
 
@@ -74,7 +75,7 @@ struct adc_device {
 
 static struct adc_device *adc_dev;
 
-static LIST_HEAD(adc_pending);
+static LIST_HEAD(adc_pending);	/* protected by adc_device.lock */
 
 #define adc_dbg(_adc, msg...) dev_dbg(&(_adc)->pdev->dev, msg)
 
@@ -145,7 +146,7 @@ int s3c_adc_start(struct s3c_adc_client *client,
 	if (client->is_ts && adc->ts_pend)
 		return -EAGAIN;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&adc->lock, flags);
 
 	client->channel = channel;
 	client->nr_samples = nr_samples;
@@ -157,7 +158,8 @@ int s3c_adc_start(struct s3c_adc_client *client,
 
 	if (!adc->cur)
 		s3c_adc_try(adc);
-	local_irq_restore(flags);
+
+	spin_unlock_irqrestore(&adc->lock, flags);
 
 	return 0;
 }
@@ -237,6 +239,10 @@ EXPORT_SYMBOL_GPL(s3c_adc_register);
 
 void s3c_adc_release(struct s3c_adc_client *client)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&adc_dev->lock, flags);
+
 	/* We should really check that nothing is in progress. */
 	if (adc_dev->cur == client)
 		adc_dev->cur = NULL;
@@ -255,6 +261,8 @@ void s3c_adc_release(struct s3c_adc_client *client)
 
 	if (adc_dev->cur == NULL)
 		s3c_adc_try(adc_dev);
+
+	spin_unlock_irqrestore(&adc_dev->lock, flags);
 	kfree(client);
 }
 EXPORT_SYMBOL_GPL(s3c_adc_release);
@@ -264,7 +272,6 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	struct adc_device *adc = pw;
 	struct s3c_adc_client *client = adc->cur;
 	enum s3c_cpu_type cpu = platform_get_device_id(adc->pdev)->driver_data;
-	unsigned long flags;
 	unsigned data0, data1;
 
 	if (!client) {
@@ -296,12 +303,12 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 		client->select_cb(client, 1);
 		s3c_adc_convert(adc);
 	} else {
-		local_irq_save(flags);
+		spin_lock(&adc->lock);
 		(client->select_cb)(client, 0);
 		adc->cur = NULL;
 
 		s3c_adc_try(adc);
-		local_irq_restore(flags);
+		spin_unlock(&adc->lock);
 	}
 
 exit:
@@ -326,6 +333,8 @@ static int s3c_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	spin_lock_init(&adc->lock);
+
 	adc->pdev = pdev;
 	adc->prescale = S3C2410_ADCCON_PRSCVL(49);
 
@@ -407,13 +416,17 @@ static int __devexit s3c_adc_remove(struct platform_device *pdev)
 static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct adc_device *adc = platform_get_drvdata(pdev);
+	unsigned long flags;
 	u32 con;
 
+	spin_lock_irqsave(&adc->lock, flags);
+
 	con = readl(adc->regs + S3C2410_ADCCON);
 	con |= S3C2410_ADCCON_STDBM;
 	writel(con, adc->regs + S3C2410_ADCCON);
 
 	disable_irq(adc->irq);
+	spin_unlock_irqrestore(&adc->lock, flags);
 	clk_disable(adc->clk);
 
 	return 0;
@@ -422,6 +435,7 @@ static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
 static int s3c_adc_resume(struct platform_device *pdev)
 {
 	struct adc_device *adc = platform_get_drvdata(pdev);
+	unsigned long flags;
 
 	clk_enable(adc->clk);
 	enable_irq(adc->irq);
-- 
1.6.3.3
