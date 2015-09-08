From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 08 Sep 2015 13:01:47 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150908091625.GV21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 8 Sep 2015 10:16:25 +0100")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
Message-ID: <m3y4gh41k4.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Do you have DRM configured as modules?  I can't think of anything else
> that would change the probe order like this.

Yes, they are modules.

> You seem to have the interrupt generated

Right.

> (though you don't print what the
> IRQ status register contained).  It should cause drm_helper_hpd_irq_event()
> to be called, which then polls the connector detect functions.
>
> If that detects any connector having changed status, it goes on to call
> drm_kms_helper_hotplug_event(), which then goes on to call (via a few
> other functions) drm_fb_helper_hotplug_event() and
> drm_fb_helper_probe_connector_modes().

Ok, I will queue this for investigation.

>> imx-drm display-subsystem: failed to allocate buffer with size 8294400
>> imx-drm display-subsystem: failed to allocate buffer with size 8294400
>
> Why are you getting those errors?  Do you have CMA disabled?  Maybe you
> need to use cma=128M or something on the command line.

Yes, I had it disabled.

>> Now, having the HDMI output on the screen, I'm trying to get XVideo
>> working. It seems all XV attributes are set to their minimum values and
>> I can't change that. Is it normal? For this or other reason, I can see
>> a black video window only (I'm trying to use I420 overlay). Could be
>> unrelated problem, though.
>
> That's probably because of the restrictions in the IPU - the mainline
> IPU code is unable to scale overlays at all - it's not supported.  The
> problem is most Xorg drivers assume that overlays can be scaled.  I've
> said about this before, and how this is broken, but I've no idea whether
> it's going to get fixed.  As far as I know, this only affects platforms
> using the IPU.

I see. But I'm ok with unscaled Xvideo. I only need a (fast) way to send
YUV (preferably YUV420) image to the screen.

> The only alternative there is to switch to using the GPU to blit the
> XVideo frame onto the display (but then you need all the etnaviv bits
> in place, including the etnaviv DRM driver.)  This works up to a point,
> but suffers from tearing, because there's no sane good way to synchronise
> the GPU blit with the video scanout (because they're two different
> completely unrelated chunks of hardware: the reason Intel i965 can do
> this is because it seems possible to put into the GPU stream "wait for
> scan line X before continuing" thereby preventing the blit modifying
> scanlines that are about to be displayed.

This could be the horizontal lines that I observed. Something similar
to what the old S3 Trio64 were doing.

> As long as the video playback situation (as a whole, I'm talking about
> the VPU) is poorly supported both in userspace and mainline kernels (it
> only supports H264, not MPEG2/4, and requires bleeding edge gstreamer
> support), video decode and overlay on iMX6 doesn't interest me.  My
> preferred ARM platform for that is Dove right now, so I'm not motivated
> to put much effort into the iMX6 video playback issues, basically because
> I can't decently test them.

I see. At the moment I'm able to use the hardware decoder (with a bit
long latencies, though), I'm getting a YUV420 image out of it. Also, the
encoder works.

> As for the overlay attributes, don't worry about them - imx-drm doesn't
> support the properties on overlay at all.  They're exposed because once
> the Xorg atoms exist, you can't then return a BadMatch when getting or
> setting them - applications tend to have a dislike for that.  Maybe I
> should arrange it to return a more sensible value though.

I see.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
