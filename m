From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 08 Sep 2015 14:43:53 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150908112909.GX21084@n2100.arm.linux.org.uk>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <20150908110135.GW21084@n2100.arm.linux.org.uk>
 <1441710467.13536.13.camel@pengutronix.de>
 <20150908112909.GX21084@n2100.arm.linux.org.uk>
Message-ID: <1441716233.13536.21.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 08.09.2015, 12:29 +0100 schrieb Russell King - ARM
Linux:
> On Tue, Sep 08, 2015 at 01:07:47PM +0200, Lucas Stach wrote:
> > Am Dienstag, den 08.09.2015, 12:01 +0100 schrieb Russell King - ARM
> > Linux:
> > > On Tue, Sep 08, 2015 at 12:56:18PM +0200, Lucas Stach wrote:
> > > > This is expected, it's the overlay adapter which doesn't really work
> > > > with imx-drm yet.
> > > 
> > > No, it's imx-drm which isn't working.  As I explained in my previous
> > > email, overlay planes are expected to do scaling.  imx-drm errors out
> > > attempts for that.  This is a kernel bug, not an Xorg driver bug.
> > > 
> > I would argue that this is a bug of the interface between kernel and
> > userspace.
> 
> Yes, only in so far as knowing beforehand whether scaling is possible.
> The only time that you get to know is when the call to display the plane
> fails.  That's a really poor interface.
> 
> > Scaling isn't something that can be expected to be usable on every
> > hardware (and in fact the IPU isn't able to do arbitrary scaling with
> > its 1024 in/out pixel constraints), but there is no clear way to
> > communicate this to userspace other than flat out rejecting the plane
> > update. Atomic may provide some better ways, but we are not there yet
> > for imx-drm.
> 
> I think that depends on your point of view - I suspect x86 people would
> be surprised by that comment. :)
> 
I think some of the recent Intel chips had the same problem, in that
they lost the ability to scale planes and ended up not exposing them due
to the poor interface.

> There was talk a while back when the overlay plane support went in that
> it was possible to do >1024 pixels, but it was complex, but the impression
> I was left with was one day it would work - and I'm still waiting. 

Don't wait for that. We can't do >1024 without doing a copy in memory,
which would be a big stretch of the plane definition and benefit.

In addition the IPU scaler has pitch and alignment constraints that make
the needed tiling extremely complex to get right. We fiddled with this
extensively to get it to the point that it is usable as a V4L2 mem2mem
device. Moving this to the display path is not going to happen, ever.

As all relevant resolutions already require a copy you are much better
of doing it with the GPU and get all the testing effort focused on that
path.

> I
> suspect that the iMX6 is going to be obsolete before we have a decent
> working video playback story on this hardware.
> 
MX6Plus is just around the corner and will probably keep us busy for a
while. ;)

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
