From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 24 Mar 2016 12:01:36 +0800
Subject: [PATCH] sbs-battery: fix power status when battery is dry
In-Reply-To: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi YH,

On Wed, Mar 23, 2016 at 5:53 PM, YH Huang <yh.huang@mediatek.com> wrote:
> When the battery is dry and BATTERY_FULL_DISCHARGED is set,
> we should check BATTERY_DISCHARGING to decide the power status.
> If BATTERY_DISCHARGING is set, the power status is not charging.
> Or the power status should be charging.
>
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  drivers/power/sbs-battery.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
> index d6226d6..d86db0e 100644
> --- a/drivers/power/sbs-battery.c
> +++ b/drivers/power/sbs-battery.c
> @@ -382,11 +382,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
>
>                 if (ret & BATTERY_FULL_CHARGED)
>                         val->intval = POWER_SUPPLY_STATUS_FULL;
> -               else if (ret & BATTERY_FULL_DISCHARGED)
> -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> -               else if (ret & BATTERY_DISCHARGING)
> -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> -               else
> +               else if (ret & BATTERY_DISCHARGING) {
> +                       if (ret & BATTERY_FULL_DISCHARGED)
> +                               val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +                       else
> +                               val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +               } else


I think (BATTERY_DISCHARGING && BATTERY_FULL_DISCHARGED) is still
POWER_SUPPLY_STATUS_DISCHARGING.
So, let's just report what the battery says and do:

               else if (ret & BATTERY_DISCHARGING)
                               val->intval = POWER_SUPPLY_STATUS_DISCHARGING;


>                         val->intval = POWER_SUPPLY_STATUS_CHARGING;
>
>                 if (chip->poll_time == 0)
> @@ -702,11 +703,12 @@ static void sbs_delayed_work(struct work_struct *work)
>
>         if (ret & BATTERY_FULL_CHARGED)
>                 ret = POWER_SUPPLY_STATUS_FULL;
> -       else if (ret & BATTERY_FULL_DISCHARGED)
> -               ret = POWER_SUPPLY_STATUS_NOT_CHARGING;
> -       else if (ret & BATTERY_DISCHARGING)
> -               ret = POWER_SUPPLY_STATUS_DISCHARGING;
> -       else
> +       else if (ret & BATTERY_DISCHARGING) {
> +               if (ret & BATTERY_FULL_DISCHARGED)
> +                       ret = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               else
> +                       ret = POWER_SUPPLY_STATUS_DISCHARGING;
> +       } else
>                 ret = POWER_SUPPLY_STATUS_CHARGING;
>
>         if (chip->last_state != ret) {
> --
> 1.7.9.5
>
