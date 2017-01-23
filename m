From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Jan 2017 11:41:47 +0100
Subject: [PATCH v2 2/7] rtc: sun6i: Add some locking
In-Reply-To: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a8798639a0c79c7b2b8e4deb412573f5a68e6d0a.1485168100.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some registers have a read-modify-write access pattern that are not atomic.

Add some locking to prevent from concurrent accesses.

Cc: stable at vger.kernel.org
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rtc/rtc-sun6i.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index a6136cb99851..5527f5eb597b 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -114,13 +114,17 @@ struct sun6i_rtc_dev {
 	void __iomem *base;
 	int irq;
 	unsigned long alarm;
+
+	spinlock_t lock;
 };
 
 static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
 {
 	struct sun6i_rtc_dev *chip = (struct sun6i_rtc_dev *) id;
+	irqreturn_t ret = IRQ_NONE;
 	u32 val;
 
+	spin_lock(&chip->lock);
 	val = readl(chip->base + SUN6I_ALRM_IRQ_STA);
 
 	if (val & SUN6I_ALRM_IRQ_STA_CNT_IRQ_PEND) {
@@ -129,10 +133,11 @@ static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
 
 		rtc_update_irq(chip->rtc, 1, RTC_AF | RTC_IRQF);
 
-		return IRQ_HANDLED;
+		ret = IRQ_HANDLED;
 	}
+	spin_unlock(&chip->lock);
 
-	return IRQ_NONE;
+	return ret;
 }
 
 static void sun6i_rtc_setaie(int to, struct sun6i_rtc_dev *chip)
@@ -140,6 +145,7 @@ static void sun6i_rtc_setaie(int to, struct sun6i_rtc_dev *chip)
 	u32 alrm_val = 0;
 	u32 alrm_irq_val = 0;
 	u32 alrm_wake_val = 0;
+	unsigned long flags;
 
 	if (to) {
 		alrm_val = SUN6I_ALRM_EN_CNT_EN;
@@ -150,9 +156,11 @@ static void sun6i_rtc_setaie(int to, struct sun6i_rtc_dev *chip)
 		       chip->base + SUN6I_ALRM_IRQ_STA);
 	}
 
+	spin_lock_irqsave(&chip->lock, flags);
 	writel(alrm_val, chip->base + SUN6I_ALRM_EN);
 	writel(alrm_irq_val, chip->base + SUN6I_ALRM_IRQ_EN);
 	writel(alrm_wake_val, chip->base + SUN6I_ALARM_CONFIG);
+	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
 static int sun6i_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
@@ -191,11 +199,15 @@ static int sun6i_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
 static int sun6i_rtc_getalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 {
 	struct sun6i_rtc_dev *chip = dev_get_drvdata(dev);
+	unsigned long flags;
 	u32 alrm_st;
 	u32 alrm_en;
 
+	spin_lock_irqsave(&chip->lock, flags);
 	alrm_en = readl(chip->base + SUN6I_ALRM_IRQ_EN);
 	alrm_st = readl(chip->base + SUN6I_ALRM_IRQ_STA);
+	spin_unlock_irqrestore(&chip->lock, flags);
+
 	wkalrm->enabled = !!(alrm_en & SUN6I_ALRM_EN_CNT_EN);
 	wkalrm->pending = !!(alrm_st & SUN6I_ALRM_EN_CNT_EN);
 	rtc_time_to_tm(chip->alarm, &wkalrm->time);
@@ -356,6 +368,7 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
+	spin_lock_init(&rtc->lock);
 
 	platform_set_drvdata(pdev, chip);
 	chip->dev = &pdev->dev;
-- 
git-series 0.8.11
