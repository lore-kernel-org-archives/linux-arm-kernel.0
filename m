From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 8 Apr 2018 13:28:04 +0200 (CEST)
Subject: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies
 return failure
In-Reply-To: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
References: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
Message-ID: <2047337098.98106.1523186884813@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

[add Phil]

> Geert Uytterhoeven <geert@linux-m68k.org> hat am 8. April 2018 um 11:05 geschrieben:
> 
> 
> If CONFIG_RASPBERRYPI_FIRMWARE=n:
> 
>     drivers/gpio/gpio-raspberrypi-exp.c: In function ?rpi_exp_gpio_get_polarity?:
>     drivers/gpio/gpio-raspberrypi-exp.c:71: warning: ?get.polarity? is used uninitialized in this function
>     drivers/gpio/gpio-raspberrypi-exp.c: In function ?rpi_exp_gpio_get_direction?:
>     drivers/gpio/gpio-raspberrypi-exp.c:150: warning: ?get.direction? is used uninitialized in this function
> 
> The dummy firmware interface functions return 0, which means success,
> causing subsequent code to make use of the never initialized output
> parameter.

i think this is more theoritical, because we need to get rpi_firmware first and in this case it's NULL.

> 
> Fix this by making the dummy functions return an error code (-ENOSYS)
> instead.

Anyway i'm okay with the change.

> 
> Note that this assumes the firmware always fills in the requested data
> in the CONFIG_RASPBERRYPI_FIRMWARE=y case.

Unfortunately i don't know.

> 
> Fixes: d45f1a563b92dac7 ("staging: vc04_services: fix up rpi firmware functions")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Should get.polarity resp. get.direction be preinitialized instead,
> like is done for get.state?
> 
> static int rpi_exp_gpio_get(struct gpio_chip *gc, unsigned int off)
> {
>         ...
>         get.state = 0;          /* storage for returned value */
> 
>         ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_STATE,
>                                          &get, sizeof(get));
>         ...
> }
> 
> This would avoid returning uninitialized data if the firmware did not
> fill in the requested data.
> ---
>  include/soc/bcm2835/raspberrypi-firmware.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
> index 50df5b28d2c9df6e..8ee8991aa099af3a 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -143,13 +143,13 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
>  static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
>  					void *data, size_t len)
>  {
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static inline int rpi_firmware_property_list(struct rpi_firmware *fw,
>  					     void *data, size_t tag_size)
>  {
> -	return 0;
> +	return -ENOSYS;
>  }
>  
>  static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
