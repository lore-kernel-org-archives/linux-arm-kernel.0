From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 20 Nov 2018 21:55:42 +0530
Subject: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix VBP size
 calculation
In-Reply-To: <20181120155715.andrjp5kg6ugcv72@flea>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com>
 <20181115095551.uctdkfmuwlnzhjnn@flea>
 <CAMty3ZAEHiovm6OF6JvJVQR4aqpG1Q3ML5YqxJkF2ntwRkUO=A@mail.gmail.com>
 <20181120155715.andrjp5kg6ugcv72@flea>
Message-ID: <CAMty3ZCUOJmvekupOwh281g5HaazTpBbukWQY2Pv2OYypAwciw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 9:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Nov 15, 2018 at 11:19:53PM +0530, Jagan Teki wrote:
> > On Thu, Nov 15, 2018 at 3:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> > > > The horizontal and vertical back porch calculation in BSP
> > > > code is simply following the Linux drm comment diagram, in
> > > > include/drm/drm_modes.h which is
> > > >
> > > > [hv]back porch = [hv]total - [hv]sync_end
> > > >
> > > > BSP code form BPI-M64-bsp is calculating vertical back porch as
> > > > (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
> > > >
> > > > timmings->ver_sync_time= panel_info->lcd_vspw;
> > > > timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
> > > >
> > > > vbp = panel->lcd_vbp;
> > > > vspw = panel->lcd_vspw;
> > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
> > > > dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
> > > > =>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
> > > > =>  timmings->ver_back_porch
> > > > =>  mode->vtotal - mode->end
> > > >
> > > > Which evatually same as mode->vtotal - mode->vsync_end so update the
> > > > same in SUN6I_DSI_BASIC_SIZE0_VBP
> > > >
> > > > On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> > > > value.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > I've tested your changes on my A33 board, and this commit will break
> > > it.
> > >
> > > It creates vblank timeouts, and visual artifacts at the bottom of the
> > > display.
> >
> > Strange, VBP is earlier gives front porch which is anyway wrong.
> >
> > >
> > > Later commits seem to fix the issue, but will create some blanking on
> > > the upper third of the display.
> > >
> > > Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> > > way too expensive, I'd really like to have at least what each of these
> > > commits are actually fixing, and what symptoms each of these were
> > > causing, and not just "the BSP does it".
> >
> > W/o this 2-lane panel is breaking, same vblank timeout and visual
> > artifacts at the bottom of the panel. though the commits may reference
> > BSP, I have at-least tested on 3 different panels for us to prove its
> > working.
> >
> > > Having some datasheet for the panels you had working would help too.
> >
> > Unfortunately datasheet doesn't have any required information what we
> > actually looking for.
>
> Not even the timings? How did you get that information then?

datasheet has timing values, but this changes need controller
information about VBP register that I don't have. But again existing
VBP is not back porch for real, it's front porch.
