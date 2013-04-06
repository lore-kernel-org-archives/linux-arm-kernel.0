From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 5 Apr 2013 20:07:09 -0500
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
References: <20130319170933.28337.50448.stgit@localhost>
 <20130325101707.GZ1906@pengutronix.de>
 <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
Message-ID: <CAKGA1bkWLrOs15ni=8D__BvuG6kvqkeeLZGOLrVZY9g0q0z4Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 6:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
> This could be useful for removing the imx6q_sabrelite_cko1_setup()
> function from arch/arm/mach-imx/mach-imx6q.c.
>
> I would like to add audio support for another board and would like to
> avoid to do the same as imx6q_sabrelite_cko1_setup()  for setting up
> the CLKO, if possible.

You know, we have the same problem on one of our designs here (CLKO is
used on MX53 for audio codec and camera device, shared) - the current
solution is hack it into platform support in a BSP kernel.

If we move to device tree, we know and you know the solution already;
all this clock setup HAS to be done in the bootloader.

The device tree really, really is only a way to describe the
configuration as it exists or to describe alternatives - for instance,
a clock with 10 parents may be described as having 10 parents, and the
binding (in complicated cases) or driver (if it is simple as a value
from 0 to 7 and the field width is 3 bits for example) will determine
how that alternative can be selected (and by consequence, what the
current setting is).

The device tree concept is NOT a place to dump configuration items for
your board as hardcoded values to try and force something you could
have done elsewhere. On i.MX53 you cannot boot a kernel verbatim - you
at least have to run through the Boot ROM and supply a DCD table or
plugins first. This is where you figure things like this out.

In a case where you have, say, an audio codec and it has a dynamic
input clock that you want to change on the fly, first of all you would
not hardcode a frequency into a device tree, second of all there is
nothing stopping you from doing that right now anyway. If the clock is
static and fixed frequency and can only be turned on and off, there
are clock bindings for this already. If it is static and can never be
turned off, then there are clock bindings for this too, and in this
case the proviso is that the clock is ALREADY turned on and ALREADY
stable before you enter the kernel otherwise the description is by
it's very definition invalid.

If the clock frequency in hardware is not what you wanted when the
driver comes up, and you only have an on/off switch, it is not up to
the device tree binding to describe how to go about configuring the
system to make sure. You cannot in good conscience put a clock
frequency "to be set later" in the device tree along with a clock
phandle, simply because that means the device tree no longer describes
the hardware accurately - the clock phandle is a valid clock, the
hardware will tell you a frequency from registers in the clock driver,
the device tree will disagree. How do you know which one is the
correct value, or if the frequency in the tree is a suggestion rather
than a description?

I am totally against this (sorry Sascha..). Let's put some effort into
fixing the bootloaders rather than trying to use the device tree to
enforce the ridiculous assumption that "Linux kernel does not trust
the bootloader". Once the bindings and trees are out of the kernel
source, you're going to HAVE to trust what the bootloader passes, be
it pregenerated compiled blob (which needs to be written to match the
hardware state the bootloader finishes up at) or dynamically generated
at runtime during the boot process (which can describe to the bit what
the hardware is doing). If you are testing this on Beagle XM you can
fix your U-Boot easily. New boards will have to be designed *with the
idea of device trees and working configurations in mind* - that is a
fact of life, in fact this is how it should be in reality these days
anyway (most HW designers will do initial bringup of the board - at
least a minimal working configuration, in a restricted environment
where they can use test pads to measure clocks, voltage outputs and
levels of devices to ensure both production was successful and that
the design is in itself electrically sound. This code 99% of the time
ends up in the bootloader... sometimes not, when the board was
designed by one group and the software written by the community, but
in this case the community needs to learn board bringup and proper
behavior...)

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
