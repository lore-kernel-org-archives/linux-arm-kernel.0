From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 18 Sep 2015 12:30:06 +0200
Subject: [PATCH v4 1/3] leds: netxbig: add device tree binding
In-Reply-To: <55FBD679.2020402@samsung.com>
References: <1442505571-9744-1-git-send-email-simon.guinot@sequanux.org>
 <1442505571-9744-2-git-send-email-simon.guinot@sequanux.org>
 <55FBD679.2020402@samsung.com>
Message-ID: <20150918103006.GM7306@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 11:16:41AM +0200, Jacek Anaszewski wrote:
> Hi Simon,
> 
> Please find my comments in the code below.

Hi Jacek,

Thanks for the quick review.

> 
> On 09/17/2015 05:59 PM, Simon Guinot wrote:
> >This patch adds device tree support for the netxbig LEDs.
> >
> >This also introduces a additionnal DT binding for the GPIO extension bus
> >(netxbig-gpio-ext) used to configure the LEDs. Since this bus could also
> >be used to control other devices, then it seems more suitable to have it
> >in a separate DT binding.
> >
> >Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> >Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >---
> >  .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
> >  .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++++
> >  drivers/leds/leds-netxbig.c                        | 258 +++++++++++++++++++--
> >  include/dt-bindings/leds/leds-netxbig.h            |  18 ++
> >  4 files changed, 369 insertions(+), 21 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
> >  create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
> >  create mode 100644 include/dt-bindings/leds/leds-netxbig.h
> >
> >Changes for v2:
> >- Check timer mode value retrieved from DT.
> >- In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
> >   timer delay values from DT with function of_property_read_u32_index.
> >   Instead, use a temporary u32 variable. This allows to silence a static
> >   checker warning.
> >- Make timer property optional in the binding documentation. It is now
> >   aligned with the driver code.
> >
> >Changes for v3:
> >- Fix pointer usage with the temporary u32 variable while calling
> >   of_property_read_u32_index.
> >
> >Changes for v4:
> >- In DT binding document netxbig-gpio-ext.txt, detail byte order for
> >   registers and latch mechanism for "enable-gpio".
> >- In leds-netxbig.c, add some error messages.
> >- In leds-netxbig.c, fix some "sizeof" style issues.
> >- In leds-netxbig.c, in netxbig_leds_get_of_pdata(), move the
> >   of_property_read_string() calls after the error-prone checks.
> >- Add some Acked-by.

...

> >+#ifdef CONFIG_OF_GPIO
> >+static int gpio_ext_get_of_pdata(struct device *dev, struct device_node *np,
> >+				 struct netxbig_gpio_ext *gpio_ext)
> >+{
> >+	int *addr, *data;
> >+	int num_addr, num_data;
> >+	int ret;
> >+	int i;
> >+
> >+	ret = of_gpio_named_count(np, "addr-gpios");
> >+	if (ret < 0) {
> >+		dev_err(dev,
> >+			"Failed to count GPIOs in DT property addr-gpios\n");
> >+		return ret;
> >+	}
> >+	num_addr = ret;
> >+	addr = devm_kzalloc(dev, num_addr * sizeof(*addr), GFP_KERNEL);
> >+	if (!addr)
> >+		return -ENOMEM;
> >+
> >+	for (i = 0; i < num_addr; i++) {
> >+		ret = of_get_named_gpio(np, "addr-gpios", i);
> >+		if (ret < 0)
> >+			return ret;
> >+		addr[i] = ret;
> >+	}
> >+	gpio_ext->addr = addr;
> >+	gpio_ext->num_addr = num_addr;
> >+
> >+	ret = of_gpio_named_count(np, "data-gpios");
> >+	if (ret < 0) {
> >+		dev_err(dev,
> >+			"Failed to count GPIOs in DT property data-gpios\n");
> >+		return ret;
> >+	}
> >+	num_data = ret;
> >+	data = devm_kzalloc(dev, num_data * sizeof(*data), GFP_KERNEL);
> >+	if (!data)
> >+		return -ENOMEM;
> >+
> >+	for (i = 0; i < num_data; i++) {
> >+		ret = of_get_named_gpio(np, "data-gpios", i);
> >+		if (ret < 0)
> >+			return ret;
> >+		data[i] = ret;
> >+	}
> >+	gpio_ext->data = data;
> >+	gpio_ext->num_data = num_data;
> >+
> >+	ret = of_get_named_gpio(np, "enable-gpio", 0);
> >+	if (ret < 0) {
> >+		dev_err(dev,
> >+			"Failed to get GPIO from DT property enable-gpio\n");
> >+		return ret;
> >+	}
> >+	gpio_ext->enable = ret;
> >+
> >+	return 0;
> >+}
> 
> Since netxbig-gpio-ext extension bus can be also used to control other
> device, and the related DT bindings are meant for GPIO subsystem, then
> the above parser should also be placed there to make it available
> for reuse by other drivers. The gpio_ext_init function should be also
> moved to GPIO subsystem, presumably to the same module.

