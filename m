From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Fri, 10 Nov 2017 15:55:06 +0100
Subject: [PATCH 2/2] rtc: at91rm9200: fix reading alarm value
In-Reply-To: <20171110085931.32347-2-alexandre.belloni@free-electrons.com>
References: <20171110085931.32347-1-alexandre.belloni@free-electrons.com>
 <20171110085931.32347-2-alexandre.belloni@free-electrons.com>
Message-ID: <31cc33d1-1953-f02b-c8fc-3b3ee2b4a123@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2017 at 09:59, Alexandre Belloni wrote:
> When alarm value is read at boot time, at91_alarm_year is not yet set to
> the proper value so the year is always set to 1900.
> 
> This results in that kind of message at boot:
> rtc rtc0: invalid alarm value: 1900-1-14 2:11:39
> 
> There is no way to recover from that as the alarm is now only read when
> booting.
> 
> Instead, rely on the rtc core to figure out the proper year.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  drivers/rtc/rtc-at91rm9200.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index e84f5ec4faf6..de81ecedd571 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -42,8 +42,6 @@
>  #define at91_rtc_write(field, val) \
>  	writel_relaxed((val), at91_rtc_regs + field)
>  
> -#define AT91_RTC_EPOCH		1900UL	/* just like arch/arm/common/rtctime.c */
> -
>  struct at91_rtc_config {
>  	bool use_shadow_imr;
>  };
> @@ -51,7 +49,6 @@ struct at91_rtc_config {
>  static const struct at91_rtc_config *at91_rtc_config;
>  static DECLARE_COMPLETION(at91_rtc_updated);
>  static DECLARE_COMPLETION(at91_rtc_upd_rdy);
> -static unsigned int at91_alarm_year = AT91_RTC_EPOCH;
>  static void __iomem *at91_rtc_regs;
>  static int irq;
>  static DEFINE_SPINLOCK(at91_rtc_lock);
> @@ -131,8 +128,7 @@ static void at91_rtc_decodetime(unsigned int timereg, unsigned int calreg,
>  
>  	/*
>  	 * The Calendar Alarm register does not have a field for
> -	 * the year - so these will return an invalid value.  When an
> -	 * alarm is set, at91_alarm_year will store the current year.
> +	 * the year - so these will return an invalid value.
>  	 */
>  	tm->tm_year  = bcd2bin(date & AT91_RTC_CENT) * 100;	/* century */
>  	tm->tm_year += bcd2bin((date & AT91_RTC_YEAR) >> 8);	/* year */
> @@ -208,14 +204,14 @@ static int at91_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	struct rtc_time *tm = &alrm->time;
>  
>  	at91_rtc_decodetime(AT91_RTC_TIMALR, AT91_RTC_CALALR, tm);
> -	tm->tm_year = at91_alarm_year - 1900;
> +	tm->tm_year = -1;
>  
>  	alrm->enabled = (at91_rtc_read_imr() & AT91_RTC_ALARM)
>  			? 1 : 0;
>  
> -	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
> -		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
> -		tm->tm_hour, tm->tm_min, tm->tm_sec);
> +	dev_dbg(dev, "%s(): %02d-%02d %02d:%02d:%02d %sabled\n", __func__,
> +		tm->tm_mon, tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec,
> +		alrm->enabled ? "en" : "dis");
>  
>  	return 0;
>  }
> @@ -229,8 +225,6 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  	at91_rtc_decodetime(AT91_RTC_TIMR, AT91_RTC_CALR, &tm);
>  
> -	at91_alarm_year = tm.tm_year;
> -
>  	tm.tm_mon = alrm->time.tm_mon;
>  	tm.tm_mday = alrm->time.tm_mday;
>  	tm.tm_hour = alrm->time.tm_hour;
> @@ -254,7 +248,7 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	}
>  
>  	dev_dbg(dev, "%s(): %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
> -		at91_alarm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour,
> +		tm.tm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour,
>  		tm.tm_min, tm.tm_sec);
>  
>  	return 0;
> 


-- 
Nicolas Ferre
