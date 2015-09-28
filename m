From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 28 Sep 2015 16:48:08 +0200
Subject: xf86-video-armada + etnaviv (Was: Re: I.MX6 HDMI support in v4.2)
In-Reply-To: <20150915170444.GX21084@n2100.arm.linux.org.uk>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl> <1442332425.2637.16.camel@pengutronix.de>
 <20150915163642.GW21084@n2100.arm.linux.org.uk>
 <1442336034.2637.20.camel@pengutronix.de>
 <20150915170444.GX21084@n2100.arm.linux.org.uk>
Message-ID: <1443451688.3178.61.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 15.09.2015, 18:04 +0100 schrieb Russell King - ARM
Linux:
> On Tue, Sep 15, 2015 at 12:53:54PM -0400, Lucas Stach wrote:
> > Hi Russell,
> > 
> > Am Dienstag, den 15.09.2015, 17:36 +0100 schrieb Russell King - ARM
> > Linux:
> > > On Tue, Sep 15, 2015 at 05:53:45PM +0200, Lucas Stach wrote:
> > > > It includes a new kernel<->userspace interface, so needs a modified
> > > > xf86-video-armada to go with it. You can pick that up here:
> > > > git://git.pengutronix.de/git/lst/xf86-video-armada.git for-rmk
> > > > 
> > > > Caution: the armada code is WIP and needs further cleanups. It
> > > > should
> > > > work though.
> > > 
> > > And it needs updating to the latest version - you seem to be missing
> > > a whole load of changes, including the changes which update the
> > > kernel API.
> > > 
> > > So... you seem to be talking about the kernel API having changed from
> > > the version which you picked up years ago, rather than the current
> > > version.  It's really unclear what you're talking about.
> > > 
> > What do you mean with missing a lot of stuff? The "for-rmk" branch in
> > that repo is your upstream "unstable-devel" branch minus the few XvBO
> > commits with my changes on top.
> 
> Ah, probably because I haven't pushed the stuff out :)
> 
> Anyway, I've taken two of your patches, reworking the second slightly:
> 
> 1fec728 etnaviv: fix compilation without DRI2 support
> 1663382 make sure that system strndup doesn't collide with X.Org server version
> 
> which are _both_ fixes, and would have been nice for them to have been
> sent in a timely manner.
> 
> Looking at "etnaviv: fix XV resize for UYVY source format", this is wrong
> to the documentation for the GC320.  Documentation which was around for
> the GC320 indicates that the _only_ YUV format it supports as a target
> is YUY2 with the vertical filter blit.  It's very specifically worded to
> indicate that this is the only YUV target format which is supported.
> What testing have you done to prove uyvy support, and on which GPUs?
> 
> "etnaviv: align vximage buffer size to pagesize" I have issues with as
> well - mapping more memory than was passed to the X server is really not
> permissible.  If we need the image size to be larger, we need to report
> a larger buffer size - and in fact, that's already done.
> QueryImageAttributes indicates that the image size is to be rounded
> up to a page size.  The X server will reject smaller buffers at higher
> levels.  So, this patch isn't required.
> 
I've looked at that again and the issue here seems to be that GStreamer
is handing us a pointer to a buffer that isn't aligned to a page. The
buffers size is properly rounded up to a pagesize, as requested by
QueryImageAttributes, but if the buffer start pointer isn't aligned to a
page boundary we end up with an non-mappable buffer anyway.

Unfortunately there is no obvious way for a driver to request a minimum
alignment for the buffer. The only possible fix is for the client to
always align the buffer to a page boundary in hopes that this is enough
for the hardware to map it directly and allow to skip any unwanted
copying.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
