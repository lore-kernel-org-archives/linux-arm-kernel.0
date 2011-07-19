From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Jul 2011 13:45:50 -0600
Subject: [PATCH 7/7] i2c: pxa: support to parse property
In-Reply-To: <1311042290-20253-8-git-send-email-haojian.zhuang@marvell.com>
References: <2011071901>
	<1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-3-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-4-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-5-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-6-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-7-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110719194550.GK6848@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 10:24:50AM +0800, Haojian Zhuang wrote:
> Support to parse some optional properties. These three properties are
> i2c-polling, i2c-frequency, i2c-class.
> 
> After supporting these property, i2c-pxa driver can avoid to use platform
> data except for slave mode.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  .../devicetree/bindings/i2c/pxa255-i2c.txt         |   36 ++++++++++++++++++++
>  drivers/i2c/busses/i2c-pxa.c                       |   22 ++++++++----
>  2 files changed, 51 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/pxa255-i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/pxa255-i2c.txt b/Documentation/devicetree/bindings/i2c/pxa255-i2c.txt
> new file mode 100644
> index 0000000..bf34236
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/pxa255-i2c.txt
> @@ -0,0 +1,36 @@
> +PXA255 I2C
> +
> +The I2C-Controller is first used in PXA255. It's widely used in Intel/Marvell
> +silicons.
> +
> +Optional Property:
> +	- i2c-polling: Specifies whether I2C-Controller is used in polling
> +	  mode or interrupt mode. The type of property should be <u32>.

mrvl,i2c-polling

Make this an empty property instead of reading a value out of it.  If
the property is present, then it means polling mode is requested.
Besides, wouldn't just the absence of an "interrupts" property mean that
the i2c controller should be run in polled mode?

> +
> +	- i2c-frequency: Specifies the frequency that the I2C-Controller
> +	  is working. The type of property should be <string>.
> +
> +	- i2c-class: Specifies the class of I2C-Controller. The type of
> +	  property should be <u32>.

???  What is this for?  The description in insufficient.

> +
> +Example:
> +	i2c0: i2c at d4011000 {
> +		compatible = "pxa2xx-i2c";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0xd4011000 0x60>;
> +		/* I2C-Controller works in interrupt mode. */
> +		i2c-polling = <0>;
> +		/* I2C-Controller's frequency is FAST. */
> +		i2c-frequency = "fast";
> +		/* interrupt of I2C-Controller */
> +		interrupts = <7>;
> +		interrupt-parent = <&mmp_intc>;
> +
> +		pm860x: pmic at 34 {
> +			interrupt-controller;
> +			/* interrupt of pm860x */
> +			interrupts = <4>;
> +			interrupt-parent = <&mmp_intc>;
> +		};
> +	};
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index adac74a..4b9fa71 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1060,7 +1060,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	const struct platform_device_id *id = platform_get_device_id(dev);
>  	enum pxa_i2c_types i2c_type;
>  	struct resource *res;
> -	int irq, ret;
> +	int irq, ret, poll;
> +	char *p = NULL;
>  	static int idx = 0;
>  
>  	if (np) {
> @@ -1093,11 +1094,24 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  
>  
>  	if (np) {
> +		of_property_read_u32(np, "i2c-polling", &poll);
> +		i2c->use_pio = (poll) ? 1 : 0;
> +		of_property_read_string(np, "i2c-frequency", &p);
> +		if (p && !strncmp(p, "fast", 4))
> +			i2c->fast_mode = 1;
> +		of_property_read_u32(np, "i2c-class", &i2c->adap.class);
> +
>  		i2c->adap.nr = idx++;
>  		snprintf(i2c->adap.name, sizeof(i2c->adap.name),
>  			"pxa2xx-i2c.%u", i2c->adap.nr);
>  		i2c->clk = clk_get_sys(i2c->adap.name, NULL);
>  	} else {
> +		if (plat) {
> +			i2c->adap.class = plat->class;
> +			i2c->use_pio = plat->use_pio;
> +			i2c->fast_mode = plat->fast_mode;
> +		}
> +
>  		/*
>  		 * If "dev->id" is negative we consider it as zero.
>  		 * The reason to do so is to avoid sysfs names that only make
> @@ -1142,12 +1156,6 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  
>  	clk_enable(i2c->clk);
>  
> -	if (plat) {
> -		i2c->adap.class = plat->class;
> -		i2c->use_pio = plat->use_pio;
> -		i2c->fast_mode = plat->fast_mode;
> -	}
> -
>  	if (i2c->use_pio) {
>  		i2c->adap.algo = &i2c_pxa_pio_algorithm;
>  	} else {
> -- 
> 1.5.6.5
> 
