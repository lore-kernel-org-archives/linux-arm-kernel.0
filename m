From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 27 Jan 2010 15:00:47 +0200
Subject: [PATCH 1/3] rtc: driver for the DryIce block found in i.MX25 chips
In-Reply-To: <cover.1264596212.git.baruch@tkos.co.il>
References: <cover.1264596212.git.baruch@tkos.co.il>
Message-ID: <e62d43482b15f0d3f9a25a9868434cd34df0dd76.1264596212.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is based on code from Freescale which accompanies their i.MX25 PDK
board, with some cleanup.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/rtc/Kconfig     |   10 +
 drivers/rtc/Makefile    |    1 +
 drivers/rtc/rtc-imxdi.c |  559 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 570 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-imxdi.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8167e9e..83bd602 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -527,6 +527,16 @@ config RTC_DRV_MSM6242
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-msm6242.
 
+config RTC_DRV_IMXDI
+	tristate "Freescale IMX DryIce Real Time Clock"
+	depends on ARCH_MX25
+	depends on RTC_CLASS
+	help
+	   Support for Freescale IMX DryIce RTC
+
+	   This driver can also be built as a module, if so, the module
+	   will be called "rtc-imxdi".
+
 config RTC_MXC
 	tristate "Freescale MXC Real Time Clock"
 	depends on ARCH_MXC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index e5160fd..f2d3420 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_RTC_DRV_EFI)	+= rtc-efi.o
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
 obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
 obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
+obj-$(CONFIG_RTC_DRV_IMXDI)	+= rtc-imxdi.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_M41T80)	+= rtc-m41t80.o
 obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
