From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Feb 2014 12:26:43 +0100
Subject: I2C dummy adapter driver ?
In-Reply-To: <5306322C.8030703@wwwdotorg.org>
References: <5305382E.9050902@gmail.com> <5306322C.8030703@wwwdotorg.org>
Message-ID: <530737F3.5050102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/14 17:49, Stephen Warren wrote:
> On 02/19/2014 04:03 PM, Sylwester Nawrocki wrote:
[...]
>> I was wondering whether it would be reasonable to create a generic
>> Linux dummy I2C bus controller driver. The rationale behind it is
>> there might be hardware configurations where I2C communication is
>> handled by firmware but still it is useful to have I2C slave devices
>              ^^^^^^^^
> 
> That doesn't sound like a dummy driver. Rather, it sounds like a driver
> for the firmware(?) interface that's used to do the I2C transactions.

Hmm, I think you're right. Just to clarify a bit, as the I2C slave device
is part of a more complex data processing chain, it is not exposed by
the firmware on a I2C read/write like command interface.
So the only thing the Linux I2C client does currently is to enable some
voltage regulators and driver reset pin through a GPIO. 

However it depends on the firmware for the MCU controlling the whole
camera data processing chain, currently the I2C slave control transactions
are being handled in an opaque way by the firmware, it just exposes (very 
few) high level commands specifically related to the I2C slave.
It could be also that the firmware leaves out the I2C bus controller and
I2C slave handling solely to the host CPU. In such case a regular I2C
bus controller driver is needed. Hence the exact role of the I2C bus 
controller driver highly depends on the firmware loaded.

I assume the "driver for the firmware interface" is a good definition.
I'm just not sure what best location of such an I2C bus driver, supposedly
drivers/media/i2c would be a good fit, rather than drivers/i2c/busses.
