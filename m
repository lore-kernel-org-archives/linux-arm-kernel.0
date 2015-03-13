From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 13 Mar 2015 12:19:36 +0100
Subject: [rtc-linux] [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <1426242563.18291.19.camel@mtksdaap41>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>	
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>	
 <20150223135044.108ea32a65063a50aa36a309@linux-foundation.org>
 <1426242563.18291.19.camel@mtksdaap41>
Message-ID: <5502C7C8.1020002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/03/15 11:29, Eddie Huang wrote:
> 
> I encounter some trouble when I add code to check return value of
> regmap_read and regmap_write. Every RTC register access through regmap,
> and there are many register read/write in this driver. If I check every
> return value, the driver will become ugly. I try to make this driver
> clean using following macro.
> 
> static int __rtc_read(struct mt6397_rtc *rtc, u32 offset, u32 *data)
> {
>         u32 addr = rtc->addr_base + offset;
> 
>         if (offset < rtc->addr_range)
>                 return regmap_read(rtc->regmap, addr, data);
> 
>         return -EINVAL;
> }
> 
> #define rtc_read(ret, rtc, offset, data)                \
> ({                                                      \
>         ret = __rtc_read(rtc, offset, data);            \
>         if (ret < 0)                                    \
>                 goto rtc_exit;                          \
> })                                                      \
> 

I agree with Sascha on hiding a goto statement in a macro is not a good idea.

> 
> And function call rtc_read, rtc_write looks like:
> 
> static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
> {
>         unsigned long time;
>         struct mt6397_rtc *rtc = dev_get_drvdata(dev);
>         int ret = 0;
>         u32 sec;
> 
>         mutex_lock(&rtc->lock);
>         do {
>                 rtc_read(ret, rtc, RTC_TC_SEC, &tm->tm_sec);
>                 rtc_read(ret, rtc, RTC_TC_MIN, &tm->tm_min);
>                 rtc_read(ret, rtc, RTC_TC_HOU, &tm->tm_hour);
>                 rtc_read(ret, rtc, RTC_TC_DOM, &tm->tm_mday);
>                 rtc_read(ret, rtc, RTC_TC_MTH, &tm->tm_mon);
>                 rtc_read(ret, rtc, RTC_TC_YEA, &tm->tm_year);
>                 rtc_read(ret, rtc, RTC_TC_SEC, &sec);
>         } while (sec < tm->tm_sec);

What about introducing
static int __mtk_rtc_read_time(struct mt6397_rtc *rtc, struct rtc_time *tm, u32 *sec)
and hide the checks of return values from regmap_read and the offset check in there. You return the error code or 0.

This way the while loop would look like this:

do {
	ret = __mtk_rtc_read_time(rtc, &tm, &sec);
	if (ret < 0)
		goto rtc_exit;
} while (sec < tm->tm_sec);

Best regards,
Matthias
