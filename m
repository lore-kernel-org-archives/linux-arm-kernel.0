From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 16 Jan 2014 21:51:58 +0800
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <20140116133649.GV15937@n2100.arm.linux.org.uk>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
Message-ID: <CAGb2v667bpKxya3TXG8xEXOKK9RaC6k_Q1=OSf5+R5BLn2e-zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 16, 2014 at 9:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Okay, I'm hitting something of a dead end with trying to work out how to
> support this in DT.
>
> The Wifi/BT (bcrmfmac) device has multiple connections to the host device
> - it has a SDIO connection, a UART connection, and an audio connection.
> In addition, a series of GPIOs are wired to control this device:
>
> - Reset for bluetooth plus two additional GPIOs (unused I think)

The other 2 are wake and host wake (interrupts in either direction) I suppose?
The device should support in-band signaling over the UART as well, and
we have no way to tie these 2 interrupts to the bluetooth device anyway.

> - Reset for Wifi plus two additional GPIOs (again, I think unused)

Again, should be out-of-band interrupts in both directions.

> - GPIO to control regulator supplying power to the Wifi/BT chip
> - GPIO to control regulator supplying power to the oscillator for
>   the Wifi/BT chip.
>
> The Wifi/BT chip can only be detected via probing the SDIO connection, and
> only when the device has been powered up and released from reset - so we
> have to power up and reset the bcrm device before we probe via the SDIO
> bus.
>
> While it's possible to attach the power supply for the Wifi/BT chip to the
> vmmc-supply property of the host, it's not possible to do that with the
> oscillator supply.  Neither is there any provision for manipulating the
> GPIOs to deal with the resets.

Android devices would probably use a custom rfkill device.

> I can't find any examples of anything similar in our existing set of DT
> files, so I suspect either this is a device which no one supports on any
> DT platform, or there's some clever way to handle this.
>
> How do other people support this in DT?  Do they hack up some platform
> specific code (which isn't nice)?  What other solutions are there to get
> around this problem?  How does this kind of thing get represented in DT?

AFAIK, there is none at the moment.

I am working on a patch series that adds DT support to rfkill-gpio.
rfkill-gpio takes at most 2 GPIOs and 1 clock for each rfkill control.
You would register one for wifi, and one for bluetooth. The patches
should be posted by tomorrow, hopefully.

But the brcmfmac driver also registers one itself, so you would have
2 wifi rfkills in the system. So I register my wifi power as a regulator
that is always on, using fixed-regulator with the regulator-always-on DT
property.

> (Don't suggest adding DT support to the bcrmfmac driver - this is a
> chicken-and-egg problem.  The driver isn't being probed at the moment
> because the device is powered down and/or held in reset, so is
> undetectable.  The kernel needs to power it up and release the reset
> so it becomes detectable.)

The brcmfmac driver also has a platform device component, which one can
give power on/off callbacks through platform data. Maybe we can add DT
support to this bit as well.

I'v already completed device tree support for the SDIO device part, to
be able to use out-of-band interrupt signaling. However the sunxi GPIO
driver isn't well tested, and I am not getting interrupts. Still have to
sort this out to actually test my work.


Cheers,
ChenYu
