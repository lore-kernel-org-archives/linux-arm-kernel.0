From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Jul 2011 16:37:28 +0100
Subject: [PATCH v2 6/7] i2c: pxa: support i2c controller from DT
In-Reply-To: <4E34155E.8010606@firmworks.com>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-4-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-6-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-7-git-send-email-haojian.zhuang@marvell.com>
	<20110729165222.GN11164@ponder.secretlab.ca>
	<20110729165547.GB30298@n2100.arm.linux.org.uk>
	<4E34155E.8010606@firmworks.com>
Message-ID: <20110730153728.GA17570@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2011 at 04:29:50AM -1000, Mitch Bradley wrote:
> On 7/29/2011 6:55 AM, Russell King - ARM Linux wrote:
>> On Fri, Jul 29, 2011 at 10:52:22AM -0600, Grant Likely wrote:
>>> On Thu, Jul 28, 2011 at 02:41:32PM +0800, Haojian Zhuang wrote:
>>>> -	/*
>>>> -	 * If "dev->id" is negative we consider it as zero.
>>>> -	 * The reason to do so is to avoid sysfs names that only make
>>>> -	 * sense when there are multiple adapters.
>>>> -	 */
>>>> -	i2c->adap.nr = dev->id;
>>>> -	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_i2c-i2c.%u",
>>>> -		 i2c->adap.nr);
>>>>
>>>> -	i2c->clk = clk_get(&dev->dev, NULL);
>>>> +	if (np) {
>>>> +		i2c->adap.nr = idx++;
>>>
>>> Use this so that a bus number gets dynamically assigned:
>>> 		i2c->adap.nr = -1;
>>>
>>>> +		snprintf(i2c->adap.name, sizeof(i2c->adap.name),
>>>> +			"pxa2xx-i2c.%u", i2c->adap.nr);
>>>> +		i2c->clk = clk_get_sys(i2c->adap.name, NULL);
>>>
>>> Missing i2c->adap.dev.of_node = dev->dev.of_node;
>>
>> And here we go again.  Is it really the case that this DT stuff doesn't
>> have stable device names?
>
> Device tree names are completely stable, based on hardware addresses  
> that don't change from boot to boot.  Even for buses where access  
> addresses are dynamically assigned, the device tree "reg property"  
> address is based on a stable addressing form.  For example, PCI devices  
> use the (stable) configuration address as the reg property and USB  
> devices use the (stable) hub port number.
>
> People's tendency to want to assign sequential small integers in Linux  
> has nothing to do with the device tree.  I suspect that it's a carryover  
> from the historical Unix major/minor device numbering model, but in any  
> case, there's nothing unstable about the device tree naming model. Quite 
> the opposite - stable naming was a fundamental criterion when I designed 
> Open Firmware.

Which means - if Grant is accepting the conversion of ARM to DT and
upstreaming it, he needs to keep an eye on this madness and reject
stuff which tries to do as per this patch.
