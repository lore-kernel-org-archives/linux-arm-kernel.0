From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 5 Sep 2011 18:05:23 +0200
Subject: [PATCH 04/13] mfd: twl-core: Add initial DT support for
	twl4030/twl6030
In-Reply-To: <4690440.pddZTpGgxd@wuerfel>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
	<1314897689-17791-5-git-send-email-b-cousson@ti.com>
	<4690440.pddZTpGgxd@wuerfel>
Message-ID: <4E64F343.7030701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/2011 8:27 PM, Arnd Bergmann wrote:
> On Thursday 01 September 2011 19:21:20 Benoit Cousson wrote:
>> +#ifdef CONFIG_OF
>> +#define MODALIAS_SIZE 32
>> +
>> +static int add_of_children(struct i2c_client *client, unsigned long features)
>> +{
>> +       u32 reg;
>> +       struct device *child, *dev =&client->dev;
>> +       struct device_node *node, *parent = client->dev.of_node;
>> +       int irq;
>> +       char alias[MODALIAS_SIZE];
>> +
>> +       for_each_child_of_node(parent, node) {
>> +               if (of_property_read_u32(node, "reg",&reg)) {
>> +                       dev_err(dev, "%s(): invalid reg on %s\n", __func__,
>> +                               node->full_name);
>> +                       continue;
>> +               }
>> +
>
> Have you tried just calling calling of_platform_bus_probe on the
> parent? If all child devices are in the device tree, I think that
> should work, too. It probably requires some tweaking in the
> child drivers though.

Good point. That should indeed work for the current children since the 
add_numbered_child is just creating a platform_device.
On top of that, this function is filling some IRQ resources, but DT will 
do that for free and in a much better way thanks to the irq_domain.

I had some concern with the regulator devices that does require some 
custom pdata for the moment, but that should disappear as soon as the 
proper regulator binding will be there.

Since the idea is to move all the children to DT, this is definitively 
the best approach. I'll update the driver to support the DT binding too.

Thanks for the suggestion. I'll try that and repost if it works as 
expected. But it should... at least for the twl_rtc.

Benoit
