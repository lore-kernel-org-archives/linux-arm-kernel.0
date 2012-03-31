From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 31 Mar 2012 14:42:15 +0100
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <20120330180134.GJ22981@n2100.arm.linux.org.uk>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
 <20120330180134.GJ22981@n2100.arm.linux.org.uk>
Message-ID: <20120331134215.GA5012@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 07:01:34PM +0100, Russell King - ARM Linux wrote:
> On Fri, Mar 30, 2012 at 09:55:37PM +0800, Shawn Guo wrote:
> > The commit 04bf301 (regulator: Support driver probe deferral) changes
> > regulator_get() and regulator_register() to return -EPROBE_DEFER
> > instead of -ENODEV.  Adapt amba bus driver to the change, otherwise
> > amba_probe() will fail on the platforms that do not have "vcore"
> > regulator device.

> Are you sure this is correct?  Did you read and understand the comment
> you removed?

Shawn's change is a good minimal fix for 3.4, probably the comment
should be maintained but the entire change in the regulator framework
was a change in return code so changing the return code we check for
should restore the previous behaviour for now.  Going forward we
probably want to do something else but for 3.4 this looks like the best
approach:

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> What do platforms do which have AMBA devices but don't have any vcore
> regulators?

We need to change the AMBA bus so it does something better than what it
does now and work out a good way to roll this out.  The more I think
about this the less convinced I am that AMBA should have regualtor
support in the bus itself at all.

I can see a few options here:

 - Add stub vcore regulators to the code for the relevant SoCs.  This is
   tedious, annoying and defeats the point of frameworks so to me it's a
   clear non-starter.

 - Require systems which do have vcore regulators to tell AMBA about it
   when registering the devices then either have the AMBA bus suppress
   the regulator calls or tell the regulator framework about it (which
   is more idiomatic and probably easier in the long run).  This is a
   bit inelegant but should minimise the amount of work.

 - Move the vcore management from AMBA into the SoC-specific power domain
   management code for relevant SoCs.  The SoCs should know if there is a
   vcore that's supplied via a visible regulator (as opposed to power
   gating within the SoC which often has other requirements or features
   and is generally implemented via the power domain support) and this
   should integrate nicely with similar handling for clocks.

I don't know if anyone else has any better ideas?  

To me the power domain approach feels right and looking at the changelog
for the commit introducing this support that seems to be roughly the use
case.  The one actual in tree AMBA device using this stuff seems to be
the pl022 (though there don't look to be any boards with the vcore
regulator supplied) and it certainly looks like it'd fit well with this
idiom.

The current approach leaves us tied to playing init ordering games to
ensure that the regulator is available prior to the AMBA device probing.
We want to get away from relying on those since they end up breaking
down and really only work when everything is built in.  It also give us
poor error handling since we end up silently ignoring failures, for
example if the driver for a vcore regulator is not enabled or the supply
not hooked up when required on a board.

In general any patch which will just ignore errors when requesting a
regulator should be treated with suspicion.

> We're not going through the same farce that the smsc network driver has
> gone through: OMAP3430LDP remains fucked through that idiotic ill-thought
> out change (c7e963f68888, net/smsc911x: Add regulator support).  See
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=99

For that board it's really very straightforward to add the required
regulators and CONFIG_REGULATOR_DUMMY will normally get things going
immediately, hopefully this is now taken care of by the latest patch
series that was floating around for that stuff?

It's one of these things where it's annoying to have to do the board
update but the update is so simple to do and the alternatives introduce
sufficient fragility and general ick to make it seem like it's the
better alternative.

In general people do need to do an audit of existing boards in the tree
when they add regulator support to an existing driver and make some
effort to at least let people know that updates are required, I did ask
for that to be done with the smsc911x change but it's apparent that this
didn't happen.

In order to reduce the amount of pain this stuff causes it's looking to
me that we should be pushing new off-SoC drivers that don't get power
from their bus to always include at least stub regulator support, that
will at least mean that if more detailed support is added in the future
we don't disrupt things too much.  One of the things I've been trying to
find time to do is adding something like what you've got for AMBA (but
with a driver specified supply list) to the driver core so that this is
as simple as possible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120331/062e1ac8/attachment.sig>
