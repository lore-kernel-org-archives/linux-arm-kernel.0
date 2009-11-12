From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 12 Nov 2009 19:37:18 +0100
Subject: [PATCH] COH 901 331 fixes
Message-ID: <1258051038-15615-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will fix some small issues with the COH 901 331 RTC driver:
- Interrupt is disabled after alarm so that we don't fire
  multiple interrupts.
- We return 0 from the coh901331_alarm_irq_enable() ridding
  a compile warning.
- We alter the name in the U300 device registry to match that
  of the driver so they sucessfully resolve.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
I will put this into Russells tracker if the RTC maintainer
doesn't mind.
---
 arch/arm/mach-u300/core.c   |    2 +-
 drivers/rtc/rtc-coh901331.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index be60d6d..653e25b 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -408,7 +408,7 @@ static struct platform_device keypad_device = {
 };
 
 static struct platform_device rtc_device = {
-	.name = "rtc0",
+	.name = "rtc-coh901331",
 	.id = -1,
 	.num_resources = ARRAY_SIZE(rtc_resources),
 	.resource = rtc_resources,
diff --git a/drivers/rtc/rtc-coh901331.c b/drivers/rtc/rtc-coh901331.c
index 7fe1fa2..03ea530 100644
--- a/drivers/rtc/rtc-coh901331.c
+++ b/drivers/rtc/rtc-coh901331.c
@@ -58,7 +58,16 @@ static irqreturn_t coh901331_interrupt(int irq, void *data)
 	clk_enable(rtap->clk);
 	/* Ack IRQ */
 	writel(1, rtap->virtbase + COH901331_IRQ_EVENT);
+	/*
+	 * Disable the interrupt. This is necessary because
+	 * the RTC lives on a lower-clocked line and will
+	 * not release the IRQ line until after a few (slower)
+	 * clock cycles. The interrupt will be re-enabled when
+	 * a new alarm is set anyway.
+	 */
+	writel(0, rtap->virtbase + COH901331_IRQ_MASK);
 	clk_disable(rtap->clk);
+
 	/* Set alarm flag */
 	rtc_update_irq(rtap->rtc, 1, RTC_AF);
 
@@ -128,6 +137,8 @@ static int coh901331_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	else
 		writel(0, rtap->virtbase + COH901331_IRQ_MASK);
 	clk_disable(rtap->clk);
+
+	return 0;
 }
 
 static struct rtc_class_ops coh901331_ops = {
-- 
1.6.2.1