Yes, this patch series is a first step. I am planning to move the
netxbig-gpio-ext extension bus into a dedicated driver as soon as I need
need it for an another device/driver. But for the time being, I was
planning to keep it here. If you agree with that of course.

> 
> Moreover, if you switched to using devm* prefixed version of
> gpio_request_one and led_classdev_reqister, you could simplify
> the error paths in the driver.

Yes, I have a pending patch for this conversion. But since it is not
really related with the subject of this patch series (add DT support),
I was planning to send it next.

Do you want me to include this patch into this series.

> 
> >+static int netxbig_leds_get_of_pdata(struct device *dev,
> >+				     struct netxbig_led_platform_data *pdata)
> >+{
> >+	struct device_node *np = dev->of_node;
> >+	struct device_node *gpio_ext_np;
> >+	struct device_node *child;
> >+	struct netxbig_gpio_ext *gpio_ext;
> >+	struct netxbig_led_timer *timers;
> >+	struct netxbig_led *leds, *led;
> >+	int num_timers;
> >+	int num_leds = 0;
> >+	int ret;
> >+	int i;

...

> >+	led = leds;
> >+	for_each_child_of_node(np, child) {
> >+		const char *string;
> >+		int *mode_val;
> >+		int num_modes;
> >+
> >+		if (of_property_read_u32(child, "mode-addr",
> >+					 &led->mode_addr))
> >+			return -EINVAL;
> >+
> >+		if (of_property_read_u32(child, "bright-addr",
> >+					 &led->bright_addr))
> >+			return -EINVAL;
> 
> You don't parse bright-max DT property anywhere, AFAICT.

Yes I don't. I have added this bright-max property thinking ahead of
moving the netxbig-gpio-ext stuff into a dedicated driver. For now, it
is possible to compute bright-max from the number of data GPIOs of the
extension bus. But once it will be removed something else will be
needed. That's why I introduced this property.

But now, I am thinking I should have used this property right now. It
will be more convenient when moving the netxbig-gpio-ext code out.

I'll do that for the next round.

> 
> >+		mode_val =
> >+			devm_kzalloc(dev,
> >+				     NETXBIG_LED_MODE_NUM * sizeof(*mode_val),
> >+				     GFP_KERNEL);
> >+		if (!mode_val)
> >+			return -ENOMEM;
> >+
> >+		for (i = 0; i < NETXBIG_LED_MODE_NUM; i++)
> >+			mode_val[i] = NETXBIG_LED_INVALID_MODE;
> >+
> >+		ret = of_property_count_u32_elems(child, "mode-val");
> >+		if (ret < 0 || ret % 2)
> >+			return -EINVAL;
> >+		num_modes = ret / 2;
> >+		if (num_modes > NETXBIG_LED_MODE_NUM)
> >+			return -EINVAL;
> >+
> >+		for (i = 0; i < num_modes; i++) {
> >+			int mode;
> >+			int val;
> >+
> >+			of_property_read_u32_index(child,
> >+						   "mode-val", 2 * i, &mode);
> >+			of_property_read_u32_index(child,
> >+						   "mode-val", 2 * i + 1, &val);
> >+			if (mode >= NETXBIG_LED_MODE_NUM)
> >+				return -EINVAL;
> >+			mode_val[mode] = val;
> >+		}
> >+		led->mode_val = mode_val;
> >+
> >+		if (!of_property_read_string(child, "label", &string))
> >+			led->name = string;
> >+		else
> >+			led->name = child->name;
> >+
> >+		if (!of_property_read_string(child,
> >+					     "linux,default-trigger", &string))
> >+			led->default_trigger = string;
> >+
> >+		led++;
> >+	}
> >+
> >+	pdata->leds = leds;
> >+	pdata->num_leds = num_leds;
> >+
> >+	return 0;
> >+}
> >+
> >+static const struct of_device_id of_netxbig_leds_match[] = {
> >+	{ .compatible = "lacie,netxbig-leds", },
> >+	{},
> >+};
> >+#else
> >+static int netxbig_leds_get_of_pdata(struct device *dev,
> >+				     struct netxbig_led_platform_data *pdata)
> 
> s/static int/static inline int/

Is that not already the case with modern compiler ?

I'll add it anyway.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/951b7bc1/attachment.sig>
