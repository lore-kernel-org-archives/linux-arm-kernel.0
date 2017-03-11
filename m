From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 11 Mar 2017 22:52:56 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170311082549.576531d0@vento.lan>
References: <20170303230645.GR21222@n2100.armlinux.org.uk>
 <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310130733.GU21222@n2100.armlinux.org.uk>
 <c679f755-52a6-3c6f-3d65-277db46676cc@xs4all.nl>
 <20170310140124.GV21222@n2100.armlinux.org.uk>
 <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
Message-ID: <20170311215256.GB7319@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > The rationale is that we should support the simplest use cases first.
> > > 
> > > In the case of the first MC-based driver (and several subsequent
> > > ones), the simplest use case required MC, as it was meant to suport
> > > a custom-made sophisticated application that required fine control
> > > on each component of the pipeline and to allow their advanced
> > > proprietary AAA userspace-based algorithms to work.  
> > 
> > The first MC based driver (omap3isp) supports what the hardware can do, it
> > does not support applications as such.
> 
> All media drivers support a subset of what the hardware can do. The
> question is if such subset covers the use cases or not.
> 
> The current MC-based drivers (except for uvc) took a patch to offer a
> more advanced API, to allow direct control to each IP module, as it was
> said, by the time we merged the OMAP3 driver, that, for the N9/N900 camera
> to work, it was mandatory to access the pipeline's individual components.
> 
> Such approach require that some userspace software will have knowledge
> about some hardware details, in order to setup pipelines and send controls
> to the right components. That makes really hard to have a generic user
> friendly application to use such devices.

Well. Even if you propagate controls to the right components, there's
still a lot application needs to know about the camera
subsystem. Focus lengths, for example. Speed of the focus
coil. Whether or not aperture controls are available. If they are not,
what is the fixed aperture.

Dunno. Knowing what control to apply on what subdevice does not look
like the hardest part of camera driver. Yes, it would be a tiny bit
easier if I would have just one device to deal with, but.... fcam-dev
has cca 20000 lines of C++ code. 

> In the case of V4L2 controls, when there's no subdev API, the main
> driver (e. g. the driver that creates the /dev/video nodes) sends a
> multicast message to all bound I2C drivers. The driver(s) that need 
> them handle it. When the same control may be implemented on different
> drivers, the main driver sends a unicast message to just one
> driver[1].

Dunno. There's quite common to have two flashes. In that case, will
application control both at the same time?

> There's nothing wrong with this approach: it works, it is simpler,
> it is generic. So, if it covers most use cases, why not allowing it
> for usecases where a finer control is not a requirement?

Because the resulting interface is quite ugly?

> That's why I'm saying that I'm OK on merging any patch that would allow
> setting controls via the /dev/video interface on MC-based drivers when
> compiled without subdev API. I may also consider merging patches allowing

So.. userspace will now have to detect if subdev is available or not,
and access hardware in different ways?

> > The original plan was and continues to be sound, it's just that there have
> > always been too few hands to implement it. :-(
> 
> If there are no people to implement a plan, it doesn't matter how good
> the plan is, it won't work.

If the plan is good, someone will do it.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170311/4438a42a/attachment.sig>
