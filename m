From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 19 Nov 2009 17:49:22 +0800
Subject: [PATCH] ARM: Add spi controller driver support for NUC900
In-Reply-To: <20091119090204.GB13376@n2100.arm.linux.org.uk>
References: <4B024748.9080001@gmail.com>
	<20091118142109.ff2c5ef6.akpm@linux-foundation.org>
	<e68bb3470911182223r28e9bac0lf185c1443168ff52@mail.gmail.com>
	<20091118234928.8d86a9f9.akpm@linux-foundation.org>
	<e68bb3470911190040v2c14bbcfi46177cd58649e1c@mail.gmail.com>
	<20091119090204.GB13376@n2100.arm.linux.org.uk>
Message-ID: <e68bb3470911190149k3bc77ef6h26475bc7272784b8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Nov 19, 2009 at 04:40:50PM +0800, Wan ZongShun wrote:
>> 2009/11/19 Andrew Morton <akpm@linux-foundation.org>:
>> > I don't know, because I don't know what operation the hardware needs to
>> > stop it from generating interrupts. ?Perhaps that's clk_disable()?
>>
>> The interrupt will be not occur as long as I run clk_disable().
>>
>> > Once you've stopped the source of interrupts then the code should wait
>> > for the IRQ handler to complete if it's running on another CPU. ?Yes,
>> > free_irq() does that.
>>
>> So, regarding my system of single CPU, maybe I need put this
>> 'clk_disable()' in the front of function of w90p910_spi_remove().
>>
>> right?
>
> Depending on the hardware, that's not the right answer. ?If turning off
> the clock also causes register accesses to the device to abort, it is
> a very dangerous thing to do.
>
> It can also be dangerous if the clock is used to synchronise the interrupt
> output - it can lead to the output being permanently asserted if the clock
> is turned off with it asserted.
>
> Normally devices have an "interrupt enable" register. ?You should disable
> all interrupts from the device using this register after unregistering
> the driver from the (SPI) subsystem.

sir, so I need implement a API to disable spi device interrupt by
"interrupt enable" register?
but I did not find the operation in other ARM platform when they close
your spi driver.

or something I missed?

>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
