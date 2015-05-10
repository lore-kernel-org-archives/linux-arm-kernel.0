From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 10 May 2015 23:42:44 +0200
Subject: [PATCH] rtc: snvs: improve timeout handling in snvs_rtc_enable()
In-Reply-To: <20527.38172.621130.368019@ipc1.ka-ro>
References: <20527.38172.621130.368019@ipc1.ka-ro>
Message-ID: <20150510214244.GJ3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn, Lothar,

On 18/08/2012 at 15:14:04 +0200, Lothar Wa?mann wrote :
> Shawn Guo writes:
> > On Sat, Aug 18, 2012 at 10:10:08AM +0200, Lothar Wa?mann wrote:
> > > If snvs_rtc_enable() happens to be descheduled for a period longer
> > > than the timout period, a timeout may be indicated even if the RTC
> > > status has changed meanwhile. Force a status read at the end of the
> > > timeout period to prevent bogus timeout errors.
> > > 
> > > 
> > > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > > ---
> > >  drivers/rtc/rtc-snvs.c |   22 +++++++++++++---------
> > >  1 files changed, 13 insertions(+), 9 deletions(-)
> > > 
> > >  Compile tested only due to lack of HW.
> > 
> > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> > 

It seems that patch never made it mainline. Can you check if it is still
needed?


> > A small nitpick below.
> > 
> > > 
> > > diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> > > index 912f116..dc921b2 100644
> > > --- a/drivers/rtc/rtc-snvs.c
> > > +++ b/drivers/rtc/rtc-snvs.c
> > > @@ -81,6 +81,13 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
> > >  	}
> > >  }
> > >  
> > > +static int snvs_rtc_enable_done(int enable, void __iomem *addr)
> > 
> > Can we rename parameter "addr" to "ioaddr" and put it before "enable",
> > also change "enable" to bool?
> > 
> OK. The resulting assembler code of the patch below is identical to
> the previous version of this patch.
> 
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/rtc/rtc-snvs.c |   22 +++++++++++++---------
>  1 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index 912f116..a757cb9 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -81,6 +81,13 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
>  	}
>  }
>  
> +static int snvs_rtc_enable_done(void __iomem *ioaddr, bool enable)
> +{
> +	u32 lpcr = readl(ioaddr + SNVS_LPCR);
> +
> +	return enable ^ !(lpcr & SNVS_LPCR_SRTC_ENV);
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
> +		if (snvs_rtc_enable_done(data->ioaddr, enable))
> +			break;
>  
> -		if (enable) {
> -			if (lpcr & SNVS_LPCR_SRTC_ENV)
> -				break;
> -		} else {
> -			if (!(lpcr & SNVS_LPCR_SRTC_ENV))
> +		if (time_after(jiffies, timeout)) {
> +			if (snvs_rtc_enable_done(data->ioaddr, enable))
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

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
