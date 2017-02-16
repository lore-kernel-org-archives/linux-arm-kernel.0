From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 16 Feb 2017 10:30:56 -0800
Subject: [PATCH v4 00/36] i.MX Media Driver
In-Reply-To: <20170216113758.GK27312@n2100.armlinux.org.uk>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <20170216113758.GK27312@n2100.armlinux.org.uk>
Message-ID: <67a4fa15-2745-a5e9-e894-be05150c3dac@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/16/2017 03:37 AM, Russell King - ARM Linux wrote:
> Two problems.
>
> On Wed, Feb 15, 2017 at 06:19:02PM -0800, Steve Longerbeam wrote:
>>   media: imx: propagate sink pad formats to source pads
>
> 1) It looks like all cases aren't being caught:
>
> - entity 74: ipu1_csi0 (3 pads, 4 links)
>              type V4L2 subdev subtype Unknown flags 0
>              device node name /dev/v4l-subdev13
>         pad0: Sink
>                 [fmt:SRGGB8/816x616 field:none]
>                 <- "ipu1_csi0_mux":2 [ENABLED]
>         pad1: Source
>                 [fmt:AYUV32/816x616 field:none
>                  crop.bounds:(0,0)/816x616
>                  crop:(0,0)/816x616]
>                 -> "ipu1_ic_prp":0 []
>                 -> "ipu1_vdic":0 []
>         pad2: Source
>                 [fmt:SRGGB8/816x616 field:none
>                  crop.bounds:(0,0)/816x616
>                  crop:(0,0)/816x616]
>                 -> "ipu1_csi0 capture":0 [ENABLED]
>
> While the size has been propagated to pad1, the format has not.

Right, Philipp also caught this. I need to finish propagating all
params from sink to source pads (mbus code and field, and colorimetry
eventually).

>
> 2) /dev/video* device node assignment
>
> I've no idea at the moment how the correct /dev/video* node should be
> chosen - initially with Philipp and your previous code, it was
> /dev/video3 after initial boot.  Philipp's was consistently /dev/video3.
> Yours changed to /dev/video7 when removing and re-inserting the modules
> (having fixed that locally.)  This version makes CSI0 be /dev/video7,
> but after a remove+reinsert, it becomes (eg) /dev/video8.
>
> /dev/v4l/by-path/platform-capture-subsystem-video-index4 also is not a
> stable path - the digit changes (it's supposed to be a stable path.)
> After a remove+reinsert, it becomes (eg)
> /dev/v4l/by-path/platform-capture-subsystem-video-index5.
> /dev/v4l/by-id doesn't contain a symlink for this either.
>
> What this means is that it's very hard to script the setup, because
> there's no easy way to know what device is the capture device.  While
> it may be possible to do:
>
> 	media-ctl -d /dev/media1 -p | \
> 		grep -A2 ': ipu1_csi0 capture' | \
> 			sed -n 's|.*\(/dev/video[0-9]*\).*|\1|p'
>
> that's hardly a nice solution - while it fixes the setup script, it
> doesn't stop the pain of having to delve around to find the correct
> device to use for gstreamer to test with.
>

I'll try to nail down the main capture node numbers, even after module
reload.

Steve
