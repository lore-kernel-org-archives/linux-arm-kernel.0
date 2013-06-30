From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 30 Jun 2013 09:52:35 +0200
Subject: [PATCH v3 1/5] rtc: mxc_rtc: Driver rework
In-Reply-To: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130630075234.GE10414@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 12:40:40PM +0400, Alexander Shiyan wrote:
> This patch rework mxc_rtc driver.
> Major changes have been made:
> - Added second clock support (optional) which permit module functionality.
> - Implemented support for periodic interrupts.
> - Some code have been optimized.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/rtc/rtc-mxc.c | 278 +++++++++++++++++++++-----------------------------
>  1 file changed, 119 insertions(+), 159 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
> index ab87bac..8ec47c8 100644
> --- a/drivers/rtc/rtc-mxc.c
> +++ b/drivers/rtc/rtc-mxc.c
> @@ -12,7 +12,6 @@
>  #include <linux/io.h>
>  #include <linux/rtc.h>
>  #include <linux/module.h>
> -#include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> @@ -39,20 +38,6 @@
>  
>  #define RTC_ENABLE_BIT  (1 << 7)
>  
> -#define MAX_PIE_NUM     9
> -#define MAX_PIE_FREQ    512
> -static const u32 PIE_BIT_DEF[MAX_PIE_NUM][2] = {
> -	{ 2,		RTC_2HZ_BIT },
> -	{ 4,		RTC_SAM0_BIT },
> -	{ 8,		RTC_SAM1_BIT },
> -	{ 16,		RTC_SAM2_BIT },
> -	{ 32,		RTC_SAM3_BIT },
> -	{ 64,		RTC_SAM4_BIT },
> -	{ 128,		RTC_SAM5_BIT },
> -	{ 256,		RTC_SAM6_BIT },
> -	{ MAX_PIE_FREQ,	RTC_SAM7_BIT },
> -};
> -
>  #define MXC_RTC_TIME	0
>  #define MXC_RTC_ALARM	1
>  
> @@ -66,9 +51,6 @@ static const u32 PIE_BIT_DEF[MAX_PIE_NUM][2] = {
>  #define RTC_STPWCH	0x1C	/*  32bit rtc stopwatch min reg */
>  #define RTC_DAYR	0x20	/*  32bit rtc days counter reg */
>  #define RTC_DAYALARM	0x24	/*  32bit rtc day alarm reg */
> -#define RTC_TEST1	0x28	/*  32bit rtc test reg 1 */
> -#define RTC_TEST2	0x2C	/*  32bit rtc test reg 2 */
> -#define RTC_TEST3	0x30	/*  32bit rtc test reg 3 */
>  
>  enum imx_rtc_type {
>  	IMX1_RTC,
> @@ -79,29 +61,12 @@ struct rtc_plat_data {
>  	struct rtc_device *rtc;
>  	void __iomem *ioaddr;
>  	int irq;
> -	struct clk *clk;
> -	struct rtc_time g_rtc_alarm;
> +	struct rtc_class_ops	rtc_ops;
> +	struct clk		*clk_rtc;
> +	struct clk		*clk_ipg;
>  	enum imx_rtc_type devtype;
>  };
>  
> -static struct platform_device_id imx_rtc_devtype[] = {
> -	{
> -		.name = "imx1-rtc",
> -		.driver_data = IMX1_RTC,
> -	}, {
> -		.name = "imx21-rtc",
> -		.driver_data = IMX21_RTC,
> -	}, {
> -		/* sentinel */
> -	}
> -};
> -MODULE_DEVICE_TABLE(platform, imx_rtc_devtype);
> -
> -static inline int is_imx1_rtc(struct rtc_plat_data *data)
> -{
> -	return data->devtype == IMX1_RTC;
> -}

What is wrong with this function?

> -
>  /*
>   * This function is used to obtain the RTC time or the alarm value in
>   * second.
> @@ -110,20 +75,16 @@ static u32 get_alarm_or_time(struct device *dev, int time_alarm)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> -	void __iomem *ioaddr = pdata->ioaddr;
> -	u32 day = 0, hr = 0, min = 0, sec = 0, hr_min = 0;
> -
> -	switch (time_alarm) {
> -	case MXC_RTC_TIME:
> -		day = readw(ioaddr + RTC_DAYR);
> -		hr_min = readw(ioaddr + RTC_HOURMIN);
> -		sec = readw(ioaddr + RTC_SECOND);
> -		break;
> -	case MXC_RTC_ALARM:
> -		day = readw(ioaddr + RTC_DAYALARM);
> -		hr_min = readw(ioaddr + RTC_ALRM_HM) & 0xffff;
> -		sec = readw(ioaddr + RTC_ALRM_SEC);
> -		break;
> +	u32 day, hr, min, sec, hr_min;
> +
> +	if (time_alarm == MXC_RTC_TIME) {
> +		day = readw(pdata->ioaddr + RTC_DAYR);
> +		hr_min = readw(pdata->ioaddr + RTC_HOURMIN);
> +		sec = readw(pdata->ioaddr + RTC_SECOND);
> +	} else {
> +		day = readw(pdata->ioaddr + RTC_DAYALARM);
> +		hr_min = readw(pdata->ioaddr + RTC_ALRM_HM);
> +		sec = readw(pdata->ioaddr + RTC_ALRM_SEC);
>  	}

It is debatable whether this change makes sense or not. It is cleanup
though and should not be mixed with functionality change also in this
patch.

>  
>  	hr = hr_min >> 8;
> @@ -140,7 +101,6 @@ static void set_alarm_or_time(struct device *dev, int time_alarm, u32 time)
>  	u32 day, hr, min, sec, temp;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> -	void __iomem *ioaddr = pdata->ioaddr;
>  
>  	day = time / 86400;
>  	time -= day * 86400;
> @@ -155,17 +115,14 @@ static void set_alarm_or_time(struct device *dev, int time_alarm, u32 time)
>  
>  	temp = (hr << 8) + min;
>  
> -	switch (time_alarm) {
> -	case MXC_RTC_TIME:
> -		writew(day, ioaddr + RTC_DAYR);
> -		writew(sec, ioaddr + RTC_SECOND);
> -		writew(temp, ioaddr + RTC_HOURMIN);
> -		break;
> -	case MXC_RTC_ALARM:
> -		writew(day, ioaddr + RTC_DAYALARM);
> -		writew(sec, ioaddr + RTC_ALRM_SEC);
> -		writew(temp, ioaddr + RTC_ALRM_HM);
> -		break;
> +	if (time_alarm == MXC_RTC_TIME) {
> +		writew(day, pdata->ioaddr + RTC_DAYR);
> +		writew(sec, pdata->ioaddr + RTC_SECOND);
> +		writew(temp, pdata->ioaddr + RTC_HOURMIN);
> +	} else {
> +		writew(day, pdata->ioaddr + RTC_DAYALARM);
> +		writew(sec, pdata->ioaddr + RTC_ALRM_SEC);
> +		writew(temp, pdata->ioaddr + RTC_ALRM_HM);
>  	}
>  }
>  
> @@ -179,7 +136,6 @@ static int rtc_update_alarm(struct device *dev, struct rtc_time *alrm)
>  	unsigned long now, time;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> -	void __iomem *ioaddr = pdata->ioaddr;
>  
>  	now = get_alarm_or_time(dev, MXC_RTC_TIME);
>  	rtc_time_to_tm(now, &now_tm);
> @@ -191,8 +147,9 @@ static int rtc_update_alarm(struct device *dev, struct rtc_time *alrm)
>  	alarm_tm.tm_sec = alrm->tm_sec;
>  	rtc_tm_to_time(&alarm_tm, &time);
>  
> -	/* clear all the interrupt status bits */
> -	writew(readw(ioaddr + RTC_RTCISR), ioaddr + RTC_RTCISR);
> +	/* clear interrupt status bit */
> +	writew(RTC_ALM_BIT, pdata->ioaddr + RTC_RTCISR);
> +

This change is not explained. Are there problems with the old code?
This hunk raises a question which should be answered in a commit message
for a separate patch.

>  	set_alarm_or_time(dev, MXC_RTC_ALARM, time);
>  
>  	return 0;
> @@ -203,18 +160,19 @@ static void mxc_rtc_irq_enable(struct device *dev, unsigned int bit,
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> -	void __iomem *ioaddr = pdata->ioaddr;
>  	u32 reg;
>  
>  	spin_lock_irq(&pdata->rtc->irq_lock);
> -	reg = readw(ioaddr + RTC_RTCIENR);
>  
> -	if (enabled)
> +	reg = readw(pdata->ioaddr + RTC_RTCIENR);
> +	if (enabled) {
>  		reg |= bit;
> -	else
> +		/* Clear interrupt status */
> +		writew(reg, pdata->ioaddr + RTC_RTCISR);
> +	} else
>  		reg &= ~bit;
> +	writew(reg, pdata->ioaddr + RTC_RTCIENR);
>  
> -	writew(reg, ioaddr + RTC_RTCIENR);

What's the change introduced here and why is it introduced? reading this
is made unnecessarily complicated due to replacing ioaddr with
pdata->ioaddr.

>  	spin_unlock_irq(&pdata->rtc->irq_lock);
>  }
>  
> @@ -252,30 +210,42 @@ static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -/*
> - * Clear all interrupts and release the IRQ
> - */
> -static void mxc_rtc_release(struct device *dev)
> +static int mxc_rtc_open(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> -	void __iomem *ioaddr = pdata->ioaddr;
>  
> -	spin_lock_irq(&pdata->rtc->irq_lock);
> +	if (pdata->irq >= 0) {
> +		unsigned long rate = clk_get_rate(pdata->clk_rtc);
>  
> -	/* Disable all rtc interrupts */
> -	writew(0, ioaddr + RTC_RTCIENR);
> +		pdata->rtc->max_user_freq = rate / 64;
> +		rtc_irq_set_freq(pdata->rtc, NULL, rate / 64);
> +		mxc_rtc_irq_enable(&pdev->dev, RTC_1HZ_BIT | RTC_SAM7_BIT, 1);
> +	}

The irq seems to be made optional here. Do we need this? Do we want
this? Again, this is something hidden in a big patch.

>  
> -	/* Clear all interrupt status */
> -	writew(0xffffffff, ioaddr + RTC_RTCISR);
> +	return 0;
> +}
>  
> -	spin_unlock_irq(&pdata->rtc->irq_lock);
> +static void mxc_rtc_release(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (pdata->irq >= 0)
> +		mxc_rtc_irq_enable(&pdev->dev, RTC_1HZ_BIT | RTC_SAM7_BIT, 0);
>  }
>  
>  static int mxc_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  {
> -	mxc_rtc_irq_enable(dev, RTC_ALM_BIT, enabled);
> -	return 0;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (pdata->irq >= 0) {
> +		mxc_rtc_irq_enable(dev, RTC_ALM_BIT, enabled);
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>  }
>  
>  /*
> @@ -306,7 +276,7 @@ static int mxc_rtc_set_mmss(struct device *dev, unsigned long time)
>  	/*
>  	 * TTC_DAYR register is 9-bit in MX1 SoC, save time and day of year only
>  	 */
> -	if (is_imx1_rtc(pdata)) {
> +	if (pdata->devtype == IMX1_RTC) {
>  		struct rtc_time tm;
>  
>  		rtc_time_to_tm(time, &tm);
> @@ -331,10 +301,9 @@ static int mxc_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> -	void __iomem *ioaddr = pdata->ioaddr;
>  
>  	rtc_time_to_tm(get_alarm_or_time(dev, MXC_RTC_ALARM), &alrm->time);
> -	alrm->pending = ((readw(ioaddr + RTC_RTCISR) & RTC_ALM_BIT)) ? 1 : 0;
> +	alrm->pending = !!(readw(pdata->ioaddr + RTC_RTCISR) & RTC_ALM_BIT);
>  
>  	return 0;
>  }
> @@ -349,61 +318,41 @@ static int mxc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	int ret;
>  
>  	ret = rtc_update_alarm(dev, &alrm->time);
> -	if (ret)
> -		return ret;
> +	if ((pdata->irq >= 0) && !ret)
> +		mxc_rtc_irq_enable(dev, RTC_ALM_BIT, alrm->enabled);
>  
> -	memcpy(&pdata->g_rtc_alarm, &alrm->time, sizeof(struct rtc_time));
> -	mxc_rtc_irq_enable(dev, RTC_ALM_BIT, alrm->enabled);
> -
> -	return 0;
> +	return ret;
>  }
>  
> -/* RTC layer */
> -static struct rtc_class_ops mxc_rtc_ops = {
> -	.release		= mxc_rtc_release,
> -	.read_time		= mxc_rtc_read_time,
> -	.set_mmss		= mxc_rtc_set_mmss,
> -	.read_alarm		= mxc_rtc_read_alarm,
> -	.set_alarm		= mxc_rtc_set_alarm,
> -	.alarm_irq_enable	= mxc_rtc_alarm_irq_enable,
> -};
> -
>  static int mxc_rtc_probe(struct platform_device *pdev)
>  {
> +	struct rtc_plat_data *pdata;
>  	struct resource *res;
> -	struct rtc_device *rtc;
> -	struct rtc_plat_data *pdata = NULL;
>  	u32 reg;
>  	unsigned long rate;
>  	int ret;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> -
>  	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
>  
> -	pdata->devtype = pdev->id_entry->driver_data;
> -
> -	if (!devm_request_mem_region(&pdev->dev, res->start,
> -				     resource_size(res), pdev->name))
> -		return -EBUSY;
> -
> -	pdata->ioaddr = devm_ioremap(&pdev->dev, res->start,
> -				     resource_size(res));
> -
> -	pdata->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(pdata->clk)) {
> -		dev_err(&pdev->dev, "unable to get clock!\n");
> -		ret = PTR_ERR(pdata->clk);
> -		goto exit_free_pdata;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pdata->ioaddr))
> +		return PTR_ERR(pdata->ioaddr);
> +
> +	pdata->clk_rtc = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pdata->clk_rtc)) {
> +		dev_err(&pdev->dev, "Unable to get clock!\n");
> +		return PTR_ERR(pdata->clk_rtc);
>  	}
>  
> -	clk_prepare_enable(pdata->clk);
> -	rate = clk_get_rate(pdata->clk);
> +	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	if (!IS_ERR(pdata->clk_ipg))
> +		clk_prepare_enable(pdata->clk_ipg);
> +	clk_prepare_enable(pdata->clk_rtc);
>  
> +	rate = clk_get_rate(pdata->clk_rtc);
>  	if (rate == 32768)
>  		reg = RTC_INPUT_CLK_32768HZ;
>  	else if (rate == 32000)
> @@ -411,49 +360,55 @@ static int mxc_rtc_probe(struct platform_device *pdev)
>  	else if (rate == 38400)
>  		reg = RTC_INPUT_CLK_38400HZ;
>  	else {
> -		dev_err(&pdev->dev, "rtc clock is not valid (%lu)\n", rate);
> +		dev_err(&pdev->dev, "RTC clock is not valid (%lu)\n", rate);

churn

>  		ret = -EINVAL;
>  		goto exit_put_clk;
>  	}
>  
> -	reg |= RTC_ENABLE_BIT;
> -	writew(reg, (pdata->ioaddr + RTC_RTCCTL));
> -	if (((readw(pdata->ioaddr + RTC_RTCCTL)) & RTC_ENABLE_BIT) == 0) {
> -		dev_err(&pdev->dev, "hardware module can't be enabled!\n");
> +	writew(reg | RTC_ENABLE_BIT, pdata->ioaddr + RTC_RTCCTL);
> +	if (!(readw(pdata->ioaddr + RTC_RTCCTL) & RTC_ENABLE_BIT)) {
> +		dev_err(&pdev->dev, "Hardware module can't be enabled!\n");

churn

>  		ret = -EIO;
>  		goto exit_put_clk;
>  	}
>  
> -	platform_set_drvdata(pdev, pdata);
> +	/* Disable all interrupts */
> +	writew(0, pdata->ioaddr + RTC_RTCIENR);
>  
> -	/* Configure and enable the RTC */
> -	pdata->irq = platform_get_irq(pdev, 0);
> +	pdata->devtype = pdev->id_entry->driver_data;
> +	platform_set_drvdata(pdev, pdata);
>  
> -	if (pdata->irq >= 0 &&
> -	    devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt,
> -			     IRQF_SHARED, pdev->name, pdev) < 0) {
> -		dev_warn(&pdev->dev, "interrupt not available.\n");
> -		pdata->irq = -1;
> +	pdata->rtc_ops.open		= mxc_rtc_open;
> +	pdata->rtc_ops.release		= mxc_rtc_release;
> +	pdata->rtc_ops.read_time	= mxc_rtc_read_time;
> +	pdata->rtc_ops.set_mmss		= mxc_rtc_set_mmss;
> +	pdata->rtc_ops.read_alarm	= mxc_rtc_read_alarm;
> +	pdata->rtc_ops.set_alarm	= mxc_rtc_set_alarm;
> +	pdata->rtc_ops.alarm_irq_enable	= mxc_rtc_alarm_irq_enable;

So struct rtc_class_ops is embedded into struct rtc_plat_data now. Why
is this necessary?

> +
> +	pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					      &pdata->rtc_ops, THIS_MODULE);
> +	if (IS_ERR(pdata->rtc)) {
> +		ret = PTR_ERR(pdata->rtc);
> +		goto exit_put_clk;
>  	}
>  
> +	pdata->irq = platform_get_irq(pdev, 0);
>  	if (pdata->irq >= 0)
> -		device_init_wakeup(&pdev->dev, 1);
> +		if (devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt,
> +				     IRQF_SHARED, pdev->name, pdev) < 0) {
> +			dev_warn(&pdev->dev, "Not using interrupt\n");
> +			pdata->irq = -1;
> +		}
>  
> -	rtc = devm_rtc_device_register(&pdev->dev, pdev->name, &mxc_rtc_ops,
> -				  THIS_MODULE);
> -	if (IS_ERR(rtc)) {
> -		ret = PTR_ERR(rtc);
> -		goto exit_put_clk;
> -	}
> -
> -	pdata->rtc = rtc;
> +	device_init_wakeup(&pdev->dev, pdata->irq >= 0);
>  
>  	return 0;
>  
>  exit_put_clk:
> -	clk_disable_unprepare(pdata->clk);
> -
> -exit_free_pdata:
> +	clk_disable_unprepare(pdata->clk_rtc);
> +	if (!IS_ERR(pdata->clk_ipg))
> +		clk_disable_unprepare(pdata->clk_ipg);
>  
>  	return ret;
>  }
> @@ -462,13 +417,14 @@ static int mxc_rtc_remove(struct platform_device *pdev)
>  {
>  	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
>  
> -	clk_disable_unprepare(pdata->clk);
> +	clk_disable_unprepare(pdata->clk_rtc);
> +	if (!IS_ERR(pdata->clk_ipg))
> +		clk_disable_unprepare(pdata->clk_ipg);
>  
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int mxc_rtc_suspend(struct device *dev)
> +static int __maybe_unused mxc_rtc_suspend(struct device *dev)
>  {
>  	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
>  
> @@ -478,7 +434,7 @@ static int mxc_rtc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int mxc_rtc_resume(struct device *dev)
> +static int __maybe_unused mxc_rtc_resume(struct device *dev)
>  {
>  	struct rtc_plat_data *pdata = dev_get_drvdata(dev);
>  
> @@ -487,24 +443,28 @@ static int mxc_rtc_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(mxc_rtc_pm_ops, mxc_rtc_suspend, mxc_rtc_resume);
>  
> +static const struct platform_device_id mxc_rtc_id_table[] = {
> +	{ .name = "imx1-rtc", .driver_data = IMX1_RTC, },
> +	{ .name = "imx21-rtc", .driver_data = IMX21_RTC, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, mxc_rtc_id_table);
> +
>  static struct platform_driver mxc_rtc_driver = {
>  	.driver = {
>  		   .name	= "mxc_rtc",
>  		   .pm		= &mxc_rtc_pm_ops,
>  		   .owner	= THIS_MODULE,
>  	},
> -	.id_table = imx_rtc_devtype,
> +	.id_table = mxc_rtc_id_table,
>  	.probe = mxc_rtc_probe,
>  	.remove = mxc_rtc_remove,
>  };
> -
>  module_platform_driver(mxc_rtc_driver)
>  
>  MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
>  MODULE_DESCRIPTION("RTC driver for Freescale MXC");
>  MODULE_LICENSE("GPL");
> -
> -- 
> 1.8.1.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
