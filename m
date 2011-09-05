From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 05 Sep 2011 14:18:21 +0200
Subject: [PATCH] arm: ixp4xx, u300: Select ARCH_REQUIRE_GPIOLIB,
	not GENERIC_GPIO
In-Reply-To: <20110905104133.GH6619@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 5 Sep 2011 11:41:33 +0100")
References: <1315192383.3092.260.camel@deadeye>
	<87r53v7a3d.fsf@lebrac.rtp-net.org>
	<20110905104133.GH6619@n2100.arm.linux.org.uk>
Message-ID: <87mxej6v3m.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

Hi,

> On Mon, Sep 05, 2011 at 08:54:30AM +0200, Arnaud Patard wrote:
>> The problem here is that gpio_request_one has been added to the ads7846
>> driver but gpio_request_one is not defined in GENERIC_GPIO case (I
>> guess that other (arm and non-arm) platforms may hit similar troubles
>> with gpio_request_one. One quick fix would be to add a gpio_request_one
>> function say in asm-generic/gpio.h. One other fix would be to define
>> gpio_request_one and gpio_request_array in each
>> machine/platform/... specific header. Don't know what's the best
>> solution.
>
> It looks like gpio_request_one() and gpio_request_array() have been added
> at the wrong level in the GPIO support code.
>
> There's two levels to the GPIO support code:
>
> 1. GENERIC_GPIO - for platforms which use the gpio_* interfaces.
> 2. GPIOLIB - for platforms which want the gpio library for handling multiple
>    GPIO controllers.
>
> There is nothing GPIOLIB specific to the gpio_request_*() interfaces, so
> to put them in gpiolib.c and include/asm-generic/gpio.h seems rather silly.
>
> On the other hand, for the single ARM kernel project, we do need everyone
> to move to GPIOLIB so that the GPIO calls can be bound appropriately at
> runtime - which means this problem goes away.  So probably the right
> solution is for IXP4xx etc to move over completely to gpiolib.

I thought about it but I considered it was too late to do that. I don't
think that moving to gpiolib u300/ixp4xx in -rc is a good idea. imho
doing it for next kernel is better but this won't solve the build
failure. Of course, you can tell me I'm plain wrong and I'll look at
converting them to gpiolib asap. Then we'll need some testers as I don't
have neither u300 nor ixp4xx systems.

Also, moving u300/ixp4xx to gpiolib will solve the issue for ARM but I
fear that other architectures may be affected by similar trouble.

Arnaud
