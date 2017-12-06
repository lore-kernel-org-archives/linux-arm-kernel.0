From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Dec 2017 09:36:18 +0100
Subject: [PATCH v2 5/5] rtc: add mxc driver for i.MX53 SRTC
In-Reply-To: <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-6-linux-kernel-dev@beckhoff.com>
Message-ID: <20171206083618.eea63zqmpgaaazwl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 03:06:46PM +0100, linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
> 
> Neither rtc-imxdi, rtc-mxc nor rtc-snvs are compatible with i.MX53.
> 
> This is driver enables support for the low power domain SRTC features:
> - 32-bit MSB of non-rollover time counter
> - 32-bit alarm register
> 
> Based on:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/rtc/rtc-mxc_v2.c?h=imx_2.6.35_11.09.01
> 
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
> 
> ---
> 
> v2:
> - have seperate patches for dt-binding, CONFIG option, imx53.dtsi and driver
> - add SPDX-License-Identifier and cleanup copyright notice
> - replace __raw_readl/writel() with readl/writel()
> - fix PM_SLEEP callbacks
> - add CONFIG_RTC_DRV_MXC_V2 to build rtc-mxc_v2.c
> - remove misleading or obvious comments and fix style of the remaining
> - avoid endless loop while waiting for hw
> - implement consistent locking; make spinlock a member of dev struct
> - enable clk only for register accesses
> - remove all udelay() calls since they are obsolete or redundant
>   (we are already waiting for register flags to change)
> - init platform_data before registering irq callback
> - let set_time() fail, when 32 bit rtc counter exceeded
> - make names more consistent
> - cleanup and reorder includes
> - cleanup and remove unused defines
> 
> To: Alessandro Zummo <a.zummo@towertech.it>
> To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Cc: linux-rtc at vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
> Cc: devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> Cc: linux-kernel at vger.kernel.org (open list)
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Juergen Borleis <jbe@pengutronix.de>
> Cc: Noel Vellemans <Noel.Vellemans@visionbms.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
> Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
> Cc: linux-arm-kernel at lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
> 
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-mxc_v2.c | 433 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 434 insertions(+)
>  create mode 100644 drivers/rtc/rtc-mxc_v2.c
> 
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index f2f50c11dc38..dcf60e61ae5c 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -106,6 +106,7 @@ obj-$(CONFIG_RTC_DRV_MT6397)	+= rtc-mt6397.o
>  obj-$(CONFIG_RTC_DRV_MT7622)	+= rtc-mt7622.o
>  obj-$(CONFIG_RTC_DRV_MV)	+= rtc-mv.o
>  obj-$(CONFIG_RTC_DRV_MXC)	+= rtc-mxc.o
> +obj-$(CONFIG_RTC_DRV_MXC_V2)	+= rtc-mxc_v2.o
>  obj-$(CONFIG_RTC_DRV_NUC900)	+= rtc-nuc900.o
>  obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
>  obj-$(CONFIG_RTC_DRV_OPAL)	+= rtc-opal.o
> diff --git a/drivers/rtc/rtc-mxc_v2.c b/drivers/rtc/rtc-mxc_v2.c
> new file mode 100644
> index 000000000000..c5a6d2c293bb
> --- /dev/null
> +++ b/drivers/rtc/rtc-mxc_v2.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Real Time Clock (RTC) Driver for i.MX53
> + * Copyright (c) 2004-2011 Freescale Semiconductor, Inc.
> + * Copyright (c) 2017 Beckhoff Automation GmbH & Co. KG
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +#define SRTC_LPPDR_INIT       0x41736166	/* init for glitch detect */
> +
> +#define SRTC_LPCR_EN_LP       BIT(3)	/* lp enable */
> +#define SRTC_LPCR_WAE         BIT(4)	/* lp wakeup alarm enable */
> +#define SRTC_LPCR_ALP         BIT(7)	/* lp alarm flag */
> +#define SRTC_LPCR_NSA         BIT(11)	/* lp non secure access */
> +#define SRTC_LPCR_NVE         BIT(14)	/* lp non valid state exit bit */
> +#define SRTC_LPCR_IE          BIT(15)	/* lp init state exit bit */
> +
> +#define SRTC_LPSR_ALP         BIT(3)	/* lp alarm flag */
> +#define SRTC_LPSR_NVES        BIT(14)	/* lp non-valid state exit status */
> +#define SRTC_LPSR_IES         BIT(15)	/* lp init state exit status */
> +
> +#define SRTC_LPSCMR	0x00	/* LP Secure Counter MSB Reg */
> +#define SRTC_LPSCLR	0x04	/* LP Secure Counter LSB Reg */
> +#define SRTC_LPSAR	0x08	/* LP Secure Alarm Reg */
> +#define SRTC_LPCR	0x10	/* LP Control Reg */
> +#define SRTC_LPSR	0x14	/* LP Status Reg */
> +#define SRTC_LPPDR	0x18	/* LP Power Supply Glitch Detector Reg */
> +
> +/* max. number of retries to read registers, 120 was max during test */
> +#define REG_READ_TIMEOUT 2000
> +
> +struct mxc_rtc_data {
> +	struct rtc_device *rtc;
> +	void __iomem *ioaddr;
> +	struct clk *clk;
> +	spinlock_t lock; /* protects register access */
> +	int irq;
> +};
> +
> +/*
> + * This function does write synchronization for writes to the lp srtc block.
> + * To take care of the asynchronous CKIL clock, all writes from the IP domain
> + * will be synchronized to the CKIL domain.
> + * The caller should hold the pdata->lock
> + */
> +static inline void mxc_rtc_sync_lp_locked(void __iomem *ioaddr)
> +{
> +	unsigned int i;
> +
> +	/* Wait for 3 CKIL cycles */
> +	for (i = 0; i < 3; i++) {
> +		const u32 count = readl(ioaddr + SRTC_LPSCLR);
> +		unsigned int timeout = REG_READ_TIMEOUT;
> +
> +		while ((readl(ioaddr + SRTC_LPSCLR)) == count) {
> +			if (!--timeout) {
> +				pr_err("SRTC_LPSCLR stuck! Check your hw.\n");
> +				return;
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * This function updates the RTC alarm registers and then clears all the
> + * interrupt status bits.
> + * The caller should hold the pdata->lock
> + *
> + * @param  alrm         the new alarm value to be updated in the RTC
> + *
> + * @return  0 if successful; non-zero otherwise.
> + */
> +static int mxc_rtc_write_alarm_locked(struct mxc_rtc_data *const pdata,
> +				      struct rtc_time *alarm_tm)
> +{
> +	void __iomem *const ioaddr = pdata->ioaddr;
> +	unsigned long time;
> +
> +	rtc_tm_to_time(alarm_tm, &time);
> +
> +	if (time > U32_MAX) {
> +		pr_err("Hopefully I am out of service by then :-(\n");
> +		return -EINVAL;
> +	}

This will never happen as on your target hardware unsigned long is a
32bit type. Not sure what is best to do here. Maybe you should test
the return value of rtc_tm_to_time. ATM it returns 0 unconditionally,
but rtc_tm_to_time could detect when the input time doesn't fit into
its return type and return an error in this case.
Also I just realized that it's unsigned and only overflows in the year
2106. I'm most likely dead then so I don't care that much ;)

> +
> +	writel((u32)time, ioaddr + SRTC_LPSAR);
> +
> +	/* clear alarm interrupt status bit */
> +	writel(SRTC_LPSR_ALP, ioaddr + SRTC_LPSR);
> +
> +	mxc_rtc_sync_lp_locked(ioaddr);
> +	return 0;
> +}
> +
> +/* This function is the RTC interrupt service routine. */
> +static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	struct mxc_rtc_data *pdata = platform_get_drvdata(pdev);
> +	void __iomem *ioaddr = pdata->ioaddr;
> +	unsigned long flags;
> +	u32 events = 0;
> +	u32 lp_status;
> +	u32 lp_cr;
> +
> +	spin_lock_irqsave(&pdata->lock, flags);
> +	if (clk_prepare_enable(pdata->clk)) {
> +		spin_unlock_irqrestore(&pdata->lock, flags);
> +		return IRQ_NONE;
> +	}

You are not allowed to do a clk_prepare under a spinlock. That was the
original reason to split enabling a clk into clk_prepare and clk_enable.
Everything that can block is done in clk_prepare and only non blocking
things are done in clk_enable.
If you want to enable/disable the clock on demand you can clk_prepare()
in probe and clk_enable when you actually need it.

> +
> +	lp_status = readl(ioaddr + SRTC_LPSR);
> +	lp_cr = readl(ioaddr + SRTC_LPCR);
> +
> +	/* update irq data & counter */
> +	if (lp_status & SRTC_LPSR_ALP) {
> +		if (lp_cr & SRTC_LPCR_ALP)
> +			events = (RTC_AF | RTC_IRQF);
> +
> +		/* disable further lp alarm interrupts */
> +		lp_cr &= ~(SRTC_LPCR_ALP | SRTC_LPCR_WAE);
> +	}
> +
> +	/* Update interrupt enables */
> +	writel(lp_cr, ioaddr + SRTC_LPCR);
> +
> +	/* clear interrupt status */
> +	writel(lp_status, ioaddr + SRTC_LPSR);
> +
> +	mxc_rtc_sync_lp_locked(ioaddr);
> +	rtc_update_irq(pdata->rtc, 1, events);
> +	clk_disable_unprepare(pdata->clk);
> +	spin_unlock_irqrestore(&pdata->lock, flags);
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Enable clk and aquire spinlock
> + * @return  0 if successful; non-zero otherwise.
> + */
> +static int mxc_rtc_lock(struct mxc_rtc_data *const pdata)
> +{
> +	int ret;
> +
> +	spin_lock_irq(&pdata->lock);
> +	ret = clk_prepare_enable(pdata->clk);
> +	if (ret) {
> +		spin_unlock_irq(&pdata->lock);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int mxc_rtc_unlock(struct mxc_rtc_data *const pdata)
> +{
> +	clk_disable_unprepare(pdata->clk);
> +	spin_unlock_irq(&pdata->lock);
> +	return 0;
> +}
> +
> +/*
> + * This function reads the current RTC time into tm in Gregorian date.
> + *
> + * @param  tm           contains the RTC time value upon return
> + *
> + * @return  0 if successful; non-zero otherwise.
> + */
> +static int mxc_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
> +	time_t now;
> +	int ret = mxc_rtc_lock(pdata);
> +
> +	if (ret)
> +		return ret;
> +
> +	now = readl(pdata->ioaddr + SRTC_LPSCMR);
> +	rtc_time_to_tm(now, tm);
> +	ret = rtc_valid_tm(tm);
> +	mxc_rtc_unlock(pdata);

I don't think this needs to be locked.

> +	return ret;
> +}
> +
> +/*
> + * This function sets the internal RTC time based on tm in Gregorian date.
> + *
> + * @param  tm           the time value to be set in the RTC
> + *
> + * @return  0 if successful; non-zero otherwise.
> + */
> +static int mxc_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
> +	time64_t time = rtc_tm_to_time64(tm);
> +	int ret;
> +
> +	if (time > U32_MAX) {
> +		dev_err(dev, "RTC exceeded by %llus\n", time - U32_MAX);
> +		return -EINVAL;
> +	}
> +
> +	ret = mxc_rtc_lock(pdata);
> +	if (ret)
> +		return ret;
> +
> +	writel(time, pdata->ioaddr + SRTC_LPSCMR);
> +	mxc_rtc_sync_lp_locked(pdata->ioaddr);
> +	return mxc_rtc_unlock(pdata);
> +}
> +
> +/*
> + * This function reads the current alarm value into the passed in \b alrm
> + * argument. It updates the \b alrm's pending field value based on the whether
> + * an alarm interrupt occurs or not.
> + *
> + * @param  alrm         contains the RTC alarm value upon return
> + *
> + * @return  0 if successful; non-zero otherwise.
> + */
> +static int mxc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
> +	void __iomem *ioaddr = pdata->ioaddr;
> +	int ret;
> +
> +	ret = mxc_rtc_lock(pdata);
> +	if (ret)
> +		return ret;
> +
> +	rtc_time_to_tm(readl(ioaddr + SRTC_LPSAR), &alrm->time);
> +	alrm->pending = !!(readl(ioaddr + SRTC_LPSR) & SRTC_LPSR_ALP);
> +	return mxc_rtc_unlock(pdata);
> +}
> +
> +/*
> + * Enable/Disable alarm interrupt
> + * The caller should hold the pdata->lock
> + */
> +static void mxc_rtc_alarm_irq_enable_locked(struct mxc_rtc_data *pdata,
> +					    unsigned int enable)
> +{
> +	u32 lp_cr = readl(pdata->ioaddr + SRTC_LPCR);
> +
> +	if (enable)
> +		lp_cr |= (SRTC_LPCR_ALP | SRTC_LPCR_WAE);
> +	else
> +		lp_cr &= ~(SRTC_LPCR_ALP | SRTC_LPCR_WAE);
> +
> +	writel(lp_cr, pdata->ioaddr + SRTC_LPCR);
> +}
> +
> +static int mxc_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
> +{
> +	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
> +	int ret = mxc_rtc_lock(pdata);
> +
> +	if (ret)
> +		return ret;
> +
> +	mxc_rtc_alarm_irq_enable_locked(pdata, enable);
> +	return mxc_rtc_unlock(pdata);
> +}
> +
> +/*
> + * This function sets the RTC alarm based on passed in alrm.
> + *
> + * @param  alrm         the alarm value to be set in the RTC
> + *
> + * @return  0 if successful; non-zero otherwise.
> + */
> +static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
> +	int ret = mxc_rtc_lock(pdata);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = mxc_rtc_write_alarm_locked(pdata, &alrm->time);

Is it worth it to make this a separate function?

> +	if (!ret) {
> +		mxc_rtc_alarm_irq_enable_locked(pdata, alrm->enabled);
> +		mxc_rtc_sync_lp_locked(pdata->ioaddr);
> +	}
> +	mxc_rtc_unlock(pdata);
> +	return ret;
> +}
> +
> +static const struct rtc_class_ops mxc_rtc_ops = {
> +	.read_time = mxc_rtc_read_time,
> +	.set_time = mxc_rtc_set_time,
> +	.read_alarm = mxc_rtc_read_alarm,
> +	.set_alarm = mxc_rtc_set_alarm,
> +	.alarm_irq_enable = mxc_rtc_alarm_irq_enable,
> +};
> +
> +static int mxc_rtc_wait_for_flag(void *__iomem ioaddr, int flag)
> +{
> +	unsigned int timeout = REG_READ_TIMEOUT;
> +
> +	while (!(readl(ioaddr) & flag)) {
> +		if (!--timeout) {
> +			pr_err("Wait timeout for 0x%x@%p!\n", flag, ioaddr);

Please use dev_* functions for printing. In this case the message should
probably be printed from the caller.

> +			return -EBUSY;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int mxc_rtc_probe(struct platform_device *pdev)
> +{
> +	struct mxc_rtc_data *pdata;
> +	struct resource *res;
> +	void __iomem *ioaddr;
> +	int ret = 0;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pdata->ioaddr))
> +		return PTR_ERR(pdata->ioaddr);
> +
> +	ioaddr = pdata->ioaddr;
> +
> +	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pdata->clk)) {
> +		dev_err(&pdev->dev, "unable to get rtc clock!\n");
> +		return PTR_ERR(pdata->clk);
> +	}
> +
> +	spin_lock_init(&pdata->lock);
> +	pdata->irq = platform_get_irq(pdev, 0);
> +	if (pdata->irq < 0)
> +		return pdata->irq;
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	ret = clk_prepare_enable(pdata->clk);
> +	if (ret)
> +		return ret;
> +	/* initialize glitch detect */
> +	writel(SRTC_LPPDR_INIT, ioaddr + SRTC_LPPDR);
> +
> +	/* clear lp interrupt status */
> +	writel(0xFFFFFFFF, ioaddr + SRTC_LPSR);
> +
> +	/* move out of init state */
> +	writel((SRTC_LPCR_IE | SRTC_LPCR_NSA), ioaddr + SRTC_LPCR);
> +	xc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_IES);

If this can fail, shouldn't you test for an error?

> +
> +	/* move out of non-valid state */
> +	writel((SRTC_LPCR_IE | SRTC_LPCR_NVE | SRTC_LPCR_NSA |
> +		SRTC_LPCR_EN_LP), ioaddr + SRTC_LPCR);
> +	mxc_rtc_wait_for_flag(ioaddr + SRTC_LPSR, SRTC_LPSR_NVES);

dito

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
