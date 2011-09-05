From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Sep 2011 11:41:33 +0100
Subject: [PATCH] arm: ixp4xx, u300: Select ARCH_REQUIRE_GPIOLIB, not
	GENERIC_GPIO
In-Reply-To: <87r53v7a3d.fsf@lebrac.rtp-net.org>
References: <1315192383.3092.260.camel@deadeye>
	<87r53v7a3d.fsf@lebrac.rtp-net.org>
Message-ID: <20110905104133.GH6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2011 at 08:54:30AM +0200, Arnaud Patard wrote:
> The problem here is that gpio_request_one has been added to the ads7846
> driver but gpio_request_one is not defined in GENERIC_GPIO case (I
> guess that other (arm and non-arm) platforms may hit similar troubles
> with gpio_request_one. One quick fix would be to add a gpio_request_one
> function say in asm-generic/gpio.h. One other fix would be to define
> gpio_request_one and gpio_request_array in each
> machine/platform/... specific header. Don't know what's the best
> solution.

It looks like gpio_request_one() and gpio_request_array() have been added
at the wrong level in the GPIO support code.

There's two levels to the GPIO support code:

1. GENERIC_GPIO - for platforms which use the gpio_* interfaces.
2. GPIOLIB - for platforms which want the gpio library for handling multiple
   GPIO controllers.

There is nothing GPIOLIB specific to the gpio_request_*() interfaces, so
to put them in gpiolib.c and include/asm-generic/gpio.h seems rather silly.

On the other hand, for the single ARM kernel project, we do need everyone
to move to GPIOLIB so that the GPIO calls can be bound appropriately at
runtime - which means this problem goes away.  So probably the right
solution is for IXP4xx etc to move over completely to gpiolib.
