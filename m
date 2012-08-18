From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 18 Aug 2012 20:46:54 +0800
Subject: [PATCH] rtc: snvs: improve timeout handling in snvs_rtc_enable()
In-Reply-To: <1345277408-30044-1-git-send-email-LW@KARO-electronics.de>
References: <1345277408-30044-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20120818124652.GH24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 18, 2012 at 10:10:08AM +0200, Lothar Wa?mann wrote:
> If snvs_rtc_enable() happens to be descheduled for a period longer
> than the timout period, a timeout may be indicated even if the RTC
> status has changed meanwhile. Force a status read at the end of the
> timeout period to prevent bogus timeout errors.
> 
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/rtc/rtc-snvs.c |   22 +++++++++++++---------
>  1 files changed, 13 insertions(+), 9 deletions(-)
> 
>  Compile tested only due to lack of HW.

Tested-by: Shawn Guo <shawn.guo@linaro.org>

A small nitpick below.

> 
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index 912f116..dc921b2 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -81,6 +81,13 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
>  	}
>  }
>  
> +static int snvs_rtc_enable_done(int enable, void __iomem *addr)

Can we rename parameter "addr" to "ioaddr" and put it before "enable",
also change "enable" to bool?

Regards,
Shawn

> +{
> +	u32 lpcr = readl(addr + SNVS_LPCR);
> +
> +	return !!enable ^ !(lpcr & SNVS_LPCR_SRTC_ENV);
> +}
> +
>  static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(1);
> @@ -99,18 +106,15 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
>  	spin_unlock_irqrestore(&data->lock, flags);
>  
>  	while (1) {
> -		lpcr = readl(data->ioaddr + SNVS_LPCR);
> +		if (snvs_rtc_enable_done(enable, data->ioaddr))
> +			break;
>  
> -		if (enable) {
> -			if (lpcr & SNVS_LPCR_SRTC_ENV)
> -				break;
> -		} else {
> -			if (!(lpcr & SNVS_LPCR_SRTC_ENV))
> +		if (time_after(jiffies, timeout)) {
> +			if (snvs_rtc_enable_done(enable, data->ioaddr))
>  				break;
> +			else
> +				return -ETIMEDOUT;
>  		}
> -
> -		if (time_after(jiffies, timeout))
> -			return -ETIMEDOUT;
>  	}
>  
>  	return 0;
> -- 
> 1.7.2.5
> 
