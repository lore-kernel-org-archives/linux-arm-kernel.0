From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 17 Jul 2013 20:41:37 +0800
Subject: [PATCH] rtc: SiRF: fix kernel warning during wakeup
Message-ID: <1374064897-29134-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xianglong Du <Xianglong.Du@csr.com>

enable_irq_wake() might fail, if so, we will see kernel warning in resume entries
due to it always calls disable_irq_wake().

[  200.659501] ------------[ cut here ]------------
[  200.661292] WARNING: at /home/ASIA/xd01/temp/atlas6-3.x/kernel/kernel/irq/manage.c:529 irq_set_irq_wake+0xc4/0xf0()
[  200.671686] Unbalanced IRQ 52 wake disable
[  200.675764] Modules linked in: ipv6 libcomposite configfs
[  200.681153] CPU: 0 PID: 1591 Comm: ash Tainted: G        W    3.10.0-00854-gdbd86d4-dirty #100
[  200.689761] [<c0014e28>] (unwind_backtrace+0x0/0xf8) from [<c0011ef4>] (show_stack+0x10/0x14)
[  200.698263] [<c0011ef4>] (show_stack+0x10/0x14) from [<c001fee4>] (warn_slowpath_common+0x54/0x68)
[  200.707198] [<c001fee4>] (warn_slowpath_common+0x54/0x68) from [<c001ff8c>] (warn_slowpath_fmt+0x30/0x40)
[  200.716749] [<c001ff8c>] (warn_slowpath_fmt+0x30/0x40) from [<c0074588>] (irq_set_irq_wake+0xc4/0xf0)
[  200.725951] [<c0074588>] (irq_set_irq_wake+0xc4/0xf0) from [<c027b31c>] (sirfsoc_rtc_restore+0x30/0x38)
[  200.735325] [<c027b31c>] (sirfsoc_rtc_restore+0x30/0x38) from [<c0211c0c>] (platform_pm_restore+0x2c/0x50)
[  200.744959] [<c0211c0c>] (platform_pm_restore+0x2c/0x50) from [<c02163e4>] (dpm_run_callback.clone.6+0x30/0xb0)
[  200.755024] [<c02163e4>] (dpm_run_callback.clone.6+0x30/0xb0) from [<c02169d0>] (device_resume+0x88/0x134)
[  200.764657] [<c02169d0>] (device_resume+0x88/0x134) from [<c0217698>] (dpm_resume+0x114/0x230)
[  200.773253] [<c0217698>] (dpm_resume+0x114/0x230) from [<c0057118>] (hibernation_snapshot+0x178/0x1d0)
[  200.782540] [<c0057118>] (hibernation_snapshot+0x178/0x1d0) from [<c0057820>] (hibernate+0x130/0x1dc)
[  200.791739] [<c0057820>] (hibernate+0x130/0x1dc) from [<c00556cc>] (state_store+0xb4/0xc0)
[  200.799990] [<c00556cc>] (state_store+0xb4/0xc0) from [<c019af68>] (kobj_attr_store+0x14/0x20)
[  200.808585] [<c019af68>] (kobj_attr_store+0x14/0x20) from [<c011b268>] (sysfs_write_file+0xfc/0x17c)
[  200.817696] [<c011b268>] (sysfs_write_file+0xfc/0x17c) from [<c00c4da8>] (vfs_write+0xc8/0x194)
[  200.826372] [<c00c4da8>] (vfs_write+0xc8/0x194) from [<c00c515c>] (SyS_write+0x40/0x6c)
[  200.834362] [<c00c515c>] (SyS_write+0x40/0x6c) from [<c000e280>] (ret_fast_syscall+0x0/0x30)
[  200.842771] ---[ end trace 10f52d38a3bc59c7 ]---

To avoid unbalanced "IRQ wake disable", ensure that disable_irq_wake() is called only when
enable_irq_wake() have been successfully enabled.

Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/rtc/rtc-sirfsoc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-sirfsoc.c b/drivers/rtc/rtc-sirfsoc.c
index aa7ed4b..63460cf 100644
--- a/drivers/rtc/rtc-sirfsoc.c
+++ b/drivers/rtc/rtc-sirfsoc.c
@@ -44,6 +44,7 @@ struct sirfsoc_rtc_drv {
 	struct rtc_device	*rtc;
 	u32			rtc_base;
 	u32			irq;
+	unsigned		irq_wake;
 	/* Overflow for every 8 years extra time */
 	u32			overflow_rtc;
 #ifdef CONFIG_PM
@@ -355,8 +356,8 @@ static int sirfsoc_rtc_suspend(struct device *dev)
 	rtcdrv->saved_counter =
 		sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_CN);
 	rtcdrv->saved_overflow_rtc = rtcdrv->overflow_rtc;
-	if (device_may_wakeup(&pdev->dev))
-		enable_irq_wake(rtcdrv->irq);
+	if (device_may_wakeup(&pdev->dev) && !enable_irq_wake(rtcdrv->irq))
+		rtcdrv->irq_wake = 1;
 
 	return 0;
 }
@@ -423,8 +424,10 @@ static int sirfsoc_rtc_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sirfsoc_rtc_drv *rtcdrv = platform_get_drvdata(pdev);
 	sirfsoc_rtc_thaw(dev);
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(&pdev->dev) && rtcdrv->irq_wake) {
 		disable_irq_wake(rtcdrv->irq);
+		rtcdrv->irq_wake = 0;
+	}
 
 	return 0;
 }
@@ -434,8 +437,10 @@ static int sirfsoc_rtc_restore(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sirfsoc_rtc_drv *rtcdrv = platform_get_drvdata(pdev);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(&pdev->dev) && rtcdrv->irq_wake) {
 		disable_irq_wake(rtcdrv->irq);
+		rtcdrv->irq_wake = 0;
+	}
 	return 0;
 }
 
-- 
1.8.2.3
