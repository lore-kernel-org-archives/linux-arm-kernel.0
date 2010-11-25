From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 25 Nov 2010 13:24:39 +0100
Subject: [PATCH 6/7] i2c/pxa2xx: reset the chip if the bus is not free
In-Reply-To: <4CEE05A4.6030201@compulab.co.il>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>	<1290633617-15311-7-git-send-email-bigeasy@linutronix.de>	<AANLkTikvN+==eTkoh7CTQyN0mbfvPhH6Uh9NX5QW7WFx@mail.gmail.com>
	<AANLkTi=8Xy3M7QGO54nt_r0_12z3+o8G5fAqQmxkTH4o@mail.gmail.com>
	<4CEE05A4.6030201@compulab.co.il>
Message-ID: <4CEE5587.90109@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg wrote:
>  Hi,
Hi,

>>> Even you reset I2C controller, it shouldn't help you since bus isn't
>>> free. I thinkt that you should reset I2C bus before you reseting I2C
>>> controller.

According to the register, IBB (bus busy) is cleared at this point. The
only remaining flag is UB (unit busy) and RW mode.

>> Excuse me that my previous comments are for PXA master mode.
I am in master mode.

>> I think that you're focused on pxa working on slave mode. But if pxa
>> is working in master mode, it seems that we needn't reset I2C
>> controller since it doesn't help.
> 
> As for PXA3xx, the Developer Manual states:
> "Software must ensure that the TWSI unit is not busy (ISR[UB] = 0)
> before it asserts a reset. Software must also ensure that the TWSI bus is idle (ISR[IBB] = 0)
> when the unit is enabled after reset."

My manual says more or less the same thing. It says "unit not busy" but
quotes the IBB bit in braces. It is probably a typo.
The register say: ISR=00000005, ICR=000017e0, IBMR=01
So according to this I am not allowed to reset the I2C unit while it is
busy.

I tracked it down to the following: i2cdetect tries to read a byte from
address 47. This fails because there is no device. Then it goes for 48
which returns 0 (there is a device). The following read always fails. So I
guess the device at 48 is still sending data. What is general rule of
thumb in such a case?

>>From my experience, in master mode resetting the controller
> does not help and if the bus is busy for too much time,
> there always was a h/w problem involved.

Looks like it.

Sebastian
