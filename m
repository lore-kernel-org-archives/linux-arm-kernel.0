From: eric@eukrea.com (=?ISO-8859-15?Q?Eric_B=E9nard?=)
Date: Thu, 13 Jan 2011 22:12:23 +0100
Subject: i.MX & IRQF_ONESHOT
In-Reply-To: <alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>
References: <20110113091355.GP24920@pengutronix.de>
	<4D2EDE10.3040809@atmel.com>
	<alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>
Message-ID: <4D2F6AB7.30800@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/2011 19:15, Thomas Gleixner wrote:
> On Thu, 13 Jan 2011, Nicolas Ferre wrote:
>> Le 13/01/2011 10:13, Uwe Kleine-K?nig :
>>> On Thu, Jan 13, 2011 at 09:25:19AM +0100, Eric B?nard wrote:
>>>> Commenting out this line in the ads7846 driver makes it work again.
>>>> Am I missing something obvious or is there a reason for IRQF_ONESHOT
>>>> creating trouble with gpio irq or SPI on i.MX ?
>>> I don't know.  Is the irq masked?  pending?
>>
>> Just to let you know that I have the same issue on my at91sam9g10ek:
>> atmel_spi + ads7846 (using ADS7843e actually).
>> ... solved by same workaround.
>
> Eric, Nicolas: How are the interrupt handlers set for the relevant
> interrupt lines and how are the interrupt pins configured?
>
on the i.MX27 :
- gpio configured as a plain input (in function ads7846_dev_init() in 
arch/arm/mach-imx/eukrea_mbimx27-baseboard.c)
- threaded interrupt handler registered with flags IRQF_TRIGGER_FALLING | 
IRQF_ONESHOT (in function ads7846_probe() in drivers/input/touchscreen/ads7846.c)
- the gpio's irq is handled by a chained irq handled registered in 
arch/arm/plat-mxc/gpio.c (the CPU has only one real interrupt for all the GPIO 
banks so this real IRQ handles up to 5 x 32 gpio's IRQ).

Eric
