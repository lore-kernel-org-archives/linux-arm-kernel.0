From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Dec 2015 08:29:41 -0600
Subject: [PATCH RFC 3/3] input: rotary_encoder: support more than 2 gpios
 as input
In-Reply-To: <1449050834-31779-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1449050834-31779-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20151202142941.GA16722@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 11:07:14AM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm/mach-pxa/raumfeld.c                       |  25 +++-
>  drivers/input/misc/rotary_encoder.c                | 127 +++++++++------------
>  include/linux/rotary_encoder.h                     |   4 -
>  4 files changed, 79 insertions(+), 79 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index de99cbbbf6da..6c9f0c8a846c 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -1,7 +1,7 @@
>  Rotary encoder DT bindings
>  
>  Required properties:
> -- gpios: a spec for two GPIOs to be used
> +- gpios: a spec for at least two GPIOs to be used, most significant first
>  
>  Optional properties:
>  - linux,axis: the input subsystem axis to map to this rotary encoder.
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 36571a9a44fe..f47e59b0efa8 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/smsc911x.h>
>  #include <linux/input.h>
>  #include <linux/rotary_encoder.h>
> @@ -370,10 +371,25 @@ static struct rotary_encoder_platform_data raumfeld_rotary_encoder_info = {
>  	.steps		= 24,
>  	.axis		= REL_X,
>  	.relative_axis	= 1,
> -	.gpio_a		= GPIO_VOLENC_A,
> -	.gpio_b		= GPIO_VOLENC_B,
> -	.inverted_a	= 1,
> -	.inverted_b	= 0,
> +};
> +
> +static struct gpiod_lookup_table raumfeld_rotary_encoder_gpio_lookup = {
> +	.dev_id = "rotary_encoder.0",
> +	.table = {
> +		{
> +			.chip_label = "gpio-0",
> +			.chip_hwnum = GPIO_VOLENC_A,
> +			.idx = 0,
> +			.flags = GPIO_ACTIVE_LOW,
> +		},
> +		{
> +			.chip_label = "gpio-0",
> +			.chip_hwnum = GPIO_VOLENC_B,
> +			.idx = 1,
> +			.flags = GPIO_ACTIVE_HIGH,
> +		},
> +		{ /* sentinel */ }
> +	},
>  };
>  
>  static struct platform_device rotary_encoder_device = {
> @@ -1051,6 +1067,7 @@ static void __init raumfeld_controller_init(void)
>  	int ret;
>  
>  	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_controller_pin_config));
> +	gpiod_add_lookup_table(&raumfeld_rotary_encoder_gpio_lookup);
>  	platform_device_register(&rotary_encoder_device);
>  	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
>  	i2c_register_board_info(0, &raumfeld_controller_i2c_board_info, 1);
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index 0582e851993f..99f19e037370 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -25,7 +25,6 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pm.h>
>  
>  #define DRV_NAME "rotary-encoder"
> @@ -36,45 +35,47 @@ struct rotary_encoder {
>  	/* configuration */
>  	unsigned int steps;
>  	unsigned int axis;
> -	unsigned int gpio_a;
> -	unsigned int gpio_b;
> -	unsigned int inverted_a;
> -	unsigned int inverted_b;
>  	unsigned int steps_per_period;
>  	bool relative_axis;
>  	bool rollover;
>  	bool wakeup_source;
>  
> -	unsigned int irq_a;
> -	unsigned int irq_b;
> +	struct gpio_descs *gpios;
> +	unsigned int *irq;
>  
>  	/* state */
>  	unsigned int pos;
>  	bool armed;
> -	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
> +	signed char dir;	/* 1 - clockwise, -1 - CCW */
>  	char last_stable;
>  };
>  
> -static int rotary_encoder_get_state(const struct rotary_encoder *encoder)
> +static unsigned rotary_encoder_get_state(const struct rotary_encoder *encoder)
>  {
> -	int a = !!gpio_get_value(encoder->gpio_a);
> -	int b = !!gpio_get_value(encoder->gpio_b);
> +	int i;
> +	unsigned ret = 0;
>  
> -	a ^= encoder->inverted_a;
> -	b ^= encoder->inverted_b;
> +	for (i = 0; i < encoder->gpios->ndescs; ++i) {
> +		int val = gpiod_get_value(encoder->gpios->desc[i]);
> +		/* convert from gray encoding to normal */
> +		if (ret & 1)
> +			val = !val;
>  
> -	return ((a << 1) | b);
> +		ret = ret << 1 | val;
> +	}
> +
> +	return ret & 3;
>  }
>  
>  static void rotary_encoder_report_event(struct rotary_encoder *encoder)
>  {
>  	if (encoder->relative_axis) {
>  		input_report_rel(encoder->input,
> -				 encoder->axis, encoder->dir ? -1 : 1);
> +				 encoder->axis, encoder->dir);
>  	} else {
>  		unsigned int pos = encoder->pos;
>  
> -		if (encoder->dir) {
> +		if (encoder->dir < 0) {
>  			/* turning counter-clockwise */
>  			if (encoder->rollover)
>  				pos += encoder->steps;
> @@ -112,12 +113,12 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
>  		break;
>  
>  	case 0x1:
> -	case 0x2:
> +	case 0x3:
>  		if (encoder->armed)
> -			encoder->dir = state - 1;
> +			encoder->dir = 2 - state;
>  		break;
>  
> -	case 0x3:
> +	case 0x2:
>  		encoder->armed = true;
>  		break;
>  	}
> @@ -134,7 +135,7 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
>  
>  	switch (state) {
>  	case 0x00:
> -	case 0x03:
> +	case 0x02:
>  		if (state != encoder->last_stable) {
>  			rotary_encoder_report_event(encoder);
>  			encoder->last_stable = state;
> @@ -142,8 +143,8 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
>  		break;
>  
>  	case 0x01:
> -	case 0x02:
> -		encoder->dir = (encoder->last_stable + state) & 0x01;
> +	case 0x03:
> +		encoder->dir = ((encoder->last_stable - state + 1) % 4) - 1;
>  		break;
>  	}
>  
> @@ -212,7 +213,6 @@ static int rotary_encoder_parse_dt(struct device *dev,
>  	const struct of_device_id *of_id =
>  				of_match_device(rotary_encoder_of_match, dev);
>  	struct device_node *np = dev->of_node;
> -	enum of_gpio_flags flags;
>  	int error;
>  
>  	if (!of_id || !np)
> @@ -221,12 +221,6 @@ static int rotary_encoder_parse_dt(struct device *dev,
>  	of_property_read_u32(np, "rotary-encoder,steps", &encoder->steps);
>  	of_property_read_u32(np, "linux,axis", &encoder->axis);
>  
> -	encoder->gpio_a = of_get_gpio_flags(np, 0, &flags);
> -	encoder->inverted_a = flags & OF_GPIO_ACTIVE_LOW;
> -
> -	encoder->gpio_b = of_get_gpio_flags(np, 1, &flags);
> -	encoder->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
> -
>  	encoder->relative_axis =
>  		of_property_read_bool(np, "rotary-encoder,relative-axis");
>  	encoder->rollover =
> @@ -273,11 +267,6 @@ static int rotary_encoder_parse_pdata(struct device *dev,
>  
>  	encoder->steps = pdata->steps;
>  	encoder->axis = pdata->axis;
> -	encoder->gpio_a = pdata->gpio_a;
> -	encoder->gpio_b = pdata->gpio_b;
> -	encoder->inverted_a = pdata->inverted_a;
> -	encoder->inverted_b = pdata->inverted_b;
> -	encoder->steps_per_period = pdata->steps_per_period;
>  	encoder->relative_axis = pdata->relative_axis;
>  	encoder->rollover = pdata->rollover;
>  
> @@ -291,6 +280,7 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>  	struct input_dev *input;
>  	irq_handler_t handler;
>  	int err;
> +	unsigned int i;
>  
>  	encoder = devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERNEL);
>  	input = devm_input_allocate_device(&pdev->dev);
> @@ -307,6 +297,16 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>  	if (err < 0)
>  		return err;
>  
> +	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
> +	if (IS_ERR(encoder->gpios)) {
> +		dev_err(dev, "unable to get gpios\n");
> +		return PTR_ERR(encoder->gpios);
> +	}
> +	if (encoder->gpios->ndescs < 2) {
> +		dev_err(dev, "not enough gpios found\n");
> +		return -EINVAL;
> +	}
> +
>  	encoder->input = input;
>  
>  	input->name = pdev->name;
> @@ -322,25 +322,7 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>  				     encoder->axis, 0, encoder->steps, 0, 1);
>  	}
>  
> -	/* request the GPIOs */
> -	err = devm_gpio_request_one(dev, encoder->gpio_a,
> -				    GPIOF_IN, dev_name(dev));
> -	if (err) {
> -		dev_err(dev, "unable to request GPIO %d\n", encoder->gpio_a);
> -		return err;
> -	}
> -
> -	err = devm_gpio_request_one(dev, encoder->gpio_b,
> -				    GPIOF_IN, dev_name(dev));
> -	if (err) {
> -		dev_err(dev, "unable to request GPIO %d\n", encoder->gpio_b);
> -		return err;
> -	}
> -
> -	encoder->irq_a = gpio_to_irq(encoder->gpio_a);
> -	encoder->irq_b = gpio_to_irq(encoder->gpio_b);
> -
> -	switch (encoder->steps_per_period) {
> +	switch (encoder->steps_per_period >> (encoder->gpios->ndescs - 2)) {
>  	case 4:
>  		handler = &rotary_encoder_quarter_period_irq;
>  		encoder->last_stable = rotary_encoder_get_state(encoder);
> @@ -358,20 +340,23 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	err = devm_request_irq(dev, encoder->irq_a, handler,
> -			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -			       DRV_NAME, encoder);
> -	if (err) {
> -		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
> -		return err;
> -	}
> +	encoder->irq =
> +		devm_kzalloc(dev,
> +			     sizeof(*encoder->irq) * encoder->gpios->ndescs,
> +			     GFP_KERNEL);
> +	if (!encoder->irq)
> +		return -ENOMEM;
>  
> -	err = devm_request_irq(dev, encoder->irq_b, handler,
> -			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -			       DRV_NAME, encoder);
> -	if (err) {
> -		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
> -		return err;
> +	for (i = 0; i < encoder->gpios->ndescs; ++i) {
> +		encoder->irq[i] = gpiod_to_irq(encoder->gpios->desc[i]);
> +		err = devm_request_irq(dev, encoder->irq[i], handler,
> +				       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				       DRV_NAME, encoder);
> +		if (err) {
> +			dev_err(dev, "unable to request IRQ %d (gpio#%d)\n",
> +				encoder->irq[i], i);
> +			return err;
> +		}
>  	}
>  
>  	err = input_register_device(input);
> @@ -399,8 +384,9 @@ static int rotary_encoder_suspend(struct device *dev)
>  	struct rotary_encoder *encoder = dev_get_drvdata(dev);
>  
>  	if (device_may_wakeup(dev)) {
> -		enable_irq_wake(encoder->irq_a);
> -		enable_irq_wake(encoder->irq_b);
> +		unsigned int i;
> +		for (i = 0; i < encoder->gpios->ndescs; ++i)
> +			enable_irq_wake(encoder->irq[i]);
>  	}
>  
>  	return 0;
> @@ -411,8 +397,9 @@ static int rotary_encoder_resume(struct device *dev)
>  	struct rotary_encoder *encoder = dev_get_drvdata(dev);
>  
>  	if (device_may_wakeup(dev)) {
> -		disable_irq_wake(encoder->irq_a);
> -		disable_irq_wake(encoder->irq_b);
> +		unsigned int i;
> +		for (i = 0; i < encoder->gpios->ndescs; ++i)
> +			disable_irq_wake(encoder->irq[i]);
>  	}
>  
>  	return 0;
> diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
> index fe3dc64e5aeb..4536c813a1e9 100644
> --- a/include/linux/rotary_encoder.h
> +++ b/include/linux/rotary_encoder.h
> @@ -4,10 +4,6 @@
>  struct rotary_encoder_platform_data {
>  	unsigned int steps;
>  	unsigned int axis;
> -	unsigned int gpio_a;
> -	unsigned int gpio_b;
> -	unsigned int inverted_a;
> -	unsigned int inverted_b;
>  	unsigned int steps_per_period;
>  	bool relative_axis;
>  	bool rollover;
> -- 
> 2.6.2
> 
