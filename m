From: zonque@gmail.com (Daniel Mack)
Date: Wed, 08 Aug 2012 15:23:15 +0200
Subject: [PATCH 2/6] ARM: pxa remove irq_to_gpio from eeti_ts driver
In-Reply-To: <1344430493-5304-3-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-3-git-send-email-arnd@arndb.de>
Message-ID: <50226843.4080508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2012 14:54, Arnd Bergmann wrote:
> The irq_to_gpio function was removed from the pxa platform
> in linux-3.2, and this driver has been broken since.
> 
> Without this patch, building raumfeld_defconfig results in:
> 
> drivers/input/touchscreen/eeti_ts.c: In function 'eeti_ts_irq_active':
> drivers/input/touchscreen/eeti_ts.c:65:2: error: implicit declaration of function 'irq_to_gpio' [-Werror=implicit-function-declaration]

I've sent out a slightly different version of such a patch just
yesterday. It deferres mainly in the fact that it uses gpio_to_irq() and
ignores the i2c_client's irq line. That way, there can't be any
inconsitency.

I've appended the patch again - I haven't heard back from Dmitry yet.


Thanks,
Daniel



> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org (v3.2+)
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  arch/arm/mach-pxa/raumfeld.c        |    1 +
>  drivers/input/touchscreen/eeti_ts.c |    8 +++++---
>  include/linux/input/eeti_ts.h       |    1 +
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 5905ed1..9e1c4ea 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -953,6 +953,7 @@ static struct i2c_board_info raumfeld_connector_i2c_board_info __initdata = {
>  
>  static struct eeti_ts_platform_data eeti_ts_pdata = {
>  	.irq_active_high = 1,
> +	.gpio = GPIO_TOUCH_IRQ,
>  };
>  
>  static struct i2c_board_info raumfeld_controller_i2c_board_info __initdata = {
> diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
> index 503c709..45dab18 100644
> --- a/drivers/input/touchscreen/eeti_ts.c
> +++ b/drivers/input/touchscreen/eeti_ts.c
> @@ -48,7 +48,7 @@ struct eeti_ts_priv {
>  	struct input_dev *input;
>  	struct work_struct work;
>  	struct mutex mutex;
> -	int irq, irq_active_high;
> +	int irq, gpio, irq_active_high;
>  };
>  
>  #define EETI_TS_BITDEPTH	(11)
> @@ -62,7 +62,7 @@ struct eeti_ts_priv {
>  
>  static inline int eeti_ts_irq_active(struct eeti_ts_priv *priv)
>  {
> -	return gpio_get_value(irq_to_gpio(priv->irq)) == priv->irq_active_high;
> +	return gpio_get_value(priv->gpio) == priv->irq_active_high;
>  }
>  
>  static void eeti_ts_read(struct work_struct *work)
> @@ -203,8 +203,10 @@ static int __devinit eeti_ts_probe(struct i2c_client *client,
>  
>  	pdata = client->dev.platform_data;
>  
> -	if (pdata)
> +	if (pdata) {
> +		priv->gpio = pdata->gpio;
>  		priv->irq_active_high = pdata->irq_active_high;
> +	}
>  
>  	irq_flags = priv->irq_active_high ?
>  		IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
> diff --git a/include/linux/input/eeti_ts.h b/include/linux/input/eeti_ts.h
> index f875b31..3404504 100644
> --- a/include/linux/input/eeti_ts.h
> +++ b/include/linux/input/eeti_ts.h
> @@ -3,6 +3,7 @@
>  
>  struct eeti_ts_platform_data {
>  	unsigned int irq_active_high;
> +	unsigned int gpio;
>  };
>  
>  #endif /* LINUX_INPUT_EETI_TS_H */
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Input-eeti_ts-pass-gpio-value-instead-of-IRQ.patch
Type: text/x-patch
Size: 3730 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120808/9725df93/attachment.bin>
