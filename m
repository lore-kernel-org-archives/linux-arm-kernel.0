From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 7 Dec 2016 20:08:05 +0100
Subject: [PATCH 3/8] rtc: add STM32 RTC driver
In-Reply-To: <1480687801-19525-5-git-send-email-amelie.delaunay@st.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
 <1480687801-19525-5-git-send-email-amelie.delaunay@st.com>
Message-ID: <20161207190805.jxbitxysxcwjylgg@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seems mostly fine.

On 02/12/2016 at 15:09:56 +0100, Amelie Delaunay wrote :
> This patch adds support for the STM32 RTC.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/rtc/Kconfig     |  10 +
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-stm32.c | 777 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 788 insertions(+)
>  create mode 100644 drivers/rtc/rtc-stm32.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index e859d14..dd8b218 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1706,6 +1706,16 @@ config RTC_DRV_PIC32
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-pic32
>  
> +config RTC_DRV_STM32
> +	tristate "STM32 On-Chip RTC"
> +	depends on ARCH_STM32

Can you add COMPILE_TEST? Looking at it, nothing seemed to be
architecture specific and this nicely increases compile test coverage.

It should also probably select REGMAP_MMIO.

> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> new file mode 100644
> index 0000000..9e710ff
> --- /dev/null
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -0,0 +1,777 @@
> +/*
> + * Copyright (C) Amelie Delaunay 2015
> + * Author:  Amelie Delaunay <adelaunay.stm32@gmail.com>

This differs from your SoB. I don't really care but it seems odd.

> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/bcd.h>
> +#include <linux/clk.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +#include <linux/spinlock.h>
> +

I have the feeling that some of those headers are not necessary maybe
some cleanup should be done.

> +static struct regmap *dbp;
> +
> +struct stm32_rtc {
> +	struct rtc_device *rtc_dev;
> +	void __iomem *base;
> +	struct clk *pclk;
> +	struct clk *ck_rtc;
> +	unsigned int clksrc;
> +	spinlock_t lock; /* Protects registers accesses */

That comment makes checkpatch happy but is not super useful :) Anyway...

> +static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
> +{

...can you make that one a threaded IRQ? If that's the case, just take
the rtc_device mutex here and remove the spinlock. All the other
function are already protected.

> +static int stm32_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct stm32_rtc *rtc = dev_get_drvdata(dev);
> +	struct rtc_time *tm = &alrm->time;
> +	unsigned int alrmar, cr, isr;
> +	unsigned long irqflags;
> +
> +	spin_lock_irqsave(&rtc->lock, irqflags);
> +
> +	alrmar = stm32_rtc_readl(rtc, STM32_RTC_ALRMAR);
> +	cr = stm32_rtc_readl(rtc, STM32_RTC_CR);
> +	isr = stm32_rtc_readl(rtc, STM32_RTC_ISR);
> +
> +	spin_unlock_irqrestore(&rtc->lock, irqflags);
> +
> +	if (alrmar & STM32_RTC_ALRMXR_DATE_MASK) {
> +		/*
> +		 * Date/day don't care in Alarm comparison so alarm triggers

I guess you meant "doesn't matter" (that is also valid for the other
usages of "don't care".

> +		 * every day
> +		 */
> +		tm->tm_mday = -1;
> +		tm->tm_wday = -1;
> +	} else {
> +		if (alrmar & STM32_RTC_ALRMXR_WDSEL) {
> +			/* Alarm is set to a day of week */
> +			tm->tm_mday = -1;
> +			tm->tm_wday = (alrmar & STM32_RTC_ALRMXR_WDAY) >>
> +				      STM32_RTC_ALRMXR_WDAY_SHIFT;
> +			tm->tm_wday %= 7;
> +		} else {
> +			/* Alarm is set to a day of month */
> +			tm->tm_wday = -1;
> +			tm->tm_mday = (alrmar & STM32_RTC_ALRMXR_DATE) >>
> +				       STM32_RTC_ALRMXR_DATE_SHIFT;
> +		}
> +	}
> +
> +	if (alrmar & STM32_RTC_ALRMXR_HOUR_MASK) {
> +		/* Hours don't care in Alarm comparison */
> +		tm->tm_hour = -1;
> +	} else {
> +		tm->tm_hour = (alrmar & STM32_RTC_ALRMXR_HOUR) >>
> +			       STM32_RTC_ALRMXR_HOUR_SHIFT;
> +		if (alrmar & STM32_RTC_ALRMXR_PM)
> +			tm->tm_hour += 12;
> +	}
> +
> +	if (alrmar & STM32_RTC_ALRMXR_MIN_MASK) {
> +		/* Minutes don't care in Alarm comparison */
> +		tm->tm_min = -1;
> +	} else {
> +		tm->tm_min = (alrmar & STM32_RTC_ALRMXR_MIN) >>
> +			      STM32_RTC_ALRMXR_MIN_SHIFT;
> +	}
> +
> +	if (alrmar & STM32_RTC_ALRMXR_SEC_MASK) {
> +		/* Seconds don't care in Alarm comparison */
> +		tm->tm_sec = -1;
> +	} else {
> +		tm->tm_sec = (alrmar & STM32_RTC_ALRMXR_SEC) >>
> +			      STM32_RTC_ALRMXR_SEC_SHIFT;
> +	}
> +
I'm not sure those multiple cases (including STM32_RTC_ALRMXR_WDSEL) are
useful because the core will always give you valid tm_sec, tm_min,
tm_hour and tm_mday (it is actually checked up to four times!) so you
should always end up in the same configuration.

If you think some code other than Linux may set an alarm (e.g. the
bootloader) then you may keep them in read_alarm but at least you can
remove them from set_alarm.


> +static int stm32_rtc_probe(struct platform_device *pdev)
> +{
> +	struct stm32_rtc *rtc;
> +	struct resource *res;
> +	int ret;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rtc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rtc->base))
> +		return PTR_ERR(rtc->base);
> +
> +	dbp = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "st,syscfg");
> +	if (IS_ERR(dbp)) {
> +		dev_err(&pdev->dev, "no st,syscfg\n");
> +		return PTR_ERR(dbp);
> +	}
> +
> +	spin_lock_init(&rtc->lock);
> +
> +	rtc->ck_rtc = devm_clk_get(&pdev->dev, "ck_rtc");
> +	if (IS_ERR(rtc->ck_rtc)) {
> +		dev_err(&pdev->dev, "no ck_rtc clock");
> +		return PTR_ERR(rtc->ck_rtc);
> +	}
> +
> +	ret = clk_prepare_enable(rtc->ck_rtc);
> +	if (ret)
> +		return ret;
> +
> +	if (dbp)
> +		regmap_update_bits(dbp, PWR_CR, PWR_CR_DBP, PWR_CR_DBP);
> +
> +	ret = stm32_rtc_init(pdev, rtc);
> +	if (ret)
> +		goto err;
> +

Isn't that RTC backuped in some way, do you really need to reinit it
each time the system reboots?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
