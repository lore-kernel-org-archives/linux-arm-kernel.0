From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 17:15:23 +0100
Subject: [PATCH 01/11] mfd: add the Berlin controller driver
In-Reply-To: <54E4B6EE.9030304@gmail.com>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <5101633.XnBqLvsiGQ@wuerfel> <54E4B6EE.9030304@gmail.com>
Message-ID: <8186955.8t2pyeaYSF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 February 2015 16:59:42 Sebastian Hesselbarth wrote:
> 
> > The alternative is to come up with a way to probe all the child
> > devices automatically, but then we should make that parent device
> > have a generic driver that does not need to know about the children
> > and that can work on any platform with similar requirements.
> 
> Ok, this is most likely the part that Lee doesn't like on the current
> driver: a platform_device for registering platform_devices *only* and
> only for Berlin.
> 
> So, out of the two options:
> 
> (a) Go for syscon_of_populate_devices() with a new compatible (I guess)
>      and having sub-nodes for each Linux subsystem that we want to have
>      a platform_device for. I fear that this will clash with early
>      registration of clk and we still have to find a way, i.e. device
>      naming policy, to match the drivers with their devices.

I don't see the problem with early clk registration, AFAICT it should
just work as expected, you just end up with an extra platform_device
for the clocks that does not get bound to a driver later because the
device node is already in use by the clock driver.

> (b) Join clk, pinctrl, reset into a single chip/soc-control node and
>      rewrite the sub-drivers to not directly rely on DT compatible.
>      With this, joining all sub-drivers into drivers/soc/berlin would
>      be a sane approach, right? Also, I have the strong feeling, that
>      we will encounter situations later that will require the clk driver
>      to pull a reset before changing a specific clk rate, e.g. for GPU.

If we do this, I think it should be a single driver as well, without
subdrivers. We should probably just do this if there is a small number
of subsystems to bind to, so the driver doesn't get out of hand.

This driver could live in drivers/soc then. 

If you want to have subdrivers after all, that would be a classic
MFD and should live in drivers/mfd. The binding would be the same
for both approaches.

	Arnd
