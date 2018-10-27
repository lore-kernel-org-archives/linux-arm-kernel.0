From: plaes@plaes.org (Priit Laes)
Date: Sat, 27 Oct 2018 16:27:38 +0000
Subject: [linux-sunxi] [PATCH v3 20/25] drm/panel: Add Techstar TS8550B
 MIPI-DSI LCD panel
In-Reply-To: <CAMty3ZDc84ErYB9LR_Y7OJtUOx+AAhTV1RwC7-Jr1Br8yN6hUw@mail.gmail.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-21-jagan@amarulasolutions.com>
 <20181026161324.qbpcpkpwyixi7juk@plaes.org>
 <CAMty3ZDc84ErYB9LR_Y7OJtUOx+AAhTV1RwC7-Jr1Br8yN6hUw@mail.gmail.com>
Message-ID: <20181027162738.7jlvinhyzx766t4a@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2018 at 03:25:29PM +0530, Jagan Teki wrote:
> On Fri, Oct 26, 2018 at 9:43 PM Priit Laes <plaes@plaes.org> wrote:
> >
> > On Fri, Oct 26, 2018 at 08:13:39PM +0530, Jagan Teki wrote:
> > > Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI
> > > LCD panel. Add panel driver for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - new patch
> > > Changes for v2:
> > > - none
> > >
> > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > >  .../gpu/drm/panel/panel-techstar-ts8550b.c    | 346 ++++++++++++++++++
> > >  3 files changed, 356 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/panel/panel-techstar-ts8550b.c
> > >
> > > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > > index 20b88c275421..d0d4e60f5153 100644
> > > --- a/drivers/gpu/drm/panel/Kconfig
> > > +++ b/drivers/gpu/drm/panel/Kconfig
> > > @@ -195,4 +195,13 @@ config DRM_PANEL_SITRONIX_ST7789V
> > >         Say Y here if you want to enable support for the Sitronix
> > >         ST7789V controller for 240x320 LCD panels
> > >
> > > +config DRM_PANEL_TECHSTAR_TS8550B
> > > +     tristate "Techstar TS8550B MIPI-DSI panel driver"
> > > +     depends on OF
> > > +     depends on DRM_MIPI_DSI
> > > +     depends on BACKLIGHT_CLASS_DEVICE
> > > +     help
> > > +       Say Y if you want to enable support for panels based on the
> > > +       Techstar TS8550B MIPI-DSI interface.
> > > +
> > >  endmenu
> > > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > > index 04696bb85218..88011f06edb8 100644
> > > --- a/drivers/gpu/drm/panel/Makefile
> > > +++ b/drivers/gpu/drm/panel/Makefile
> > > @@ -20,3 +20,4 @@ obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
> > >  obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
> > >  obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
> > >  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
> > > +obj-$(CONFIG_DRM_PANEL_TECHSTAR_TS8550B) += panel-techstar-ts8550b.o
> > > diff --git a/drivers/gpu/drm/panel/panel-techstar-ts8550b.c b/drivers/gpu/drm/panel/panel-techstar-ts8550b.c
> > > new file mode 100644
> > > index 000000000000..8baca71595a7
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/panel/panel-techstar-ts8550b.c
> > > @@ -0,0 +1,346 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2019, Amarula Solutions.
> > > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > > + */
> > > +
> > > +#include <linux/backlight.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/fb.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#include <drm/drm_mipi_dsi.h>
> > > +#include <drm/drm_modes.h>
> > > +#include <drm/drm_panel.h>
> > > +
> > > +#include <video/mipi_display.h>
> > > +
> > > +struct ts8550b {
> > > +     struct drm_panel        panel;
> > > +     struct mipi_dsi_device  *dsi;
> > > +
> > > +     struct backlight_device *backlight;
> > > +     struct regulator        *dvdd;
> > > +     struct regulator        *avdd;
> > > +     struct gpio_desc        *reset;
> > > +
> > > +     bool                    is_enabled;
> > > +     bool                    is_prepared;
> > > +};
> > > +
> > > +static inline struct ts8550b *panel_to_ts8550b(struct drm_panel *panel)
> > > +{
> > > +     return container_of(panel, struct ts8550b, panel);
> > > +}
> > > +
> > > +static inline int ts8550b_dcs_write_seq(struct ts8550b *ctx, const void *seq,
> > > +                                     size_t len)
> > > +{
> > > +     return mipi_dsi_dcs_write_buffer(ctx->dsi, seq, len);
> > > +};
> > > +
> > > +#define ts8550b_dcs_write_seq_static(ctx, seq...)            \
> > > +     ({                                                      \
> > > +             static const u8 d[] = { seq };                  \
> > > +             ts8550b_dcs_write_seq(ctx, d, ARRAY_SIZE(d));   \
> > > +     })
> > > +
> > > +static void ts8550b_init_sequence(struct ts8550b *ctx)
> >
> > This seems to be pretty "standard" MIPI-based display, utilizing
> > bunch of manufacturer-specific commands during init sequence.
> >
> > Standard MIPI commands fall between 0x00..0xAF and are defined in <video/mipi.h>
> 
> Where is this file? we have include/video/mipi_display.h with
> 0x00..0xA8. Not all commands in sequence is listed in this, may be I
> will update DCS commands macros and rest as-it-is. what do you think?

Yeah, include/video/mipi_display.h is the header file I was referring to.

Although those three commands I pointed out look like standard DCS command
defines and the order makes sense too:
SOFT_RESET -> magic1 -> EXIT_SLEEP_MODE -> magic2 -> SET_DISPLAY_ON

Until someone finds proper datasheet for this device, those magic1
and magic2 sequenses remain mystery...

P?ikest,
Priit :)
