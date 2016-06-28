From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jun 2016 13:03:56 +0100
Subject: [PATCH v4 5/5] mfd: rn5t618: register restart handler
In-Reply-To: <20160628062757.24490-6-stefan@agner.ch>
References: <20160628062757.24490-1-stefan@agner.ch>
 <20160628062757.24490-6-stefan@agner.ch>
Message-ID: <20160628120356.GF24982@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jun 2016, Stefan Agner wrote:

> Use the PMIC's repower capability for reboots. Register a restart
> handler and use a slightly elevated priority of 192 since the PMIC
> has suprior reset capability (causing a system wide reset).
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>  drivers/mfd/rn5t618.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index 1831740..b3ca6df 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -12,11 +12,13 @@
>   * along with this program. If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/rn5t618.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/reboot.h>
>  #include <linux/regmap.h>
>  
>  static const struct mfd_cell rn5t618_cells[] = {
> @@ -50,17 +52,38 @@ static const struct regmap_config rn5t618_regmap_config = {
>  };
>  
>  static struct rn5t618 *rn5t618_pm_power_off;
> +static struct notifier_block rn5t618_restart_handler;
>  
> -static void rn5t618_power_off(void)
> +static void rn5t618_trigger_poweroff_sequence(bool repower)
>  {
>  	/* disable automatic repower-on */
>  	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_REPCNT,
> -			   RN5T618_REPCNT_REPWRON, 0);
> +			   RN5T618_REPCNT_REPWRON,
> +			   repower ? RN5T618_REPCNT_REPWRON : 0);
>  	/* start power-off sequence */
>  	regmap_update_bits(rn5t618_pm_power_off->regmap, RN5T618_SLPCNT,
>  			   RN5T618_SLPCNT_SWPWROFF, RN5T618_SLPCNT_SWPWROFF);
>  }
>  
> +static void rn5t618_power_off(void)
> +{
> +	rn5t618_trigger_poweroff_sequence(false);
> +}
> +
> +static int rn5t618_restart(struct notifier_block *this,
> +			    unsigned long mode, void *cmd)
> +{
> +	rn5t618_trigger_poweroff_sequence(true);
> +
> +	/*
> +	 * Repower factor detection on PMIC side is not instant. 1ms
> +	 * proved to be enouth time until reset takes effect.

Spell check.

Please fix this, add all the Acks you received and resubmit the set.

Acked-by: Lee Jones <lee.jones@linaro.org>

> +	 */
> +	mdelay(1);
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static const struct of_device_id rn5t618_of_match[] = {
>  	{ .compatible = "ricoh,rn5t567", .data = (void *)RN5T567 },
>  	{ .compatible = "ricoh,rn5t618", .data = (void *)RN5T618 },
> @@ -102,13 +125,21 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> +	rn5t618_pm_power_off = priv;
>  	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
> -		if (!pm_power_off) {
> -			rn5t618_pm_power_off = priv;
> +		if (!pm_power_off)
>  			pm_power_off = rn5t618_power_off;
> -		} else {
> +		else
>  			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
> -		}
> +	}
> +
> +	rn5t618_restart_handler.notifier_call = rn5t618_restart;
> +	rn5t618_restart_handler.priority = 192;
> +
> +	ret = register_restart_handler(&rn5t618_restart_handler);
> +	if (ret) {
> +		dev_err(&i2c->dev, "cannot register restart handler, %d\n", ret);
> +		return ret;
>  	}
>  
>  	return 0;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
