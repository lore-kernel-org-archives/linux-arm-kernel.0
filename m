From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 Mar 2017 13:02:07 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170317114203.GZ21222@n2100.armlinux.org.uk>
References: <20170310130733.GU21222@n2100.armlinux.org.uk>
 <c679f755-52a6-3c6f-3d65-277db46676cc@xs4all.nl>
 <20170310140124.GV21222@n2100.armlinux.org.uk>
 <cc8900b0-c091-b14b-96f4-01f8fa72431c@xs4all.nl>
 <20170310125342.7f047acf@vento.lan>
 <20170310223714.GI3220@valkosipuli.retiisi.org.uk>
 <20170311082549.576531d0@vento.lan>
 <20170313124621.GA10701@valkosipuli.retiisi.org.uk>
 <20170314004533.3b3cd44b@vento.lan>
 <e0a6c60b-1735-de0b-21f4-d8c3f4b3f10f@xs4all.nl>
 <20170317114203.GZ21222@n2100.armlinux.org.uk>
Message-ID: <1489752127.2905.49.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 11:42 +0000, Russell King - ARM Linux wrote:
> On Tue, Mar 14, 2017 at 08:55:36AM +0100, Hans Verkuil wrote:
> > We're all very driver-development-driven, and userspace gets very little
> > attention in general. So before just throwing in the towel we should take
> > a good look at the reasons why there has been little or no development: is
> > it because of fundamental design defects, or because nobody paid attention
> > to it?
> > 
> > I strongly suspect it is the latter.
> > 
> > In addition, I suspect end-users of these complex devices don't really care
> > about a plugin: they want full control and won't typically use generic
> > applications. If they would need support for that, we'd have seen much more
> > interest. The main reason for having a plugin is to simplify testing and
> > if this is going to be used on cheap hobbyist devkits.
> 
> I think you're looking at it with a programmers hat on, not a users hat.
> 
> Are you really telling me that requiring users to 'su' to root, and then
> use media-ctl to manually configure the capture device is what most
> users "want" ?
> 
> Hasn't the way technology has moved towards graphical interfaces,
> particularly smart phones, taught us that the vast majority of users
> want is intuitive, easy to use interfaces, and not the command line
> with reams of documentation?
> 
> Why are smart phones soo popular - it's partly because they're flashy,
> but also because of the wealth of apps, and apps which follow the
> philosophy of "do one job, do it well" (otherwise they get bad reviews.)

> > An additional complication is simply that it is hard to find fully supported
> > MC hardware. omap3 boards are hard to find these days, renesas boards are not
> > easy to get, freescale isn't the most popular either. Allwinner, mediatek,
> > amlogic, broadcom and qualcomm all have closed source implementations or no
> > implementation at all.
> 
> Right, and that in itself tells us something - the problem that we're
> trying to solve is not one that commonly exists in the real world.
> 
> Yes, the hardware we have in front of us may be very complex, but if
> there's very few systems out there which are capable of making use of
> all that complexity, then we're trying to solve a problem that isn't
> the common case - and if it's going to take years to solve it (it
> already has taken years) then it's the wrong problem to be solved.
> 
> I bet most of the problem can be eliminated if, rather than exposing
> all this complexity, we instead expose a simpler capture system where
> the board designer gets to "wire up" the capture system.
> 
> I'll go back to my Bayer example, because that's the simplest.  As
> I've already said many times in these threads, there is only one
> possible path through the iMX6 device that such a source can be used
> with - it's a fixed path.  The actual path depends on the CSI2
> virtual channel that the camera has been _configured_ to use, but
> apart from that, it's effectively a well known set of blocks.  Such
> a configuration could be placed in DT.
> 
> For RGB connected to a single parallel CSI, things get a little more
> complex - capture through the CSI or through two other capture devices
> for de-interlacing or other features.  However, I'm not convinced that
> exposing multiple /dev/video* devices for different features for the
> same video source is a sane approach - I think that's a huge usability
> problem.  (The user is expected to select the capture device on iMX6
> depending on the features they want, and if they want to change features,
> they're expected to shut down their application and start it up on a
> different capture device.)  For the most part on iMX6, there's one
> path down to the CSI block, and then there's optional routing through
> the rest of the IPU depending on what features you want (such as
> de-interlacing.)
>
> The complex case is a CSI2 connected camera which produces multiple
> streams through differing virtual channels - and that's IMHO the only
> case where we need multiple different /dev/video* capture devices to
> be present.

I wanted to have the IC PRP outputs separate because the IC PRP should
support running both the VF and ENC tasks with different parameters from
the same input. That would allow to capture two different resolutions
(up to 1024x1024) at the same time.

I think most of the simple, fixed pipeline use cases could be handled by
libv4l2, by allowing to pass a v4l2 subdevice path to v4l2_open. If that
function internally would set up the media links to the
nearest /dev/video interface, propagate format, resolution and frame
intervals if necessary, and return an fd to the video device, there'd be
no additional complexity for the users beyond selecting the v4l2_subdev
instead of the video device.

regards
Philipp
