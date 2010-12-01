From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 01 Dec 2010 11:03:05 +0100
Subject: [patch 1/2] imx51: fix gpiolib support
In-Reply-To: <19702.5080.913577.652396@ipc1.ka-ro> ("Lothar =?utf-8?Q?Wa?=
	=?utf-8?Q?=C3=9Fmann=22's?= message
	of "Wed, 1 Dec 2010 10:22:32 +0100")
References: <20101201083715.625363724@rtp-net.org>
	<20101201084257.327766974@rtp-net.org>
	<19702.5080.913577.652396@ipc1.ka-ro>
Message-ID: <87lj49u7xi.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lothar Wa?mann <LW@KARO-electronics.de> writes:

> Hi,

Hi,
>
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
>>  
>>  	return (__raw_readl(port->base + GPIO_PSR) >> offset) & 1;
>>  }
>>
> Now you are not reading the actual pin state as with GPIO_PSR, but the
> value that has been programmed into the output register (thus you
> would not be able to determine whether an Open Drain output that is
> programmed to HIGH is driven LOW by an external device).

yeah, I know. I didn't say it was the right fix. I noticed a problem and
proposed a solution.

>
> Note that for being able to read back the actual pin state of an
> output, the SION bit in the MUX_CTL register of the corresponding pad
> has to be asserted.

Is it working no matter of the MUX_MODE setting ? I thought that it was
working only if the MUX_MODE setting was 0 and not for every possible
MUX_MODE setting.

Arnaud
