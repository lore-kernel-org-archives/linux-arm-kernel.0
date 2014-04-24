From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 24 Apr 2014 14:00:49 -0700
Subject: [PATCH] imx-drm: fix hdmi hotplug detection initial state
In-Reply-To: <E1Wb5Nd-0002Ef-Es@rmk-PC.arm.linux.org.uk>
References: <E1Wb5Nd-0002Ef-Es@rmk-PC.arm.linux.org.uk>
Message-ID: <CAJ+vNU23SE7ZumL34+6Wsv9c6rvcLx6jYQ_ed4uUY6yyGBnRBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 2:46 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
>
> The initial state at boot is assumed to be disconnected, and we hope
> to receive an interrupt to update the status.  Let's be more explicit
> about the current state - reading the PHY status register tells us
> the current level of the hotplug signal, which we can report back in
> the _detect() method.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Having discussed the issue of how to detect HDMI with David Airlie last
> night, it is perfectly fine to use the HPD signal.  The reason adapters
> like Intel i915 use EDID is because of cross-talk on their HPD signals,
> which cause them to falsely indicate transitions when nothing has really
> changed state.  So, to say that EDID polling is somehow more in keeping
> with DRM than using the HPD signal is rather bogus.
>
> The patch below fixes imx-hdmi for good systems where the HPD signal is
> wired up at the board level.
>
>  drivers/staging/imx-drm/imx-hdmi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
> index d47dedd2cdb4..6f5efcc89880 100644
> --- a/drivers/staging/imx-drm/imx-hdmi.c
> +++ b/drivers/staging/imx-drm/imx-hdmi.c
> @@ -120,8 +120,6 @@ struct imx_hdmi {
>         struct clk *isfr_clk;
>         struct clk *iahb_clk;
>
> -       enum drm_connector_status connector_status;
> -
>         struct hdmi_data_info hdmi_data;
>         int vic;
>
> @@ -1382,7 +1380,9 @@ static enum drm_connector_status imx_hdmi_connector_detect(struct drm_connector
>  {
>         struct imx_hdmi *hdmi = container_of(connector, struct imx_hdmi,
>                                              connector);
> -       return hdmi->connector_status;
> +
> +       return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
> +               connector_status_connected : connector_status_disconnected;
>  }
>
>  static int imx_hdmi_connector_get_modes(struct drm_connector *connector)
> @@ -1524,7 +1524,6 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
>
>                         hdmi_modb(hdmi, 0, HDMI_PHY_HPD, HDMI_PHY_POL0);
>
> -                       hdmi->connector_status = connector_status_connected;
>                         imx_hdmi_poweron(hdmi);
>                 } else {
>                         dev_dbg(hdmi->dev, "EVENT=plugout\n");
> @@ -1532,7 +1531,6 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
>                         hdmi_modb(hdmi, HDMI_PHY_HPD, HDMI_PHY_HPD,
>                                 HDMI_PHY_POL0);
>
> -                       hdmi->connector_status = connector_status_disconnected;
>                         imx_hdmi_poweroff(hdmi);
>                 }
>                 drm_helper_hpd_irq_event(hdmi->connector.dev);
> @@ -1606,7 +1604,6 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
>                 return -ENOMEM;
>
>         hdmi->dev = dev;
> -       hdmi->connector_status = connector_status_disconnected;
>         hdmi->sample_rate = 48000;
>         hdmi->ratio = 100;
>
> --
> 1.8.3.1
>

Hi Russell,

I'm still seeing issues with HDMI detect on powerup, at least on my
Gateworks Ventana boards (which have no voltage devider or anything
else on the HPD line to the IMX6 other than a TVS). I'm currently
using your latest imx-drm-staging branch and have applied this patch
on top of it. When I enable debug in imx-hdmi.c I see the following:

on powerup with HDMI attached:
[    6.291082] imx-ipuv3 2400000.ipu: IPUv3H probed
[    6.298370] imx-ipuv3 2800000.ipu: IPUv3H probed
[    6.310356] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    6.317087] [drm] No driver support for vblank timestamp query.
[    6.324249] imx-drm display-subsystem.11: bound imx-ipuv3-crtc.0
(ops ipu_crtc_ops)
[    6.332475] imx-drm display-subsystem.11: bound imx-ipuv3-crtc.1
(ops ipu_crtc_ops)
[    6.340616] imx-drm display-subsystem.11: bound imx-ipuv3-crtc.2
(ops ipu_crtc_ops)
[    6.349221] imx-drm display-subsystem.11: bound imx-ipuv3-crtc.3
(ops ipu_crtc_ops)
[    6.358098] imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
[    6.365366] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
[    6.372169] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator:
samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250
[    6.383971] imx-drm display-subsystem.11: bound 120000.hdmi (ops hdmi_ops)
[    6.383998] imx-hdmi 120000.hdmi: EVENT=plugin
[    6.384011] imx-hdmi 120000.hdmi: imx_hdmi_poweron
[    6.384022] imx-hdmi 120000.hdmi: imx_hdmi_setup vic=0
[    6.384031] imx-hdmi 120000.hdmi: Non-CEA mode used in HDMI
[    6.384038] imx-hdmi 120000.hdmi: final pixclk = 0
[    6.402148] imx-hdmi 120000.hdmi: imx_hdmi_setup DVI mode
[    6.428804] imx-drm display-subsystem.11: bound ldb.10 (ops imx_ldb_ops)
[    6.490101] imx-hdmi 120000.hdmi: got edid: width[70] x height[39]
[    6.506191] imx-drm display-subsystem.11: fb0:  frame buffer device
[    6.512596] imx-drm display-subsystem.11: registered panic notifier
[    6.518947] [drm] Initialized imx-drm 1.0.0 20120507 on minor 0

