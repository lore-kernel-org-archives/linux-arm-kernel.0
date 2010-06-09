From: gdavis@mvista.com (George G. Davis)
Date: Wed, 9 Jun 2010 11:59:19 -0400
Subject: mpcore_wdt: Add percpu support for ARM11 MPCore watchdogs
Message-ID: <mailman.3.1285171006.1886.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: George G. Davis <gdavis@mvista.com>

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index b8ec7ac..d624d8d 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -42,11 +42,14 @@ struct mpcore_wdt {
 	int		irq;
 	unsigned int	perturb;
 	char		expect_close;
+	int		margin;
+	int		nowayout;
+	int		noboot;
+	char		name[12];
+	spinlock_t	lock;
+	struct miscdevice miscdev;
 };
 
-static struct platform_device *mpcore_wdt_dev;
-static DEFINE_SPINLOCK(wdt_lock);
-
 #define TIMER_MARGIN	60
 static int mpcore_margin = TIMER_MARGIN;
 module_param(mpcore_margin, int, 0);
@@ -97,25 +100,25 @@ static void mpcore_wdt_keepalive(struct mpcore_wdt *wdt)
 {
 	unsigned long count;
 
-	spin_lock(&wdt_lock);
+	spin_lock(&wdt->lock);
 	/* Assume prescale is set to 256 */
 	count =  __raw_readl(wdt->base + TWD_WDOG_COUNTER);
 	count = (0xFFFFFFFFU - count) * (HZ / 5);
-	count = (count / 256) * mpcore_margin;
+	count = (count / 256) * wdt->margin;
 
 	/* Reload the counter */
 	writel(count + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
 	wdt->perturb = wdt->perturb ? 0 : 1;
-	spin_unlock(&wdt_lock);
+	spin_unlock(&wdt->lock);
 }
 
 static void mpcore_wdt_stop(struct mpcore_wdt *wdt)
 {
-	spin_lock(&wdt_lock);
+	spin_lock(&wdt->lock);
 	writel(0x12345678, wdt->base + TWD_WDOG_DISABLE);
 	writel(0x87654321, wdt->base + TWD_WDOG_DISABLE);
 	writel(0x0, wdt->base + TWD_WDOG_CONTROL);
-	spin_unlock(&wdt_lock);
+	spin_unlock(&wdt->lock);
 }
 
 static void mpcore_wdt_start(struct mpcore_wdt *wdt)
@@ -125,7 +128,7 @@ static void mpcore_wdt_start(struct mpcore_wdt *wdt)
 	/* This loads the count register but does NOT start the count yet */
 	mpcore_wdt_keepalive(wdt);
 
-	if (mpcore_noboot) {
+	if (wdt->noboot) {
 		/* Enable watchdog - prescale=256, watchdog mode=0, enable=1 */
 		writel(0x0000FF01, wdt->base + TWD_WDOG_CONTROL);
 	} else {
@@ -134,12 +137,12 @@ static void mpcore_wdt_start(struct mpcore_wdt *wdt)
 	}
 }
 
-static int mpcore_wdt_set_heartbeat(int t)
+static int mpcore_wdt_set_heartbeat(int *p, int t)
 {
 	if (t < 0x0001 || t > 0xFFFF)
 		return -EINVAL;
 
-	mpcore_margin = t;
+	*p = t;
 	return 0;
 }
 
@@ -148,12 +151,13 @@ static int mpcore_wdt_set_heartbeat(int t)
  */
 static int mpcore_wdt_open(struct inode *inode, struct file *file)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_dev);
+	struct mpcore_wdt *wdt = container_of(file->private_data,
+					      struct mpcore_wdt, miscdev);
 
 	if (test_and_set_bit(0, &wdt->timer_alive))
 		return -EBUSY;
 
-	if (nowayout)
+	if (wdt->nowayout)
 		__module_get(THIS_MODULE);
 
 	file->private_data = wdt;
@@ -172,7 +176,7 @@ static int mpcore_wdt_release(struct inode *inode, struct file *file)
 
 	/*
 	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we set nowayout
+	 * 	Lock it in if it's a module and we set wdt->nowayout
 	 */
 	if (wdt->expect_close == 42)
 		mpcore_wdt_stop(wdt);
