From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Oct 2013 20:02:11 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131016183107.GC18050@kroah.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <20131016180735.GI25034@n2100.arm.linux.org.uk>
 <20131016183107.GC18050@kroah.com>
Message-ID: <20131016190211.GJ25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 11:31:07AM -0700, Greg Kroah-Hartman wrote:
> On Wed, Oct 16, 2013 at 07:07:35PM +0100, Russell King - ARM Linux wrote:
> > Sorry, but I don't think imx-drm is driving the hardware correctly, and
> > I know that Greg wants it moved out of drivers/staging, but frankly it
> > seems to be far from ready for that.  Certainly the HDMI parts seems to
> > be especially problematical.
> 
> I want it out of staging if it's working properly.  Yours is the first
> report of it not working properly, and in fact, probably one of the
> first users of the driver, as I haven't gotten any reports of it working
> or not at all over the years.

Well, part of that is because I have this other thing called Armada DRM,
which is a similar thing to imx-drm, except for the Marvell Dove SoCs,
so it's been really quite easy to get a full Ubuntu 12.04 up and running
on the IMX SoC I have here.

As part of that effort, I'm now using my Armada DRM Xorg driver with
imx-drm to test this stuff out.  (Bearing in mind that IMX and Dove use
the same Vivante GPU, there's some sense in getting my Xorg Armada DRM
driver working on both.)

I'm not aware of there being any X drivers for imx-drm (google turns
up nothing), which might be a reason why it hasn't been well tested
and has also languished in drivers/staging for soo long.  Alternatively,
maybe my google searching sucks, or it is out there somewhere but
hidden from googlebot?

To be fair, so far most of the problems I'm finding are with the HDMI
addition to imx-drm rather than imx-drm itself: there's been the lockdep
problem and the clock polarity problem which the HDMI stuff discovered.

Looking at the todo list for moving it out of staging, we have:

- get DRM Maintainer review for this code
- Wait for common display framework to hit mainline and update the IPU
  driver to use it. This will most probably make changes to the devicetree
  bindings necessary.
- Factor out more code to common helper functions
- decide where to put the base driver. It is not specific to a subsystem
  and would be used by DRM/KMS and media/V4L2

(1) is quite a difficult task: I'm waiting for a review of the Armada DRM
stuff, which I'm hoping will make the next merge window.  Rob Clark is
looking at that but has been distracted recently from completing it.

(2) CDF... has been around in RFC according to LWN.net but doesn't seem to
make much in the way of progress from what I can see, despite there
allegedly being "many developers show[ing] interest in the first RFC".
CDF is over a year old now - first RFC 17 Aug 2012, second 22 Nov 2012,
third 9 Aug 2013.

(3) is an on-going effort and really isn't a reason for it to stay in
staging.

(4) is probably the biggest issue.  The problem there is that the IMX
display subsystem is very flexible: it's basically a set of DMA engines
on the front, and behind that a fair number of modules implementing
facilities like image rotation, display driving and image capture.
Display driving alone involves setting up waveforms and writing some
microcode to tell the thing what to do on certain events (like end
of frame etc.)  Hence it doesn't fit well into any particular "Linux"
subsystem.  In this regard, it's a victim of its own flexibility.

I think the biggest problem though is its complexity.  It doesn't fit
into the "single device for a card" model which DRM has.  It's made
up from several separate devices, which is all very well, but it leads
to it having its own private "framework" to glue all the different
devices together - which adds a layer of indirection and makes the code
harder to understand.  As for trying to work out how any of this stuff
works - even though I have the manual which describes all the registers,
I'm struggling with it because there seems to be bits which just aren't
documented and its not always obvious that the code can be relied upon
either.

That all said, I don't think throwing this out of the kernel will do
it any good what so ever - that will just mean that there's even less
potential eyes looking at it.  Yes, some of that is my own selfishness
here - I don't want to have to carry this hunk of code around in my
tree and then be lumbered with trying to get it into mainline myself!
