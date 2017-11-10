From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Fri, 10 Nov 2017 14:41:38 +0100
Subject: [PATCH 1/2] rtc: at91rm9200: stop calculating yday in
 at91_rtc_readalarm
In-Reply-To: <20171110085931.32347-1-alexandre.belloni@free-electrons.com>
References: <20171110085931.32347-1-alexandre.belloni@free-electrons.com>
Message-ID: <a00561dd-fb84-55d4-c819-12dd9d2bace7@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2017 at 09:59, Alexandre Belloni wrote:
> Calculating yday in the read_alarm callback is useless as this value is
> never used later. Also, it was buggy anyway because at the time this is
> done, tm_year is always 0 as the alarm register doesn't hold the year.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  drivers/rtc/rtc-at91rm9200.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index e221b78b6f10..e84f5ec4faf6 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -208,7 +208,6 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	struct rtc_time *tm = &alrm->time;
>  
>  	at91_rtc_decodetime(AT91_RTC_TIMALR, AT91_RTC_CALALR, tm);
> -	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
>  	tm->tm_year = at91_alarm_year - 1900;
>  
>  	alrm->enabled = (at91_rtc_read_imr() & AT91_RTC_ALARM)
> 


-- 
Nicolas Ferre
