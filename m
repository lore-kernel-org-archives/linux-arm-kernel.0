From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Sep 2015 09:41:41 +0100
Subject: xf86-video-armada + etnaviv (Was: Re: I.MX6 HDMI support in v4.2)
In-Reply-To: <1443515299.3141.4.camel@pengutronix.de>
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
Message-ID: <20150929084141.GH21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 10:28:19AM +0200, Lucas Stach wrote:
> Am Montag, den 28.09.2015, 17:50 +0100 schrieb Russell King - ARM Linux:
> > You really do _not_ want to do be copying image data.  With large images
> > (1080p) that will consume lots of CPU, and tie up the X server doing not
> > much other than copying data.  You might as well manually convert and
> > copy the data to the screen at that point.
> > 
> So what other possibilities do we have if the client hands us a non page
> aligned buffer, other than failing the PutImage? Converting the image
> manually and possibly doubling the amount of bytes to write out
> (YUV->RGB) will tie up the X server even longer.

Are you sure about that?

If you memcpy() the buffer, you have to read about 6MB of data, write
6MB of data, flush the caches of that, then ask the GPU to perform two
blits (which on my measurements just about fit in one field scan), wait
for the blit to finish before then returning to the client.

I can tell you that VLC uses memcpy() on images internally, and you can't
get away with it for 1080p video.

> This all doesn't seem to be a problem as long as the client allocates
> from XShm, as this seems to hand out page aligned memory. Only if the
> client mallocs the image buffer we might end up with unaligned buffers.

I don't see that.  How does a malloc()'d buffer get to the X server,
other than throuh XvPutImage?  If you're using XvPutImage(), you'll
be incurring an even _larger_ overhead because the kernel will have
to copy the image data as well.  AFAIK, you can't pass arbitary malloc()d
buffers to sysvipc and therefore via XShm.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
