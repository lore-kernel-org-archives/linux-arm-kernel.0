From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 30 Nov 2017 12:21:05 +0100
Subject: [PATCH] rtc: add mxc driver for i.MX53
In-Reply-To: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20171130122105.40cf6819@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 28 Nov 2017 08:39:27 +0100 linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
[...]
> +/*!
> + * This function is the RTC interrupt service routine.
> + *
> + * @param  irq          RTC IRQ number
> + * @param  dev_id       device ID which is not used
> + *
> + * @return IRQ_HANDLED as defined in the include/linux/interrupt.h file.
> + */
> +static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	struct rtc_drv_data *pdata = platform_get_drvdata(pdev);
> +	void __iomem *ioaddr = pdata->ioaddr;
> +	u32 lp_status, lp_cr;
> +	u32 events = 0;
> +
> +	lp_status = __raw_readl(ioaddr + SRTC_LPSR);
> +	lp_cr = __raw_readl(ioaddr + SRTC_LPCR);
> +
> +	/* update irq data & counter */
> +	if (lp_status & SRTC_LPSR_ALP) {
> +		if (lp_cr & SRTC_LPCR_ALP)
> +			events |= (RTC_AF | RTC_IRQF);
> +
> +		/* disable further lp alarm interrupts */
> +		lp_cr &= ~(SRTC_LPCR_ALP | SRTC_LPCR_WAE);
> +	}
> +
> +	/* Update interrupt enables */
> +	__raw_writel(lp_cr, ioaddr + SRTC_LPCR);
> +
> +	/* clear interrupt status */
> +	__raw_writel(lp_status, ioaddr + SRTC_LPSR);
> +
> +	rtc_write_sync_lp(ioaddr);
> +	rtc_update_irq(pdata->rtc, 1, events);
> +	return IRQ_HANDLED;
> +}
> +
see comment below...

> +/*! MXC RTC Power management control */
> +static int mxc_rtc_probe(struct platform_device *pdev)
> +{
> +	struct timespec tv;
> +	struct resource *res;
> +	struct rtc_drv_data *pdata = NULL;
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
> +	ret = clk_prepare_enable(pdata->clk);
> +	if (ret)
> +		return ret;
>
Is it really necessary to have the clock enabled all the time, or
should it be enabled/disabled for the register accesses only?

> +	/* Configure and enable the RTC */
> +	pdata->irq = platform_get_irq(pdev, 0);
> +	if (pdata->irq >= 0
> +	    && devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt,
> +				IRQF_SHARED, pdev->name, pdev) < 0) {
>
If requesting an IRQ with the IRQF_SHARED flag, the interrupt handler
must check whether it was responsible for the IRQ and return IRQ_NONE
if that is not the case to allow some other interrupt handler to jump
in. But AFAICS the RTC IRQ is not shared with any other device, so
requesting the IRQ with IRQF_SHARED is invalid here!

> +		dev_warn(&pdev->dev, "interrupt not available.\n");
> +		pdata->irq = -1;
> +	}
> +
> +	if (pdata->irq >= 0)
> +		device_init_wakeup(&pdev->dev, 1);
> +
> +	/* initialize glitch detect */
> +	__raw_writel(SRTC_LPPDR_INIT, ioaddr + SRTC_LPPDR);
> +	udelay(100);
> +
> +	/* clear lp interrupt status */
> +	__raw_writel(0xFFFFFFFF, ioaddr + SRTC_LPSR);
> +	udelay(100);
> +
> +	/* move out of init state */
> +	__raw_writel((SRTC_LPCR_IE | SRTC_LPCR_NSA), ioaddr + SRTC_LPCR);
> +
> +	udelay(100);
> +
> +	while ((__raw_readl(ioaddr + SRTC_LPSR) & SRTC_LPSR_IES) == 0)
> +		;
>
Loops polling for the change of HW controlled bits should have a
timeout, to prevent locking up when the hardware misbehaves.

> +	/* move out of non-valid state */
> +	__raw_writel((SRTC_LPCR_IE | SRTC_LPCR_NVE | SRTC_LPCR_NSA |
> +		      SRTC_LPCR_EN_LP), ioaddr + SRTC_LPCR);
> +
> +	udelay(100);
> +
> +	while ((__raw_readl(ioaddr + SRTC_LPSR) & SRTC_LPSR_NVES) == 0)
> +		;
>
dto.

> +	__raw_writel(0xFFFFFFFF, ioaddr + SRTC_LPSR);
> +	udelay(100);
> +
> +	platform_set_drvdata(pdev, pdata);
>
The IRQ handler uses platform_get_drvdata(), so this has to be done
BEFORE registering the interrupt handler.

> +	pdata->rtc =
> +	    devm_rtc_device_register(&pdev->dev, pdev->name, &mxc_rtc_ops,
> +				     THIS_MODULE);
> +	if (IS_ERR(pdata->rtc)) {
> +		ret = PTR_ERR(pdata->rtc);
> +		goto exit_put_clk;
> +	}
> +
> +	tv.tv_nsec = 0;
> +	tv.tv_sec = __raw_readl(ioaddr + SRTC_LPSCMR);
> +
> +	/* By default, devices should wakeup if they can */
> +	/* So srtc is set as "should wakeup" as it can */
>
multi line comment style?

> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	return ret;
> +
> +exit_put_clk:
> +	clk_disable_unprepare(pdata->clk);
> +	return ret;
> +}
> +
> +static int __exit mxc_rtc_remove(struct platform_device *pdev)
> +{
> +	struct rtc_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(pdata->clk);
> +	return 0;
> +}
> +
> +/*!
> + * This function is called to save the system time delta relative to
> + * the MXC RTC when enterring a low power state. This time delta is
> + * then used on resume to adjust the system time to account for time
> + * loss while suspended.
> + *
> + * @param   pdev  not used
> + * @param   state Power state to enter.
> + *
> + * @return  The function always returns 0.
> + */
> +static int mxc_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct rtc_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		enable_irq_wake(pdata->irq);
> +
> +	return 0;
> +}
> +
> +/*!
> + * This function is called to correct the system time based on the
> + * current MXC RTC time relative to the time delta saved during
> + * suspend.
> + *
> + * @param   pdev  not used
> + *
> + * @return  The function always returns 0.
> + */
> +static int mxc_rtc_resume(struct platform_device *pdev)
> +{
> +	struct rtc_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		disable_irq_wake(pdata->irq);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mxc_ids[] = {
> +	{.compatible = "fsl,imx53-rtc",},
>
missing spaces after '{' and before '}'


Lothar Wa?mann
