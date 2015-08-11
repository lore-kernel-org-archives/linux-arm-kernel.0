From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 11 Aug 2015 20:31:31 +0200
Subject: [rtc-linux] [PATCH v2 2/2] drivers: rtc: add xilinx zynqmp rtc
 driver
In-Reply-To: <1438336757-23404-2-git-send-email-suneel.garapati@xilinx.com>
References: <1438336757-23404-1-git-send-email-suneel.garapati@xilinx.com>
 <1438336757-23404-2-git-send-email-suneel.garapati@xilinx.com>
Message-ID: <20150811183131.GW3411@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please run checkpatch --strict and fix the issues.

On 31/07/2015 at 15:29:17 +0530, Suneel Garapati wrote :
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/rtc.h>
> +

The includes hav to be sorted alphabetically.

> +static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> +	unsigned long new_time;
> +
> +	rtc_tm_to_time(tm, &new_time);

You should use rtc_tm_to_time64() and rtc_time64_to_tm() throughout the
file.

> +	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
> +

Is that a 32bits register? If yes, you probably want to return an error
if the year is 2106 or after.

> +	return 0;
> +}
> +

[...]

> +static int xlnx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
> +	unsigned long alarm_time;
> +

Same comment, you probably want to error out if the time overflows a
32bits register.

> +	rtc_tm_to_time(&alrm->time, &alarm_time);
> +
> +	writel((u32) alarm_time, (xrtcdev->reg_base + RTC_ALRM));
> +
> +	xlnx_rtc_alarm_irq_enable(dev, alrm->enabled);
> +
> +	return 0;
> +}
> +
> +static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev, u32 calibval)
> +{
> +	/*
> +	 * Based on crystal freq of 33.330 KHz
> +	 * set the secounds counter and enable, set fractions counter
typo --------------^

> +	 * to default value suggested as per design spec
> +	 * to correct RTC delay in frequency over period of time.
> +	 */
> +	calibval &= RTC_CALIB_MASK;
> +	writel(calibval, (xrtcdev->reg_base + RTC_CALIB_WR));
> +}
> +
> +static const struct rtc_class_ops xlnx_rtc_ops = {
> +	.set_time	  = xlnx_rtc_set_time,
> +	.read_time	  = xlnx_rtc_read_time,
> +	.read_alarm	  = xlnx_rtc_read_alarm,
> +	.set_alarm	  = xlnx_rtc_set_alarm,
> +	.alarm_irq_enable = xlnx_rtc_alarm_irq_enable,
> +};
> +
> +static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
> +{
> +	struct xlnx_rtc_dev *xrtcdev = (struct xlnx_rtc_dev *) id;
> +	unsigned int status;
> +
> +	status = readl(xrtcdev->reg_base + RTC_INT_STS);
> +	/* Check if interrupt asserted */
> +	if (!(status & (RTC_INT_SEC | RTC_INT_ALRM)))
> +		return IRQ_NONE;
> +
> +	/* Clear interrupt */
> +	writel(status, xrtcdev->reg_base + RTC_INT_STS);
> +
> +	if (status & RTC_INT_SEC)
> +		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
> +	if (status & RTC_INT_ALRM)
> +		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
> +	if (status & RTC_INT_ALRM)
> +		printk("alarm interrupt\n");

I guess this is a debug message that you forgot to remove.

> +static int xlnx_rtc_probe(struct platform_device *pdev)
> +{
> +	struct xlnx_rtc_dev *xrtcdev;
> +	struct resource *res;
> +	int ret;
> +	unsigned int calibvalue;
> +
> +	xrtcdev = devm_kzalloc(&pdev->dev, sizeof(*xrtcdev), GFP_KERNEL);
> +	if (!xrtcdev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, xrtcdev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	xrtcdev->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xrtcdev->reg_base))
> +		return PTR_ERR(xrtcdev->reg_base);
> +
> +	xrtcdev->alarm_irq = platform_get_irq_byname(pdev, "alarm");
> +	if (xrtcdev->alarm_irq < 0) {
> +		dev_err(&pdev->dev, "no irq resource\n");
> +		return xrtcdev->alarm_irq;
> +	}
> +	ret = devm_request_irq(&pdev->dev, xrtcdev->alarm_irq,
> +				xlnx_rtc_interrupt, 0,
> +				dev_name(&pdev->dev), xrtcdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request irq failed\n");
> +		return ret;
> +	}
> +
> +	xrtcdev->sec_irq = platform_get_irq_byname(pdev, "sec");
> +	if (xrtcdev->sec_irq < 0) {
> +		dev_err(&pdev->dev, "no irq resource\n");
> +		return xrtcdev->sec_irq;
> +	}
> +	ret = devm_request_irq(&pdev->dev, xrtcdev->sec_irq,
> +				xlnx_rtc_interrupt, 0,
> +				dev_name(&pdev->dev), xrtcdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request irq failed\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "calibration",
> +					&calibvalue);
> +	if (ret)
> +		calibvalue = RTC_CALIB_DEF;
> +
> +	xlnx_init_rtc(xrtcdev, calibvalue);
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	xrtcdev->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					 &xlnx_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(xrtcdev->rtc)) {
> +		return PTR_ERR(xrtcdev->rtc);
> +	}
> +
> +	return 0;

You should use PTR_ERR_OR_ZERO here.

Thanks,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
