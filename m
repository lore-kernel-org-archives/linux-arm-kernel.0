From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 17 Oct 2013 10:27:30 +0200
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131016190211.GJ25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <20131016180735.GI25034@n2100.arm.linux.org.uk>
 <20131016183107.GC18050@kroah.com>
 <20131016190211.GJ25034@n2100.arm.linux.org.uk>
Message-ID: <1381998450.4093.36.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Mittwoch, den 16.10.2013, 20:02 +0100 schrieb Russell King - ARM
Linux:
> On Wed, Oct 16, 2013 at 11:31:07AM -0700, Greg Kroah-Hartman wrote:
> > On Wed, Oct 16, 2013 at 07:07:35PM +0100, Russell King - ARM Linux wrote:
> > > Sorry, but I don't think imx-drm is driving the hardware correctly, and
> > > I know that Greg wants it moved out of drivers/staging, but frankly it
> > > seems to be far from ready for that.  Certainly the HDMI parts seems to
> > > be especially problematical.
> > 
> > I want it out of staging if it's working properly.  Yours is the first
> > report of it not working properly, and in fact, probably one of the
> > first users of the driver, as I haven't gotten any reports of it working
> > or not at all over the years.
> 
> Well, part of that is because I have this other thing called Armada DRM,
> which is a similar thing to imx-drm, except for the Marvell Dove SoCs,
> so it's been really quite easy to get a full Ubuntu 12.04 up and running
> on the IMX SoC I have here.
> 
> As part of that effort, I'm now using my Armada DRM Xorg driver with
> imx-drm to test this stuff out.  (Bearing in mind that IMX and Dove use
> the same Vivante GPU, there's some sense in getting my Xorg Armada DRM
> driver working on both.)
> 
> I'm not aware of there being any X drivers for imx-drm (google turns
> up nothing), which might be a reason why it hasn't been well tested
> and has also languished in drivers/staging for soo long.  Alternatively,
> maybe my google searching sucks, or it is out there somewhere but
> hidden from googlebot?
> 

X.Org isn't the center of the world anymore. For some general purpose
distros this might still hold true for some time, but certainly not for
the use-cases we test this driver with.

For most of our embedded use-cases we currently use the FBdev emulation
(phasing this out at the moment) or the apps are sitting right on top of
the raw KMS APIs, rather than on top of a display server.
We also did some experiments with Wayland (Weston) on top of imx-drm,
which worked quite well.

There might be dragons hiding in some corners for the more general
purpose use-cases and we are happy to have you test the driver and
provide valuable reports.

> To be fair, so far most of the problems I'm finding are with the HDMI
> addition to imx-drm rather than imx-drm itself: there's been the lockdep
> problem and the clock polarity problem which the HDMI stuff discovered.
> 
> Looking at the todo list for moving it out of staging, we have:
> 
> - get DRM Maintainer review for this code
> - Wait for common display framework to hit mainline and update the IPU
>   driver to use it. This will most probably make changes to the devicetree
>   bindings necessary.
> - Factor out more code to common helper functions
> - decide where to put the base driver. It is not specific to a subsystem
>   and would be used by DRM/KMS and media/V4L2
> 
> (1) is quite a difficult task: I'm waiting for a review of the Armada DRM
> stuff, which I'm hoping will make the next merge window.  Rob Clark is
> looking at that but has been distracted recently from completing it.
> 
> (2) CDF... has been around in RFC according to LWN.net but doesn't seem to
> make much in the way of progress from what I can see, despite there
> allegedly being "many developers show[ing] interest in the first RFC".
> CDF is over a year old now - first RFC 17 Aug 2012, second 22 Nov 2012,
> third 9 Aug 2013.
> 

Philipp has a prototype of CDF on imx-drm working internally and I
suspect he will be able to post patches shortly after ELCE.

> (3) is an on-going effort and really isn't a reason for it to stay in
> staging.
> 
> (4) is probably the biggest issue.  The problem there is that the IMX
> display subsystem is very flexible: it's basically a set of DMA engines
> on the front, and behind that a fair number of modules implementing
> facilities like image rotation, display driving and image capture.
> Display driving alone involves setting up waveforms and writing some
> microcode to tell the thing what to do on certain events (like end
> of frame etc.)  Hence it doesn't fit well into any particular "Linux"
> subsystem.  In this regard, it's a victim of its own flexibility.

We are aiming to do the same thing as the Tegra host1x driver: move the
IPU core to drivers/gpu and export API for other drivers to use. This
may mean we still have to keep the DRM part in staging (at least until
the CDF thing is sorted, as this prevents us from setting the devicetree
bindings in stone), but at least should be a step in the right
direction.

Regards,
Lucas

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
