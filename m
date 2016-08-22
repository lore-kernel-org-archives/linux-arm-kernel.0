From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 22 Aug 2016 14:12:00 -0700
Subject: [PATCH] input: touchscreen: silead: Use devm_gpiod_get
In-Reply-To: <1471384043-11717-1-git-send-email-hdegoede@redhat.com>
References: <1471384043-11717-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160822211200.GD12277@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 11:47:23PM +0200, Hans de Goede wrote:
> The silead code is using devm_foo for everything (and does not free
> any resources). Except that it is using gpiod_get instead of
> devm_gpiod_get (but is not freeing the gpio_desc), change this
> to use devm_gpiod_get so that the gpio will be properly released.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/silead.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 04992c5..3b80f14 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -497,7 +497,7 @@ static int silead_ts_probe(struct i2c_client *client,
>  	}
>  
>  	/* Power GPIO pin */
> -	data->gpio_power = gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> +	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>  	if (IS_ERR(data->gpio_power)) {
>  		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
>  			dev_err(dev, "Shutdown GPIO request failed\n");
> -- 
> 2.7.4
> 

-- 
Dmitry
