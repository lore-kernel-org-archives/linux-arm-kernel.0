From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Nov 2012 10:36:26 +0900
Subject: [PATCH 0/10] Kirkwood ASoC drivers fixes and improvements
In-Reply-To: <20121122140614.GA26930@n2100.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
 <20121120122051.GA12063@n2100.arm.linux.org.uk>
 <20121122140614.GA26930@n2100.arm.linux.org.uk>
Message-ID: <20121123013625.GA4385@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 02:06:14PM +0000, Russell King - ARM Linux wrote:

> Instead, a DT description will just declare there to be one I2S device
> with its relevant resources.

Yes, this is exactly the sort of thing all the existing platforms
using DT are doing in their ASoC drivers - there's normally some
grouping or sharing at the hardware level that doesn't map exactly onto
Linux models.  We're already at the point you're trying to get to here.

> Such a description is _inherently_ incompatible with ASoC as long as
> ASoC insists that there is this artificial distinction.

> What Mark is telling me is that he requires yet more board files to
> spring up under sound/soc/ which create these artificial platform
> devices.  Not only does that go against the direction which we're heading

What I said was that you should just register everything from the DT
nodes that describe the hardware and not create dummy devices in the DT
for the Linux internals.  The drivers instantiated from DT should take
care of mapping the hardware into Linux, instantiating everything they
need to from code.  The approach the existing drivers in mainline are
taking is to register multiple ASoC functions from a single device model
device which seems like the logical approach to doing the mapping to me.

Some of the remarks you've made on IRC and code you've pointed me at
suggest that you have formed the impression that there needs to be a 1:1
mapping between device model devices and ASoC function drivers.  This is
not the case.  A driver for a device model device can register as many
different ASoC functions of whatever type it sees fit from a single
device model device.

> on ARM (at Linus' insistance) to get rid of board files, but it perpetuates
> this silly idea that every audio interface should be split up whether
> there's a distinction there or not.

I'm not entirely convinced that modelling different areas of
functionality with different ops structures (which is essentially what
is happening here) is a massive design flaw.

> We need to have solutions which do not require artificial breakup of
> drivers; we need solutions where hardware can be described by DT and
> that DT description be used by the kernel with the minimum of code.
> What we don't need are yet more board files appearing in some other
> random part of the kernel tree.

This is the current situation, none of the existing DT using platforms
have had any need to do that.  Nothing about Kirkwood audio seems to be
at all unusual here.

We *do* have board files for the linkage between the various components
since (as discussed previously ad nauseum) a lot of embedded audio
hardware is interesting enough to warrant having a driver itself.  There
has been some work on generic drivers for simpler systems which should
be useful and can be built on, though we do need the problems with the
clock framework availability to be addressed (both getting it available
on all platforms and ensuring that the platforms with custom frameworks
move to the genric one).  These drivers are separate to the issue you
are discussing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121123/c35b8c7f/attachment.sig>
