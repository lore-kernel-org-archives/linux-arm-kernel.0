From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 13:57:56 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m3y4gh41k4.fsf@t19.piap.pl>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
 <m3y4gh41k4.fsf@t19.piap.pl>
Message-ID: <20150908125756.GY21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 01:01:47PM +0200, Krzysztof Ha?asa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > That's probably because of the restrictions in the IPU - the mainline
> > IPU code is unable to scale overlays at all - it's not supported.  The
> > problem is most Xorg drivers assume that overlays can be scaled.  I've
> > said about this before, and how this is broken, but I've no idea whether
> > it's going to get fixed.  As far as I know, this only affects platforms
> > using the IPU.
> 
> I see. But I'm ok with unscaled Xvideo. I only need a (fast) way to send
> YUV (preferably YUV420) image to the screen.

Note that most (all?) video requires some scaling.  A 720x576 video on
square pixels needs to be scaled to 768x576, but at "modern" aspect
ratio of 16:9, it needs to be scaled horizontally to 1024x576.

This pretty much makes the video overlay which imx-drm publishes to
userspace as useful as a chocolate teapot.  I suppose you could eat the
chocolate teapot, but it's not useful for its intended purpose of making
tea.

> > The only alternative there is to switch to using the GPU to blit the
> > XVideo frame onto the display (but then you need all the etnaviv bits
> > in place, including the etnaviv DRM driver.)  This works up to a point,
> > but suffers from tearing, because there's no sane good way to synchronise
> > the GPU blit with the video scanout (because they're two different
> > completely unrelated chunks of hardware: the reason Intel i965 can do
> > this is because it seems possible to put into the GPU stream "wait for
> > scan line X before continuing" thereby preventing the blit modifying
> > scanlines that are about to be displayed.
> 
> This could be the horizontal lines that I observed. Something similar
> to what the old S3 Trio64 were doing.

They're probably not the tearing - tearing is where you scan out part of
the old frame and part of the new frame, which appears as a particularly
noticable effect on scenes with a lot of change.

Horizontal lines which are significantly different (eg, short black lines)
will be CPU cache corruption - both the main etnaviv DRM and Lucas' "fixed"
cache handling suffer from this.  My patch set doesn't.

 git://ftp.arm.linux.org.uk/~rmk/linux-arm.git drm-etnaviv-devel

contains my code.

Etnaviv DRM development has stalled because of Pengutronix, and their
attitude towards open source development - which is to develop their
patches behind closed doors, and publish part of a story once in a blue
moon.  (Sorry Lucas, but Pengutronix has this criticism coming.)  Both
myself and Christian have tried to get more of their work out in the
open, and failed.  I think Christian has stopped work on the project
completely because of this, as he doesn't want to waste time duplicating
effort.  I've certainly asked for Lucas' modifications to my Xorg driver,
and got nowhere (I've had to update it myself, to align the kernel/user
API with Pengutronix' efforts.)  I think Christian has virtually given
up on it because of the lack of communication.

Etnaviv DRM is not a happy place to be right now, because of Pengutronix'
involvement in it, and their lack of sharing.  The only thing that they've
shared so far is a set of kernel patches.  Everything else is kept behind
their closed doors.

I think part of this is because Pengutronix want to be ones to claim "oh
look what we've done for the community" all the time - I see that a lot
on google+, where they're always posting "this is what we did in Linux
4.whatever" and they don't want anyone taking away their "thunder".
Quite sad really, because it means that development is actually being
hindered by such an approach, and people are getting pissed off with it.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
