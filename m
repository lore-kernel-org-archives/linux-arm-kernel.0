From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 4 Nov 2013 08:42:27 +0100
Subject: [PATCH RFC] clk: add gpio controlled clock
In-Reply-To: <c52a7910c6ce33ceed0f38b89953527eee06b0b5.1383312867.git.jsarha@ti.com>
References: <cover.1383312867.git.jsarha@ti.com>
 <c52a7910c6ce33ceed0f38b89953527eee06b0b5.1383312867.git.jsarha@ti.com>
Message-ID: <20131104084227.3323f98e@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jyri Sarha wrote:
> The added clk-gpio is a basic clock that can be enabled and disabled
> trough a gpio output. The DT binding document for the clock is also
> added.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../devicetree/bindings/clock/gpio-clock.txt       |   21 +++
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/clk-gpio.c                             |  154 ++++++++++++++++++++
>  include/linux/clk-provider.h                       |   25 ++++
>  4 files changed, 201 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
>  create mode 100644 drivers/clk/clk-gpio.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/gpio-clock.txt b/Documentation/devicetree/bindings/clock/gpio-clock.txt
> new file mode 100644
> index 0000000..54fea39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/gpio-clock.txt
[...]
> +/**
> + * clk_register_gpio - register a gpip clock with the clock framework
> + * @dev: device that is registering this clock
> + * @name: name of this clock
> + * @parent_name: name of this clock's parent
> + * @flags: framework-specific flags for this clock
> + * @gpio: gpio to control this clock
> + * @active_low: gpio polarity
> + */
> +struct clk *clk_register_gpio(struct device *dev, const char *name,
> +		const char *parent_name, unsigned long flags,
> +		unsigned int gpio, bool active_low)
> +{
> +	struct clk_gpio *clk_gpio;
> +	struct clk *clk;
> +	struct clk_init_data init = { NULL };
> +	unsigned long gpio_flags;
> +	int err;
> +
> +	if (active_low)
> +		gpio_flags = GPIOF_OUT_INIT_LOW;
> +	else
> +		gpio_flags = GPIOF_OUT_INIT_HIGH;
> +
> +	err = gpio_request_one(gpio, gpio_flags, name);
> +	if (err) {
> +		pr_err("%s: Error requesting clock control gpio %u\n",
> +		       __func__, gpio);
> +		return ERR_PTR(-EINVAL);
>
You already have an error code from the gpio_request_one() call.
Why return a different one?

> +
> +	clk_gpio = kzalloc(sizeof(struct clk_gpio), GFP_KERNEL);
>
devm_kzalloc()?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
