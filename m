From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jun 2016 13:01:37 +0100
Subject: [PATCH v4 4/5] mfd: rn5t618: register power off callback
 optionally
In-Reply-To: <20160628062757.24490-5-stefan@agner.ch>
References: <20160628062757.24490-1-stefan@agner.ch>
 <20160628062757.24490-5-stefan@agner.ch>
Message-ID: <20160628120137.GE24982@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jun 2016, Stefan Agner wrote:

> Only register power off if the PMIC is defined as system power
> controller (see Documentation/devicetree/bindings/power/
> power-controller.txt).
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>  drivers/mfd/rn5t618.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

For my own reference:
  Acked-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index c86160d..1831740 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -102,9 +102,13 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> -	if (!pm_power_off) {
> -		rn5t618_pm_power_off = priv;
> -		pm_power_off = rn5t618_power_off;
> +	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
> +		if (!pm_power_off) {
> +			rn5t618_pm_power_off = priv;
> +			pm_power_off = rn5t618_power_off;
> +		} else {
> +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
> +		}
>  	}
>  
>  	return 0;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
