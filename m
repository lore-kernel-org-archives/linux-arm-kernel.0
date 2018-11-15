From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 15 Nov 2018 10:55:51 +0100
Subject: [PATCH v4 08/26] drm/sun4i: sun6i_mipi_dsi: Fix VBP size
 calculation
In-Reply-To: <20181113111633.20189-9-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-9-jagan@amarulasolutions.com>
Message-ID: <20181115095551.uctdkfmuwlnzhjnn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 13, 2018 at 04:46:15PM +0530, Jagan Teki wrote:
> The horizontal and vertical back porch calculation in BSP
> code is simply following the Linux drm comment diagram, in
> include/drm/drm_modes.h which is
> 
> [hv]back porch = [hv]total - [hv]sync_end
> 
> BSP code form BPI-M64-bsp is calculating vertical back porch as
> (from linux-sunxi/drivers/video/sunxi/disp2/disp/de/disp_lcd.c)
> 
> timmings->ver_sync_time= panel_info->lcd_vspw;
> timmings->ver_back_porch= panel_info->lcd_vbp-panel_info->lcd_vspw;
> 
> vbp = panel->lcd_vbp;
> vspw = panel->lcd_vspw;
> dsi_dev[sel]->dsi_basic_size0.bits.vbp = vbp-vspw;
> dsi_dev[sel]->dsi_basic_size0.bits.vbp = panel->lcd_vbp - panel->lcd_vspw;
> =>  timmings->ver_back_porch + panel_info->lcd_vspw - panel_info->lcd_vspw
> =>  timmings->ver_back_porch
> =>  mode->vtotal - mode->end
> 
> Which evatually same as mode->vtotal - mode->vsync_end so update the
> same in SUN6I_DSI_BASIC_SIZE0_VBP
> 
> On the information note, existing SUN6I_DSI_BASIC_SIZE0_VSA is proper
> value.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

I've tested your changes on my A33 board, and this commit will break
it.

It creates vblank timeouts, and visual artifacts at the bottom of the
display.

Later commits seem to fix the issue, but will create some blanking on
the upper third of the display.

Since the documentation is quite sparse, and a MIPI-DSI analyzer is
way too expensive, I'd really like to have at least what each of these
commits are actually fixing, and what symptoms each of these were
causing, and not just "the BSP does it".

Having some datasheet for the panels you had working would help too.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181115/4721cf66/attachment.sig>
