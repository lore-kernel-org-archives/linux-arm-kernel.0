From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 28 Jun 2018 15:56:16 +0200
Subject: [PATCH 2/2] rtc: armada38x: reset after rtc power loss
In-Reply-To: <2a509f094a7ae584f657fb02791e5edea29ea149.1529602823.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Thu, 21 Jun 2018 20:40:23 +0300")
References: <00ffe926e6878724d8289dd0e289a1f16df55ef7.1529602823.git.baruch@tkos.co.il>
 <2a509f094a7ae584f657fb02791e5edea29ea149.1529602823.git.baruch@tkos.co.il>
Message-ID: <87wouj581r.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On jeu., juin 21 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> When the RTC block looses power it needs a reset sequence to make it
> usable again. Otherwise, writes to the time register have no effect.
>
> This reset sequence combines information from the mvebu_rtc driver in
> the Marvell provided U-Boot, and the SolidRun provided U-Boot repo.
>
> Tested on the Armada 388 based SolidRun Clearfog Base.

It also matches my notes to reset the RTC on Armada 8K:
devmem2 0xf428401c w 0
devmem2 0xf4284018 w 0x2000

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/rtc/rtc-armada38x.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index 4d62a54fd5d6..0b50276dce6d 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -30,6 +30,8 @@
>  #define RTC_IRQ_FREQ_1HZ	    BIT(2)
>  #define RTC_CCR		    0x18
>  #define RTC_CCR_MODE		    BIT(15)
> +#define RTC_CONF_TEST	    0x1C
> +#define RTC_NOMINAL_TIMING	    BIT(13)
>  
>  #define RTC_TIME	    0xC
>  #define RTC_ALARM1	    0x10
> @@ -75,6 +77,7 @@ struct armada38x_rtc {
>  	void __iomem	    *regs_soc;
>  	spinlock_t	    lock;
>  	int		    irq;
> +	bool		    initialized;
>  	struct value_to_freq *val_to_freq;
>  	struct armada38x_rtc_data *data;
>  };
> @@ -226,6 +229,23 @@ static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	return 0;
>  }
>  
> +static void armada38x_rtc_reset(struct armada38x_rtc *rtc)
> +{
> +	u32 reg;
> +
> +	reg = rtc->data->read_rtc_reg(rtc, RTC_CONF_TEST);
> +	/* If bits [7:0] are non-zero, assume RTC was uninitialized */
> +	if (reg & 0xff) {
> +		rtc_delayed_write(0, rtc, RTC_CONF_TEST);
> +		msleep(500); /* Oscillator startup time */
> +		rtc_delayed_write(0, rtc, RTC_TIME);
> +		rtc_delayed_write(SOC_RTC_ALARM1 | SOC_RTC_ALARM2, rtc,
> +				  RTC_STATUS);
> +		rtc_delayed_write(RTC_NOMINAL_TIMING, rtc, RTC_CCR);
> +	}
> +	rtc->initialized = true;
> +}
> +
>  static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> @@ -237,6 +257,9 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	if (ret)
>  		goto out;
>  
> +	if (!rtc->initialized)
> +		armada38x_rtc_reset(rtc);
> +
>  	spin_lock_irqsave(&rtc->lock, flags);
>  	rtc_delayed_write(time, rtc, RTC_TIME);
>  	spin_unlock_irqrestore(&rtc->lock, flags);
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
