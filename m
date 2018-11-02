From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 2 Nov 2018 23:16:15 +0100
Subject: [PATCH 01/15] power: supply: olpc_battery: correct the
 temperature units
In-Reply-To: <20181010172300.317643-2-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-2-lkundrak@v3.sk>
Message-ID: <20181102221615.GB5322@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:46, Lubomir Rintel wrote:
> According to [1] and [2], the temperature values are in tenths of degree
> Celsius. Exposing the Celsius value makes the battery appear on fire:
> 
>   $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
>   ...
>       temperature:         236.9 degrees C
> 
> Tested on OLPC XO-1 and OLPC XO-1.75 laptops.
> 
> [1] include/linux/power_supply.h
> [2] Documentation/power/power_supply_class.txt
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/power/supply/olpc_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 6da79ae14860..5a97e42a3547 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_supply *psy,
>  		if (ret)
>  			return ret;
>  
> -		val->intval = (s16)be16_to_cpu(ec_word) * 100 / 256;
> +		val->intval = (s16)be16_to_cpu(ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>  		ret = olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>  		if (ret)
>  			return ret;
>  
> -		val->intval = (int)be16_to_cpu(ec_word) * 100 / 256;
> +		val->intval = (int)be16_to_cpu(ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		ret = olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181102/4d9489e3/attachment.sig>
