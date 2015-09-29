From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 29 Sep 2015 11:01:51 +0200
Subject: xf86-video-armada + etnaviv (Was: Re: I.MX6 HDMI support in v4.2)
In-Reply-To: <20150929084141.GH21513@n2100.arm.linux.org.uk>
References: <m3bnd52y4s.fsf@t19.piap.pl>
 <1442332425.2637.16.camel@pengutronix.de>
 <20150915163642.GW21084@n2100.arm.linux.org.uk>
 <1442336034.2637.20.camel@pengutronix.de>
 <20150915170444.GX21084@n2100.arm.linux.org.uk>
 <1443451688.3178.61.camel@pengutronix.de>
 <20150928152429.GW21513@n2100.arm.linux.org.uk>
 <1443454813.3178.66.camel@pengutronix.de>
 <20150928165021.GY21513@n2100.arm.linux.org.uk>
 <1443515299.3141.4.camel@pengutronix.de>
 <20150929084141.GH21513@n2100.arm.linux.org.uk>
Message-ID: <1443517311.3141.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 29.09.2015, 09:41 +0100 schrieb Russell King - ARM
Linux:
> On Tue, Sep 29, 2015 at 10:28:19AM +0200, Lucas Stach wrote:
> > Am Montag, den 28.09.2015, 17:50 +0100 schrieb Russell King - ARM Linux:
> > > You really do _not_ want to do be copying image data.  With large images
> > > (1080p) that will consume lots of CPU, and tie up the X server doing not
> > > much other than copying data.  You might as well manually convert and
> > > copy the data to the screen at that point.
> > > 
> > So what other possibilities do we have if the client hands us a non page
> > aligned buffer, other than failing the PutImage? Converting the image
> > manually and possibly doubling the amount of bytes to write out
> > (YUV->RGB) will tie up the X server even longer.
> 
> Are you sure about that?
> 
> If you memcpy() the buffer, you have to read about 6MB of data, write
> 6MB of data, flush the caches of that, then ask the GPU to perform two
> blits (which on my measurements just about fit in one field scan), wait
> for the blit to finish before then returning to the client.
> 
The cache flush can easily be avoided if you copy into a WC buffer.

And I don't see why we would need to wait for the blit to finish before
returning to the client. If we copy the userdata there is no need to
block the client until the GPU is done with the data.

Or is there something in the spec I'm not aware of which would mandate
such blocking?

> I can tell you that VLC uses memcpy() on images internally, and you can't
> get away with it for 1080p video.
> 
I'm not disputing that it's a really bad idea if you care about
performance.

> > This all doesn't seem to be a problem as long as the client allocates
> > from XShm, as this seems to hand out page aligned memory. Only if the
> > client mallocs the image buffer we might end up with unaligned buffers.
> 
> I don't see that.  How does a malloc()'d buffer get to the X server,
> other than throuh XvPutImage?  If you're using XvPutImage(), you'll
> be incurring an even _larger_ overhead because the kernel will have
> to copy the image data as well.  AFAIK, you can't pass arbitary malloc()d
> buffers to sysvipc and therefore via XShm.
> 
Right I'm talking about XvPutImage. I'm not saying it is a good way to
hand off your image data to the X server, all I'm saying is that this is
a path that applications _might_ use.

We can just choose to ignore this for the time being, as it's a
non-issue if the client is using XShm.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
