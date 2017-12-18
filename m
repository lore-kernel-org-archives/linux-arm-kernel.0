From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Mon, 18 Dec 2017 12:51:32 +0100
Subject: [PATCH v4 3/4] rtc: add mxc driver for i.MX53 SRTC
In-Reply-To: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
References: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20171218115133.16371-4-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

Neither rtc-imxdi, rtc-mxc nor rtc-snvs are compatible with i.MX53.

This is driver enables support for the low power domain SRTC features:
- 32-bit MSB of non-rollover time counter
- 32-bit alarm register

Select the new config option RTC_DRV_MXC_V2 to build this driver

Based on:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/rtc/rtc-mxc_v2.c?h=imx_2.6.35_11.09.01

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---

v3:
- introduce new config option with the same patch, which adds the driver
- call rtc_update_irq() only if necessary
- merge mxc_rtc_write_alarm_locked() with mxc_rtc_set_alarm()
- only use clk_enable/disable (without "prepare") during operation
- rebase on v4.15-rc3
- consistently use rtc_tm_to_time64() and time64_t
- refactor mxc_rtc_read_time(): don't lock for readl() only;
  don't rtc_valid_tm(); use time64_t
- check returncode of mxc_rtc_wait_for_flag()
- restructure mxc_rtc_sync_lp_locked() to replace pr_err() with
  dev_err_once(); remove explicit 'inline'
- don't touch imx_v4_v5_defconfig, instead add to imx_v6_v7_defconfig

v2:
- have seperate patches for dt-binding, CONFIG option, imx53.dtsi and driver
- add SPDX-License-Identifier and cleanup copyright notice
- replace __raw_readl/writel() with readl/writel()
- fix PM_SLEEP callbacks
- add CONFIG_RTC_DRV_MXC_V2 to build rtc-mxc_v2.c
- remove misleading or obvious comments and fix style of the remaining
- avoid endless loop while waiting for hw
- implement consistent locking; make spinlock a member of dev struct
- enable clk only for register accesses
- remove all udelay() calls since they are obsolete or redundant
  (we are already waiting for register flags to change)
- init platform_data before registering irq callback
- let set_time() fail, when 32 bit rtc counter exceeded
- make names more consistent
- cleanup and reorder includes
- cleanup and remove unused defines

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-rtc at vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Cc: devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-kernel at vger.kernel.org (open list)
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Juergen Borleis <jbe@pengutronix.de>
Cc: Noel Vellemans <Noel.Vellemans@visionbms.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: linux-arm-kernel at lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/rtc/Kconfig      |  10 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-mxc_v2.c | 422 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 433 insertions(+)
 create mode 100644 drivers/rtc/rtc-mxc_v2.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b59a31b079a5..440edebf5c71 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1689,6 +1689,16 @@ config RTC_DRV_MXC
 	   This driver can also be built as a module, if so, the module
 	   will be called "rtc-mxc".
 
+config RTC_DRV_MXC_V2
+	tristate "Freescale MXC Real Time Clock for i.MX53"
+	depends on ARCH_MXC
+	help
+	   If you say yes here you get support for the Freescale MXC
+	   SRTC module in i.MX53 processor.
+
+	   This driver can also be built as a module, if so, the module
+	   will be called "rtc-mxc_v2".
+
 config RTC_DRV_SNVS
 	tristate "Freescale SNVS RTC support"
 	select REGMAP_MMIO
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index f2f50c11dc38..dcf60e61ae5c 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_RTC_DRV_MT6397)	+= rtc-mt6397.o
 obj-$(CONFIG_RTC_DRV_MT7622)	+= rtc-mt7622.o
 obj-$(CONFIG_RTC_DRV_MV)	+= rtc-mv.o
 obj-$(CONFIG_RTC_DRV_MXC)	+= rtc-mxc.o
+obj-$(CONFIG_RTC_DRV_MXC_V2)	+= rtc-mxc_v2.o
 obj-$(CONFIG_RTC_DRV_NUC900)	+= rtc-nuc900.o
 obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
 obj-$(CONFIG_RTC_DRV_OPAL)	+= rtc-opal.o
diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
new file mode 100644
index 000000000000..b637095b0716
--- /dev/null
+++ b/drivers/rtc/rtc-mxc_v2.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Real Time Clock (RTC) Driver for i.MX53
+ * Copyright (c) 2004-2011 Freescale Semiconductor, Inc.
+ * Copyright (c) 2017 Beckhoff Automation GmbH & Co. KG
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define SRTC_LPPDR_INIT       0x41736166	/* init for glitch detect */
+
+#define SRTC_LPCR_EN_LP       BIT(3)	/* lp enable */
+#define SRTC_LPCR_WAE         BIT(4)	/* lp wakeup alarm enable */
+#define SRTC_LPCR_ALP         BIT(7)	/* lp alarm flag */
+#define SRTC_LPCR_NSA         BIT(11)	/* lp non secure access */
+#define SRTC_LPCR_NVE         BIT(14)	/* lp non valid state exit bit */
+#define SRTC_LPCR_IE          BIT(15)	/* lp init state exit bit */
+
+#define SRTC_LPSR_ALP         BIT(3)	/* lp alarm flag */
+#define SRTC_LPSR_NVES        BIT(14)	/* lp non-valid state exit status */
+#define SRTC_LPSR_IES         BIT(15)	/* lp init state exit status */
+
+#define SRTC_LPSCMR	0x00	/* LP Secure Counter MSB Reg */
+#define SRTC_LPSCLR	0x04	/* LP Secure Counter LSB Reg */
+#define SRTC_LPSAR	0x08	/* LP Secure Alarm Reg */
+#define SRTC_LPCR	0x10	/* LP Control Reg */
+#define SRTC_LPSR	0x14	/* LP Status Reg */
+#define SRTC_LPPDR	0x18	/* LP Power Supply Glitch Detector Reg */
+
+/* max. number of retries to read registers, 120 was max during test */
+#define REG_READ_TIMEOUT 2000
+
+struct mxc_rtc_data {
+	struct rtc_device *rtc;
+	void __iomem *ioaddr;
+	struct clk *clk;
+	spinlock_t lock; /* protects register access */
+	int irq;
+};
+
+/*
+ * This function does write synchronization for writes to the lp srtc block.
+ * To take care of the asynchronous CKIL clock, all writes from the IP domain
+ * will be synchronized to the CKIL domain.
+ * The caller should hold the pdata->lock
+ */
+static void mxc_rtc_sync_lp_locked(struct device *dev, void __iomem *ioaddr)
+{
+	unsigned int i;
+
+	/* Wait for 3 CKIL cycles */
+	for (i = 0; i < 3; i++) {
+		const u32 count = readl(ioaddr + SRTC_LPSCLR);
+		unsigned int timeout = REG_READ_TIMEOUT;
+
+		while ((readl(ioaddr + SRTC_LPSCLR)) == count) {
+			if (!--timeout) {
+				dev_err_once(dev, "SRTC_LPSCLR stuck! Check your hw.\n");
+				return;
+			}
+		}
+	}
+}
+
+/* This function is the RTC interrupt service routine. */
+static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	unsigned long flags;
+	u32 lp_status;
+	u32 lp_cr;
+
+	spin_lock_irqsave(&pdata->lock, flags);
+	if (clk_enable(pdata->clk)) {
+		spin_unlock_irqrestore(&pdata->lock, flags);
+		return IRQ_NONE;
+	}
+
+	lp_status = readl(ioaddr + SRTC_LPSR);
+	lp_cr = readl(ioaddr + SRTC_LPCR);
+
+	/* update irq data & counter */
+	if (lp_status & SRTC_LPSR_ALP) {
+		if (lp_cr & SRTC_LPCR_ALP)
+			rtc_update_irq(pdata->rtc, 1, RTC_AF | RTC_IRQF);
+
+		/* disable further lp alarm interrupts */
+		lp_cr &= ~(SRTC_LPCR_ALP | SRTC_LPCR_WAE);
+	}
+
+	/* Update interrupt enables */
+	writel(lp_cr, ioaddr + SRTC_LPCR);
+
+	/* clear interrupt status */
+	writel(lp_status, ioaddr + SRTC_LPSR);
+
+	mxc_rtc_sync_lp_locked(dev, ioaddr);
+	clk_disable(pdata->clk);
+	spin_unlock_irqrestore(&pdata->lock, flags);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Enable clk and aquire spinlock
+ * @return  0 if successful; non-zero otherwise.
+ */
+static int mxc_rtc_lock(struct mxc_rtc_data *const pdata)
+{
+	int ret;
+
+	spin_lock_irq(&pdata->lock);
+	ret = clk_enable(pdata->clk);
+	if (ret) {
+		spin_unlock_irq(&pdata->lock);
+		return ret;
+	}
+	return 0;
+}
+
+static int mxc_rtc_unlock(struct mxc_rtc_data *const pdata)
+{
+	clk_disable(pdata->clk);
+	spin_unlock_irq(&pdata->lock);
+	return 0;
+}
+
+/*
+ * This function reads the current RTC time into tm in Gregorian date.
+ *
+ * @param  tm           contains the RTC time value upon return
+ *
+ * @return  0 if successful; non-zero otherwise.
+ */
+static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
+	const int clk_failed = clk_enable(pdata->clk);
+
+	if (!clk_failed) {
+		const time64_t now = readl(pdata->ioaddr + SRTC_LPSCMR);
+
+		rtc_time64_to_tm(now, tm);
+		clk_disable(pdata->clk);
+		return 0;
+	}
+	return clk_failed;
+}
+
+/*
+ * This function sets the internal RTC time based on tm in Gregorian date.
+ *
+ * @param  tm           the time value to be set in the RTC
+ *
+ * @return  0 if successful; non-zero otherwise.
+ */
+static int mxc_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
+	time64_t time = rtc_tm_to_time64(tm);
+	int ret;
+
+	if (time > U32_MAX) {
+		dev_err(dev, "RTC exceeded by %llus\n", time - U32_MAX);
+		return -EINVAL;
+	}
+
+	ret = mxc_rtc_lock(pdata);
+	if (ret)
+		return ret;
+
+	writel(time, pdata->ioaddr + SRTC_LPSCMR);
+	mxc_rtc_sync_lp_locked(dev, pdata->ioaddr);
+	return mxc_rtc_unlock(pdata);
+}
+
+/*
+ * This function reads the current alarm value into the passed in \b alrm
+ * argument. It updates the \b alrm's pending field value based on the whether
+ * an alarm interrupt occurs or not.
+ *
+ * @param  alrm         contains the RTC alarm value upon return
+ *
+ * @return  0 if successful; non-zero otherwise.
+ */
+static int mxc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	int ret;
+
+	ret = mxc_rtc_lock(pdata);
+	if (ret)
+		return ret;
+
+	rtc_time_to_tm(readl(ioaddr + SRTC_LPSAR), &alrm->time);
+	alrm->pending = !!(readl(ioaddr + SRTC_LPSR) & SRTC_LPSR_ALP);
+	return mxc_rtc_unlock(pdata);
+}
+
+/*
+ * Enable/Disable alarm interrupt
+ * The caller should hold the pdata->lock
+ */
+static void mxc_rtc_alarm_irq_enable_locked(struct mxc_rtc_data *pdata,
+					    unsigned int enable)
+{
+	u32 lp_cr = readl(pdata->ioaddr + SRTC_LPCR);
+
+	if (enable)
+		lp_cr |= (SRTC_LPCR_ALP | SRTC_LPCR_WAE);
+	else
+		lp_cr &= ~(SRTC_LPCR_ALP | SRTC_LPCR_WAE);
+
+	writel(lp_cr, pdata->ioaddr + SRTC_LPCR);
+}
+
+static int mxc_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
+	int ret = mxc_rtc_lock(pdata);
+
+	if (ret)
+		return ret;
+
+	mxc_rtc_alarm_irq_enable_locked(pdata, enable);
+	return mxc_rtc_unlock(pdata);
+}
+
+/*
+ * This function sets the RTC alarm based on passed in alrm.
+ *
+ * @param  alrm         the alarm value to be set in the RTC
+ *
+ * @return  0 if successful; non-zero otherwise.
+ */
+static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	const time64_t time = rtc_tm_to_time64(&alrm->time);
+	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
+	int ret = mxc_rtc_lock(pdata);
+
+	if (ret)
+		return ret;
+
+	if (time > U32_MAX) {
+		dev_err(dev, "Hopefully I am out of service by then :-(\n");
+		return -EINVAL;
+	}
+
+	writel((u32)time, pdata->ioaddr + SRTC_LPSAR);
+
+	/* clear alarm interrupt status bit */
+	writel(SRTC_LPSR_ALP, pdata->ioaddr + SRTC_LPSR);
+	mxc_rtc_sync_lp_locked(dev, pdata->ioaddr);
+
+	mxc_rtc_alarm_irq_enable_locked(pdata, alrm->enabled);
+	mxc_rtc_sync_lp_locked(dev, pdata->ioaddr);
+	mxc_rtc_unlock(pdata);
+	return ret;
+}
+
+static const struct rtc_class_ops mxc_rtc_ops = {
+	.read_time = mxc_rtc_read_time,
+	.set_time = mxc_rtc_set_time,
+	.read_alarm = mxc_rtc_read_alarm,
+	.set_alarm = mxc_rtc_set_alarm,
+	.alarm_irq_enable = mxc_rtc_alarm_irq_enable,
+};
+
+static int mxc_rtc_wait_for_flag(void *__iomem ioaddr, int flag)
+{
+	unsigned int timeout = REG_READ_TIMEOUT;
+
+	while (!(readl(ioaddr) & flag)) {
+		if (!--timeout)
+			return -EBUSY;
+	}
+	return 0;
+}
+
+static int mxc_rtc_probe(struct platform_device *pdev)
+{
+	struct mxc_rtc_data *pdata;
+	struct resource *res;
+	void __iomem *ioaddr;
+	int ret = 0;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pdata->ioaddr))
+		return PTR_ERR(pdata->ioaddr);
+
+	ioaddr = pdata->ioaddr;
+
+	pdata->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pdata->clk)) {
+		dev_err(&pdev->dev, "unable to get rtc clock!\n");
+		return PTR_ERR(pdata->clk);
+	}
+
+	spin_lock_init(&pdata->lock);
+	pdata->irq = platform_get_irq(pdev, 0);
+	if (pdata->irq < 0)
+		return pdata->irq;
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	ret = clk_prepare_enable(pdata->clk);
+	if (ret)
+		return ret;
+	/* initialize glitch detect */
+	writel(SRTC_LPPDR_INIT, ioaddr + SRTC_LPPDR);
+
+	/* clear lp interrupt status */
+	writel(0xFFFFFFFF, ioaddr + SRTC_LPSR);
+
+	/* move out of init state */
+	writel((SRTC_LPCR_IE | SRTC_LPCR_NSA), ioaddr + SRTC_LPCR);
+	ret = mxc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_IES);
+	if (ret) {
+		dev_err(&pdev->dev, "Timeout waiting for SRTC_LPSR_IES\n");
+		clk_disable_unprepare(pdata->clk);
+		return ret;
+	}
+
+	/* move out of non-valid state */
+	writel((SRTC_LPCR_IE | SRTC_LPCR_NVE | SRTC_LPCR_NSA |
+		SRTC_LPCR_EN_LP), ioaddr + SRTC_LPCR);
+	ret = mxc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_NVES);
+	if (ret) {
+		dev_err(&pdev->dev, "Timeout waiting for SRTC_LPSR_NVES\n");
+		clk_disable_unprepare(pdata->clk);
+		return ret;
+	}
+
+	clk_disable(pdata->clk);
+	platform_set_drvdata(pdev, pdata);
+	ret =
+	    devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt, 0,
+			     pdev->name, &pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "interrupt not available.\n");
+		clk_unprepare(pdata->clk);
+		return ret;
+	}
+
+	pdata->rtc =
+	    devm_rtc_device_register(&pdev->dev, pdev->name, &mxc_rtc_ops,
+				     THIS_MODULE);
+	if (IS_ERR(pdata->rtc)) {
+		clk_unprepare(pdata->clk);
+		return PTR_ERR(pdata->rtc);
+	}
+
+	return 0;
+}
+
+static int __exit mxc_rtc_remove(struct platform_device *pdev)
+{
+	struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(pdata->clk);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mxc_rtc_suspend(struct device *dev)
+{
+	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(pdata->irq);
+
+	return 0;
+}
+
+static int mxc_rtc_resume(struct device *dev)
+{
+	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(pdata->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mxc_rtc_pm_ops, mxc_rtc_suspend, mxc_rtc_resume);
+
+static const struct of_device_id mxc_ids[] = {
+	{ .compatible = "fsl,imx53-rtc", },
+	{}
+};
+
+static struct platform_driver mxc_rtc_driver = {
+	.driver = {
+		.name = "mxc_rtc_v2",
+		.of_match_table = mxc_ids,
+		.pm = &mxc_rtc_pm_ops,
+	},
+	.probe = mxc_rtc_probe,
+	.remove = mxc_rtc_remove,
+};
+
+module_platform_driver(mxc_rtc_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Real Time Clock (RTC) Driver for i.MX53");
+MODULE_LICENSE("GPL");
-- 
2.11.0
