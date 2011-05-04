From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 05 May 2011 08:49:13 +1200
Subject: AT91: Convert RTC and RTT drivers to be independent of processor
	base-address
In-Reply-To: <1304106068.25025.8.camel@redbox>
References: <1304106068.25025.8.camel@redbox>
Message-ID: <4DC1BBC9.1070306@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2011 07:41 AM, Andrew Victor wrote:
> For supporting multiple AT91 processors in a single kernel image, the
> following changes to the RTC and RTT driver support:
>  * pass base addresses via platform resources
>  * replace calls to at91_sys_read() / at91_sys_write()
>  * rename AT91_RTT/AT91_RTC to AT91xxx_RTT/AT91xxx_RTC to denote they
> are processor-specific.
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>

Looks mostly good. Couple of minor comments below.

~Ryan

> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index e39b77a..971271c 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/ioctl.h>
>  #include <linux/completion.h>
> +#include <linux/slab.h>
>  
>  #include <asm/uaccess.h>
>  
> @@ -35,23 +36,33 @@
>  
>  #define AT91_RTC_EPOCH		1900UL	/* just like arch/arm/common/rtctime.c */
>  
> +struct at91_rtc {
> +	struct rtc_device	*rtcdev;
> +	void __iomem		*regbase;
> +	unsigned int		alarm_year;
> +};
> +
>  static DECLARE_COMPLETION(at91_rtc_updated);
> -static unsigned int at91_alarm_year = AT91_RTC_EPOCH;
> +
> +#define rtc_readl(rtc, reg) \
> +	__raw_readl((rtc)->regbase + (reg))
> +#define rtc_writel(rtc, reg, value) \
> +	__raw_writel((value), (rtc)->regbase + (reg))

static inline unsigned rtc_readl(struct at91_rtc, unsigned reg)
{
	return __raw_readl(rtc->regbase + reg);
}

static inline void rtc_writel(struct at91_rtc, unsigned reg,
				unsigned value)
{
	__raw_writel(valie, rtc->regbase + reg);
}

>  
>  /*
>   * Decode time/date into rtc_time structure
>   */
> -static void at91_rtc_decodetime(unsigned int timereg, unsigned int calreg,
> -				struct rtc_time *tm)
> +static void at91_rtc_decodetime(struct at91_rtc* rtc,

Nitpick, should be:

	struct at91_rtc *rtc,

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
