From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 14:40:27 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <1441716233.13536.21.camel@pengutronix.de>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl>
 <1441709778.13536.8.camel@pengutronix.de>
 <20150908110135.GW21084@n2100.arm.linux.org.uk>
 <1441710467.13536.13.camel@pengutronix.de>
 <20150908112909.GX21084@n2100.arm.linux.org.uk>
 <1441716233.13536.21.camel@pengutronix.de>
Message-ID: <20150908134027.GZ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 02:43:53PM +0200, Lucas Stach wrote:
> Am Dienstag, den 08.09.2015, 12:29 +0100 schrieb Russell King - ARM
> Linux:
> > There was talk a while back when the overlay plane support went in that
> > it was possible to do >1024 pixels, but it was complex, but the impression
> > I was left with was one day it would work - and I'm still waiting. 
> 
> Don't wait for that. We can't do >1024 without doing a copy in memory,
> which would be a big stretch of the plane definition and benefit.
> 
> In addition the IPU scaler has pitch and alignment constraints that make
> the needed tiling extremely complex to get right. We fiddled with this
> extensively to get it to the point that it is usable as a V4L2 mem2mem
> device. Moving this to the display path is not going to happen, ever.
> 
> As all relevant resolutions already require a copy you are much better
> of doing it with the GPU and get all the testing effort focused on that
> path.

And at that point, you might as well use the filter blit and blit directly
to the screen.

I've run some performance analysis on this on iMX6 hardware, and the time
taken for the CPU to copy the Xv data passed to it is about the same time
that it takes the CPU to flush the caches, then ask the GPU to copy the
data, and then wait for the GPU to report that the copy has finished.  My
analysis shows that you actually lose performance by using the GPU to
merely copy and then pass it to Xv.

Also, you mention that the IPU scaler has pitch and alignment constraints.
So does the GPU.  The Xv interface can cope with that just fine, because
the Xv backend gets to define the pitch and buffer size for any given
format/width/height, and offsets in the buffer for planar image formats.

It isn't able to specify the alignment of the actual buffer though - for
SHM, that's going to be the size of a struct page due to the way shmem
works.  For raw XvPutImage, things are harder to cope with, but the GPU
can cope provided the offset is aligned to a pixel boundary.

> MX6Plus is just around the corner and will probably keep us busy for a
> while. ;)

You might be excited about that, but for the rest of us, we have to put
up with the hardware we have, which is basically iMX6.  We need solutions
now on existing iMX6 hardware, not the next set of likely to be
problematical hardware.

I know the grass is always greener on the other side - and I expect that
when MX6+ comes out, you'll then have no time to work on etnaviv DRM,
and we'll still be stuck without any progress on that.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
