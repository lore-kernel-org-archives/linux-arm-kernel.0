From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 5 May 2015 22:00:10 +0200
Subject: [rtc-linux] [PATCH v3 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <1430206556-18254-3-git-send-email-eddie.huang@mediatek.com>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150505200010.GP4276@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This looks mostly good. Could you align the wrapped function parameters
to the open parenthesis (use checkpatch --strict)?

On 28/04/2015 at 15:35:55 +0800, Eddie Huang wrote :
> +static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> +{
> +	unsigned long timeout = jiffies + HZ;
> +	int ret;
> +	u32 data;
> +
> +	ret = regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	do {
> +		cpu_relax();
> +		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
> +				&data);
> +		if (ret < 0)
> +			goto exit;
> +	} while ((data & RTC_BBPU_CBUSY) && time_after(timeout, jiffies));
> +

Shouldn't you return -ETIMEDOUT if the loop breaks because of time_after?

Thanks,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
