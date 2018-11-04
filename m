From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:37:10 +0100
Subject: [PATCH 12/15] power: supply: olpc_battery: Use DT to get battery
 version
In-Reply-To: <20181010172300.317643-13-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-13-lkundrak@v3.sk>
Message-ID: <20181104123710.GE23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:57, Lubomir Rintel wrote:
> Avoid using the x86 OLPC platform specific call to get the board
> version. It won't work on FDT-based ARM MMP2 platform.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

AFAICT, this should go earlier in the series; first, add support in
the code, then switch to new name in DTS.
								Pavel

> ---
>  drivers/power/supply/olpc_battery.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 5a97e42a3547..540d44bf536f 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -19,6 +19,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/sched.h>
>  #include <linux/olpc-ec.h>
> +#include <linux/of.h>
>  #include <asm/olpc.h>
>  
>  
> @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
>  	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
>  	if (IS_ERR(olpc_ac))
>  		return PTR_ERR(olpc_ac);
> -
> -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> +					"olpc,xo1.5-battery") >= 0) {
> +		/* XO-1.5 */
>  		olpc_bat_desc.properties = olpc_xo15_bat_props;
>  		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
> -	} else { /* XO-1 */
> +	} else {
> +		/* XO-1 */
>  		olpc_bat_desc.properties = olpc_xo1_bat_props;
>  		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id olpc_battery_ids[] = {
>  	{ .compatible = "olpc,xo1-battery" },
> +	{ .compatible = "olpc,xo1.5-battery" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, olpc_battery_ids);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/0054373d/attachment.sig>
