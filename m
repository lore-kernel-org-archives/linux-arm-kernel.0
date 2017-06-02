From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Thu, 1 Jun 2017 17:43:39 -0700
Subject: [PATCH v7 00/34] i.MX Media Driver
In-Reply-To: <CAJ+vNU2K1g32HTbJktLYaCGWLbPs19HSM_PMNryPBqQC-O77vw@mail.gmail.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <CAJ+vNU2K1g32HTbJktLYaCGWLbPs19HSM_PMNryPBqQC-O77vw@mail.gmail.com>
Message-ID: <8e240c2d-f762-ff04-f57b-2741cb6fab58@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On 06/01/2017 05:25 PM, Tim Harvey wrote:
> 
> 
> Hi Steve,
> 
> I've applied adv7180 device-tree config for the Gateworks ventana
> boards on top of your imx-media-staging-md-v15 github branch but am
> not able to get it to work.
> 
> Here's my device-tree patch that adds adv7180 to the GW54xx connected
> to IPU2_CSI1:
> --- a/arch/arm/boot/dts/imx6q-gw54xx.dts
> +++ b/arch/arm/boot/dts/imx6q-gw54xx.dts


I haven't studied your device-tree in detail yet, I'll try to have a
better look this weekend.

<snip>

> 
> 
> Here's my userspace test commands:
> 
> media-ctl -r # reset all links
> export outputfmt="UYVY2X8/720x480"
> # Setup links (ADV7180 IPU2_CSI1)
> media-ctl -l '"adv7180 2-0020":0 -> "ipu2_csi1_mux":1[1]'
> media-ctl -l '"ipu2_csi1_mux":2 -> "ipu2_csi1":0[1]'
> media-ctl -l '"ipu2_csi1":1 -> "ipu2_vdic":0[1]'
> media-ctl -l '"ipu2_vdic":2 -> "ipu2_ic_prp":0[1]'
> media-ctl -l '"ipu2_ic_prp":2 -> "ipu2_ic_prpvf":0[1]'
> media-ctl -l '"ipu2_ic_prpvf":1 -> "ipu2_ic_prpvf capture":0[1]'
> # Configure pads
> media-ctl -V "'adv7180 2-0020':0 [fmt:UYVY2X8/720x480]"
> media-ctl -V "'ipu2_csi1_mux':2 [fmt:UYVY2X8/720x480 field:interlaced]"
> media-ctl -V "'ipu2_csi1':1 [fmt:UYVY2X8/720x480 field:interlaced]"
> media-ctl -V "'ipu2_vdic':2 [fmt:UYVY2X8/720x480 field:none]"
> media-ctl -V "'ipu2_ic_prp':2 [fmt:AYUV32/720x480 field:none]"
> media-ctl -V "'ipu2_ic_prpvf':1 [fmt:$outputfmt field:none]"
> ^^^^ no errors up to this point; streaming can now begin on
> 'ipu2_ic_prpvf capture'
> 
> # select input
> v4l2-ctl --device /dev/video3 -i0 # 0=AIN1 1=AIN2 2=AIN3
> VIDIOC_S_INPUT: failed: Inappropriate ioctl for device
> ^^^^ /sys/class/video4linux/v4l-subdev2/name is 'ipu2_ic_prpvf
> capture' - is this not right?


Support for setting sensor inputs from the main video capture nodes
was long ago removed. Sorry about that, but there were objections to
reaching across the media graph to make this happen.

Until a VIDIOC_SUBDEV_S_INPUT is added to v4l2, you will just need to
send your analog signal to whichever ADV7180 input is active.



> 
> # select any supported YUV or RGB pixelformat on the capture device node
> v4l2-ctl --device /dev/video3
> --set-fmt-video=width=720,height=480,pixelformat=UYVY
> v4l2-ctl --device /dev/video3 --stream-mmap --stream-to=/x.raw
> --stream-count=1 # capture single raw-frame
> [  904.870444] ipu2_ic_prpvf: EOF timeout
> VIDIOC_DQBUF: failed: Input/output error
> [  905.910702] ipu2_ic_prpvf: wait last EOF timeout
> ^^^^ not getting any frames
> 
> The last patchset of yours I had running on this board was your v3
> patchset - any ideas?


Beyond maybe the input selection issue above, not really, your pipeline
config looks correct.

I have a script for the ADV7180 VDIC -> prpvf pipeline on IPU1 for the
SabreAuto, I will send to you separately to see if that helps.


> 
> As it looks like things have settled down with this patchset and it
> sounds like it will get merged for 4.13 I'm going to start working on
> a driver for the tda1997x HDMI receiver which is also on this board
> connected to IPU1_CSI0.

Awesome, thanks.

Steve