@@ -195,7 +199,7 @@ static ssize_t mpcore_wdt_write(struct file *file, const char *data,
 	 *	Refresh the timer.
 	 */
 	if (len) {
-		if (!nowayout) {
+		if (!wdt->nowayout) {
 			size_t i;
 
 			/* In case it was set long ago */
@@ -271,14 +275,14 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case WDIOC_SETTIMEOUT:
-		ret = mpcore_wdt_set_heartbeat(uarg.i);
+		ret = mpcore_wdt_set_heartbeat(&wdt->margin, uarg.i);
 		if (ret)
 			break;
 
 		mpcore_wdt_keepalive(wdt);
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
-		uarg.i = mpcore_margin;
+		uarg.i = wdt->margin;
 		ret = 0;
 		break;
 
@@ -318,20 +322,14 @@ static const struct file_operations mpcore_wdt_fops = {
 	.release	= mpcore_wdt_release,
 };
 
-static struct miscdevice mpcore_wdt_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &mpcore_wdt_fops,
-};
-
 static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 {
 	struct mpcore_wdt *wdt;
 	struct resource *res;
 	int ret;
 
-	/* We only accept one device, and it must have an id of -1 */
-	if (dev->id != -1)
+	/* Support up to four devices having an id of 0..3 */
+	if (dev->id < 0 || dev->id > 3)
 		return -ENODEV;
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
@@ -358,8 +356,12 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 		goto err_free;
 	}
 
-	mpcore_wdt_miscdev.parent = &dev->dev;
-	ret = misc_register(&mpcore_wdt_miscdev);
+	snprintf(wdt->name, ARRAY_SIZE(wdt->name), "watchdog%d", dev->id);
+	wdt->miscdev.parent = &dev->dev;
+	wdt->miscdev.minor = MISC_DYNAMIC_MINOR,
+	wdt->miscdev.name = wdt->name,
+	wdt->miscdev.fops = &mpcore_wdt_fops,
+	ret = misc_register(&wdt->miscdev);
 	if (ret) {
 		dev_printk(KERN_ERR, wdt->dev,
 			"cannot register miscdev on minor=%d (err=%d)\n",
@@ -367,22 +369,28 @@ static int __devinit mpcore_wdt_probe(struct platform_device *dev)
 		goto err_misc;
 	}
 
-	ret = request_irq(wdt->irq, mpcore_wdt_fire, IRQF_DISABLED,
-							"mpcore_wdt", wdt);
+	ret = request_irq(wdt->irq, mpcore_wdt_fire,
+			  IRQF_DISABLED |
+			  IRQF_SHARED |
+			  IRQF_NOBALANCING |
+			  IRQF_PERCPU, "mpcore_wdt", wdt);
 	if (ret) {
 		dev_printk(KERN_ERR, wdt->dev,
 			"cannot register IRQ%d for watchdog\n", wdt->irq);
 		goto err_irq;
 	}
 
+	spin_lock_init(&wdt->lock);
+	wdt->margin = mpcore_margin;
+	wdt->nowayout = nowayout;
+	wdt->noboot = mpcore_noboot;
 	mpcore_wdt_stop(wdt);
 	platform_set_drvdata(dev, wdt);
-	mpcore_wdt_dev = dev;
 
 	return 0;
 
 err_irq:
-	misc_deregister(&mpcore_wdt_miscdev);
+	misc_deregister(&wdt->miscdev);
 err_misc:
 	iounmap(wdt->base);
 err_free:
@@ -397,9 +405,7 @@ static int __devexit mpcore_wdt_remove(struct platform_device *dev)
 
 	platform_set_drvdata(dev, NULL);
 
-	misc_deregister(&mpcore_wdt_miscdev);
-
-	mpcore_wdt_dev = NULL;
+	misc_deregister(&wdt->miscdev);
 
 	free_irq(wdt->irq, wdt);
 	iounmap(wdt->base);
@@ -421,7 +427,7 @@ static struct platform_driver mpcore_wdt_driver = {
 };
 
 static char banner[] __initdata = KERN_INFO "MPcore Watchdog Timer: 0.1. "
-		"mpcore_noboot=%d mpcore_margin=%d sec (nowayout= %d)\n";
+		"mpcore_noboot=%d mpcore_margin=%d sec (nowayout=%d)\n";
 
 static int __init mpcore_wdt_init(void)
 {
@@ -429,8 +435,8 @@ static int __init mpcore_wdt_init(void)
 	 * Check that the margin value is within it's range;
 	 * if not reset to the default
 	 */
-	if (mpcore_wdt_set_heartbeat(mpcore_margin)) {
-		mpcore_wdt_set_heartbeat(TIMER_MARGIN);
+	if (mpcore_wdt_set_heartbeat(&mpcore_margin, mpcore_margin)) {
+		mpcore_wdt_set_heartbeat(&mpcore_margin, TIMER_MARGIN);
 		printk(KERN_INFO "mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
 			TIMER_MARGIN);
 	}


HTH!

--
Regards,
George

> 
> Thanks,
> John
> 
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
> 
