From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 15 Mar 2017 19:04:21 +0100
Subject: media / v4l2-mc: wishlist for complex cameras (was Re: [PATCH v4
 14/36] [media] v4l2-mc: add a function to inherit controls from a
 pipeline)
In-Reply-To: <20170314215420.6fc63c67@vento.lan>
References: <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170313124621.GA10701@valkosipuli.retiisi.org.uk>
 <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170314072143.498cde9b@vento.lan> <20170314223254.GA7141@amd>
 <20170314215420.6fc63c67@vento.lan>
Message-ID: <20170315180421.GA10206@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Well, I believe first question is: what applications would we want to
> > run on complex devices? Will sending control from video to subdevs
> > actually help?
> 
> I would say: camorama, xawtv3, zbar, google talk, skype. If it runs
> with those, it will likely run with any other application.

I'll take a look when I'm at better internet access.

> > mplayer is useful for testing... but that one already works (after you
> > setup the pipeline, and configure exposure/gain).
> > 
> > But thats useful for testing, not really for production. Image will be
> > out of focus and with wrong white balance.
> > 
> > What I would really like is an application to get still photos. For
> > taking pictures with manual settings we need
> > 
> > a) units for controls: user wants to focus on 1m, and take picture
> > with ISO200, 1/125 sec. We should also tell him that lens is f/5.6 and
> > focal length is 20mm with 5mm chip.
> > 
> > But... autofocus/autogain would really be good to have. Thus we need:
> > 
> > b) for each frame, we need exposure settings and focus position at
> > time frame was taken. Otherwise autofocus/autogain will be too
> > slow. At least focus position is going to be tricky -- either kernel
> > would have to compute focus position for us (not trivial) or we'd need
> > enough information to compute it in userspace.
> > 
> > There are more problems: hardware-accelerated preview is not trivial
> > to set up (and I'm unsure if it can be done in generic way). Still
> > photos application needs to switch resolutions between preview and
> > photo capture. Probably hardware-accelerated histograms are needed for
> > white balance, auto gain and auto focus, ....
> > 
> > It seems like there's a _lot_ of stuff to be done before we have
> > useful support for complex cameras...
> 
> Taking still pictures using a hardware-accelerated preview is
> a sophisticated use case. I don't know any userspace application
> that does that. Ok, several allow taking snapshots, by simply
> storing the image of the current frame.

Well, there are applications that take still pictures. Android has
one. Maemo has another. Then there's fcam-dev. Its open source; with
modified kernel it is fully usable. I have version that runs on recent
nearly-mainline on N900. 

So yes, I'd like solution for problems a) and b).

> > (And I'm not sure... when application such as skype is running, is
> > there some way to run autogain/autofocus/autowhitebalance? Is that
> > something we want to support?)
> 
> Autofocus no. Autogain/Autowhite can be done via libv4l, provided that
> it can access the device's controls via /dev/video devnode. Other
> applications may be using some other similar algorithms.
> 
> Ok, they don't use histograms provided by the SoC. So, they do it in
> software, with is slower. Still, it works fine when the light
> conditions don't change too fast.

I guess it is going to work well enough with higher CPU
usage. Question is if camera without autofocus is usable. I'd say "not
really".

> > I believe other question is: will not having same control on main
> > video device and subdevs be confusing? Does it actually help userspace
> > in any way? Yes, we can make controls accessible to old application,
> > but does it make them more useful? 
> 
> Yes. As I said, libv4l (and some apps) have logic inside to adjust
> the image via bright, contrast and white balance controls, using the
> video devnode. They don't talk subdev API. So, if those controls
> aren't exported, they won't be able to provide a good quality image.

Next question is if the libv4l will do the right thing if we just put
all controls to one node. For example on N900 you have exposure/gain
and brightness. But the brightness is applied at preview phase, so it
is "basically useless". You really need to adjust the image using the
exposure/gain.

> > > > In addition, I suspect end-users of these complex devices don't really care
> > > > about a plugin: they want full control and won't typically use generic
> > > > applications. If they would need support for that, we'd have seen much more
> > > > interest. The main reason for having a plugin is to simplify testing and
> > > > if this is going to be used on cheap hobbyist devkits.  
> > > 
> > > What are the needs for a cheap hobbyist devkit owner? Do we currently
> > > satisfy those needs? I'd say that having a functional driver when
> > > compiled without the subdev API, that implements the ioctl's/controls  
> > 
> > Having different interface based on config options... is just
> > weird. What about poor people (like me) trying to develop complex
> > applications?
> 
> Well, that could be done using other mechanisms, like a modprobe
> parameter or by switching the behaviour if a subdev interface is
> opened. I don't see much trouble on allowing accessing a control via
> both interfaces.

If we really want to go that way (is not modifying library to access
the right files quite easy?), I believe non-confusing option would be
to have '/dev/video0 -- omap3 camera for legacy applications' which
would include all the controls.

> > You can get Nokia N900 on aliexpress. If not, they are still available
> > between people :-)
> 
> I have one. Unfortunately, I never had a chance to use it, as the display
> stopped working one week after I get it.

Well, I guess the easiest option is to just get another one :-).

But otoh -- N900 is quite usable without the screen. 0xffff tool can
be used to boot the kernel, then you can use nfsroot and usb
networking. It also has serial port (over strange
connector). Connected over ssh over usb network is actually how I do
most of the v4l work.

Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/da50f767/attachment.sig>
