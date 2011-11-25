From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 25 Nov 2011 21:14:37 +0100
Subject: [V1 3/3] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <1322219217-1866-1-git-send-email-jtzhou@marvell.com> (Jett
 Zhou's message of "Fri, 25 Nov 2011 19:06:57 +0800")
References: <1322219217-1866-1-git-send-email-jtzhou@marvell.com>
Message-ID: <87bos0vu1e.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Jett.Zhou" <jtzhou@marvell.com> writes:

> Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
> almost the same, so re-arch the rtc-sa1100 to support them.
Hi Jett.Zhou,
That's a very good work.

...zip...
>  static int sa1100_rtc_remove(struct platform_device *pdev)
>  {
> -	struct rtc_device *rtc = platform_get_drvdata(pdev);
> +	struct sa1100_rtc *sa1100_rtc = platform_get_drvdata(pdev);
>  
> -	if (rtc)
> -		rtc_device_unregister(rtc);
> +	rtc_device_unregister(sa1100_rtc->rtc);
> +	if (sa1100_rtc->id == RTC_MMP) {
> +		clk_unprepare(sa1100_rtc->clk);
> +		clk_disable(sa1100_rtc->clk);
> +	}
>  
> +	spin_lock_irq(&sa1100_rtc->lock);
> +	iounmap(sa1100_rtc->base);
> +	spin_unlock_irq(&sa1100_rtc->lock);
Why the spin lock here ?

Cheers.

--
Robert
