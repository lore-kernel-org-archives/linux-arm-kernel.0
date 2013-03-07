From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Mar 2013 14:40:54 +0800
Subject: [PATCH 3/9] MXS/i.MX28: prepare different clocking of the
 built-in RTC
In-Reply-To: <1362405948-12992-4-git-send-email-s.trumtrar@pengutronix.de>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
 <1362405948-12992-4-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20130307064052.GC5372@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 03:05:42PM +0100, Steffen Trumtrar wrote:
> From: Juergen Beisert <jbe@pengutronix.de>
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> ---
>  drivers/rtc/rtc-stmp3xxx.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

So this is a rtc patch, and should be prefixed with "rtc: stmp3xxx: "
like patches #6~9.

And IMO, all the changes in this patch can just be added together with
the codes that use them.  IOW, it can be merged into patch #4.

> 
> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> index 98f0d3c..7311292 100644
> --- a/drivers/rtc/rtc-stmp3xxx.c
> +++ b/drivers/rtc/rtc-stmp3xxx.c
> @@ -53,18 +53,26 @@
>  #define STMP3XXX_RTC_PERSISTENT0		0x60
>  #define STMP3XXX_RTC_PERSISTENT0_SET		0x64
>  #define STMP3XXX_RTC_PERSISTENT0_CLR		0x68
> +#define STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE	(1 << 0)
>  #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN	0x00000002
>  #define STMP3XXX_RTC_PERSISTENT0_ALARM_EN	0x00000004
> +#define STMP3XXX_RTC_PERSISTENT0_XTAL24MHZ_PWRUP (1 << 4)
> +#define STMP3XXX_RTC_PERSISTENT0_XTAL32KHZ_PWRUP (1 << 5)
> +#define STMP3XXX_RTC_PERSISTENT0_XTAL32_FREQ	(1 << 6)
> +
>  #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE	0x00000080
>  
>  #define STMP3XXX_RTC_PERSISTENT1		0x70
>  /* missing bitmask in headers */
>  #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
>  
> +enum clock_source { MXS_UNKNOWN, MXS_OSC_24M, MXS_OSC_32K, MXS_OSC_32K768 };
> +
We generic write it like

enum clock_source {
        MXS_UNKNOWN,
        MXS_OSC_24M,
        MXS_OSC_32K,
        MXS_OSC_32K768
};

Shawn

>  struct stmp3xxx_rtc_data {
>  	struct rtc_device *rtc;
>  	void __iomem *io;
>  	int irq_alarm;
> +	enum clock_source clk_src;
>  };
>  
>  #if IS_ENABLED(CONFIG_STMP3XXX_RTC_WATCHDOG)
> -- 
> 1.7.10.4
> 
