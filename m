From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Mar 2017 21:29:55 +0000
Subject: [PATCH v4 29/36] media: imx: mipi-csi2: enable setting and
 getting of frame rates
In-Reply-To: <20170313210349.GD10701@valkosipuli.retiisi.org.uk>
References: <1487211578-11360-30-git-send-email-steve_longerbeam@mentor.com>
 <20170220220409.GX16975@valkosipuli.retiisi.org.uk>
 <20170221001332.GS21222@n2100.armlinux.org.uk>
 <25596b21-70de-5e46-f149-f9ce3a86ecb7@gmail.com>
 <1487667023.2331.8.camel@pengutronix.de>
 <20170313131647.GB10701@valkosipuli.retiisi.org.uk>
 <20170313132701.GJ21222@n2100.armlinux.org.uk>
 <1489413301.2288.53.camel@pengutronix.de>
 <27397114-7d77-2353-c526-bddd5f5297d9@gmail.com>
 <20170313210349.GD10701@valkosipuli.retiisi.org.uk>
Message-ID: <20170313212955.GO21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 11:03:50PM +0200, Sakari Ailus wrote:
> Hi Steve,
> 
> On Mon, Mar 13, 2017 at 11:06:22AM -0700, Steve Longerbeam wrote:
> > I'm kinda in the middle on this topic. I agree with Sakari that
> > frame rate can fluctuate, but that should only be temporary. If
> > the frame rate permanently shifts from what a subdev reports via
> > g_frame_interval, then that is a system problem. So I agree with
> > Phillip and Russell that a link validation of frame interval still
> > makes sense.
> > 
> > But I also have to agree with Sakari that a subdev that has no
> > control over frame rate has no business implementing those ops.
> > 
> > And then I agree with Russell that for subdevs that do have control
> > over frame rate, they would have to walk the graph to find the frame
> > rate source.
> > 
> > So we're stuck in a broken situation: either the subdevs have to walk
> > the graph to find the source of frame rate, or s_frame_interval
> > would have to be mandatory and validated between pads, same as set_fmt.
> 
> It's not broken; what we are missing though is documentation on how to
> control devices that can change the frame rate i.e. presumably drop frames
> occasionally.

It's not about "presumably drop frames occasionally."  The definition
of "occasional" is "occurring or appearing at irregular or infrequent
intervals".  Another word which describes what you're saying would be
"randomly drop frames" which would be a quite absurd "feature" to
include in hardware.

It's about _deterministically_ omitting frames from the capture.

The hardware provides two controls:
1. the size of a group of frames - between 1 and 5 frames
2. select which frames within the group are dropped using a bitmask

This gives a _regular_ pattern of dropped frames.

The rate scaling is given by: hweight(bitmask) / group size.

So, for example, if you're receiving a 50fps TV broadcast, and want to
capture at 25fps, you can set the group size to 2, and set the frame
drop to binary "01" or "10" - if it's interlaced, this would have the
effect of selecting one field, or skipping every other frame if
progressive.

That's not "we'll occasionally drop some frames", that's frame rate
scaling.  Just like you can scale the size of an image by omitting
every other pixel and every other line, this hardware allows omitting
every other frame or more.

So, to configure this feature, CSI needs to know two bits of information:

1. The _source_ frame rate.
2. The desired _sink_ frame rate.

>From that, it can compute how many frames to drop, and size of the group.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
