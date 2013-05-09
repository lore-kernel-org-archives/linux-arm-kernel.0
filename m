From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 May 2013 15:37:02 +0100
Subject: [PATCH 1/3] driver core: Add API to wait for deferred probe to
 complete during init
In-Reply-To: <20130509141444.GV18614@n2100.arm.linux.org.uk>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
 <CACVXFVMd_iRtEM8ZLK6Ps66gZO6SCp1mXSgY6JbWtRJjJUh+ag@mail.gmail.com>
 <CACxGe6uHBNUcbD9SeRP5c3E8NN-Z2yjVV+9VAhuoJnXoBtTu2w@mail.gmail.com>
 <20130509135017.GD3200@sirena.org.uk>
 <20130509141444.GV18614@n2100.arm.linux.org.uk>
Message-ID: <20130509143702.GE3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 03:14:45PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 09, 2013 at 02:50:17PM +0100, Mark Brown wrote:

> > Even if the driver copes fine it can still be desirable to avoid the
> > power down/up cycle if it involves some user visible effect - things
> > like blinking the display off then on for example.  That said I am a
> > little suspicious about this approach, it doesn't feel as robust as it
> > should to go round individual callers.

> What if the driver for something like your display is a module which
> needs to be loaded from userland?

That's clearly a "don't do that then" sort of thing; while we don't want
to be unhelpful there's no guarantees with this approach.

> Where the design bug lies is in the "lets probe all the drivers and then
> shut down resources which drivers haven't claimed".  That contains an
> implied assumption: that all drivers have been loaded and probed at the
> point where you shut down those resources.

Well, that's not really the intention - it's not a strong guarantee,
it never has been given things like the module case you mention.

> So, trying to solve the problem may be totally fruitless because you
> can't actually solve it - you can only put a sticky plaster over it and
> hope that it catches most of the problem.  But reality is that you can't
> have both a shutdown of unused resources _and_ avoid the down/up cycle.

Yes, exactly - all we're trying to do here is cover the 90% case, not
solve all the possible problems since as you say that's not achievable.  
There's a clear and reasonable desire to turn off resources we know
aren't in use at the current time, but equally well doing so as soon as
we start controlling the resources is pretty much guranteed to introduce
user visible issues on some systems so it's a question of picking some
reasonable point after that.

Another option here which is more in tune with deferred probing and
hotplugging would be to switch the delay over to be time based rather
than initcall based; do the shutdown at some point based on the time the
last resource was registered.  That still won't cover everything
though we could make the delay tunable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130509/5d081cc7/attachment.sig>
