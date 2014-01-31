From: balbi@ti.com (Felipe Balbi)
Date: Fri, 31 Jan 2014 15:44:05 -0600
Subject: [RFC/PATCH] base: platform: add generic clock handling for
 platform-bus
In-Reply-To: <Pine.LNX.4.44L0.1401311614100.12368-100000@netrider.rowland.org>
References: <1391191965-31102-1-git-send-email-balbi@ti.com>
 <Pine.LNX.4.44L0.1401311614100.12368-100000@netrider.rowland.org>
Message-ID: <20140131214405.GC2502@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 31, 2014 at 04:34:27PM -0500, Alan Stern wrote:
> On Fri, 31 Jan 2014, Felipe Balbi wrote:
> 
> > Still TODO a commit log. Not for merging!!!!!
> > 
> > NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > This patch is an idea I've had recently in order to combine several different
> > PM implementations into the platform-bus.
> > 
> > This patch is bare minimum for platforms which need to handle functional and
> > interface clocks but the whole thing is made optional.
> > 
> > Note that this patch makes sure that by the time a platform_driver's probe is
> > called, we already have clocks enabled and pm_runtime_set_active() has been
> > called, thus making sure that a device driver's pm_runtime_get_sync() will
> > solely increase the pm usage counter.
> > 
> > I have *NOT* tested this anywhere *YET*, but I suppose it shouldn't cause any
> > issues since the clock API has ref counting too.
> > 
> > Would really like to get some review from several folks involved with ARM SoC
> > PM so that's the reason for the wide audience. If I have missed anybody, please
> > add them to Cc.
> > 
> > As mentioned above, this is *NOT* meant for merging, but serves as a starting
> > point for discussing some convergence of several PM domain implementations on
> > different arch/arm/mach-* directories.
> 
> You might want to copy the runtime-PM approach used by the PCI 
> subsystem.  It works like this:
> 
> 	The core invokes a driver's probe routine with runtime PM 
> 	enabled, the device in the ACTIVE state, and the usage counter 
> 	incremented by 1.
> 
> 	If the driver wants to support runtime PM, the probe routine
> 	can call pm_runtime_put_noidle.
> 
> 	The core does pm_runtime_get_sync before invoking the driver's
> 	remove routine.  At this point a runtime-PM-aware driver whould 
> 	call pm_runtime_get_noresume, to balance the _put during probe.
> 
> 	After invoking the remove routine, the core does a put_noidle
> 	(to balance the get_sync) and a final put_sync (to balance the
> 	increment before probe and to leave the device at low power.)
> 
> A nice consequence is that everything is transparent for drivers that 
> don't support runtime PM.  The usage counter remains > 0 the entire 
> time the driver is bound.
> 
> Conversely, drivers that do support runtime PM merely have to add one 
> call during probe and one during remove.
> 
> There is one tricky aspect to all this.  The driver core sets the
> dev->driver field before calling the subsystem core's probe routine.  
> As a result, the subsystem has to be very careful about performing
> runtime PM before invoking the driver's probe routine.  Otherwise you
> will end up calling the driver's runtime_resume callback before the
> driver's probe!  (And of course, the same problem exists in reverse
> during remove.)

I can, certainly, do that and that would, most likely, simplify a whole
bunch of drivers. But that change, I suppose, would be a whole lot more
invasive. I'll spend some time studying PCI pm_runtime support, thanks
for the tip.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/8008aa52/attachment-0001.sig>
