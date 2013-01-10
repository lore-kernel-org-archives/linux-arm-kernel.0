From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 10 Jan 2013 15:07:43 -0700
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <50EF27B4.60608@wwwdotorg.org>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
 <50EF27B4.60608@wwwdotorg.org>
Message-ID: <50EF3BAF.4010200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 01:42 PM, Stephen Warren wrote:
> On 12/12/2012 01:25 PM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This makes the device core auto-grab the pinctrl handle and set
>> the "default" (PINCTRL_STATE_DEFAULT) state for every device
>> that is present in the device model right before probe. This will
>> account for the lion's share of embedded silicon devcies.
> 
> There are quite a few problems with this patch, and they end up
> completely breaking at least Tegra in next-20130110.
> 
>> diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
> 
>> +int pinctrl_bind_pins(struct device *dev)
>> +{
>> +	struct dev_pin_info *dpi;
>> +	int ret;
>> +
>> +	/* Allocate a pin state container on-the-fly */
>> +	if (!dev->pins) {
>> +		dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
>> +		if (!dpi)
>> +			return -ENOMEM;
>> +	} else
>> +		dpi = dev->pins;
>> +
>> +	/*
>> +	 * Check if we already have a pinctrl handle, as we may arrive here
>> +	 * after a deferral in the state selection below
>> +	 */
>> +	if (!dpi->p) {
>> +		dpi->p = devm_pinctrl_get(dev);
> 
> That won't succeed for a pinctrl device that has a default state in
> order to implement hogs. This will then cause the pin controller device
> to always defer probe and never activate. This will leave HW
> unconfigured and/or prevent other devices from successfully calling
> pinctrl_get().

I see that an attempt was made to solve this problem, in the patch
immediately preceding this one (at least, as applied in the pinctrl
tree). However, that patch only addresses the case where the pin
controller is being looked up in the map, and not the case when
converting device tree to the map in the first place. The patch below
solves this:

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fe2d1af..fd40a11 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -141,6 +141,11 @@ static int dt_to_map_one_config(struct pinctrl *p,
const char *statename,
                pctldev = find_pinctrl_by_of_node(np_pctldev);
                if (pctldev)
                        break;
+               /* Do not defer probing of hogs (circular loop) */
+               if (np_pctldev == p->dev->of_node) {
+                       of_node_put(np_pctldev);
+                       return -ENODEV;
+               }
        }
        of_node_put(np_pctldev);
