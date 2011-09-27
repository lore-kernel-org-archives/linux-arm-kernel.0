From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 27 Sep 2011 20:06:29 +0200
Subject: [PATCH 4/8] ispvideo: Add support for G/S/ENUM_STD ioctl
In-Reply-To: <19F8576C6E063C45BE387C64729E739404EC8113E2@dbde02.ent.ti.com>
References: <1315488922-16152-1-git-send-email-deepthy.ravi@ti.com>
	<201109161506.16505.laurent.pinchart@ideasonboard.com>
	<19F8576C6E063C45BE387C64729E739404EC8113E2@dbde02.ent.ti.com>
Message-ID: <201109272006.30130.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

On Monday 19 September 2011 17:31:02 Hiremath, Vaibhav wrote:
> On Friday, September 16, 2011 6:36 PM Laurent Pinchart wrote:
> > On Friday 16 September 2011 15:00:53 Ravi, Deepthy wrote:
> > > On Thursday, September 08, 2011 10:51 PM Laurent Pinchart wrote:
> > > > On Thursday 08 September 2011 15:35:22 Deepthy Ravi wrote:
> > > >> From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > >> 
> > > >> In order to support TVP5146 (for that matter any video decoder),
> > > >> it is important to support G/S/ENUM_STD ioctl on /dev/videoX
> > > >> device node.
> > > > 
> > > > Why so ? Shouldn't it be queried on the subdev output pad directly ?
> > > 
> > > Because standard v4l2 application for analog devices will call these
> > > std ioctls on the streaming device node. So it's done on /dev/video to
> > > make the existing apllication work.
> > 
> > Existing applications can't work with the OMAP3 ISP (and similar complex
> > embedded devices) without userspace support anyway, either in the form of
> > a GStreamer element or a libv4l plugin. I still believe that analog video
> > standard operations should be added to the subdev pad operations and
> > exposed through subdev device nodes, exactly as done with formats.
> 
> I completely agree with your point that, existing application will not work
> without setting links properly. But I believe the assumption here is,
> media-controller should set the links (along with pad formants) and all
> existing application should work as is. Isn't it?

The media controller is an API used (among other things) to set the links. You 
still need to call it from userspace. That won't happen magically. The 
userspace component that sets up the links and configures the formats, be it a 
GStreamer element, a libv4l plugin, or something else, can as well setup the 
standard on the TVP5146 subdev.

> The way it is being done currently is, set the format at the pad level
> which is same as analog standard resolution and use existing application
> for streaming...

At then end of the OMAP3 ISP pipeline video data has long lost its analog 
roots. I don't think standards make sense there.

> I am ok, if we add s/g/enum_std api support at sub-dev level but this
> should also be supported on streaming device node.

-- 
Regards,

Laurent Pinchart
