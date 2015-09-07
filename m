From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 07 Sep 2015 16:04:30 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150907112555.GS21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Mon, 7 Sep 2015 12:25:55 +0100")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
Message-ID: <m37fo25nrl.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> Now if I enable LVDS (CONFIG_DRM_IMX_LDB - I don't have any LVDS
>> hardware connected), the HDMI device is created (as well as LVDS).
>
> Are you telling the kernel in your device tree file that LDB is required?
> DRM doesn't support hot-plugging outputs, all specified output modules
> must be present before DRM can bring up the display subsystem.

It seems to be the case, I'll test with the LDB portion removed. Though
I don't mind LVDS if it doesn't break HDMI.

>> This used to detect the monitor as "unknown" but now it's "connected"
>> most of the time - not sure what have changed. EDID is empty and I get
>> the following entries in /sys/devices/soc0/display-subsystem/drm/card0:
>
> "used to" - when was this?

Well... before I made unspecified changes to something :-)
I mean, I don't think I made any related changes, but something must
have changed since it always prints "connected" now. Most of the time.
I mean, from time to time :-)
Seems low level.

> I don't think dw_hdmi has ever reported
> a connected status of "unknown", always explicitly stating connected
> or disconnected.

The "unknown" must be an uninitialized variable (neither connected = 1
or disconnected = 2):

--- dmesg-unknown
+++ dmesg-connected
-imx-ipuv3 2400000.ipu: IPUv3H probed
@@
-XXX dw_hdmi_imx_probe[261]
+imx-ipuv3 2400000.ipu: IPUv3H probed
 imx-ipuv3 2800000.ipu: IPUv3H probed
+XXX dw_hdmi_imx_probe[261]
 [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
 [drm] No driver support for vblank timestamp query.
 imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops [imx_ipuv3_crtc])
@@ -323,8 +323,9 @@
 XXX dw_hdmi_hardirq[1479]
 XXX dw_hdmi_irq[1493]
 imx-drm display-subsystem: bound 2000000.aips-bus:ldb at 020e0008 (ops imx_ldb_driver_exit [imx_ldb])
 [drm] Initialized imx-drm 1.0.0 20120507 on minor 0
+XXX dw_hdmi_connector_detect[1389]: CONNECTED

In the "unknown" case, the dw_hdmi_connector_detect() wasn't called.
Maybe the problem happens when dw_hdmi_imx_probe() is called before
"imx-ipuv3 2400000.ipu: IPUv3H probed" is done. Probably an interrupt
isn't generated or something like this, maybe it should poll it once.
I'll check this later.

> Looks fine apart from the lack of EDID.  Are you sure you have the
> pinctrl setup correct for this?  (We don't use the DDC I2C built
> into the HDMI interface.)

How do I check it? I'm simply using the (v4.2) imx6q-gw54xx.dts file.

>> Now, somehow the X.org server sets the resolution to 1024x768, though
>> nothing is displayed on the monitor (it's in stand-by). Files in
>> /sys/.../card0-HDMI-A/ now have the actual EDID, mode list etc.
>
> By default, 1024x768 is selected when there's nothing else available.

How do I select e.g. 1920x1080? The EDID supports this mode, but
# xrandr --output HDMI1 --auto

X Error:  BadMatch
  Request Major code 139 (RANDR)
  Request Minor code 7 ()
  Error Serial #34
  Current Serial #35

imx-drm display-subsystem: failed to allocate buffer with size 8294400
imx-drm display-subsystem: failed to allocate buffer with size 8294400
imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms

I assume I have to reserve the (big linear region of) memory at boot
time, but don't know how.

> The DPMS "on" and enabled above tends to suggest you should be seeing
> output though.

I've applied the PLL5 patch and it now started to work. At least I have
output. I'm still seeing "DC stop timeout after 50 ms" but apparently
only when the X server is being closed, from time to time.

> I should point out that virtually every -rc kernel gets tested here on
> iMX6 with HDMI output - onto my Panasonic TV, and I've seen no evidence
> of any regressions.  For me, it Just Works(tm).

Ok. I'll try to reach the same state :-)

Now, having the HDMI output on the screen, I'm trying to get XVideo
working. It seems all XV attributes are set to their minimum values and
I can't change that. Is it normal? For this or other reason, I can see
a black video window only (I'm trying to use I420 overlay). Could be
unrelated problem, though.

# xvattr
Found Xv 2.2
Adaptor: 0
Name: Marvell Armada Overlay Video
 Port: 85
  Name: XV_ENCODING
   Flags: XvGettable XvSettable
   Min value: 0
   Max value: 0
   Current value: 0
  Name: XV_SATURATION
   Flags: XvGettable XvSettable
   Min value: -16384
   Max value: 16383
   Current value: -16384
  Name: XV_BRIGHTNESS
   Flags: XvGettable XvSettable
   Min value: -256
   Max value: 255
   Current value: -256
  Name: XV_CONTRAST
   Flags: XvGettable XvSettable
   Min value: -16384
   Max value: 16383
   Current value: -16384
  Name: XV_AUTOPAINT_COLORKEY
   Flags: XvGettable XvSettable
   Min value: 0
   Max value: 1
   Current value: 1
  Name: XV_COLORKEY
   Flags: XvGettable XvSettable
   Min value: 0
   Max value: 16777215
   Current value: 0
  Name: XV_PIPE
   Flags: XvGettable XvSettable
   Min value: -1
   Max value: 3
   Current value: -1

# xvattr -a XV_BRIGHTNESS -v 0 -p 85
Found Xv 2.2
XV_BRIGHTNESS set to -256

I'll continue with this stuff tomorrow.


Thanks for the help,
--
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
