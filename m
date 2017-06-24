From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 24 Jun 2017 20:59:43 +0200
Subject: [PATCH 2/2] rtc: brcmstb-waketimer: Add Broadcom STB wake-timer
In-Reply-To: <20170615195904.12653-3-f.fainelli@gmail.com>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
 <20170615195904.12653-3-f.fainelli@gmail.com>
Message-ID: <20170624185942.vq656pjxbqnqdhll@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This seems mostly good.

On 15/06/2017 at 12:59:04 -0700, Florian Fainelli wrote:
> +static void wktmr_read(struct brcmstb_waketmr *timer,
> +		       struct wktmr_time *t)
> +{
> +	u32 tmp;
> +

To be sure, is this IP always 32bit, even on 64bit platforms?

> +	do {
> +		t->sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
> +		tmp = readl_relaxed(timer->base + BRCMSTB_WKTMR_PRESCALER_VAL);
> +	} while (tmp >= timer->rate);
> +
> +	t->pre = timer->rate - tmp;
> +}
> +

[...]

> +static int brcmstb_waketmr_settime(struct device *dev,
> +				   struct rtc_time *tm)
> +{
> +	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
> +	unsigned long sec;
> +	int ret;
> +
> +	ret = rtc_valid_tm(tm);
> +	if (ret)
> +		return ret;
> +

There is no way this function can be called without a valid tm. The only
caller checks before calling.

> +	rtc_tm_to_time(tm, &sec);
> +
> +	dev_dbg(dev, "%s: sec=%ld\n", __func__, sec);
> +	writel_relaxed(sec, timer->base + BRCMSTB_WKTMR_COUNTER);
> +
> +	return 0;
> +}
> +
> +static int brcmstb_waketmr_getalarm(struct device *dev,
> +				    struct rtc_wkalrm *alarm)
> +{
> +	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
> +	unsigned long sec;
> +	u32 reg;
> +
> +	sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM);
> +	if (sec == 0) {
> +		/* Alarm is disabled */
> +		alarm->enabled = 0;
> +		alarm->time.tm_mon = -1;
> +		alarm->time.tm_mday = -1;
> +		alarm->time.tm_year = -1;
> +		alarm->time.tm_hour = -1;
> +		alarm->time.tm_min = -1;
> +		alarm->time.tm_sec = -1;

This is not needed since d68778b80dd7

> +		dev_dbg(dev, "%s: alarm is disabled\n", __func__);
> +	} else {
> +		/* Alarm is enabled */
> +		alarm->enabled = 1;
> +		rtc_time_to_tm(sec, &alarm->time);
> +		dev_dbg(dev, "%s: alarm is enabled\n", __func__);
> +	}
> +
> +	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
> +	alarm->pending = !!(reg & 1);
> +	dev_dbg(dev, "%s: alarm pending=%d\n", __func__, alarm->pending);
> +
> +	return 0;
> +}

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
