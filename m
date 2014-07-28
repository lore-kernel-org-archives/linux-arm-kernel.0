From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 17:23:03 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <53D65C16.2050202@arm.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <5959830.lpqeqL7HbK@wuerfel> <53D65C16.2050202@arm.com>
Message-ID: <13731398.6CtXoCyCVq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 15:20:06 Andre Przywara wrote:
> On 28/07/14 11:46, Arnd Bergmann wrote:
> > On Monday 28 July 2014 10:23:57 Graeme Gregory wrote:
> >> The PL011 UART is the use-case I keep hitting, that IP block has a 
> >> variable input clock on pretty much everything I have seen in the wild. 
> > 
> > Ok, I see. What does ACPI-5.1 say about pl011?
> > 
> > Interestingly, the subset of pl011 that is specified by SBSA does not
> > contain the IBRD/FBRD registers, effectively making it a fixed-rated
> > UART (I guess that would be a ART, without the U then), and you
> > consequently don't even need to know the clock rate.
> 
> The idea of this was probably to let the baudrate set by some firmware
> code to the "right" value and the spec just didn't want to expose the
> details for the generic UART:
> "This specification does not cover registers needed to configure the
> UART as these are considered hardware-specific and will be set up by
> hardware-specific software."
> To me that reads like the SBSA UART is just for debugging, and you are
> expected just to access the data register.

Right, makes sense. It also avoids the case where Linux for some reason
ends up using a different line rate than the firmware, which can
cause a lot of unnecessary pain.

> > However, my guess is that most hardware in the real world contains
> > an actual pl011 and it does make a lot of sense to allow setting
> > the baud rate on it, which then requires knowing the input clock.
> > 
> > If there is any hardware that implements just the SBSA-mandated subset
> > rather than the full pl011, we should probably implement both
> > in the kernel: a dumb driver that can only send and receive, and the
> > more complex one that can set the bit rates and flow-control but that
> > requires a standardized ACPI table with the input clock rate.
> 
> The fast model I use can be switched to use the SBSA restricted PL011,
> and as expected the Linux kernel crashes at the device doesn't support
> DMA (and a lot more stuff) - but the current code requires it.

It does? We have a lot of platforms that don't have DMA support for
pl011.

> So I am about to implement a new driver for that SBSA subset. So far
> this will be a separate driver, starting from a copy of amba-pl011.c,
> but removing most of the code ;-)

Ok. You might want to consider starting from a different base though.
IIRC, pl011 uses uart_port as the basic abstraction, while the
new driver should probably use the raw tty_port instead.
drivers/tty/goldfish.c is probably a good example to look at for
that.

You could also make it a hvc_driver like drivers/tty/hvc/hvc_vio.c,
but I'm not sure if that model seen favorable by the tty maintainers.
It would probably be the shortest driver though.

	Arnd
