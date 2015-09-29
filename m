From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 29 Sep 2015 10:28:19 +0200
Subject: xf86-video-armada + etnaviv (Was: Re: I.MX6 HDMI support in v4.2)
In-Reply-To: <20150928165021.GY21513@n2100.arm.linux.org.uk>
References: <m337yp5gvv.fsf@t19.piap.pl>
 <1441709778.13536.8.camel@pengutronix.de> <m3bnd52y4s.fsf@t19.piap.pl>
 <1442332425.2637.16.camel@pengutronix.de>
 <20150915163642.GW21084@n2100.arm.linux.org.uk>
 <1442336034.2637.20.camel@pengutronix.de>
 <20150915170444.GX21084@n2100.arm.linux.org.uk>
 <1443451688.3178.61.camel@pengutronix.de>
 <20150928152429.GW21513@n2100.arm.linux.org.uk>
 <1443454813.3178.66.camel@pengutronix.de>
 <20150928165021.GY21513@n2100.arm.linux.org.uk>
Message-ID: <1443515299.3141.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 17:50 +0100 schrieb Russell King - ARM Linux:
> On Mon, Sep 28, 2015 at 05:40:13PM +0200, Lucas Stach wrote:
> > Am Montag, den 28.09.2015, 16:24 +0100 schrieb Russell King - ARM Linux:
> > > On Mon, Sep 28, 2015 at 04:48:08PM +0200, Lucas Stach wrote:
> > > > I've looked at that again and the issue here seems to be that GStreamer
> > > > is handing us a pointer to a buffer that isn't aligned to a page. The
> > > > buffers size is properly rounded up to a pagesize, as requested by
> > > > QueryImageAttributes, but if the buffer start pointer isn't aligned to a
> > > > page boundary we end up with an non-mappable buffer anyway.
> > > > 
> > > > Unfortunately there is no obvious way for a driver to request a minimum
> > > > alignment for the buffer. The only possible fix is for the client to
> > > > always align the buffer to a page boundary in hopes that this is enough
> > > > for the hardware to map it directly and allow to skip any unwanted
> > > > copying.
> > > 
> > > We can't just "round up" the size.  We've no idea whether the buffer
> > > came from shmem (for XvShmPutImage), or whether it's part of an internal
> > > X buffer (for XvPutImage).  In the latter case, we've no idea whether
> > > data in the remainder of the page will be read or written by the CPU
> > > when, eg, a signal occurs - and X does use signals.
> > > 
> > I'm not talking about the driver rounding up the size. That is obviously
> > (contrary to what my patch did) the wrong thing to do.
> > 
> > I was talking of the client (as in VLC, GStreamer, whatever) aligning
> > the buffer to a page boundary. As there is no way for the client to
> > query the alignment restrictions, we may still need a fallback path in
> > the driver, so that if an unaligned buffer comes in we don't do a
> > buffer_from_userptr but actually copy client memory to a new buffer.
> 
> You really do _not_ want to do be copying image data.  With large images
> (1080p) that will consume lots of CPU, and tie up the X server doing not
> much other than copying data.  You might as well manually convert and
> copy the data to the screen at that point.
> 
So what other possibilities do we have if the client hands us a non page
aligned buffer, other than failing the PutImage? Converting the image
manually and possibly doubling the amount of bytes to write out
(YUV->RGB) will tie up the X server even longer.

This all doesn't seem to be a problem as long as the client allocates
from XShm, as this seems to hand out page aligned memory. Only if the
client mallocs the image buffer we might end up with unaligned buffers.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
