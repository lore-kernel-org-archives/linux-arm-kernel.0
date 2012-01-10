From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 10 Jan 2012 12:22:52 +0000
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0B897A.20502@firmworks.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
Message-ID: <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mitch Bradley wrote:
> In my opinion, pushing the EDID abstraction into a node by itself is
> not worthwhile.  The EDID spec says that you read either 128 or 256
> bytes from an I2C device at I2C address 0x50; you hardly need an
> abstraction for that, given that you have a "read from I2C" method.

Since E-EDID and E-DDC, it's up to 32k in 256 byte pages, and you need
a special way of reading beyond the first 128 bytes, by writing page
register at 0x30; and it must be all in a single I2C transaction as
the page register is reset by STOP events.

Also on some monitors there's DDC-CI protocol on a different I2C
address for controlling the monitor. It's not very useful in practice
IME, but some may want to use it, for which userspace needs DDC access.

If you mimic what X.org and some kernel graphics drivers do with DDC,
there's some extra signal wiggling that ought to happen beyond I2C
protocol for compatibility with older monitors.  But that's not
mentioned in the DDC specs that I've seen.

Unlike I2C itself, DDC has timeouts if there's no response, in which
case an I2C reset sequence is a good idea after.  It makes sense for
the timeouts and resets to be the same for all display drivers.

Reading over DDC can become a random write if there's a signal glitch,
like bounce when someone removes a cable.  Unfortunately some monitors
store the written data permanently, wiping their EDID or part of it.
(I suspect this is actually the reason the kernel EDID code has (or
had?) a workaround to ignore the first four bytes for the checksum.)
This can happen especially if EDID is polled in the background to
check for cable removal.  It's possible to guard against this (or
limit the damage) by checking the display doesn't assert I2C data for
more than 8 cycles in a row.

The EDID data of the currently connected display, and notification
when it changes or is detached, are quite useful to userspace in my
experience.  Preferably cached, periodically validated.

> The right level of abstraction at the device node level is "this
> hardware implements an I2C bus master", for which there is already a
> binding.  Then all you need is a reference to that device from a
> display device node.

It still needs to know *which* I2C bus master is connected to the
display. Some graphics hardware has multiple, e.g. one to talk with
the DVI/HDMI transmitter, another connected by cable to the display.

Since the I2C connected to the display is officially called DDC
(actually E-DDC now) that seems a natural name for the node.

I have worked with devices that shared the same I2C for DDC and
talking with on-board devices. (That was a bad idea, as some monitors
clamp the lines high or low excessively even when switched off.) Point
here is sometimes there's a dedicated one for DDC; sometimes there isn't.

> The display device driver will need to interpret the EDID data in an
> device-dependent manner.  That is inherent in the fact that the
> driver for the given display hardware must map the EDID description
> of the monitor into display-hardware-dependent timing settings.

For the most part, EDID's timings are independent of the display
driver except the chosen timings will have to satisfy both sets of
constraints (sender and receiver). Decoding E-EDID fully is
surprisingly big and complicated, not to mention the workarounds for
dodgy EDIDs (see X.org source) so it's really best to not duplicate it.

All the best,
-- Jamie
