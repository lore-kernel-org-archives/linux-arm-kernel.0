From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Nov 2013 14:50:38 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <1704730.RnIqE1USnv@wuerfel>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <2443024.JdDKnfkC18@wuerfel> <5277CD33.6030003@wwwdotorg.org>
 <1704730.RnIqE1USnv@wuerfel>
Message-ID: <527816AE.1080508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2013 01:43 PM, Arnd Bergmann wrote:
> On Monday 04 November 2013 09:37:07 Stephen Warren wrote:
>>> The basic idea is to extend 'devres' to automatically register
>>> all the resources (registers, irq, dma, gpio, pinctrl, clk, regulator, ...)
>>> and simple properties before the ->probe() callback is even called,
>>> based on a per-driver data structure that describes them, and that
>>> can be easily parsed by an external tool.
>>
>> I had suggested that while talking to someone at the kernel summit,
>> basically each driver supplies functions like:
>>
>> 1) ACPI -> platform data or resources converter
>> 2) DT -> platform or resources data converter
>> 3) anything else -> platform or resources data converter
>> 4) probe()
> 
> FWIW, here is a very early draft of the interfaces I have in mind.
> At the moment the implementation is DT focused, but that should
> be extensible to ACPI if necessary.
> 
> At the end, you can see how a probe function could end up looking.
> I'm sure this is full of bugs at the moment, incomplete and needs
> to be moved into actual header and C files, but it should be enough
> to get across where I'm getting with this, and to see if anyone
> thinks it's a really bad idea or won't actually work.

This looks interesting. The simple cases end up quite simple. I wonder
what's the best way to handle the more complex cases; more on that below.

> int devm_probe_gpio(struct device *dev, const struct devm_probe *probe)
...
> #define DEVM_GPIO(_struct, _member, _index) {				 \
...
> #define DEVM_GPIO_NAMED(_struct, _member, _name) { 			 \

Should those save the GPIO flags too? Or, do we assume that gpiod-based
GPIOs already handle the flags inside the gpiod API?

> /*
>  * this lists all properties we access from the driver. The list
>  * is interpreted by devm_probe() and can be programmatically
>  * verified to match the binding.
>  */
> static const struct devm_probe foo_probe_list[] = {
> 	DEVM_ALLOC(foo_priv),
> 	DEVM_IOMAP(foo_priv, regs, 0, 0),
> 	DEVM_PROP_BOOL(foo_priv, oldstyle_dma, "foo,oldstyle-dma"),

I wonder if it makes sense to handle pure data here, or whether this
only makes sense for resources/services that are provided by some other
device?

I guess it's nice for all resources and configuration to come through to
probe() in the same way, but I rather wonder how we'd handle bindings
that have large custom (driver-specific) tables of data. Would be simply
defer such things to custom code in probe()? If so, it feels slightly
inconsistent to handle some data in the probe_list[] and some in code in
probe(). Still, I guess there's something to be said for keeping the
simple cases simple.

> 	DEVM_DMA_SLAVE(foo_priv, rxdma, "rx");
> 	DEVM_DMA_SLAVE(foo_priv, txdma, "tx");
> 	DEVM_GPIO(foo_priv, gpio, 0);
> 	DEVM_IRQ_NAMED(foo_priv, irq, foo_irq_handler, "fifo", IRQF_SHARED),

What about the case where some resources are optional, or only required
based on the values of certain other properties? I suppose that probe()
could call devm_probe() multiple times, with different probe_list[]s,
based on whatever algorithm they need.

> 	{},
> };
> 
> static int foo_probe(struct platform_device *dev)
> {
> 	int ret;
> 
> 	ret = devm_probe(dev->dev, foo_probe_list);
> 	if (ret)
> 		return ret;
> 
> 	return bar_subsystem_register(&foo_bar_ops, dev);
> }
