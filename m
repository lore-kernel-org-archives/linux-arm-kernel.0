From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 21 Feb 2017 14:15:42 +0200
Subject: [PATCH v4 29/36] media: imx: mipi-csi2: enable setting and
 getting of frame rates
In-Reply-To: <6892fb15-2d18-4898-c328-3acff9d6cc39@gmail.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-30-git-send-email-steve_longerbeam@mentor.com>
 <20170220220409.GX16975@valkosipuli.retiisi.org.uk>
 <6892fb15-2d18-4898-c328-3acff9d6cc39@gmail.com>
Message-ID: <20170221121542.GH16975@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Mon, Feb 20, 2017 at 02:56:15PM -0800, Steve Longerbeam wrote:
> 
> 
> On 02/20/2017 02:04 PM, Sakari Ailus wrote:
> >Hi Steve,
> >
> >On Wed, Feb 15, 2017 at 06:19:31PM -0800, Steve Longerbeam wrote:
> >>From: Russell King <rmk+kernel@armlinux.org.uk>
> >>
> >>Setting and getting frame rates is part of the negotiation mechanism
> >>between subdevs.  The lack of support means that a frame rate at the
> >>sensor can't be negotiated through the subdev path.
> >
> >Just wondering --- what do you need this for?
> 
> 
> Hi Sakari,
> 
> i.MX does need the ability to negotiate the frame rates in the
> pipelines. The CSI has the ability to skip frames at the output,
> which is something Philipp added to the CSI subdev. That affects
> frame interval at the CSI output.
> 
> But as Russell pointed out, the lack of [gs]_frame_interval op
> causes media-ctl to fail:
> 
> media-ctl -v -d /dev/media1 --set-v4l2
> '"imx6-mipi-csi2":1[fmt:SGBRG8/512x512 at 1/30]'
> 
> Opening media device /dev/media1
> Enumerating entities
> Found 29 entities
> Enumerating pads and links
> Setting up format SGBRG8 512x512 on pad imx6-mipi-csi2/1
> Format set: SGBRG8 512x512
> Setting up frame interval 1/30 on entity imx6-mipi-csi2
> Unable to set frame interval: Inappropriate ioctl for device (-25)Unable to
> setup formats: Inappropriate ioctl for device (25)
> 
> 
> So i.MX needs to implement this op in every subdev in the
> pipeline, otherwise it's not possible to configure the
> pipeline with media-ctl.

The frame rate is only set on the sub-device which you explicitly set it.
I.e. setting the frame rate fails if it's not supported on a pad.

Philipp recently posted patches that add frame rate propagation to
media-ctl.

Frame rate is typically settable (and gettable) only on sensor sub-device's
source pad, which means it normally would not be propagated by the kernel
but with Philipp's patches, on the sink pad of the bus receiver. Receivers
don't have a way to control it nor they implement the IOCTLs, so that would
indeed result in an error.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
