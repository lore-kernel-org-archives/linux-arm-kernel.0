From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 01 Dec 2010 12:24:20 +0100
Subject: [patch 1/2] imx51: fix gpiolib support
In-Reply-To: <201012011200.25430.alexander.stein@systec-electronic.com>
	(Alexander Stein's message of "Wed, 1 Dec 2010 11:59:59 +0100")
References: <20101201083715.625363724@rtp-net.org>
	<20101201092529.GE32355@pengutronix.de>
	<87hbexu7mr.fsf@lechat.rtp-net.org>
	<201012011200.25430.alexander.stein@systec-electronic.com>
Message-ID: <87d3plu463.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Stein <alexander.stein@systec-electronic.com> writes:

Hi,

> On Wednesday 01 December 2010, 11:09:32 Arnaud Patard wrote:
>> > Maybe only read GDIR on mx51?  Isn't the direction saved by gpiolib
>> > somewhere in RAM?  Is the same needed on other SoCs, too (see below for
>> > my grouping)?  Technically it's not needed at all I think.
>> > (Documentation/gpio.txt has: "However, note that not all platforms can
>> > read the value of output pins; those that can't should always return
>> > zero.".  I didn't check if the implementation conforms here though.)
>> 
>> yeah, I know that the gpiolib allows that and in this case, it's always
>> returning 0 but while I was debugging an other problem, I wanted to read
>> output value and it was not working. The manual was not explicitely
>> saying it was not possible so I thought it was a bug and propose a
>> fix. Hopefully, sending this patch allows me to get more feedback and
>> tell me if I got something wrong and there's a better fix.
>> 
>> > I wonder if cpu_is_mx51 is the right macro to test, I'd prefer something
>> > like imx_gpio_vX().  IMHO the gpio stuff needs a major overhaul getting
>> > rid of most runtime checks.
>> 
>> I used cpu_is_mx51() because I only had tested/seen that on imx515. I
>> wanted to avoid breaking other systems while trying to fix mine.
>> As regards getting rid of runtime checks, maybe registering different
>> gpiochip depending on the SoC would allow to check it a init time and no
>> more check later.
>
> I can conform, that reading from GPIO_DR on mx35 works too. Also checked with 
> the description is this register. It seem to show exactly what we want, 
> regarding GPIO_GDIR value. So even evaluating GPIO_DIR isn't needed at all.
> My fix was to simply replace GPIO_PSR with GPIO_DR.

Please look also at Lothar Wa?mann's comments. I plan to test that later
but if setting the SION bit allows things to work correctly, setting it
by default for the GPIOs may be a better fix than my patch.

Arnaud