new file mode 100644
index 0000000..12a6df5
--- /dev/null
+++ b/drivers/rtc/rtc-imxdi.c
@@ -0,0 +1,559 @@
+/*
+ * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2010 Orex Computed Radiography
+ */
+
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/* based on rtc-mc13892.c */
+
+/*
+ * This driver uses the 47-bit 32 kHz counter in the Freescale DryIce block
+ * to implement a Linux RTC. Times and alarms are truncated to seconds.
+ * Since the RTC framework performs API locking via rtc->ops_lock the
+ * only simultaneous accesses we need to deal with is updating DryIce
+ * registers while servicing an alarm.
+ *
+ * Note that reading the DSR (DryIce Status Register) automatically clears
+ * the WCF (Write Complete Flag). All DryIce writes are synchronized to the
+ * LP (Low Power) domain and set the WCF upon completion. Writes to the
+ * DIER (DryIce Interrupt Enable Register) are the only exception. These
+ * occur at normal bus speeds and do not set WCF.  Periodic interrupts are
+ * not supported by the hardware.
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/workqueue.h>
+
+/* DryIce Register Definitions */
+
+#define DTCMR     0x00           /* Time Counter MSB Reg */
+#define DTCLR     0x04           /* Time Counter LSB Reg */
+
+#define DCAMR     0x08           /* Clock Alarm MSB Reg */
+#define DCALR     0x0c           /* Clock Alarm LSB Reg */
+#define DCAMR_UNSET  0xFFFFFFFF  /* doomsday - 1 sec */
+
+#define DCR       0x10           /* Control Reg */
+#define DCR_TCE   (1 << 3)       /* Time Counter Enable */
+
+#define DSR       0x14           /* Status Reg */
+#define DSR_WBF   (1 << 10)      /* Write Busy Flag */
+#define DSR_WNF   (1 << 9)       /* Write Next Flag */
+#define DSR_WCF   (1 << 8)       /* Write Complete Flag */
+#define DSR_WEF   (1 << 7)       /* Write Error Flag */
+#define DSR_CAF   (1 << 4)       /* Clock Alarm Flag */
+#define DSR_NVF   (1 << 1)       /* Non-Valid Flag */
+#define DSR_SVF   (1 << 0)       /* Security Violation Flag */
+
+#define DIER      0x18           /* Interrupt Enable Reg */
+#define DIER_WNIE (1 << 9)       /* Write Next Interrupt Enable */
+#define DIER_WCIE (1 << 8)       /* Write Complete Interrupt Enable */
+#define DIER_WEIE (1 << 7)       /* Write Error Interrupt Enable */
+#define DIER_CAIE (1 << 4)       /* Clock Alarm Interrupt Enable */
+
+/**
+ * struct imxdi_dev - private imxdi rtc data
+ * @pdev: pionter to platform dev
+ * @rtc: pointer to rtc struct
+ * @ioaddr: IO registers pointer
+ * @irq: dryice normal interrupt
+ * @clk: input reference clock
+ * @dsr: copy of the DSR register
+ * @irq_lock: interrupt enable register (DIER) lock
+ * @write_wait: registers write complete queue
+ * @write_mutex: serialize registers write
+ * @work: schedule alarm work
+ */
+struct imxdi_dev {
+	struct platform_device *pdev;
+	struct rtc_device *rtc;
+	void __iomem *ioaddr;
+	int irq;
+	struct clk *clk;
+	u32 dsr;
+	spinlock_t irq_lock;
+	wait_queue_head_t write_wait;
+	struct mutex write_mutex;
+	struct work_struct work;
+};
+
+/*
+ * enable a dryice interrupt
+ */
+static inline void di_int_enable(struct imxdi_dev *imxdi, u32 intr)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&imxdi->irq_lock, flags);
+	__raw_writel(__raw_readl(imxdi->ioaddr+DIER) | intr,
+			imxdi->ioaddr+DIER);
+	spin_unlock_irqrestore(&imxdi->irq_lock, flags);
+}
+
+/*
+ * disable a dryice interrupt
+ */
+static inline void di_int_disable(struct imxdi_dev *imxdi, u32 intr)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&imxdi->irq_lock, flags);
+	__raw_writel(__raw_readl(imxdi->ioaddr+DIER) & ~intr,
+			imxdi->ioaddr+DIER);
+	spin_unlock_irqrestore(&imxdi->irq_lock, flags);
+}
+
+/*
+ * This function attempts to clear the dryice write-error flag.
+ *
+ * A dryice write error is similar to a bus fault and should not occur in
+ * normal operation.  Clearing the flag requires another write, so the root
+ * cause of the problem may need to be fixed before the flag can be cleared.
+ */
+static void clear_write_error(struct imxdi_dev *imxdi)
+{
+	int cnt;
+
+	dev_warn(&imxdi->pdev->dev, "WARNING: Register write error!\n");
+
+	for (;;) {
+		/* clear the write error flag */
+		__raw_writel(DSR_WEF, imxdi->ioaddr+DSR);
+
+		/* wait for it to take effect */
+		for (cnt = 0; cnt < 100; cnt++) {
+			if ((__raw_readl(imxdi->ioaddr+DSR) & DSR_WEF) == 0)
+				return;
+			udelay(10);
+		}
+		dev_err(&imxdi->pdev->dev,
+			"ERROR: Cannot clear write-error flag!\n");
+	}
+}
+
+/*
+ * Write a dryice register and wait until it completes.
+ *
+ * This function uses interrupts to determine when the
+ * write has completed.
+ */
+static int di_write_wait(struct imxdi_dev *imxdi, u32 val, int reg)
+{
+	int ret;
+	int rc = 0;
+
+	/* serialize register writes */
+	mutex_lock(&imxdi->write_mutex);
+
+	/* enable the write-complete interrupt */
+	di_int_enable(imxdi, DIER_WCIE);
+
+	imxdi->dsr = 0;
+
+	/* do the register write */
+	__raw_writel(val, imxdi->ioaddr+reg);
+
+	/* wait for the write to finish */
+	ret = wait_event_interruptible_timeout(imxdi->write_wait,
+			imxdi->dsr & (DSR_WCF | DSR_WEF), 1 * HZ);
+	if (ret == 0)
+		dev_warn(&imxdi->pdev->dev,
+				"Write-wait timeout "
+				"val = 0x%08x reg = 0x%08x\n", val, reg);
+
+	/* check for write error */
+	if (imxdi->dsr & DSR_WEF) {
+		clear_write_error(imxdi);
+		rc = -EIO;
+	}
+	mutex_unlock(&imxdi->write_mutex);
+	return rc;
+}
+
+/*
+ * rtc device ioctl
+ *
+ * The rtc framework handles the basic rtc ioctls on behalf
+ * of the driver by calling the functions registered in the
+ * rtc_ops structure.
+ */
+static int dryice_rtc_ioctl(struct device *dev, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s(0x%x)\n", __func__, cmd);
+	switch (cmd) {
+	case RTC_AIE_OFF:  /* alarm disable */
+		di_int_disable(imxdi, DIER_CAIE);
+		return 0;
+
+	case RTC_AIE_ON:  /* alarm enable */
+		di_int_enable(imxdi, DIER_CAIE);
+		return 0;
+	}
+	return -ENOIOCTLCMD;
+}
+
+/*
+ * read the seconds portion of the current time from the dryice time counter
+ */
+static int dryice_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
+	unsigned long now;
+
+	now = __raw_readl(imxdi->ioaddr+DTCMR);
+	rtc_time_to_tm(now, tm);
+
+	return 0;
+}
+
+/*
+ * set the seconds portion of dryice time counter and clear the
+ * fractional part.
+ */
+static int dryice_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
+	unsigned long now;
+	int rc;
+
+	rc = rtc_tm_to_time(tm, &now);
+	if (rc == 0)
+		/* zero the fractional part first */
+		rc = di_write_wait(imxdi, 0, DTCLR);
+	if (rc == 0)
+		rc = di_write_wait(imxdi, now, DTCMR);
+
+	return rc;
+}
+
+/*
+ * read the seconds portion of the alarm register.
+ * the fractional part of the alarm register is always zero.
+ */
+static int dryice_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
+	u32 dcamr;
+
+	dcamr = __raw_readl(imxdi->ioaddr+DCAMR);
+	rtc_time_to_tm(dcamr, &alarm->time);
+
+	/* alarm is enabled if the interrupt is enabled */
+	alarm->enabled = (__raw_readl(imxdi->ioaddr+DIER) & DIER_CAIE) != 0;
+
+	/* don't allow the DSR read to mess up DSR_WCF */
+	mutex_lock(&imxdi->write_mutex);
+
+	/* alarm is pending if the alarm flag is set */
+	alarm->pending = (__raw_readl(imxdi->ioaddr+DSR) & DSR_CAF) != 0;
+
+	mutex_unlock(&imxdi->write_mutex);
+
+	return 0;
+}
+
+/*
+ * set the seconds portion of dryice alarm register
+ */
+static int dryice_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct imxdi_dev *imxdi = dev_get_drvdata(dev);
+	unsigned long now;
+	unsigned long alarm_time;
+	int rc;
+
+	rc = rtc_tm_to_time(&alarm->time, &alarm_time);
+	if (rc)
+		return rc;
+
+	/* don't allow setting alarm in the past */
+	now = __raw_readl(imxdi->ioaddr+DTCMR);
+	if (alarm_time < now)
+		return -EINVAL;
+
+	/* write the new alarm time */
+	rc = di_write_wait(imxdi, (u32)alarm_time, DCAMR);
+	if (rc)
+		return rc;
+
+	if (alarm->enabled)
+		di_int_enable(imxdi, DIER_CAIE);  /* enable alarm intr */
+	else
+		di_int_disable(imxdi, DIER_CAIE); /* disable alarm intr */
+
+	return 0;
+}
+
+static struct rtc_class_ops dryice_rtc_ops = {
+	.ioctl = dryice_rtc_ioctl,
+	.read_time = dryice_rtc_read_time,
+	.set_time = dryice_rtc_set_time,
+	.read_alarm = dryice_rtc_read_alarm,
+	.set_alarm = dryice_rtc_set_alarm,
+};
+
+/*
+ * dryice "normal" interrupt handler
+ */
+static irqreturn_t dryice_norm_irq(int irq, void *dev_id)
+{
+	struct imxdi_dev *imxdi = dev_id;
+	u32 dsr, dier;
+	irqreturn_t rc = IRQ_NONE;
+
+	dier = __raw_readl(imxdi->ioaddr+DIER);
+
+	/* handle write complete and write error cases */
+	if ((dier & DIER_WCIE)) {
+		/*If the write wait queue is empty then there is no pending
+		  operations. It means the interrupt is for DryIce -Security.
+		  IRQ must be returned as none.*/
+		if (list_empty_careful(&imxdi->write_wait.task_list))
+			return rc;
+
+		/* DSR_WCF clears itself on DSR read */
+		dsr = __raw_readl(imxdi->ioaddr+DSR);
+		if ((dsr & (DSR_WCF | DSR_WEF))) {
+			/* mask the interrupt */
+			di_int_disable(imxdi, DIER_WCIE);
+
+			/* save the dsr value for the wait queue */
+			imxdi->dsr |= dsr;
+
+			wake_up_interruptible(&imxdi->write_wait);
+			rc = IRQ_HANDLED;
+		}
+	}
+
+	/* handle the alarm case */
+	if ((dier & DIER_CAIE)) {
+		/* DSR_WCF clears itself on DSR read */
+		dsr = __raw_readl(imxdi->ioaddr+DSR);
+		if (dsr & DSR_CAF) {
+			/* mask the interrupt */
+			di_int_disable(imxdi, DIER_CAIE);
+
+			/* finish alarm in user context */
+			schedule_work(&imxdi->work);
+			rc = IRQ_HANDLED;
+		}
+	}
+	return rc;
+}
+
+/*
+ * post the alarm event from user context so it can sleep
+ * on the write completion.
+ */
+static void dryice_work(struct work_struct *work)
+{
+	struct imxdi_dev *imxdi = container_of(work,
+			struct imxdi_dev, work);
+
+	/* dismiss the interrupt (ignore error) */
+	di_write_wait(imxdi, DSR_CAF, DSR);
+
+	/*
+	 * pass the alarm event to the rtc framework. note that
+	 * rtc_update_irq expects to be called with interrupts off.
+	 */
+	local_irq_disable();
+	rtc_update_irq(imxdi->rtc, 1, RTC_AF | RTC_IRQF);
+	local_irq_enable();
+}
+
+/*
+ * probe for dryice rtc device
+ */
+static int dryice_rtc_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct imxdi_dev *imxdi = NULL;
+	int rc = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	imxdi = kzalloc(sizeof(*imxdi), GFP_KERNEL);
+	if (!imxdi)
+		return -ENOMEM;
+
+	imxdi->pdev = pdev;
+	imxdi->irq = -1;
+
+	if (!request_mem_region(res->start, resource_size(res),
+				pdev->name)) {
+		rc = -EBUSY;
+		goto err_free_mem;
+	}
+	imxdi->ioaddr = ioremap(res->start, resource_size(res));
+	if (imxdi->ioaddr == NULL) {
+		rc = -ENOMEM;
+		goto err_release_region;
+	}
+	imxdi->irq = platform_get_irq(pdev, 0);
+
+	init_waitqueue_head(&imxdi->write_wait);
+
+	INIT_WORK(&imxdi->work, dryice_work);
+
+	mutex_init(&imxdi->write_mutex);
+
+	imxdi->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(imxdi->clk)) {
+		rc = -ENODEV;
+		goto err;
+	}
+	clk_enable(imxdi->clk);
+
+	if (imxdi->irq >= 0) {
+		if (request_irq(imxdi->irq, dryice_norm_irq, IRQF_SHARED,
+				pdev->name, imxdi) < 0) {
+			dev_warn(&pdev->dev, "interrupt not available.\n");
+			imxdi->irq = -1;
+			goto err;
+		}
+	}
+
+	/*
+	 * Initialize dryice hardware
+	 */
+
+	/* put dryice into valid state */
+	if (__raw_readl(imxdi->ioaddr+DSR) & DSR_NVF)
+		rc = di_write_wait(imxdi, DSR_NVF | DSR_SVF, DSR);
+	if (rc)
+		goto err;
+
+	/* mask alarm interrupt */
+	di_int_disable(imxdi, DIER_CAIE);
+
+	/* initialize alarm */
+	rc = di_write_wait(imxdi, DCAMR_UNSET, DCAMR);
+	if (rc == 0)
+		rc = di_write_wait(imxdi, 0, DCALR);
+	if (rc)
+		goto err;
+
+	/* clear alarm flag */
+	if (__raw_readl(imxdi->ioaddr+DSR) & DSR_CAF)
+		rc = di_write_wait(imxdi, DSR_CAF, DSR);
+	if (rc)
+		goto err;
+
+	/* the timer won't count if it has never been written to */
+	if (__raw_readl(imxdi->ioaddr+DTCMR) == 0)
+		rc = di_write_wait(imxdi, 0, DTCMR);
+	if (rc)
+		goto err;
+
+	/* start keeping time */
+	if (!(__raw_readl(imxdi->ioaddr+DCR) & DCR_TCE))
+		rc = di_write_wait(imxdi,
+				__raw_readl(imxdi->ioaddr+DCR) | DCR_TCE, DCR);
+	if (rc)
+		goto err;
+
+	imxdi->rtc = rtc_device_register(pdev->name, &pdev->dev,
+				  &dryice_rtc_ops, THIS_MODULE);
+	if (IS_ERR(imxdi->rtc)) {
+		rc = PTR_ERR(imxdi->rtc);
+		goto err;
+	}
+	platform_set_drvdata(pdev, imxdi);
+
+	return 0;
+err:
+	if (imxdi->rtc && !IS_ERR(imxdi->rtc))
+		rtc_device_unregister(imxdi->rtc);
+
+	if (imxdi->irq >= 0)
+		free_irq(imxdi->irq, imxdi);
+
+	if (imxdi->clk && !IS_ERR(imxdi->clk)) {
+		clk_disable(imxdi->clk);
+		clk_put(imxdi->clk);
+	}
+
+	if (imxdi->ioaddr)
+		iounmap(imxdi->ioaddr);
+
+err_release_region:
+	release_mem_region(res->start, resource_size(res));
+
+err_free_mem:
+	kfree(imxdi);
+
+	return rc;
+}
+
+static int __exit dryice_rtc_remove(struct platform_device *pdev)
+{
+	struct imxdi_dev *imxdi = platform_get_drvdata(pdev);
+	struct resource *mem;
+
+	flush_scheduled_work();
+
+	rtc_device_unregister(imxdi->rtc);
+
+	/* mask alarm interrupt */
+	di_int_disable(imxdi, DIER_CAIE);
+
+	if (imxdi->irq >= 0)
+		free_irq(imxdi->irq, imxdi);
+
+	clk_disable(imxdi->clk);
+	clk_put(imxdi->clk);
+
+	iounmap(imxdi->ioaddr);
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+
+	kfree(imxdi);
+
+	return 0;
+}
+
+static struct platform_driver dryice_rtc_driver = {
+	.driver = {
+		   .name = "imxdi_rtc",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = dryice_rtc_probe,
+	.remove = __exit_p(dryice_rtc_remove),
+};
+
+static int __init dryice_rtc_init(void)
+{
+	return platform_driver_register(&dryice_rtc_driver);
+}
+
+static void __exit dryice_rtc_exit(void)
+{
+	platform_driver_unregister(&dryice_rtc_driver);
+}
+
+module_init(dryice_rtc_init);
+module_exit(dryice_rtc_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("IMXDI Realtime Clock Driver (RTC)");
+MODULE_LICENSE("GPL");
-- 
1.6.5
