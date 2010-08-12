From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Aug 2010 19:27:44 +0100
Subject: [RFC] the right way to use gpiolib hooks to automate power
	management?
In-Reply-To: <4C6423C1.9060509@codeaurora.org>
References: <4C6423C1.9060509@codeaurora.org>
Message-ID: <20100812182744.GC31982@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 09:39:29AM -0700, Gregory Bean wrote:
> On MSM, we have a bank of gpios whose physical characteristics are
> controlled via a 'gpiomux' subsystem, which sets things like drive
> strength, pull-up, pull-down, gpio functional assignment, and the like.
>
> We have a written a software driver which reference-counts these gpio
> lines (via a put()/get() api), putting them in their "high-power" active
> configurations when they're in use, and dropping them down into a
> high-impedance low-power setting when they're not.

Beware.  What you're suggesting can lead to an increase in power
consumption rather than the reduction you're looking for.

Inputs don't like to float at mid-rail (mid-rail is absolutely the _worst_
thing you can do with an unused input.)  Mid-rail means both transistors
on the input are partially turned on, thereby causing current to flow
between the supply rail through these transistors down to ground.

This is also exactly the same reason why power consumption is related to
clock speeds - when an input changes state, there's an overlap between one
transistor turning on and the other turning off, which causes a pulse of
current to be taken.

It's far better, not only for power consumption reasons but also ESD
sensitivity reasons to have unused outputs actively driven to their
appropriate inactive level.

Consider that output you're about to switch to a high impedance state
(which makes it appear as an input.)  Have you first checked that there's
a pull-up or pull-down resistor on the signal, or have you just created
the situation where the device has become more sensitive to electrical
noise and increased its (and the connected device) quiescent power
dissipation?
