From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 29 May 2015 22:31:37 +0200
Subject: [PATCH 05/12] i2c: pxa: Add bus reset functionality
In-Reply-To: <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
 (Vaibhav Hiremath's message of "Thu, 28 May 2015 18:33:37 +0530")
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87zj4nxh06.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:

> From: Rob Herring <robh@kernel.org>
>
> Since there is some problematic i2c slave devices on some
> platforms such as dkb (sometimes), it will drop down sda
> and make i2c bus hang, at that time, it need to config
> scl/sda into gpio to simulate "stop" sequence to recover
> i2c bus, so add this interface.
>
> Signed-off-by: Leilei Shang <shangll@marvell.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> [vaibhav.hiremath at linaro.org: Updated Changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
I'm not enthusiastic about this patch.
Linus, would you please place a comment on this patch ?

My personal feeling :
 - all the udelays are just ugly
 - the pinctrl binding into i2c-pxa doesn't look good to me
   Linus will probably comment on that

 - all of this patch looks like a workaround for a single platform "poor"
   support. If this is dkb specific (what is dkb BTW ?), can't it be hooked
   into this driver, but placed in dkb platform code ?

Cheers.

--
Robert

> ---
>  drivers/i2c/busses/i2c-pxa.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 8ca5552..eb09071 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -37,6 +37,8 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/i2c/pxa-i2c.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include <asm/irq.h>
>  
> @@ -177,6 +179,9 @@ struct pxa_i2c {
>  	bool			highmode_enter;
>  	unsigned int		ilcr;
>  	unsigned int		iwcr;
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*pin_i2c;
> +	struct pinctrl_state	*pin_gpio;
>  };
>  
>  #define _IBMR(i2c)	((i2c)->reg_ibmr)
> @@ -269,6 +274,62 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c, int lno, const char *fname)
>  
>  #define show_state(i2c) i2c_pxa_show_state(i2c, __LINE__, __func__)
>  
> +static void i2c_bus_reset(struct pxa_i2c *i2c)
> +{
> +	int ret, ccnt, pins_scl, pins_sda;
> +	struct device *dev = i2c->adap.dev.parent;
> +	struct device_node *np = dev->of_node;
> +
> +	if (!i2c->pinctrl) {
> +		dev_warn(dev, "could not do i2c bus reset\n");
> +		return;
> +	}
> +
> +	ret = pinctrl_select_state(i2c->pinctrl, i2c->pin_gpio);
> +	if (ret) {
> +		dev_err(dev, "could not set gpio pins\n");
> +		return;
> +	}
> +
> +	pins_scl = of_get_named_gpio(np, "i2c-gpio", 0);
> +	if (!gpio_is_valid(pins_scl)) {
> +		dev_err(dev, "i2c scl gpio not set\n");
> +		goto err_out;
> +	}
> +	pins_sda = of_get_named_gpio(np, "i2c-gpio", 1);
> +	if (!gpio_is_valid(pins_sda)) {
> +		dev_err(dev, "i2c sda gpio not set\n");
> +		goto err_out;
> +	}
> +
> +	gpio_request(pins_scl, NULL);
> +	gpio_request(pins_sda, NULL);
> +
> +	gpio_direction_input(pins_sda);
> +	for (ccnt = 20; ccnt; ccnt--) {
> +		gpio_direction_output(pins_scl, ccnt & 0x01);
> +		udelay(5);
> +	}
> +	gpio_direction_output(pins_scl, 0);
> +	udelay(5);
> +	gpio_direction_output(pins_sda, 0);
> +	udelay(5);
> +	/* stop signal */
> +	gpio_direction_output(pins_scl, 1);
> +	udelay(5);
> +	gpio_direction_output(pins_sda, 1);
> +	udelay(5);
> +
> +	gpio_free(pins_scl);
> +	gpio_free(pins_sda);
> +
> +err_out:
> +	ret = pinctrl_select_state(i2c->pinctrl, i2c->pin_i2c);
> +	if (ret)
> +		dev_err(dev, "could not set default(i2c) pins\n");
> +	return;
> +}
> +
>  static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
>  {
>  	unsigned int i;
> @@ -281,6 +342,11 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
>  	for (i = 0; i < i2c->irqlogidx; i++)
>  		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
>  	printk("\n");
> +	if (strcmp(why, "exhausted retries") != 0) {
> +		i2c_bus_reset(i2c);
> +		/* reset i2c contorler when it's fail */
> +		i2c_pxa_reset(i2c);
> +	}
>  }
>  
>  #else /* ifdef DEBUG */
> @@ -1301,6 +1367,30 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  
>  	platform_set_drvdata(dev, i2c);
>  
> +	i2c->pinctrl = devm_pinctrl_get(&dev->dev);
> +	if (IS_ERR(i2c->pinctrl)) {
> +		i2c->pinctrl = NULL;
> +		dev_warn(&dev->dev, "could not get pinctrl\n");
> +	} else {
> +		i2c->pin_i2c = pinctrl_lookup_state(i2c->pinctrl, "default");
> +		if (IS_ERR(i2c->pin_i2c)) {
> +			dev_err(&dev->dev, "could not get default(i2c) pinstate\n");
> +			ret = IS_ERR(i2c->pin_i2c);
> +		}
> +
> +		i2c->pin_gpio = pinctrl_lookup_state(i2c->pinctrl, "gpio");
> +		if (IS_ERR(i2c->pin_gpio)) {
> +			dev_err(&dev->dev, "could not get gpio pinstate\n");
> +			ret = IS_ERR(i2c->pin_gpio);
> +		}
> +
> +		if (ret) {
> +			i2c->pin_i2c = NULL;
> +			i2c->pin_gpio = NULL;
> +			i2c->pinctrl = NULL;
> +			ret = 0;
> +		}
> +	}
>  #ifdef CONFIG_I2C_PXA_SLAVE
>  	printk(KERN_INFO "I2C: %s: PXA I2C adapter, slave address %d\n",
>  	       dev_name(&i2c->adap.dev), i2c->slave_addr);

-- 
Robert
