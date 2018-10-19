From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 19 Oct 2018 16:00:32 +0300
Subject: [PATCH 01/15] power: supply: olpc_battery: correct the
 temperature units
In-Reply-To: <20181010172300.317643-2-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-2-lkundrak@v3.sk>
Message-ID: <CAHp75VenECSZWR3RVh=t35Os93t-MzEH_YzPgT=qQWL-SwjgFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> According to [1] and [2], the temperature values are in tenths of degree
> Celsius. Exposing the Celsius value makes the battery appear on fire:
>
>   $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
>   ...
>       temperature:         236.9 degrees C
>
> Tested on OLPC XO-1 and OLPC XO-1.75 laptops.

It's interesting that the very author of that code is not included in
so-o long Cc list :)
Cc: David.

David, do you remember if and how you had tested temperature report of
the battery on OLPC?
I guess this kind of error would be appear immediately.

OTOH it might be that power framework had changed requirements (which
would be noticeable change).
If the latter is true, this patch misses Fixes tag. Actually in any
case it misses it.

>
> [1] include/linux/power_supply.h
> [2] Documentation/power/power_supply_class.txt
>
> Cc: stable at vger.kernel.org
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/power/supply/olpc_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 6da79ae14860..5a97e42a3547 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_supply *psy,
>                 if (ret)
>                         return ret;
>
> -               val->intval = (s16)be16_to_cpu(ec_word) * 100 / 256;
> +               val->intval = (s16)be16_to_cpu(ec_word) * 10 / 256;
>                 break;
>         case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>                 ret = olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>                 if (ret)
>                         return ret;
>
> -               val->intval = (int)be16_to_cpu(ec_word) * 100 / 256;
> +               val->intval = (int)be16_to_cpu(ec_word) * 10 / 256;
>                 break;
>         case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>                 ret = olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
