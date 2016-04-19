From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 Apr 2016 00:31:09 +0200
Subject: [PATCH 3/3] RTC: Update seconds time programming logic
In-Reply-To: <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
 <1460463346-24923-3-git-send-email-anuragku@xilinx.com>
Message-ID: <20160419223109.GF29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Please use rtc: zynqmp in your subject line.

On 12/04/2016 at 17:45:46 +0530, Anurag Kumar Vulisha wrote :
> @@ -78,6 +85,17 @@ static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  
>  	writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR);
>  
> +	/*
> +	 * Clear the rtc interrupt status register after setting the
> +	 * time. During a read_time function, the code should read the
> +	 * RTC_INT_STATUS register and if bit 0 is still 0, it means
> +	 * that one second has not elapsed yet since RTC was set and
> +	 * the current time should be read from SET_TIME_READ register;
> +	 * otherwise, CURRENT_TIME register is read to report the time
> +	 */
> +	writel(RTC_INT_SEC | RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_STS);

You probably shouldn't clear RTC_INT_ALRM here but it should be done in
the init and when enabling/disabling alarm. Or maybe easier would be to
ignore RTC_INT_ALRM in xlnx_rtc_interrupt when it is not set in
RTC_INT_MASK.

Or, instead of using interrupts, can't you simply read RTC_INT_STS in
xlnx_rtc_read_time()? Is it updated even when the interrupt is not
enabled?

> +	xrtcdev->time_updated = 0;
> +
>  	return 0;
>  }
>  
> @@ -85,7 +103,17 @@ static int xlnx_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
>  
> -	rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> +	if (xrtcdev->time_updated == 0) {
> +		/*
> +		 * Time written in SET_TIME_WRITE has not yet updated into
> +		 * the seconds read register, so read the time from the
> +		 * SET_TIME_WRITE instead of CURRENT_TIME register.
> +		 */
> +		rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_SET_TM_RD), tm);
> +		tm->tm_sec -= 1;
> +	} else {
> +		rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm);
> +	}
>  
>  	return rtc_valid_tm(tm);
>  }
> @@ -133,6 +161,9 @@ static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev)
>  {
>  	u32 rtc_ctrl;
>  
> +	/* Enable RTC SEC interrupts */
> +	writel(RTC_INT_SEC, xrtcdev->reg_base + RTC_INT_EN);
> +
>  	/* Enable RTC switch to battery when VCC_PSAUX is not available */
>  	rtc_ctrl = readl(xrtcdev->reg_base + RTC_CTRL);
>  	rtc_ctrl |= RTC_BATT_EN;
> @@ -169,8 +200,13 @@ static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
>  	/* Clear interrupt */
>  	writel(status, xrtcdev->reg_base + RTC_INT_STS);
>  
> -	if (status & RTC_INT_SEC)
> +	if (status & RTC_INT_SEC) {
> +		if (xrtcdev->time_updated == 0) {
> +			/* RTC updated the seconds read register */
> +			xrtcdev->time_updated = 1;
> +		}
>  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF);
> +	}
>  	if (status & RTC_INT_ALRM)
>  		rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
>  
> -- 
> 2.1.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
