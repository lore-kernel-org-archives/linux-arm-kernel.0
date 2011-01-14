From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 14 Jan 2011 08:35:26 +0100
Subject: i.MX & IRQF_ONESHOT
In-Reply-To: <20110113212401.GZ24920@pengutronix.de>
References: <20110113091355.GP24920@pengutronix.de>	<4D2EDE10.3040809@atmel.com>	<alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>	<4D2F6AB7.30800@eukrea.com>
	<20110113212401.GZ24920@pengutronix.de>
Message-ID: <4D2FFCBE.3010704@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/2011 22:24, Uwe Kleine-K?nig wrote:
> On Thu, Jan 13, 2011 at 10:12:23PM +0100, Eric B?nard wrote:
>> On 13/01/2011 19:15, Thomas Gleixner wrote:
>>> On Thu, 13 Jan 2011, Nicolas Ferre wrote:
>>>> Le 13/01/2011 10:13, Uwe Kleine-K?nig :
>>>>> On Thu, Jan 13, 2011 at 09:25:19AM +0100, Eric B?nard wrote:
>>>>>> Commenting out this line in the ads7846 driver makes it work again.
>>>>>> Am I missing something obvious or is there a reason for IRQF_ONESHOT
>>>>>> creating trouble with gpio irq or SPI on i.MX ?
>>>>> I don't know.  Is the irq masked?  pending?
>>>>
>>>> Just to let you know that I have the same issue on my at91sam9g10ek:
>>>> atmel_spi + ads7846 (using ADS7843e actually).
>>>> ... solved by same workaround.
>>>
>>> Eric, Nicolas: How are the interrupt handlers set for the relevant
>>> interrupt lines and how are the interrupt pins configured?
>>>
>> on the i.MX27 :
>> - gpio configured as a plain input (in function ads7846_dev_init()
>> in arch/arm/mach-imx/eukrea_mbimx27-baseboard.c)
>> - threaded interrupt handler registered with flags
>> IRQF_TRIGGER_FALLING | IRQF_ONESHOT (in function ads7846_probe() in
>> drivers/input/touchscreen/ads7846.c)
> I didn't recheck the hw manual, but adding IRQF_TRIGGER_FALLING calls
> gpio_set_irq_type (defined in arch/arm/plat-mxc/gpio.c) which results
> into something called GPIO_INT_FALL_EDGE being written into a register.
>
> So I'd say it's configured to be edge sensitive.
>
I confirm this point : the gpio is configured to trigger an irq on falling edge.

Eric
