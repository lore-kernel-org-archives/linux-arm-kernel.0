From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 May 2013 15:14:45 +0100
Subject: [PATCH 1/3] driver core: Add API to wait for deferred probe to
 complete during init
In-Reply-To: <20130509135017.GD3200@sirena.org.uk>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
 <CACVXFVMd_iRtEM8ZLK6Ps66gZO6SCp1mXSgY6JbWtRJjJUh+ag@mail.gmail.com>
 <CACxGe6uHBNUcbD9SeRP5c3E8NN-Z2yjVV+9VAhuoJnXoBtTu2w@mail.gmail.com>
 <20130509135017.GD3200@sirena.org.uk>
Message-ID: <20130509141444.GV18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 02:50:17PM +0100, Mark Brown wrote:
> On Thu, May 09, 2013 at 12:50:46PM +0100, Grant Likely wrote:
> 
> > However, if a device that shuts down resources after init has
> > completed and then cannot turn those resources back on when another
> > driver requests them then it sounds like there is a bigger design
> > problem. We're in a hotplug world and most of the time a driver cannot
> > assume that a resource will never get requested after initcalls have
> > completed. It sounds like a design bug in the driver if it cannot
> > handle that use case.
> 
> Even if the driver copes fine it can still be desirable to avoid the
> power down/up cycle if it involves some user visible effect - things
> like blinking the display off then on for example.  That said I am a
> little suspicious about this approach, it doesn't feel as robust as it
> should to go round individual callers.

What if the driver for something like your display is a module which
needs to be loaded from userland?

Where the design bug lies is in the "lets probe all the drivers and then
shut down resources which drivers haven't claimed".  That contains an
implied assumption: that all drivers have been loaded and probed at the
point where you shut down those resources.

That simply may not be true in todays kernel - it's not true for a start
if you have modular drivers, and you have built most of the drivers as
modules (as a distro would want to with single zImage).  It's
coincidentally not true if you have deferred probing and some drivers
defer.

The real problem is this: at what point has the system actually finished
"booting" in the sense that all drivers for a platform have been
initialised?  With user loadable modules and deferred probing, that's
actually a very fuzzy concept.

As you can't really tell when that point has been reached, how can you
decide to shut down resources which "aren't being used" in a sane way
without avoiding the down/up cycle?  Basically, you can't.

So, trying to solve the problem may be totally fruitless because you
can't actually solve it - you can only put a sticky plaster over it and
hope that it catches most of the problem.  But reality is that you can't
have both a shutdown of unused resources _and_ avoid the down/up cycle.
