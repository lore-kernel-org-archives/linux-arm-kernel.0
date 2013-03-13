From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Wed, 13 Mar 2013 22:29:04 +0530
Subject: [PATCH 6/7] ARM: SAMSUNG: use clk_prepare_enable in samsung-time
In-Reply-To: <201303120145.21072.heiko@sntech.de>
References: <201303120141.31262.heiko@sntech.de>
 <201303120145.21072.heiko@sntech.de>
Message-ID: <CADTbHxq-gxoN9HKkjPsZ5uBt7PhrvO8XdQdmAyscOA+xPy9Z7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 12, 2013 at 6:15 AM, Heiko St?bner <heiko@sntech.de> wrote:
> The common clock framework expects clocks to be prepared
> before they are enabled.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/plat-samsung/samsung-time.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/samsung-time.c b/arch/arm/plat-samsung/samsung-time.c
> index f899cbc..6ebb851 100644
> --- a/arch/arm/plat-samsung/samsung-time.c
> +++ b/arch/arm/plat-samsung/samsung-time.c
> @@ -355,7 +355,7 @@ static void __init samsung_timer_resources(void)
>         if (IS_ERR(timerclk))
>                 panic("failed to get timers clock for timer");
>
Also how about calling the clk_prepare_enable() only if the clk_get()
call is a sucess? Though clk framework will take care of it. Just
thinking even to avoid that call if clk_get() fails since you are
modifying the code.

> -       clk_enable(timerclk);
> +       clk_prepare_enable(timerclk);
>
>         sprintf(devname, "s3c24xx-pwm.%lu", event_id);
>         s3c_device_timer[event_id].id = event_id;
> @@ -369,7 +369,7 @@ static void __init samsung_timer_resources(void)
>         if (IS_ERR(tdiv_event))
>                 panic("failed to get pwm-tdiv clock for event timer");
>
Same here...
> -       clk_enable(tin_event);
> +       clk_prepare_enable(tin_event);
>
>         sprintf(devname, "s3c24xx-pwm.%lu", source_id);

Regards,
Pankaj Jangra
