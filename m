From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Fri, 19 Mar 2010 18:13:27 +0300
Subject: [PATCH 1/3] watchdog: Add support for the Freescale MXC watchdog
Message-ID: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver for the Freescale MXC SoCs built-in watchdog.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/Kconfig   |   10 ++
 drivers/watchdog/Makefile  |    1 +
 drivers/watchdog/mxc_wdt.c |  385 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 396 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/mxc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 088f32f..985d067 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -289,6 +289,16 @@ config ADX_WATCHDOG
 	  Say Y here if you want support for the watchdog timer on Avionic
 	  Design Xanthos boards.
 
+config MXC_WATCHDOG
+	tristate "MXC watchdog"
+	depends on ARCH_MXC
+        select WATCHDOG_NOWAYOUT
+	help
+	  Say Y here if to include support for the watchdog timer
+	  in Freescale MXC SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called mxc_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 475c611..347c227 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
 obj-$(CONFIG_STMP3XXX_WATCHDOG) += stmp3xxx_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
 obj-$(CONFIG_ADX_WATCHDOG) += adx_wdt.o
+obj-$(CONFIG_MXC_WATCHDOG) += mxc_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/mxc_wdt.c b/drivers/watchdog/mxc_wdt.c
new file mode 100644
index 0000000..0daa37b
--- /dev/null
+++ b/drivers/watchdog/mxc_wdt.c
@@ -0,0 +1,385 @@
+/*
+ * linux/drivers/char/watchdog/mxc_wdt.c
+ *
+ * Watchdog driver for Freescale MXC SoCs. It is based on omap_wdt.c
+ *
+ * Copyright 2010 Vladimir Zapolskiy <vzapolskiy@gmail.com>
+ * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * 2005 (c) MontaVista Software, Inc.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/moduleparam.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+
+#define MXC_WDT_WCR             0x00
+#define MXC_WDT_WSR             0x02
+#define MXC_WDT_WRSR            0x04
+#define WCR_WOE_BIT             (1 << 6)
+#define WCR_WDA_BIT             (1 << 5)
+#define WCR_SRS_BIT             (1 << 4)
+#define WCR_WRE_BIT             (1 << 3)
+#define WCR_WDE_BIT             (1 << 2)
+#define WCR_WDBG_BIT            (1 << 1)
+#define WCR_WDZST_BIT           (1 << 0)
+#define WDT_MAGIC_1             0x5555
+#define WDT_MAGIC_2             0xAAAA
+
+#define TIMER_MARGIN_MAX        127
+#define TIMER_MARGIN_DEFAULT    60        /* 60 seconds */
+#define TIMER_MARGIN_MIN        1
+
+#define WDOG_SEC_TO_COUNT(s)  ((s * 2) << 8)
+#define WDOG_COUNT_TO_SEC(c)  ((c >> 8) / 2)
+
+static struct platform_device *mxc_wdt_dev;
+
+struct mxc_wdt {
+        void __iomem    *base;
+        struct device   *dev;
+        unsigned long   status;
+        struct clk      *clk;
+        struct resource *mem;
+};
+
+static spinlock_t wdt_lock;
+
+static unsigned int timer_margin = TIMER_MARGIN_DEFAULT;
+module_param(timer_margin, uint, 0);
+MODULE_PARM_DESC(timer_margin, "initial watchdog timeout in seconds (default="
+                 __MODULE_STRING(TIMER_MARGIN_DEFAULT) ")");
+
+static u16 mxc_wdt_get_bootstatus(struct mxc_wdt *wdt)
+{
+        void __iomem *base = wdt->base;
+        u16 val;
+
+        val = __raw_readw(base + MXC_WDT_WRSR);
+        return val;
+}
+
+static void mxc_wdt_set_timeout(struct mxc_wdt *wdt)
+{
+        void __iomem *base = wdt->base;
+        u16 val;
+
+        val = __raw_readw(base + MXC_WDT_WCR);
+        val = (val & 0x00FF) | WDOG_SEC_TO_COUNT(timer_margin);
+        __raw_writew(val, base + MXC_WDT_WCR);
+}
+
+static void mxc_wdt_ping(struct mxc_wdt *wdt)
+{
+        void __iomem *base = wdt->base;
+
+        /* issue the service sequence instructions */
+        __raw_writew(WDT_MAGIC_1, base + MXC_WDT_WSR);
+        __raw_writew(WDT_MAGIC_2, base + MXC_WDT_WSR);
+}
+
+static void mxc_wdt_enable(struct mxc_wdt *wdt)
+{
+        void __iomem *base = wdt->base;
+        u16 val;
+
+        val = __raw_readw(base + MXC_WDT_WCR);
+        val &= 0xFF00; /* preserve timeout value */
+        val |= WCR_WOE_BIT | WCR_WDA_BIT | WCR_SRS_BIT |
+                WCR_WDZST_BIT | WCR_WDBG_BIT | WCR_WDE_BIT;
+
+        __raw_writew(val, base + MXC_WDT_WCR);
+
+        mxc_wdt_ping(wdt);
+}
+
+static void mxc_wdt_disable(struct mxc_wdt *wdt)
+{
+        /* This stub is remained to include disable support on IMX1 SoCs */
+}
+
+/* Allow only one task to hold watchdog node open */
+static int mxc_wdt_open(struct inode *inode, struct file *file)
+{
+        struct mxc_wdt *wdt = platform_get_drvdata(mxc_wdt_dev);
+
+        if (test_and_set_bit(0, &wdt->status))
+                return -EBUSY;
+
+        file->private_data = (void *)wdt;
+
+        clk_enable(wdt->clk);
+
+        spin_lock(&wdt_lock);
+        mxc_wdt_set_timeout(wdt);
+        mxc_wdt_enable(wdt);
+        spin_unlock(&wdt_lock);
+
+        return 0;
+}
+
+/* The watchdog found on MXC chips cannot be disabled. */
+static int mxc_wdt_release(struct inode *inode, struct file *file)
+{
+        struct mxc_wdt *wdt = file->private_data;
+
+        /* disable the watchdog timer unless NOWAYOUT is defined. */
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+        mxc_wdt_disable(wdt);
+#else
+        printk(KERN_CRIT "MXC watchdog: unexpected close, timer will not stop\n");
+#endif
+        clear_bit(0, &wdt->status);
+
+        clk_disable(wdt->clk);
+
+        return 0;
+}
+
+static ssize_t mxc_wdt_write(struct file *file, const char __user * data,
+                             size_t len, loff_t * ppos)
+{
+        struct mxc_wdt *wdt = file->private_data;
+
+        /* Reload counter */
+        if (len) {
+                spin_lock(&wdt_lock);
+                mxc_wdt_ping(wdt);
+                spin_unlock(&wdt_lock);
+        }
+
+        return len;
+}
+
+static long mxc_wdt_ioctl(struct file *file, unsigned int cmd,
+                          unsigned long arg)
+{
+        void __user *argp = (void __user *)arg;
+        int __user *p = argp;
+        int new_margin;
+        struct mxc_wdt *wdt = file->private_data;
+
+        static const struct watchdog_info mxc_wdt_ident = {
+                .identity = "MXC watchdog",
+                .options = WDIOF_SETTIMEOUT,
+                .firmware_version = 0,
+        };
+
+        switch (cmd) {
+        case WDIOC_GETSUPPORT:
+                return copy_to_user(argp, &mxc_wdt_ident,
+                                    sizeof(mxc_wdt_ident)) ? -EFAULT : 0;
+        case WDIOC_GETSTATUS:
+                return put_user(0, p);
+        case WDIOC_GETBOOTSTATUS:
+                return put_user(mxc_wdt_get_bootstatus(wdt), p);
+        case WDIOC_KEEPALIVE:
+                spin_lock(&wdt_lock);
+                mxc_wdt_ping(wdt);
+                spin_unlock(&wdt_lock);
+                return 0;
+        case WDIOC_SETTIMEOUT:
+                if (get_user(new_margin, p))
+                        return -EFAULT;
+
+                if (new_margin < TIMER_MARGIN_MIN ||
+                    new_margin > TIMER_MARGIN_MAX)
+                        return -EINVAL;
+
+                spin_lock(&wdt_lock);
+                timer_margin = new_margin;
+                mxc_wdt_set_timeout(wdt);
+                mxc_wdt_ping(wdt);
+                spin_unlock(&wdt_lock);
+                /* Fall */
+        case WDIOC_GETTIMEOUT:
+                return put_user(timer_margin, p);
+        default:
+                return -ENOTTY;
+        }
+}
+
+static const struct file_operations mxc_wdt_fops = {
+        .owner          = THIS_MODULE,
+        .llseek         = no_llseek,
+        .write          = mxc_wdt_write,
+        .unlocked_ioctl = mxc_wdt_ioctl,
+        .open           = mxc_wdt_open,
+        .release        = mxc_wdt_release,
+};
+
+static struct miscdevice mxc_wdt_miscdev = {
+        .minor          = WATCHDOG_MINOR,
+        .name           = "watchdog",
+        .fops           = &mxc_wdt_fops,
+};
+
+static int __init mxc_wdt_probe(struct platform_device *pdev)
+{
+        struct resource *res;
+        struct mxc_wdt *wdt;
+        int ret;
+
+        /* reserve static register mappings */
+        res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+        if (!res) {
+                ret = -ENOENT;
+                goto err_get_resource;
+        }
+
+        wdt = kzalloc(sizeof(struct mxc_wdt), GFP_KERNEL);
+        if (!wdt) {
+                ret = -ENOMEM;
+                goto err_kzalloc;
+        }
+
+        wdt->status = 0;
+        wdt->mem = request_mem_region(res->start, resource_size(res),
+                                      pdev->name);
+        if (!wdt->mem) {
+                ret = -EBUSY;
+                goto err_busy;
+        }
+
+        /* To determine watchdog clock state it is assumed
+           that the clock is disabled on probe */
+        wdt->clk = clk_get(&pdev->dev, NULL);
+        if (IS_ERR(wdt->clk)) {
+                ret = PTR_ERR(wdt->clk);
+                printk(KERN_ERR "MXC watchdog: no clock source found\n");
+                goto err_clk;
+        }
+
+        wdt->base = ioremap(res->start, resource_size(res));
+        if (!wdt->base) {
+                ret = -ENOMEM;
+                goto err_ioremap;
+        }
+
+        platform_set_drvdata(pdev, wdt);
+
+        mxc_wdt_miscdev.parent = &pdev->dev;
+
+        ret = misc_register(&mxc_wdt_miscdev);
+        if (ret)
+                goto err_misc;
+
+        pr_info("MXC watchdog: initial timeout %d sec\n", timer_margin);
+
+        mxc_wdt_dev = pdev;
+
+        return 0;
+
+ err_misc:
+        platform_set_drvdata(pdev, NULL);
+        iounmap(wdt->base);
+
+ err_ioremap:
+        clk_put(wdt->clk);
+
+ err_clk:
+        release_mem_region(res->start, resource_size(res));
+
+ err_busy:
+        kfree(wdt);
+
+ err_kzalloc:
+ err_get_resource:
+        return ret;
+}
+
+static void mxc_wdt_shutdown(struct platform_device *pdev)
+{
+        struct mxc_wdt *wdt = platform_get_drvdata(pdev);
+
+        if (wdt->status)
+                mxc_wdt_disable(wdt);
+}
+
+static int __devexit mxc_wdt_remove(struct platform_device *pdev)
+{
+        struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+        struct mxc_wdt *wdt = platform_get_drvdata(pdev);
+
+        if (!res)
+                return -ENOENT;
+
+        misc_deregister(&mxc_wdt_miscdev);
+
+        platform_set_drvdata(pdev, NULL);
+        iounmap(wdt->base);
+
+        clk_put(wdt->clk);
+
+        release_mem_region(res->start, resource_size(res));
+
+        kfree(wdt);
+        mxc_wdt_dev = NULL;
+
+        return 0;
+}
+
+static struct platform_driver mxc_wdt_driver = {
+        .probe         = mxc_wdt_probe,
+        .remove        = __devexit_p(mxc_wdt_remove),
+        .shutdown      = mxc_wdt_shutdown,
+        .driver        = {
+                .owner = THIS_MODULE,
+                .name  = "imx-wdt",
+        },
+};
+
+static int __init mxc_wdt_init(void)
+{
+        if ((timer_margin < TIMER_MARGIN_MIN) ||
+            (timer_margin > TIMER_MARGIN_MAX)) {
+                pr_info("MXC watchdog error: wrong timer_margin %d\n",
+                        timer_margin);
+                pr_info("    Valid range: %d to %d seconds\n", TIMER_MARGIN_MIN,
+                        TIMER_MARGIN_MAX);
+                return -EINVAL;
+        }
+
+        spin_lock_init(&wdt_lock);
+        return platform_driver_register(&mxc_wdt_driver);
+}
+
+static void __exit mxc_wdt_exit(void)
+{
+        platform_driver_unregister(&mxc_wdt_driver);
+}
+
+module_init(mxc_wdt_init);
+module_exit(mxc_wdt_exit);
+
+MODULE_AUTHOR("Vladimir Zapolskiy");
+MODULE_DESCRIPTION("MXC Watchdog");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imx-wdt");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.6.6.1
