From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 27 Jul 2012 07:25:08 +0200
Subject: [RFC PATCH] gpio: Add a generic GPIO handling driver
References: <1340961676-25432-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20498.9780.825958.340618@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

sorry, I obviuosly missed your reply and had to pick it up from the
archives.

> On Fri, Jun 29, 2012 at 11:21:16AM +0200, Lothar Wa?mann wrote:
>> in the .dts file:
>> 	flexcan_transceiver: gpio-switch at 0 {
>> 		compatible = "linux,gpio-switch";
> 
> Why not simply "gpio-switch"?
> 
OK.

>> 		gpio = <&gpio4 21 1>; /* GPIO is active low */
>> 		label = "Flexcan Transceiver Enable";
>> 		gpio-shared;
>> 		init-state = <0>; /* Transceiver will be initially inactive */
>> 	};
>> 
> It looks like the design intends to have every single gpio-switch
> probed as a platform_device.  I'm not sure it's a good idea.
> 
I considered that myself already.

> Also I'm not sure it's preferable to have such shinny new stuff support
> platform probing, which adds much unnecessary complexity, considering
> we are on the way to device tree.  If we support device tree only,
> a lot of codes like provider API will not be needed.
> 
There are still archs that do not use DT but could still benefit from
this driver.

>> in flexcan_probe()
>> 	struct gpio_sw *xcvr_switch = NULL;
>> 	struct device_node *np = pdev->dev.of_node;
>> 
>> 	if (np) {
>> 		ph = of_get_property(np, "transceiver-switch", NULL);
> 
> I would have a fixed property name under client device node
> representing the phandle to gpio-switch sub-node, like what we are
> doing with clk binding.
> 
OK.

>> flexcan_remove()
>>     free_gpio_switch(xcvr_switch);
> 
> Can we have a devm_request_gpio_switch to ease the client driver
> a little bit?
> 
Sure.

I'll try to get a new version out over the weekend, if there is still
interest in this driver.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
