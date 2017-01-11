From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 11 Jan 2017 01:08:03 +0100
Subject: [PATCHv3 3/8] rtc: add STM32 RTC driver
In-Reply-To: <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170111000803.mlie6kizcsj2o7lh@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good to me, however...


On 05/01/2017 at 14:43:24 +0100, Amelie Delaunay wrote :
> +struct stm32_rtc {
> +	struct rtc_device *rtc_dev;
> +	void __iomem *base;
> +	struct clk *ck_rtc;
> +	spinlock_t lock; /* Protects registers accesses */

This spinlock seems to be useless, the rtc ops_lock is already
protecting everywhere it is taken.

> +	int irq_alarm;
> +};
> +

[...]

> +static int stm32_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct stm32_rtc *rtc = dev_get_drvdata(dev);
> +	struct rtc_time *tm = &alrm->time;
> +	unsigned long irqflags;
> +	unsigned int cr, isr, alrmar;
> +	int ret = 0;
> +
> +	if (rtc_valid_tm(tm)) {
> +		dev_err(dev, "Alarm time not valid.\n");
> +		return -EINVAL;

This will never happen, tm is already checked multiple times (up to
three) in the core before this function can be called.

> +	}
> +

You don't need to resend the whole series, just this patch. I'll take
2/8 and 3/8, the other ones can go through the stm32 tree.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
