From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 21 May 2010 10:19:43 +0200
Subject: Samsung watchdog driver updates
In-Reply-To: <1274353105-17774-1-git-send-email-ben-linux@fluff.org>
References: <1274353105-17774-1-git-send-email-ben-linux@fluff.org>
Message-ID: <20100521081943.GO3972@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

> two updates for samsung watchdog driver, one bugfix and one kconfig.
> 
> please apply for this merge window.

I added them to the linux-2.6-watchdog tree so that they can be included
in this merge window.

I also created a fix for the removal of the driver (the misc_deregister
needs to happen first so that userspace access is removed before removing
the rest of the driver).
Can you test and give feedback?

Thanks,
Wim.

commit c41e5d25f3d82d1b048f8dc156f057d0deba093a
Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Fri May 21 08:11:42 2010 +0000

    watchdog: s3c2410_wdt - Fix removing of platform device
    
    When removing the watchdog platform device, we need to
    disable the access to userspace first. It makes no sense
    to remove the drivers clock, irq's, ... and then disable
    usersapce access.
    the order of removal has also been changed so that it
    is the reverse of probing (this way the clock is also
    disabled sooner).
    
    Cc: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 3009325..ae53662 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -532,21 +532,22 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 
 static int __devexit s3c2410wdt_remove(struct platform_device *dev)
 {
-	s3c2410wdt_cpufreq_deregister();
-
-	release_resource(wdt_mem);
-	kfree(wdt_mem);
-	wdt_mem = NULL;
+	misc_deregister(&s3c2410wdt_miscdev);
 
-	free_irq(wdt_irq->start, dev);
-	wdt_irq = NULL;
+	s3c2410wdt_cpufreq_deregister();
 
 	clk_disable(wdt_clock);
 	clk_put(wdt_clock);
 	wdt_clock = NULL;
 
+	free_irq(wdt_irq->start, dev);
+	wdt_irq = NULL;
+
 	iounmap(wdt_base);
-	misc_deregister(&s3c2410wdt_miscdev);
+
+	release_resource(wdt_mem);
+	kfree(wdt_mem);
+	wdt_mem = NULL;
 	return 0;
 }
 
