From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Wed, 24 Jun 2015 11:07:57 +0200
Subject: [PATCH v3 1/3] leds: netxbig: add device tree binding
In-Reply-To: <20150623211711.GF4853@kw.sim.vm.gnt>
References: <1434639590-27389-1-git-send-email-simon.guinot@sequanux.org>
 <1434639590-27389-2-git-send-email-simon.guinot@sequanux.org>
 <55894D0A.8000306@samsung.com> <20150623211711.GF4853@kw.sim.vm.gnt>
Message-ID: <558A736D.8030503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 06/23/2015 11:17 PM, Simon Guinot wrote:
> On Tue, Jun 23, 2015 at 02:11:54PM +0200, Jacek Anaszewski wrote:
>> Hi Simon,
>
> Hi Jacek,
>
> Thanks again for taking care of this patch set.
>
>>
>> On 06/18/2015 04:59 PM, Simon Guinot wrote:
>>> This patch adds device tree support for the netxbig LEDs.
>>>
>>> This also introduces a additionnal DT binding for the GPIO extension bus
>>> (netxbig-gpio-ext) used to configure the LEDs. Since this bus could also
>>> be used to control other devices, then it seems more suitable to have it
>>> in a separate DT binding.
>>>
>>> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
>>> ---
>>> Changes since v1:
>>> - Check timer mode value retrieved from DT.
>>> - In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
>>>    timer delay values from DT with function of_property_read_u32_index.
>>>    Instead, use a temporary u32 variable. This allows to silence a static
>>>    checker warning.
>>> - Make timer property optional in the binding documentation. It is now
>>>    aligned with the driver code.
>>>
>>> Changes since v2:
>>> - Fix pointer usage with the temporary u32 variable while calling
>>>    of_property_read_u32_index.
>>>
>>>   .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
>>>   .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++++
>>>   drivers/leds/leds-netxbig.c                        | 250 +++++++++++++++++++--
>>>   include/dt-bindings/leds/leds-netxbig.h            |  18 ++
>>>   4 files changed, 361 insertions(+), 21 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
>>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
>>>   create mode 100644 include/dt-bindings/leds/leds-netxbig.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt b/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
>>> new file mode 100644
>>> index 000000000000..e4fb2fe11086
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
>>> @@ -0,0 +1,22 @@
>>> +Binding for the GPIO extension bus found on some LaCie/Seagate boards
>>> +(Example: 2Big/5Big Network v2, 2Big NAS).
>>> +
>>> +Required properties:
>>> +- compatible: "lacie,netxbig-gpio-ext".
>>> +- addr-gpios: GPIOs representing the address register.
>>> +- data-gpios: GPIOs representing the data register.
>>> +- enable-gpio: GPIO used to enable the new configuration (address, data).
>>
>> Please mention that enable-gpio latches the settings on raising edge.
>
> OK.
>
>>
>>> +
>>> +Example:
>>> +
>>> +netxbig_gpio_ext: netxbig-gpio-ext {
>>> +	compatible = "lacie,netxbig-gpio-ext";
>>> +
>>> +	addr-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH
>>> +		      &gpio1 16 GPIO_ACTIVE_HIGH
>>> +		      &gpio1 17 GPIO_ACTIVE_HIGH>;
>>> +	data-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH
>>> +		      &gpio1 13 GPIO_ACTIVE_HIGH
>>> +		      &gpio1 14 GPIO_ACTIVE_HIGH>;
>>
>> You should indicate which element is MSB/LSB.
>
> OK.
>
>>
>>> +	enable-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
>>> +};
>>
>> This needs gpio maintainer ack. Adding Linus and Alexandre.
>>
>> Please also cc devicetree at vger.kernel.org always when modifying
>> DT bindings.
>
> OK.
>
>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-netxbig.txt b/Documentation/devicetree/bindings/leds/leds-netxbig.txt
>>> new file mode 100644
>>> index 000000000000..efadbecbfeb9
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/leds-netxbig.txt
>>> @@ -0,0 +1,92 @@
>>> +Binding for the CPLD LEDs (GPIO extension bus) found on some LaCie/Seagate
>>> +boards (Example: 2Big/5Big Network v2, 2Big NAS).
>>> +
>>> +Required properties:
>>> +- compatible: "lacie,netxbig-leds".
>>> +- gpio-ext: Phandle for the gpio-ext bus.
>>> +
>>> +Optional properties:
>>> +- timers: Timer array. Each timer entry is represented by three integers:
>>> +  Mode (gpio-ext bus), delay_on and delay_off.
>>> +
>>> +Each LED is represented as a sub-node of the netxbig-leds device.
>>> +
>>> +Required sub-node properties:
>>> +- mode-addr: Mode register address on gpio-ext bus.
>>> +- mode-val: Mode to value mapping. Each entry is represented by two integers:
>>> +  A mode and the corresponding value on the gpio-ext bus.
>>> +- bright-addr: Brightness register address on gpio-ext bus.
>>> +- bright-max: Maximum brightness value.
>>
>> We have a property led-max-microamp for this. Since LED subsystem
>> brightness level is not suitable for describing hardware properties,
>> we've switched to using microamperes. There is pending patch [1] that
>> makes the things more precise.
>
> Thanks. I'll have a look at this.
>
>>
>>> +
>>> +Optional sub-node properties:
>>> +- label: Name for this LED. If omitted, the label is taken from the node name.
>>> +- linux,default-trigger: Trigger assigned to the LED.
>>> +
>>> +Example:
>>> +
>>> +netxbig-leds {
>>> +	compatible = "lacie,netxbig-leds";
>>> +
>>> +	gpio-ext = &gpio_ext;
>>> +
>>> +	timers = <NETXBIG_LED_TIMER1 500 500
>>> +		  NETXBIG_LED_TIMER2 500 1000>;
>>> +
>>> +	blue-power {
>>> +		label = "netxbig:blue:power";
>>> +		mode-addr = <0>;
>>> +		mode-val = <NETXBIG_LED_OFF 0
>>> +			    NETXBIG_LED_ON 1
>>> +			    NETXBIG_LED_TIMER1 3
>>> +			    NETXBIG_LED_TIMER2 7>;
>>> +		bright-addr = <1>;
>>> +		bright-max = <7>;
>>> +	};
>>> +	red-power {
>>> +		label = "netxbig:red:power";
>>> +		mode-addr = <0>;
>>> +		mode-val = <NETXBIG_LED_OFF 0
>>> +			    NETXBIG_LED_ON 2
>>> +			    NETXBIG_LED_TIMER1 4>;
>>> +		bright-addr = <1>;
>>> +		bright-max = <7>;
>>> +	};
>>> +	blue-sata0 {
>>> +		label = "netxbig:blue:sata0";
>>> +		mode-addr = <3>;
>>> +		mode-val = <NETXBIG_LED_OFF 0
>>> +			    NETXBIG_LED_ON 7
>>> +			    NETXBIG_LED_SATA 1
>>> +			    NETXBIG_LED_TIMER1 3>;
>>> +		bright-addr = <2>;
>>> +		bright-max = <7>;
>>> +	};
>>> +	red-sata0 {
>>> +		label = "netxbig:red:sata0";
>>> +		mode-addr = <3>;
>>> +		mode-val = <NETXBIG_LED_OFF 0
>>> +			    NETXBIG_LED_ON 2
>>> +			    NETXBIG_LED_TIMER1 4>;
>>> +		bright-addr = <2>;
>>> +		bright-max = <7>;
>>> +	};
>>> +	blue-sata1 {
>>> +		label = "netxbig:blue:sata1";
>>> +		mode-addr = <4>;
>>> +		mode-val = <NETXBIG_LED_OFF 0
>>> +			    NETXBIG_LED_ON 7
>>> +			    NETXBIG_LED_SATA 1
>>> +			    NETXBIG_LED_TIMER1 3>;
>>> +		bright-addr = <2>;
>>> +		bright-max = <7>;
>>> +	};
>>> +	red-sata1 {
>>> +		label = "netxbig:red:sata1";
>>> +		mode-addr = <4>;
>>> +		mode-val = <NETXBIG_LED_OFF 0
>>> +			    NETXBIG_LED_ON 2
>>> +			    NETXBIG_LED_TIMER1 4>;
>>> +		bright-addr = <2>;
>>> +		bright-max = <7>;
>>> +	};
>>> +};
>>> diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
>>> index 25e419752a7b..3649dfebd1d3 100644
>>> --- a/drivers/leds/leds-netxbig.c
>>> +++ b/drivers/leds/leds-netxbig.c
>>> @@ -26,6 +26,7 @@
>>>   #include <linux/spinlock.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/gpio.h>
>>> +#include <linux/of_gpio.h>
>>>   #include <linux/leds.h>
>>>   #include <linux/platform_data/leds-kirkwood-netxbig.h>
>>>
>>> @@ -140,6 +141,11 @@ struct netxbig_led_data {
>>>   	spinlock_t		lock;
>>>   };
>>>
>>> +struct netxbig_led_priv {
>>> +	struct netxbig_led_platform_data *pdata;
>>> +	struct netxbig_led_data leds_data[];
>>> +};
>>> +
>>>   static int netxbig_led_get_timer_mode(enum netxbig_led_mode *mode,
>>>   				      unsigned long delay_on,
>>>   				      unsigned long delay_off,
>>> @@ -304,12 +310,12 @@ static void delete_netxbig_led(struct netxbig_led_data *led_dat)
>>>   	led_classdev_unregister(&led_dat->cdev);
>>>   }
>>>
>>> -static int
>>> -create_netxbig_led(struct platform_device *pdev,
>>> -		   struct netxbig_led_data *led_dat,
>>> -		   const struct netxbig_led *template)
>>> +static int create_netxbig_led(struct platform_device *pdev, int led,
>>> +			      struct netxbig_led_priv *priv)
>>>   {
>>> -	struct netxbig_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>> +	struct netxbig_led_platform_data *pdata = priv->pdata;
>>> +	struct netxbig_led_data *led_dat = &priv->leds_data[led];
>>> +	const struct netxbig_led *template = &priv->pdata->leds[led];
>>>
>>>   	spin_lock_init(&led_dat->lock);
>>>   	led_dat->gpio_ext = pdata->gpio_ext;
>>> @@ -346,38 +352,241 @@ create_netxbig_led(struct platform_device *pdev,
>>>   	return led_classdev_register(&pdev->dev, &led_dat->cdev);
>>>   }
>>>
>>> +#ifdef CONFIG_OF_GPIO
>>> +static int gpio_ext_get_of_pdata(struct device *dev, struct device_node *np,
>>> +				 struct netxbig_gpio_ext *gpio_ext)
>>> +{
>>> +	int *addr, *data;
>>> +	int num_addr, num_data;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	ret = of_gpio_named_count(np, "addr-gpios");
>>> +	if (ret < 0)
>>> +		return ret;
>>
>> Please add error messages when parsing fails somewhere. There is a bit
>> to parse in this driver and the messages would make debugging easier.
>
> I am not sure it makes sense to add an error message here. It is very
> unlikely we will get an error here. The only purpose would be debugging
> while writing a DT node for this driver. With the DT binding document,
> I think it is quite hard to make it wrong. Moreover, while writing this
> code, I didn't need messages here.

You knew the code and you was a designer. If you looked at this from the
perspective of a person who doesn't have an access to the driver source
code or isn't fluent in code analysis the things look different.

> But if you think that error messages are needed anyway, I'll be glad to
> add them.

It's up to you. If you looked through the other kernel drivers, many of
them provide error messages when DT parsing fails.

>>
>>> +	num_addr = ret;
>>> +	addr = devm_kzalloc(dev, num_addr * sizeof(unsigned int), GFP_KERNEL);
>>> +	if (!addr)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < num_addr; i++) {
>>> +		ret = of_get_named_gpio(np, "addr-gpios", i);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		addr[i] = ret;
>>> +	}
>>> +	gpio_ext->addr = addr;
>>> +	gpio_ext->num_addr = num_addr;
>>> +
>>> +	ret = of_gpio_named_count(np, "data-gpios");
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	num_data = ret;
>>> +	data = devm_kzalloc(dev, num_data * sizeof(unsigned int), GFP_KERNEL);
>>> +	if (!data)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < num_data; i++) {
>>> +		ret = of_get_named_gpio(np, "data-gpios", i);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		data[i] = ret;
>>> +	}
>>> +	gpio_ext->data = data;
>>> +	gpio_ext->num_data = num_data;
>>> +
>>> +	ret = of_get_named_gpio(np, "enable-gpio", 0);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	gpio_ext->enable = ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int netxbig_leds_get_of_pdata(struct device *dev,
>>> +				     struct netxbig_led_platform_data *pdata)
>>> +{
>>> +	struct device_node *np = dev->of_node;
>>> +	struct device_node *gpio_ext_np;
>>> +	struct device_node *child;
>>> +	struct netxbig_gpio_ext *gpio_ext;
>>> +	struct netxbig_led_timer *timers;
>>> +	struct netxbig_led *leds, *led;
>>> +	int num_timers;
>>> +	int num_leds = 0;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	/* GPIO extension */
>>> +	gpio_ext_np = of_parse_phandle(np, "gpio-ext", 0);
>>> +	if (!gpio_ext_np)
>>> +		return -EINVAL;
>>
>> Please add error message here.
>>
>>> +	gpio_ext = devm_kzalloc(dev, sizeof(struct netxbig_gpio_ext),
>>> +				GFP_KERNEL);
>>
>> Kernel code style would be: sizeof(*gpio_ext). The same is relevant
>> to all other occurrences of sizeof in this file.
>
> OK.
>
>>
>>> +	if (!gpio_ext)
>>> +		return -ENOMEM;
>>> +	ret = gpio_ext_get_of_pdata(dev, gpio_ext_np, gpio_ext);
>>> +	if (ret)
>>> +		return ret;
>>> +	of_node_put(gpio_ext_np);
>>> +	pdata->gpio_ext = gpio_ext;
>>> +
>>> +	/* Timers (optional) */
>>> +	ret = of_property_count_u32_elems(np, "timers");
>>> +	if (ret > 0) {
>>> +		if (ret % 3)
>>> +			return -EINVAL;
>>> +		num_timers = ret / 3;
>>> +		timers = devm_kzalloc(dev,
>>> +				num_timers * sizeof(struct netxbig_led_timer),
>>> +				GFP_KERNEL);
>>> +		if (!timers)
>>> +			return -ENOMEM;
>>> +		for (i = 0; i < num_timers; i++) {
>>> +			u32 tmp;
>>> +
>>> +			of_property_read_u32_index(np, "timers", 3 * i,
>>> +						   &timers[i].mode);
>>> +			if (timers[i].mode >= NETXBIG_LED_MODE_NUM)
>>> +				return -EINVAL;
>>> +			of_property_read_u32_index(np, "timers",
>>> +						   3 * i + 1, &tmp);
>>> +			timers[i].delay_on = tmp;
>>> +			of_property_read_u32_index(np, "timers",
>>> +						   3 * i + 2, &tmp);
>>> +			timers[i].delay_off = tmp;
>>
>> You could get rid of tmp by reformatting above as follows:
>>
>> of_property_read_u32_index(np, "timers", 3 * i + 1,
>>                             &timers[i].delay_on);
>> of_property_read_u32_index(np, "timers", 3 * i + 2,
>>                             &timers[i].delay_off);
>
> No we can't. This was the main purpose for the v2. delay_{on,off} are
> unsigned long and of_property_read_u32_index expects u32. On an 64-bit
> big endian machine, this code is broken. Even if this driver will never
> be used on a such architecture, it is still a mistake. Moreover, it has
> been reported by Dan Carpenter that the static code checker was not
> happy about that.
>
> That's why we are using an intermediary variable here.

OK, I had to refresh my memory and it turned out that I myself
also took part in that discussion. tmp is indeed required.

>>
>>> +		}
>>> +		pdata->timer = timers;
>>> +		pdata->num_timer = num_timers;
>>> +	}
>>> +
>>> +	/* LEDs */
>>> +	num_leds = of_get_child_count(np);
>>> +	if (!num_leds)
>>> +		return -ENODEV;
>>> +
>>> +	leds = devm_kzalloc(dev, num_leds * sizeof(struct netxbig_led),
>>> +			    GFP_KERNEL);
>>> +	if (!leds)
>>> +		return -ENOMEM;
>>> +
>>> +	led = leds;
>>> +	for_each_child_of_node(np, child) {
>>> +		const char *string;
>>> +		int *mode_val;
>>> +		int num_modes;
>>> +
>>> +		if (!of_property_read_string(child, "label", &string))
>>> +			led->name = string;
>>> +		else
>>> +			led->name = child->name;
>>> +
>>> +		if (!of_property_read_string(child,
>>> +					     "linux,default-trigger", &string))
>>> +			led->default_trigger = string;
>>
>> Please put above calls to of_property_read_string after all the
>> below conditions that can end up with returning an error.
>
> OK.
>
>>
>>> +
>>> +		if (of_property_read_u32(child, "mode-addr",
>>> +					 &led->mode_addr))
>>> +			return -EINVAL;
>>> +
>>> +		if (of_property_read_u32(child, "bright-addr",
>>> +					 &led->bright_addr))
>>> +			return -EINVAL;
>>> +
>>> +		mode_val = devm_kzalloc(dev,
>>> +					NETXBIG_LED_MODE_NUM * sizeof(int),
>>> +					GFP_KERNEL);
>>> +		if (!mode_val)
>>> +			return -ENOMEM;
>>> +
>>> +		for (i = 0; i < NETXBIG_LED_MODE_NUM; i++)
>>> +			mode_val[i] = NETXBIG_LED_INVALID_MODE;
>>> +
>>> +		ret = of_property_count_u32_elems(child, "mode-val");
>>> +		if (ret < 0 || ret % 2)
>>> +			return -EINVAL;
>>> +		num_modes = ret / 2;
>>> +		if (num_modes > NETXBIG_LED_MODE_NUM)
>>> +			return -EINVAL;
>>> +
>>> +		for (i = 0; i < num_modes; i++) {
>>> +			int mode;
>>> +			int val;
>>> +
>>> +			of_property_read_u32_index(child,
>>> +						   "mode-val", 2 * i, &mode);
>>> +			of_property_read_u32_index(child,
>>> +						   "mode-val", 2 * i + 1, &val);
>>> +			if (mode >= NETXBIG_LED_MODE_NUM)
>>> +				return -EINVAL;
>>> +			mode_val[mode] = val;
>>> +		}
>>> +		led->mode_val = mode_val;
>>> +
>>> +		led++;
>>> +	}
>>> +
>>> +	pdata->leds = leds;
>>> +	pdata->num_leds = num_leds;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id of_netxbig_leds_match[] = {
>>> +	{ .compatible = "lacie,netxbig-leds", },
>>> +	{},
>>> +};
>>> +#else
>>> +static int netxbig_leds_get_of_pdata(struct device *dev,
>>> +				     struct netxbig_led_platform_data *pdata)
>>> +{
>>> +	return -ENODEV;
>>> +}
>>> +#endif /* CONFIG_OF_GPIO */
>>> +
>>>   static int netxbig_led_probe(struct platform_device *pdev)
>>>   {
>>>   	struct netxbig_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
>>> -	struct netxbig_led_data *leds_data;
>>> +	struct netxbig_led_priv *priv;
>>>   	int i;
>>>   	int ret;
>>>
>>> -	if (!pdata)
>>> -		return -EINVAL;
>>> +	if (!pdata) {
>>> +		pdata = devm_kzalloc(&pdev->dev,
>>> +				     sizeof(struct netxbig_led_platform_data),
>>> +				     GFP_KERNEL);
>>> +		if (!pdata)
>>> +			return -ENOMEM;
>>> +		ret = netxbig_leds_get_of_pdata(&pdev->dev, pdata);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>
>> You're removing board file for the device later in this patch set, but
>> in the same time you seem to expect pdata from board file as the
>> first choice and resort to parsing DT only if pdata is not available.
>> This is inconsistent. I'd leave the board file intact for now, also
>> because there can be some users of it.
>
> It is probably true that the next patch makes it inconsistent. But even
> if there is no more "board setup" code to fill pdata, I think it may be
> convenient to still support this mechanism.
>
> About the board file removal, it is safe. AFAIK, for this boards, users
> will update the Linux and DTB images together. Backward compatibility
> between Linux and the earlier DTB version is not supported. Else we
> would have to keep this board file forever and I am pretty sure that
> the mvebu maintainers will disagree about that :)

Ack.

>>
>> BTW how do you compile the driver? I've tried to use
>> multi_v5_defconfig and mvebu_v5_defconfig and I have build breaks
>> with both of them on the recent linux-next.
>
> For the original patch set version (Linux 4.0 at the time), I have used
> the mvebu_v5_defconfig. Now I am using a lighter configuration because
> I don't need to build the whole mvebu stuff.
>
> What kind of error do you get ? I remember something about setting
> CONFIG_HZ to 250.

I am getting:

drivers/crypto/mv_cesa.c:1037:2: error: implicit declaration of function 
?of_get_named_gen_pool? [-Werror=implicit-function-declaration]

Compilation succeeded after disabling CONFIG_CRYPTO_DEV_MV_CESA.

-- 
Best Regards,
Jacek Anaszewski
