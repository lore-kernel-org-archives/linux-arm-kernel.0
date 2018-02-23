From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Feb 2018 11:01:04 -0800
Subject: [PATCH] rtc: brcmstb-waketimer: Set wktmr prescaler
In-Reply-To: <1519262155-15580-1-git-send-email-justin.chen@broadcom.com>
References: <1519262155-15580-1-git-send-email-justin.chen@broadcom.com>
Message-ID: <e991b6b5-3f3d-f9da-2655-008921eee2a7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2018 05:15 PM, Justin Chen wrote:
> The HW default is one tick per second, however instead of assuming this,
> lets make sure the waketimer is actually one tick per second before
> arming the alarm.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/rtc/rtc-brcmstb-waketimer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
> index 796ac79..46116b7 100644
> --- a/drivers/rtc/rtc-brcmstb-waketimer.c
> +++ b/drivers/rtc/rtc-brcmstb-waketimer.c
> @@ -60,6 +60,10 @@ static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
>  {
>  	brcmstb_waketmr_clear_alarm(timer);
>  
> +	/* Make sure we are actually counting in seconds */
> +	writel_relaxed(BRCMSTB_WKTMR_DEFAULT_FREQ,
> +			timer->base + BRCMSTB_WKTMR_PRESCALER);

The change is correct, however you would likely want to use timer->rate
which makes sure that we either got the clock rate information from the
LCCF, or we got the correct fixed rate frequency. With that fixed:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
