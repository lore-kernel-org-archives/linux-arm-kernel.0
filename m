From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 23 Jun 2013 21:18:48 +0200
Subject: [PATCH v2 1/3] rtc: mxc_rtc: Driver rework
In-Reply-To: <1371976349-18679-1-git-send-email-shc_work@mail.ru>
References: <1371976349-18679-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130623191848.GD26397@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 12:32:27PM +0400, Alexander Shiyan wrote:
> This patch rework mxc_rtc driver.
> Major changes have been made:
> - Added second clock support (optional) which permit module functionality.
> - Implemented support for periodic interrupts.
> - Code have been optimized and cleaned.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/rtc/rtc-mxc.c | 382 +++++++++++++++++++++-----------------------------
>  1 file changed, 159 insertions(+), 223 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
> index ab87bac..90b0222 100644
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
> @@ -21,54 +20,37 @@
>  #define RTC_INPUT_CLK_32000HZ	(0x01 << 5)
>  #define RTC_INPUT_CLK_38400HZ	(0x02 << 5)
>  
> -#define RTC_SW_BIT      (1 << 0)
> -#define RTC_ALM_BIT     (1 << 2)
> -#define RTC_1HZ_BIT     (1 << 4)
> -#define RTC_2HZ_BIT     (1 << 7)
> -#define RTC_SAM0_BIT    (1 << 8)
> -#define RTC_SAM1_BIT    (1 << 9)
> -#define RTC_SAM2_BIT    (1 << 10)
> -#define RTC_SAM3_BIT    (1 << 11)
> -#define RTC_SAM4_BIT    (1 << 12)
> -#define RTC_SAM5_BIT    (1 << 13)
> -#define RTC_SAM6_BIT    (1 << 14)
> -#define RTC_SAM7_BIT    (1 << 15)
> -#define PIT_ALL_ON      (RTC_2HZ_BIT | RTC_SAM0_BIT | RTC_SAM1_BIT | \
> +#define RTC_SW_BIT	BIT(0)
> +#define RTC_ALM_BIT	BIT(2)
> +#define RTC_1HZ_BIT	BIT(4)
> +#define RTC_2HZ_BIT	BIT(7)
> +#define RTC_SAM0_BIT	BIT(8)
> +#define RTC_SAM1_BIT	BIT(9)
> +#define RTC_SAM2_BIT	BIT(10)
> +#define RTC_SAM3_BIT	BIT(11)
> +#define RTC_SAM4_BIT	BIT(12)
> +#define RTC_SAM5_BIT	BIT(13)
> +#define RTC_SAM6_BIT	BIT(14)
> +#define RTC_SAM7_BIT	BIT(15)

This is only unnecessary churn. Personally I wouldn't change from
(1 << x) to BIT(x) or the other way round. If you really want to do it
this@least should be a separate patch.


> -#define RTC_HOURMIN	0x00	/*  32bit rtc hour/min counter reg */
> -#define RTC_SECOND	0x04	/*  32bit rtc seconds counter reg */
> -#define RTC_ALRM_HM	0x08	/*  32bit rtc alarm hour/min reg */
> -#define RTC_ALRM_SEC	0x0C	/*  32bit rtc alarm seconds reg */
> -#define RTC_RTCCTL	0x10	/*  32bit rtc control reg */
> -#define RTC_RTCISR	0x14	/*  32bit rtc interrupt status reg */
> -#define RTC_RTCIENR	0x18	/*  32bit rtc interrupt enable reg */
> -#define RTC_STPWCH	0x1C	/*  32bit rtc stopwatch min reg */
> -#define RTC_DAYR	0x20	/*  32bit rtc days counter reg */
> -#define RTC_DAYALARM	0x24	/*  32bit rtc day alarm reg */
> -#define RTC_TEST1	0x28	/*  32bit rtc test reg 1 */
> -#define RTC_TEST2	0x2C	/*  32bit rtc test reg 2 */
> -#define RTC_TEST3	0x30	/*  32bit rtc test reg 3 */
> +#define RTC_HOURMIN	0x00	/*  rtc hour/min counter */
> +#define RTC_SECOND	0x04	/*  rtc seconds counter */
> +#define RTC_ALRM_HM	0x08	/*  rtc alarm hour/min */
> +#define RTC_ALRM_SEC	0x0c	/*  rtc alarm seconds */
> +#define RTC_RTCCTL	0x10	/*  rtc control */
> +#define RTC_RTCISR	0x14	/*  rtc interrupt status */
> +#define RTC_RTCIENR	0x18	/*  rtc interrupt enable */
> +#define RTC_STPWCH	0x1c	/*  rtc stopwatch min */
> +#define RTC_DAYR	0x20	/*  rtc days counter */
> +#define RTC_DAYALARM	0x24	/*  rtc day alarm */

Also only churn. This only hides what the patch really does.

>  static u32 get_alarm_or_time(struct device *dev, int time_alarm)
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

Why? If there's a reason for this change let us know it in a commit
message to a separate patch.

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

ditto.

>  static void mxc_rtc_irq_enable(struct device *dev, unsigned int bit,
> -				unsigned int enabled)
> +			       unsigned int enabled)
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

Another hunk that might make sense but we do not know what's wrong with
the original code.

>  	spin_lock_irqsave(&pdata->rtc->irq_lock, flags);
> +
>  	status = readw(ioaddr + RTC_RTCISR) & readw(ioaddr + RTC_RTCIENR);
>  	/* clear interrupt sources */
>  	writew(status, ioaddr + RTC_RTCISR);
>  
>  	/* update irq data & counter */
>  	if (status & RTC_ALM_BIT) {
> -		events |= (RTC_AF | RTC_IRQF);
> +		events |= RTC_AF | RTC_IRQF;
>  		/* RTC alarm should be one-shot */
>  		mxc_rtc_irq_enable(&pdev->dev, RTC_ALM_BIT, 0);
>  	}
>  
>  	if (status & RTC_1HZ_BIT)
> -		events |= (RTC_UF | RTC_IRQF);
> +		events |= RTC_UF | RTC_IRQF;
>  
>  	if (status & PIT_ALL_ON)
> -		events |= (RTC_PF | RTC_IRQF);
> +		events |= RTC_PF | RTC_IRQF;
>  
>  	rtc_update_irq(pdata->rtc, 1, events);
> +
>  	spin_unlock_irqrestore(&pdata->rtc->irq_lock, flags);

Only cosmetic above. Should be ok, but please in a patch with 'only
cosmetic, no functional change' description.

I'm stopping here. This really needs a serious rework.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
