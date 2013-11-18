From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 18 Nov 2013 13:26:46 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <52644A9E.3060007@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>
Message-ID: <20131118122644.GA26046@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
[...]
> In general, the kernel still needs a complete driver to every last
> device on every strange board, and needs to support every strange way
> some random board hooks all the devices together.
[...]

This may only be slightly related and it doesn't address all the points
you brought up here, but for lack of a better place, here goes.

I've had an interesting discussion with a friend over the weekend which
eventually turned to a similar topic. With all the recent discussions
about how to push board-specific details out into firmware, perhaps a
more drastic measure would be to push for standardization of hardware
interfaces.

For instance, one of the reason we have so much code in the kernel is
because every driver needs to talk to hardware through a slightly
different set of registers. Perhaps it would be possible to get some
discussion going about standardizing register interfaces for various
components. This has already been done for 16550 UART and the same
should be possible for a wide variety of other controllers such as I2C
or SPI.

There have been some attempts at creating reusable IP blocks, I think
ARM does have quite a few which can be licensed. At the same time, many
vendors may already have their own IP so it makes little sense for them
to license third party IP just to provide a standard interface for
drivers. However it might be easy in many cases to support the standard
interface using custom IP blocks.

I suspect something similar could be done for much of the clock, power
and reset requirements of IP blocks. Now I know little about how exactly
an SoC is designed these days, but I can imagine that it would be easy
to move out some of the complexity into hardware by defining something
like a standard register to enable a block. If each block has that
standard register it becomes trivial to write driver and SoC support. It
essentially becomes a matter of calling a platform_device_enable()
function, analogous to pci_enable_device(). There would no longer be a
need for the kind of intra-SoC glue that's taking up a significant
amount of code these days.

Obviously an effort such as the above is on a completely different scale
and would require many vendors to sit together and work something out.
But this isn't new either. After all there are committees and consortia
that already do this in some areas (Khronos). Many of these working
groups seem to focus mostly on software specifications, but what would
prevent them from doing something similar on a hardware interface level?

There are of course some dangers to this as well. Since much of the
complexity is moved into hardware, bugs can no longer be fixed or easily
worked around in software. However to some degree the same is true for
scenarios where a lot of the complexity is moved into firmware instead,
since that's typically not easily replaceable or fixable either.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/99620774/attachment.sig>
