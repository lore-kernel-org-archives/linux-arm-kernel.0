From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 10:16:25 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m37fo25nrl.fsf@t19.piap.pl>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
Message-ID: <20150908091625.GV21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 04:04:30PM +0200, Krzysztof Ha?asa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> >> Now if I enable LVDS (CONFIG_DRM_IMX_LDB - I don't have any LVDS
> >> hardware connected), the HDMI device is created (as well as LVDS).
> >
> > Are you telling the kernel in your device tree file that LDB is required?
> > DRM doesn't support hot-plugging outputs, all specified output modules
> > must be present before DRM can bring up the display subsystem.
> 
> It seems to be the case, I'll test with the LDB portion removed. Though
> I don't mind LVDS if it doesn't break HDMI.
> 
> >> This used to detect the monitor as "unknown" but now it's "connected"
> >> most of the time - not sure what have changed. EDID is empty and I get
> >> the following entries in /sys/devices/soc0/display-subsystem/drm/card0:
> >
> > "used to" - when was this?
> 
> Well... before I made unspecified changes to something :-)
> I mean, I don't think I made any related changes, but something must
> have changed since it always prints "connected" now. Most of the time.
> I mean, from time to time :-)
> Seems low level.

I don't know - what normally happens is that a HPD IRQ fires at boot time
from the HDMI interface which causes us to run the ->detect functions,
and that would have updated the connect status before the thing has
finished probing.

> > I don't think dw_hdmi has ever reported
> > a connected status of "unknown", always explicitly stating connected
> > or disconnected.
> 
> The "unknown" must be an uninitialized variable (neither connected = 1
> or disconnected = 2):
> 
> --- dmesg-unknown
> +++ dmesg-connected
> -imx-ipuv3 2400000.ipu: IPUv3H probed
> @@
> -XXX dw_hdmi_imx_probe[261]
> +imx-ipuv3 2400000.ipu: IPUv3H probed
>  imx-ipuv3 2800000.ipu: IPUv3H probed
> +XXX dw_hdmi_imx_probe[261]

Do you have DRM configured as modules?  I can't think of anything else
that would change the probe order like this.

>  [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>  [drm] No driver support for vblank timestamp query.
>  imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops [imx_ipuv3_crtc])
> @@ -323,8 +323,9 @@
>  XXX dw_hdmi_hardirq[1479]
>  XXX dw_hdmi_irq[1493]
>  imx-drm display-subsystem: bound 2000000.aips-bus:ldb at 020e0008 (ops imx_ldb_driver_exit [imx_ldb])
>  [drm] Initialized imx-drm 1.0.0 20120507 on minor 0
> +XXX dw_hdmi_connector_detect[1389]: CONNECTED
> 
> In the "unknown" case, the dw_hdmi_connector_detect() wasn't called.
> Maybe the problem happens when dw_hdmi_imx_probe() is called before
> "imx-ipuv3 2400000.ipu: IPUv3H probed" is done.

The IPU and HDMI are separate entities and can't influence each others
IRQs.

> Probably an interrupt
> isn't generated or something like this, maybe it should poll it once.
> I'll check this later.

You seem to have the interrupt generated (though you don't print what the
IRQ status register contained).  It should cause drm_helper_hpd_irq_event()
to be called, which then polls the connector detect functions.

If that detects any connector having changed status, it goes on to call
drm_kms_helper_hotplug_event(), which then goes on to call (via a few
other functions) drm_fb_helper_hotplug_event() and
drm_fb_helper_probe_connector_modes().

> > Looks fine apart from the lack of EDID.  Are you sure you have the
> > pinctrl setup correct for this?  (We don't use the DDC I2C built
> > into the HDMI interface.)
> 
> How do I check it? I'm simply using the (v4.2) imx6q-gw54xx.dts file.

drm_fb_helper_probe_connector_modes() should cause the modes to be read
via the get_modes() callback into the HDMI driver.

> >> Now, somehow the X.org server sets the resolution to 1024x768, though
> >> nothing is displayed on the monitor (it's in stand-by). Files in
> >> /sys/.../card0-HDMI-A/ now have the actual EDID, mode list etc.
> >
> > By default, 1024x768 is selected when there's nothing else available.
> 
> How do I select e.g. 1920x1080? The EDID supports this mode, but
> # xrandr --output HDMI1 --auto
> 
> X Error:  BadMatch
>   Request Major code 139 (RANDR)
>   Request Minor code 7 ()
>   Error Serial #34
>   Current Serial #35
> 
> imx-drm display-subsystem: failed to allocate buffer with size 8294400
> imx-drm display-subsystem: failed to allocate buffer with size 8294400

Why are you getting those errors?  Do you have CMA disabled?  Maybe you
need to use cma=128M or something on the command line.

> Now, having the HDMI output on the screen, I'm trying to get XVideo
> working. It seems all XV attributes are set to their minimum values and
> I can't change that. Is it normal? For this or other reason, I can see
> a black video window only (I'm trying to use I420 overlay). Could be
> unrelated problem, though.

That's probably because of the restrictions in the IPU - the mainline
IPU code is unable to scale overlays at all - it's not supported.  The
problem is most Xorg drivers assume that overlays can be scaled.  I've
said about this before, and how this is broken, but I've no idea whether
it's going to get fixed.  As far as I know, this only affects platforms
using the IPU.

The only alternative there is to switch to using the GPU to blit the
XVideo frame onto the display (but then you need all the etnaviv bits
in place, including the etnaviv DRM driver.)  This works up to a point,
but suffers from tearing, because there's no sane good way to synchronise
the GPU blit with the video scanout (because they're two different
completely unrelated chunks of hardware: the reason Intel i965 can do
this is because it seems possible to put into the GPU stream "wait for
scan line X before continuing" thereby preventing the blit modifying
scanlines that are about to be displayed.

I have some experimental code for the Xorg driver that computes the
period of time after the vsync that the scanlines would be scanned out.
However, my measurements of the time taken for the GPU to blit the
frame show that it takes almost one scan-out to do the filter blit.
That makes the timings are _really_ tight there which means any jitter
in the scheduling and interrupts will throw any solution to this off,
and the tearing will be back.

As long as the video playback situation (as a whole, I'm talking about
the VPU) is poorly supported both in userspace and mainline kernels (it
only supports H264, not MPEG2/4, and requires bleeding edge gstreamer
support), video decode and overlay on iMX6 doesn't interest me.  My
preferred ARM platform for that is Dove right now, so I'm not motivated
to put much effort into the iMX6 video playback issues, basically because
I can't decently test them.

As for the overlay attributes, don't worry about them - imx-drm doesn't
support the properties on overlay at all.  They're exposed because once
the Xorg atoms exist, you can't then return a BadMatch when getting or
setting them - applications tend to have a dislike for that.  Maybe I
should arrange it to return a more sensible value though.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
