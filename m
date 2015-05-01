From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 01 May 2015 18:13:48 +0200
Subject: [PATCH v2 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <1430426233-7461-3-git-send-email-robh@kernel.org> (Rob Herring's
 message of "Thu, 30 Apr 2015 15:37:11 -0500")
References: <1430426233-7461-1-git-send-email-robh@kernel.org>
 <1430426233-7461-3-git-send-email-robh@kernel.org>
Message-ID: <87mw1ojmwz.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

>  static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> -	rtc_time_to_tm(RCNR, tm);
> +	struct sa1100_rtc *info = dev_get_drvdata(dev);
> +	rtc_time_to_tm(readl_relaxed(info->rcnr), tm);
One nitpick here : an empty line between info declaration and code would be
better..

> @@ -206,8 +215,9 @@ out:
>
>  static int sa1100_rtc_proc(struct device *dev, struct seq_file *seq)
>  {
> -	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", (u32) RTTR);
> -	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", (u32)RTSR);
> +	struct sa1100_rtc *info = dev_get_drvdata(dev);
> +	seq_printf(seq, "trim/divider\t\t: 0x%08x\n", readl_relaxed(info->rttr));
> +	seq_printf(seq, "RTSR\t\t\t: 0x%08x\n", readl_relaxed(info->rtsr));
Ditto.

> @@ -244,6 +256,26 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
>  	}
>  	info->irq_1hz = irq_1hz;
>  	info->irq_alarm = irq_alarm;
> +
> +
Ah here the is one too much. Too bad I had not caught it the first time.

With these 3 small details, you can add my :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