I think the issue may be that the plugin event was encountered and
EDID read before the frame buffer device exists?

on hotplug:
[  153.216538] imx-hdmi 120000.hdmi: EVENT=plugout
[  155.596765] imx-hdmi 120000.hdmi: EVENT=plugin
[  155.601273] imx-hdmi 120000.hdmi: Non-CEA mode used in HDMI
[  155.606985] imx-hdmi 120000.hdmi: final pixclk = 0
[  155.629933] imx-hdmi 120000.hdmi: imx_hdmi_setup DVI mode
[  155.684976] imx-hdmi 120000.hdmi: got edid: width[70] x height[39]
[  155.695157] imx-hdmi 120000.hdmi: CEA mode used vic=4
[  155.700234] imx-hdmi 120000.hdmi: final pixclk = 74250000
[  155.723830] imx-hdmi 120000.hdmi: imx_hdmi_setup CEA mode
[  155.729251] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
[  155.736044] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator:
samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250
[  155.748264] imx-hdmi 120000.hdmi: CEA mode used vic=4
[  155.754049] imx-hdmi 120000.hdmi: final pixclk = 74250000
[  155.777569] imx-hdmi 120000.hdmi: imx_hdmi_setup CEA mode
[  155.783089] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
[  155.789859] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator:
samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250
[  156.277154] imx-hdmi 120000.hdmi: EVENT=plugout
[  156.281774] imx-hdmi 120000.hdmi: EVENT=plugin
[  156.286398] imx-hdmi 120000.hdmi: CEA mode used vic=4
[  156.291470] imx-hdmi 120000.hdmi: final pixclk = 74250000
[  156.315042] imx-hdmi 120000.hdmi: imx_hdmi_setup CEA mode
[  156.320512] hdmi_compute_cts: freq: 48000 pixel_clk: 74250000 ratio: 100
[  156.327302] imx-hdmi 120000.hdmi: hdmi_set_clk_regenerator:
samplerate=48000  ratio=100  pixelclk=74250000  N=6144 cts=74250
display is now sync'd and good

Regards,

Tim
