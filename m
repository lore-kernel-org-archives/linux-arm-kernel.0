From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Sep 2015 12:25:55 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m3bnde5whx.fsf@t19.piap.pl>
References: <m3bnde5whx.fsf@t19.piap.pl>
Message-ID: <20150907112555.GS21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 12:55:54PM +0200, Krzysztof Ha?asa wrote:
> Hi,
> 
> I'd like to ask if the HDMI output on I.MX6-based boards is possible.
> I'm unable to get it to work. What I'm trying to do is getting
> a) DRM HDMI output, b) X.org output using etnaviv, libdrm-armada and
> xf86-video-armada, c) GLX and Xvideo. Basically, latest versions.
> 
> I'm working with Gateworks Ventana GW54xx boards and with Sabre-lite,
> using newly built imx6q-gw54xx.dtb and imx6q-sabrelite.dtb. In both
> cases, required kernel modules are inserted and (somehow) initialized,
> but the HDMI device isn't created.
> 
> The first problem seems to be this:
> - dw_hdmi_imx_probe() is called (and does component_add()), but
> - dw_hdmi_imx_bind() is never called.
> 
> Now if I enable LVDS (CONFIG_DRM_IMX_LDB - I don't have any LVDS
> hardware connected), the HDMI device is created (as well as LVDS).

Are you telling the kernel in your device tree file that LDB is required?
DRM doesn't support hot-plugging outputs, all specified output modules
must be present before DRM can bring up the display subsystem.

> This used to detect the monitor as "unknown" but now it's "connected"
> most of the time - not sure what have changed. EDID is empty and I get
> the following entries in /sys/devices/soc0/display-subsystem/drm/card0:

"used to" - when was this?  I don't think dw_hdmi has ever reported
a connected status of "unknown", always explicitly stating connected
or disconnected.

> dev                                            226:0
> card0-HDMI-A-1/edid                            (empty)
> card0-HDMI-A-1/dpms                            On
> card0-HDMI-A-1/modes
> card0-HDMI-A-1/power/control                   auto
> card0-HDMI-A-1/power/runtime_active_time       0
> card0-HDMI-A-1/power/autosuspend_delay_ms      (Input/output error)
> card0-HDMI-A-1/power/runtime_status            unsupported
> card0-HDMI-A-1/power/runtime_suspended_time    0
> card0-HDMI-A-1/enabled                         enabled
> card0-HDMI-A-1/status                          used to be "unknown", now: "connected"
> card0-HDMI-A-1/uevent                          power/control auto

Looks fine apart from the lack of EDID.  Are you sure you have the
pinctrl setup correct for this?  (We don't use the DDC I2C built
into the HDMI interface.)

> Now, somehow the X.org server sets the resolution to 1024x768, though
> nothing is displayed on the monitor (it's in stand-by). Files in
> /sys/.../card0-HDMI-A/ now have the actual EDID, mode list etc.

By default, 1024x768 is selected when there's nothing else available.
The DPMS "on" and enabled above tends to suggest you should be seeing
output though.

It's possible that having both LVDS and HDMI enabled causes a pixel
clocking conflict if both are routed to the same CRTC and PLL.  (The
clocking side of it is something I really hate, and the decision was
taken to control this statically.)

> This also causes:
> imx-ipuv3 2400000.ipu: DC stop timeout after 50 ms
> imx-ipuv3 2400000.ipu: Timeout waiting for DMFC FIFOs to clear

I don't have an answer for that... that's deep internal IPU stuff.

> What am I doing wrong?
> - kernel command line? video=mxcfb0:dev=hdmi,1920x1080M at 60,if=RGB24
> - wrong SDMA firmware? MD5 is:
>   5d4584134cc4cba62e1be2f382cd6f3a  /lib/firmware/imx/sdma/sdma-imx6q.bin
> - wrong X.org stuff?

Probably none of the above.

I should point out that virtually every -rc kernel gets tested here on
iMX6 with HDMI output - onto my Panasonic TV, and I've seen no evidence
of any regressions.  For me, it Just Works(tm).

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
