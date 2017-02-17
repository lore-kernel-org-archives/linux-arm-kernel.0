From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 Feb 2017 09:34:36 +0100
Subject: [PATCH v4 18/36] media: Add i.MX media core driver
In-Reply-To: <c22dfd68-a41c-08d2-4b8d-c7ee1884ea31@gmail.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-19-git-send-email-steve_longerbeam@mentor.com>
 <1487250123.2377.53.camel@pengutronix.de>
 <c22dfd68-a41c-08d2-4b8d-c7ee1884ea31@gmail.com>
Message-ID: <1487320476.3107.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-02-16 at 17:33 -0800, Steve Longerbeam wrote:
> 
> On 02/16/2017 05:02 AM, Philipp Zabel wrote:
> > On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
> <snip>
> >> +
> >> +- Clean up and move the ov5642 subdev driver to drivers/media/i2c, and
> >> +  create the binding docs for it.
> >
> > This is done already, right?
> 
> 
> I cleaned up ov5640 and moved it to drivers/media/i2c with binding docs,
> but not the ov5642 yet.

Ok, thanks.

> >> +- The Frame Interval Monitor could be exported to v4l2-core for
> >> +  general use.
> >> +
> >> +- The subdev that is the original source of video data (referred to as
> >> +  the "sensor" in the code), is called from various subdevs in the
> >> +  pipeline in order to set/query the video standard ({g|s|enum}_std)
> >> +  and to get/set the original frame interval from the capture interface
> >> +  ([gs]_parm). Instead, the entities that need this info should call its
> >> +  direct neighbor, and the neighbor should propagate the call to its
> >> +  neighbor in turn if necessary.
> >
> > Especially the [gs]_parm fix is necessary to present userspace with the
> > correct frame interval in case of frame skipping in the CSI.
> 
> 
> Right, understood. I've added this to list of fixes for version 5.
> 
> What a pain though! It means propagating every call to g_frame_interval
> upstream until a subdev "that cares" returns ret == 0 or
> ret != -ENOIOCTLCMD. And that goes for any other chained subdev call
> as well.

Not at all. Since the frame interval is a property of the pad, that had
to be propagated downstream by media-ctl along with media bus format,
frame size, and colorimetry earlier.

regards
Philipp
