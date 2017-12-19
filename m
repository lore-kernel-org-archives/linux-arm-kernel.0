From: j-keerthy@ti.com (Keerthy)
Date: Tue, 19 Dec 2017 14:00:52 +0530
Subject: [PATCH 2/2] clocksource: timer-dm: Check prescaler value
In-Reply-To: <20171218113153.GB18637@lenoch>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <20171218111610.GA16906@lenoch> <20171218113153.GB18637@lenoch>
Message-ID: <f3c92557-f3e9-9ea7-ad1f-c6e8924d9ee2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 18 December 2017 05:01 PM, Ladislav Michl wrote:
> Invalid prescaler value is silently ignored. Fix that
> by returning -EINVAL in such case. As invalid value
> disabled use of the prescaler, use -1 explicitely for
> that purpose.

Thanks. I will post this as part of my migration series.

> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/clocksource/timer-dm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> index ec3a28c90c70..95cd98be8541 100644
> --- a/drivers/clocksource/timer-dm.c
> +++ b/drivers/clocksource/timer-dm.c
> @@ -609,6 +609,9 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
>  	if (prescaler >= 0x00 && prescaler <= 0x07) {
>  		l |= OMAP_TIMER_CTRL_PRE;
>  		l |= prescaler << 2;
> +	} else {
> +		if (prescaler != -1)
> +			return -EINVAL;
>  	}
>  	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
>  
> 
