From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 01 Dec 2010 11:09:32 +0100
Subject: [patch 1/2] imx51: fix gpiolib support
In-Reply-To: <20101201092529.GE32355@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
	=?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Wed, 1 Dec 2010 10:25:29 +0100")
References: <20101201083715.625363724@rtp-net.org>
	<20101201084257.327766974@rtp-net.org>
	<20101201092529.GE32355@pengutronix.de>
Message-ID: <87hbexu7mr.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> Hello Arnaud,

Hi,
>
> On Wed, Dec 01, 2010 at 09:37:16AM +0100, Arnaud Patard wrote:
>> The gpiolib code is always returning 0 when reading pad values if the pads
>> are configured as output. Using DR registers instead of PSR is fixing that.
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: linux-2.6-submit/arch/arm/plat-mxc/gpio.c
>> ===================================================================
>> --- linux-2.6-submit.orig/arch/arm/plat-mxc/gpio.c	2010-11-24 18:00:47.000000000 +0100
>> +++ linux-2.6-submit/arch/arm/plat-mxc/gpio.c	2010-11-24 18:06:54.000000000 +0100
>> @@ -276,6 +276,10 @@
>>  {
>>  	struct mxc_gpio_port *port =
>>  		container_of(chip, struct mxc_gpio_port, chip);
>> +	u32 l = __raw_readl(port->base + GPIO_GDIR);
>> +
>> +	if (cpu_is_mx51() && (l & (1 << offset)))
>> +		return (__raw_readl(port->base + GPIO_DR) >> offset) & 1;
> Maybe only read GDIR on mx51?  Isn't the direction saved by gpiolib
> somewhere in RAM?  Is the same needed on other SoCs, too (see below for
> my grouping)?  Technically it's not needed at all I think.
> (Documentation/gpio.txt has: "However, note that not all platforms can
> read the value of output pins; those that can't should always return
> zero.".  I didn't check if the implementation conforms here though.)

yeah, I know that the gpiolib allows that and in this case, it's always
returning 0 but while I was debugging an other problem, I wanted to read
output value and it was not working. The manual was not explicitely
saying it was not possible so I thought it was a bug and propose a
fix. Hopefully, sending this patch allows me to get more feedback and
tell me if I got something wrong and there's a better fix.

>
> I wonder if cpu_is_mx51 is the right macro to test, I'd prefer something
> like imx_gpio_vX().  IMHO the gpio stuff needs a major overhaul getting
> rid of most runtime checks.

I used cpu_is_mx51() because I only had tested/seen that on imx515. I
wanted to avoid breaking other systems while trying to fix mine.
As regards getting rid of runtime checks, maybe registering different
gpiochip depending on the SoC would allow to check it a init time and no
more check later.

Arnaud
