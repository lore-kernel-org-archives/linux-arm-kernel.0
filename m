From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 23:07:33 +0100
Subject: [PATCH] imx-drm: fix hdmi hotplug detection initial state
In-Reply-To: <CAJ+vNU23SE7ZumL34+6Wsv9c6rvcLx6jYQ_ed4uUY6yyGBnRBw@mail.gmail.com>
References: <E1Wb5Nd-0002Ef-Es@rmk-PC.arm.linux.org.uk>
 <CAJ+vNU23SE7ZumL34+6Wsv9c6rvcLx6jYQ_ed4uUY6yyGBnRBw@mail.gmail.com>
Message-ID: <20140424220732.GE26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 02:00:49PM -0700, Tim Harvey wrote:
> I'm still seeing issues with HDMI detect on powerup, at least on my
> Gateworks Ventana boards (which have no voltage devider or anything
> else on the HPD line to the IMX6 other than a TVS). I'm currently
> using your latest imx-drm-staging branch and have applied this patch
> on top of it. When I enable debug in imx-hdmi.c I see the following:

So it's a similar setup to the Cubox-i.

> on powerup with HDMI attached:
> [    6.291082] imx-ipuv3 2400000.ipu: IPUv3H probed
> [    6.298370] imx-ipuv3 2800000.ipu: IPUv3H probed
> [    6.310356] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    6.317087] [drm] No driver support for vblank timestamp query.
> [    6.324249] imx-drm display-subsystem.11: bound imx-ipuv3-crtc.0
> (ops ipu_crtc_ops)
> [    6.332475] imx-drm display-subsystem.11: bound imx-ipuv3-crtc.1
> (ops ipu_crtc_ops)
> [    6.340616] imx-drm display-subsystem.11: bound imx-ipuv3-crtc.2
> (ops ipu_crtc_ops)
> [    6.349221] imx-drm display-subsystem.11: bound imx-ipuv3-crtc.3
> (ops ipu_crtc_ops)
> [    6.358098] imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
> [    6.365366] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
> [    6.372169] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator:
> samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250
> [    6.383971] imx-drm display-subsystem.11: bound 120000.hdmi (ops hdmi_ops)
> [    6.383998] imx-hdmi 120000.hdmi: EVENT=plugin
> [    6.384011] imx-hdmi 120000.hdmi: imx_hdmi_poweron
> [    6.384022] imx-hdmi 120000.hdmi: imx_hdmi_setup vic=0
> [    6.384031] imx-hdmi 120000.hdmi: Non-CEA mode used in HDMI
> [    6.384038] imx-hdmi 120000.hdmi: final pixclk = 0
> [    6.402148] imx-hdmi 120000.hdmi: imx_hdmi_setup DVI mode
> [    6.428804] imx-drm display-subsystem.11: bound ldb.10 (ops imx_ldb_ops)
> [    6.490101] imx-hdmi 120000.hdmi: got edid: width[70] x height[39]
> [    6.506191] imx-drm display-subsystem.11: fb0:  frame buffer device
> [    6.512596] imx-drm display-subsystem.11: registered panic notifier
> [    6.518947] [drm] Initialized imx-drm 1.0.0 20120507 on minor 0

So at boot, I see this:

[    1.282549] imx-ipuv3 2400000.ipu: IPUv3H probed
[    1.295494] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.302197] [drm] No driver support for vblank timestamp query.
[    1.308315] imx-drm display-subsystem.10: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
[    1.326728] imx-drm display-subsystem.10: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
[    1.336741] imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0x1a:0xa0:0xc1
[    1.346109] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
[    1.346128] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator: samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250
[    1.346276] imx-hdmi 120000.hdmi: EVENT=plugin
[    1.346291] imx-hdmi 120000.hdmi: Non-CEA mode used in HDMI
[    1.346301] imx-hdmi 120000.hdmi: final pixclk = 0
[    1.364422] imx-hdmi 120000.hdmi: imx_hdmi_setup DVI mode
[    1.365896] imx-drm display-subsystem.10: bound 120000.hdmi (ops hdmi_ops)
[    1.428629] imx-hdmi 120000.hdmi: got edid: width[128] x height[72]
[    1.435752] imx-hdmi 120000.hdmi: CEA mode used vic=31
[    1.435761] imx-hdmi 120000.hdmi: final pixclk = 148500000
[    1.453879] imx-hdmi 120000.hdmi: imx_hdmi_setup CEA mode
[    1.453886] hdmi_compute_cts: freq: 48000 pixel_clk: 148500000 ratio: 100
[    1.453896] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator: samplerate=48000  ratio=100  pixelclk=148500000  N=6144 cts=148500
[    1.454549] imx-hdmi 120000.hdmi: CEA mode used vic=31
[    1.454555] imx-hdmi 120000.hdmi: final pixclk = 148500000
[    1.472685] imx-hdmi 120000.hdmi: imx_hdmi_setup CEA mode
[    1.472691] hdmi_compute_cts: freq: 48000 pixel_clk: 148500000 ratio: 100
[    1.472702] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator: samplerate=48000  ratio=100  pixelclk=148500000  N=6144 cts=148500
[    1.489418] Console: switching to colour frame buffer device 240x67
[    1.511370] imx-drm display-subsystem.10: fb0:  frame buffer device
[    1.517770] imx-drm display-subsystem.10: registered panic notifier
[    1.524160] [drm] Initialized imx-drm 1.0.0 20120507 on minor 0

which is only with imx-hdmi bound, no ldb.  The difference you will
notice is that there's the "Console: switching ..." line, which is
there because I have fbcon enabled.

Therefore, I suspect that it is working as it should - if you enable
fbcon, it should automatically initialise.  If you don't have fbcon
enabled, then it'll probably wait for a userspace DRM driver to bring
it up.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
