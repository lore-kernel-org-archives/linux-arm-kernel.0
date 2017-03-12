From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Sun, 12 Mar 2017 17:59:28 -0300
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170312194700.GR21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170312194700.GR21222@n2100.armlinux.org.uk>
Message-ID: <20170312175923.6ad86dff@vento.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Sun, 12 Mar 2017 19:47:00 +0000
Russell King - ARM Linux <linux@armlinux.org.uk> escreveu:

> Another issue.
> 
> The "reboot and the /dev/video* devices come up in a completely
> different order" problem seems to exist with this version.
> 
> The dot graph I supplied previously had "ipu1_csi0 capture" on
> /dev/video4.  I've just rebooted, and now I find it's on
> /dev/video2 instead.
> 
> Here's the extract from the .dot file of the old listing:
> 
>         n00000018 [label="ipu1_ic_prpenc capture\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
>         n00000021 [label="ipu1_ic_prpvf capture\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
>         n0000002e [label="ipu2_ic_prpenc capture\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
>         n00000037 [label="ipu2_ic_prpvf capture\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
>         n00000048 [label="ipu1_csi0 capture\n/dev/video4", shape=box, style=filled, fillcolor=yellow]
>         n00000052 [label="ipu1_csi1 capture\n/dev/video5", shape=box, style=filled, fillcolor=yellow]
>         n00000062 [label="ipu2_csi0 capture\n/dev/video6", shape=box, style=filled, fillcolor=yellow]
>         n0000006c [label="ipu2_csi1 capture\n/dev/video7", shape=box, style=filled, fillcolor=yellow]
> 
> and here's the same after reboot:
> 
>         n00000014 [label="ipu1_csi0 capture\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
>         n0000001e [label="ipu1_csi1 capture\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
>         n00000028 [label="ipu2_csi0 capture\n/dev/video4", shape=box, style=filled, fillcolor=yellow]
>         n00000035 [label="ipu1_ic_prpenc capture\n/dev/video5", shape=box, style=filled, fillcolor=yellow]
>         n0000003e [label="ipu1_ic_prpvf capture\n/dev/video6", shape=box, style=filled, fillcolor=yellow]
>         n0000004c [label="ipu2_csi1 capture\n/dev/video7", shape=box, style=filled, fillcolor=yellow]
>         n00000059 [label="ipu2_ic_prpenc capture\n/dev/video8", shape=box, style=filled, fillcolor=yellow]
>         n00000062 [label="ipu2_ic_prpvf capture\n/dev/video9", shape=box, style=filled, fillcolor=yellow]
> 
> (/dev/video0 and /dev/video1 are taken up by CODA, since I updated the
> names of the firmware files, and now CODA initialises... seems the
> back-compat filenames don't work, but that's not a problem with imx6
> capture.)
> 

Didn't have time yet to read/comment the other e-mails in this thread.

Yet, as this is a simple issue, let me answer it first.

With regards to /dev/video?, the device number depends on the probing 
order, with can be random on SoC drivers, due to the way OF works. 

Yet, udev/systemd has some rules that provide an unique name for V4L
devices at /lib/udev/rules.d/60-persistent-v4l.rules. Basically, it
runs a small application (v4l_id) with creates a persistent symling
using rules like this:

	KERNEL=="video*", ENV{ID_SERIAL}=="?*", SYMLINK+="v4l/by-id/$env{ID_BUS}-$env{ID_SERIAL}-video-index$attr{index}"

Those names are stored at /dev/v4l/by-path.

For example, on Exynos, we have:

$ ls -lctra /dev/v4l/by-path/
total 0
lrwxrwxrwx 1 root root  12 Mar 11 07:19 platform-13e10000.video-scaler-video-index0 -> ../../video7
lrwxrwxrwx 1 root root  12 Mar 11 07:19 platform-13e00000.video-scaler-video-index0 -> ../../video6
lrwxrwxrwx 1 root root  12 Mar 11 07:19 platform-11f60000.jpeg-video-index0 -> ../../video4
lrwxrwxrwx 1 root root  12 Mar 11 07:19 platform-11f50000.jpeg-video-index1 -> ../../video3
lrwxrwxrwx 1 root root  12 Mar 11 07:19 platform-11f50000.jpeg-video-index0 -> ../../video2
drwxr-xr-x 3 root root  60 Mar 11 07:19 ..
lrwxrwxrwx 1 root root  12 Mar 11 07:19 platform-11f60000.jpeg-video-index1 -> ../../video5
lrwxrwxrwx 1 root root  12 Mar 11 07:19 platform-11000000.codec-video-index1 -> ../../video1
lrwxrwxrwx 1 root root  12 Mar 11 07:19 platform-11000000.codec-video-index0 -> ../../video0

No matter what driver gets probed first, the above names should not
change.

So, if you want to write a script, the best is to use the /dev/v4l/by-path.

Unfortunately, gstreamer has some issues with that, as some of their plugins
don't seem to allow passing the name of the devnode, but just the number of
/dev/video?.

So, you need some script to convert from /dev/v4l/by-path/foo to
/dev/video?.

What I'm using on Exynos scripts is this logic:

	NEEDED1=platform-13e00000.video-scaler-video-index0
	DEV1=$(ls -l /dev/v4l/by-path/$NEEDED1|perl -ne ' print $1 if (m,/video(\d+),)')

Then, if I need to talk with this mem2mem driver using the v4l2video
convert plugin, I can launch gst with something like:

	gst-launch-1.0 videotestsrc ! v4l2video${DEV1}convert ! fakesink

Thanks,
Mauro


Thanks,
Mauro
