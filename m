From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 4 Oct 2018 21:36:05 +0530
Subject: [PATCH 10/12] drm/panel: Add Bananapi S070WV20-CT16 MIPI-DSI
 panel driver
In-Reply-To: <CAGb2v67+TmDn-MT5-LE1dwRA0vYSJNJBZEA7pi8wi-Cyy-Lp2w@mail.gmail.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-11-jagan@amarulasolutions.com>
 <CAGb2v67+TmDn-MT5-LE1dwRA0vYSJNJBZEA7pi8wi-Cyy-Lp2w@mail.gmail.com>
Message-ID: <CAMty3ZAvgh0J_phJpMKt1WTEYU0VUqK0KYJN5o01_Y6LyMVtUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 10:02 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Sep 27, 2018 at 7:50 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel which
> > can be used to connect via BPI-M64 board, so add a driver for it.
> >
> > The same panel PCB comes with parallel RBG which is supported via
> > panel-simple driver with "bananapi,s070wv20-ct16" compatible.
>
> As I mentioned before, this PCB uses a ICN6211 MIPI-DSI to RGB bridge.
> Please model it as such.

OK.

>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> >  drivers/gpu/drm/panel/Makefile                |   1 +
> >  .../gpu/drm/panel/panel-bananapi-s070wv20.c   | 336 ++++++++++++++++++
> >  3 files changed, 346 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20.c
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > index 6020c30a33b3..d25960a63b10 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -17,6 +17,15 @@ config DRM_PANEL_ARM_VERSATILE
> >           reference designs. The panel is detected using special registers
> >           in the Versatile family syscon registers.
> >
> > +config DRM_PANEL_BANANAPI_S070WV20
> > +       tristate "Bananapi S070WV20-CT16 MIPI-DSI panel driver"
> > +       depends on OF
> > +       depends on DRM_MIPI_DSI
> > +       depends on BACKLIGHT_CLASS_DEVICE
> > +       help
> > +         Say Y if you want to enable support for panels based on the
> > +         Bananapi S070WV20-CT16 MIPI-DSI controller.
> > +
> >  config DRM_PANEL_LVDS
> >         tristate "Generic LVDS panel driver"
> >         depends on OF
> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > index 5ccaaa9d13af..345b6475d3a4 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
> > +obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20) += panel-bananapi-s070wv20.o
> >  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
> >  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> >  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
> > diff --git a/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c b/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c
> > new file mode 100644
> > index 000000000000..6c9adbec6dd8
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c
> > @@ -0,0 +1,336 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2018 Amarula Solutions
> > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/fb.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_panel.h>
> > +
> > +#include <video/mipi_display.h>
> > +
> > +struct s070wv20 {
> > +       struct drm_panel        panel;
> > +       struct mipi_dsi_device  *dsi;
> > +
> > +       struct backlight_device *backlight;
> > +       struct regulator        *dvdd;
> > +       struct regulator        *avdd;
> > +       struct gpio_desc        *reset;
> > +
> > +       bool                    is_enabled;
> > +       bool                    is_prepared;
> > +};
> > +
> > +static inline struct s070wv20 *panel_to_s070wv20(struct drm_panel *panel)
> > +{
> > +       return container_of(panel, struct s070wv20, panel);
> > +}
> > +
> > +struct s070wv20_init_cmd {
> > +       size_t len;
> > +       const char *data;
> > +};
> > +
> > +#define S070WV20_INIT_CMD(...) { \
> > +       .len = sizeof((char[]){__VA_ARGS__}), \
> > +       .data = (char[]){__VA_ARGS__} }
> > +
>
> Using the timings from below, and comparing with
>
>    https://shiminblog.github.io/mipi-to-rgb-lcd/
>
> > +static const struct s070wv20_init_cmd s070wv20_init_cmds[] = {
> > +       S070WV20_INIT_CMD(0x7A, 0xC1),
>
> > +       S070WV20_INIT_CMD(0x20, 0x20),
>
> This is likely the lower 8 bits of .hdisplay.
>
> > +       S070WV20_INIT_CMD(0x21, 0xE0),
>
> Lower 8 bits of .vdisplay
>
> > +       S070WV20_INIT_CMD(0x22, 0x13),
>
> Might be ((.hdisplay >> 8) & 0xf | (.vdisplay >> 8) & 0xf) << 4).
>
> > +       S070WV20_INIT_CMD(0x23, 0x28),
>
> HFP, or horizontal front porch. 40 in this case.
>
> > +       S070WV20_INIT_CMD(0x24, 0x30),
>
> HSYNC, or horizontal sync pulse length. 48 in this case.
>
> > +       S070WV20_INIT_CMD(0x25, 0x28),
>
> HBP, or horizontal back porch. 40 in this case.
>
> > +       S070WV20_INIT_CMD(0x26, 0x00),
>
> Unknown. Possibly RGB phase shift?
>
> > +       S070WV20_INIT_CMD(0x27, 0x0D),
>
> VFP, or vertical front porch. 13 in this case.
>
> > +       S070WV20_INIT_CMD(0x28, 0x03),
>
> This might be VSYNC, judging from the grouping. 3 in this case.
>
> > +       S070WV20_INIT_CMD(0x29, 0x1D),
>
> VBP, or vertical back porch. 29 in this case.
>
> > +       S070WV20_INIT_CMD(0x34, 0x80),
> > +       S070WV20_INIT_CMD(0x36, 0x28),
> > +       S070WV20_INIT_CMD(0xB5, 0xA0),
> > +       S070WV20_INIT_CMD(0x5C, 0xFF),
> > +       S070WV20_INIT_CMD(0x2A, 0x01),
> > +       S070WV20_INIT_CMD(0x56, 0x92),
> > +       S070WV20_INIT_CMD(0x6B, 0x71),
> > +       S070WV20_INIT_CMD(0x69, 0x2B),
> > +       S070WV20_INIT_CMD(0x10, 0x40),
> > +       S070WV20_INIT_CMD(0x11, 0x98),
>
> This might be related to number of MIPI lanes. I saw 0x88 for 2-lane devices.
>
> > +       S070WV20_INIT_CMD(0xB6, 0x20),
> > +       S070WV20_INIT_CMD(0x51, 0x20),
> > +       S070WV20_INIT_CMD(0x09, 0x10),
>
> The last three seem standardized across all ICN6211 drivers I could
> find on github.
>
> Other drivers / init sequences I found:
>
> https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
>
> https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> matches timings for
> https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
>
> https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169
>
> I also reached out to Bananapi to see if they have more information on
> this chip.

Did you get any further information from BPI?
