From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jun 2017 21:27:44 +0200
Subject: [PATCH 14/19] drm/sun4i: hdmi: Add support for A31's HDMI
 controller
In-Reply-To: <CAGb2v65eFAmAybmHkQcKjF+ZKxh+_G6q9i2GPzMs5854X8bQug@mail.gmail.com>
References: <20170602101024.18940-1-wens@csie.org>
 <20170602101024.18940-15-wens@csie.org>
 <20170602194110.goale2ssyg5vuqiv@flea.lan>
 <CAGb2v65eFAmAybmHkQcKjF+ZKxh+_G6q9i2GPzMs5854X8bQug@mail.gmail.com>
Message-ID: <20170606192744.sktuiwm3udn623gt@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 03, 2017 at 11:19:09PM +0800, Chen-Yu Tsai wrote:
> On Sat, Jun 3, 2017 at 3:41 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, Jun 02, 2017 at 06:10:19PM +0800, Chen-Yu Tsai wrote:
> >> The HDMI controller found in the A31 SoCs is slightly different
> >> from the one already supported, which is found in the A10s:
> >>
> >>   - Need different initial values for the PLL related registers
> >>
> >>   - Different behavior of the DDC and TMDS clocks
> >>
> >>   - Different register layout for the DDC portion
> >>
> >>   - Separate DDC parent clock
> >>
> >> This patch adds support for it.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  drivers/gpu/drm/sun4i/sun4i_hdmi.h     |   3 +
> >>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 141 +++++++++++++++++++++++++++++++++
> >>  2 files changed, 144 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> >> index c63d0bd95963..2589bc92be59 100644
> >> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> >> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> >> @@ -56,10 +56,13 @@
> >>  #define SUN4I_HDMI_PAD_CTRL0_TXEN            BIT(23)
> >>
> >>  #define SUN4I_HDMI_PAD_CTRL1_REG     0x204
> >> +#define SUN4I_HDMI_PAD_CTRL1_UNKNOWN         BIT(24) /* set on A31 */
> >>  #define SUN4I_HDMI_PAD_CTRL1_AMP_OPT         BIT(23)
> >>  #define SUN4I_HDMI_PAD_CTRL1_AMPCK_OPT               BIT(22)
> >>  #define SUN4I_HDMI_PAD_CTRL1_EMP_OPT         BIT(20)
> >>  #define SUN4I_HDMI_PAD_CTRL1_EMPCK_OPT               BIT(19)
> >> +#define SUN4I_HDMI_PAD_CTRL1_PWSCK           BIT(18)
> >> +#define SUN4I_HDMI_PAD_CTRL1_PWSDT           BIT(17)
> >>  #define SUN4I_HDMI_PAD_CTRL1_REG_DEN         BIT(15)
> >>  #define SUN4I_HDMI_PAD_CTRL1_REG_DENCK               BIT(14)
> >>  #define SUN4I_HDMI_PAD_CTRL1_REG_EMP(n)              (((n) & 7) << 10)
> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> >> index 9ded40aaed32..e9abf93eb41c 100644
> >> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> >> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> >> @@ -293,6 +293,109 @@ static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs
> >>       .get_modes      = sun4i_hdmi_get_modes,
> >>  };
> >>
> >> +static int sun6i_hdmi_read_sub_block(struct sun4i_hdmi *hdmi,
> >> +                                  unsigned int blk, unsigned int offset,
> >> +                                  u8 *buf, unsigned int count)
> >> +{
> >> +     unsigned long reg;
> >> +     int i;
> >> +
> >> +     reg = readl(hdmi->base + SUN6I_HDMI_DDC_FIFO_CTRL_REG);
> >> +     writel(reg | SUN6I_HDMI_DDC_FIFO_CTRL_CLEAR,
> >> +            hdmi->base + SUN6I_HDMI_DDC_FIFO_CTRL_REG);
> >> +     writel(SUN6I_HDMI_DDC_ADDR_SEGMENT(offset >> 8) |
> >> +            SUN6I_HDMI_DDC_ADDR_EDDC(DDC_SEGMENT_ADDR << 1) |
> >> +            SUN6I_HDMI_DDC_ADDR_OFFSET(offset) |
> >> +            SUN6I_HDMI_DDC_ADDR_SLAVE(DDC_ADDR),
> >> +            hdmi->base + SUN6I_HDMI_DDC_ADDR_REG);
> >> +
> >> +     writel(SUN6I_HDMI_DDC_CMD_EXPLICIT_EDDC_READ |
> >> +            SUN6I_HDMI_DDC_CMD_BYTE_COUNT(count),
> >> +            hdmi->base + SUN6I_HDMI_DDC_CMD_REG);
> >> +
> >> +     reg = readl(hdmi->base + SUN6I_HDMI_DDC_CTRL_REG);
> >> +     writel(reg | SUN6I_HDMI_DDC_CTRL_START_CMD,
> >> +            hdmi->base + SUN6I_HDMI_DDC_CTRL_REG);
> >> +
> >> +     if (readl_poll_timeout(hdmi->base + SUN6I_HDMI_DDC_CTRL_REG, reg,
> >> +                            !(reg & SUN6I_HDMI_DDC_CTRL_START_CMD),
> >> +                            100, 100000))
> >> +             return -EIO;
> >> +
> >> +     for (i = 0; i < count; i++)
> >> +             buf[i] = readb(hdmi->base + SUN6I_HDMI_DDC_FIFO_DATA_REG);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int sun6i_hdmi_read_edid_block(void *data, u8 *buf, unsigned int blk,
> >> +                                   size_t length)
> >> +{
> >> +     struct sun4i_hdmi *hdmi = data;
> >> +     int retry = 2, i;
> >> +
> >> +     do {
> >> +             for (i = 0; i < length; i += SUN4I_HDMI_DDC_FIFO_SIZE) {
> >> +                     unsigned char offset = blk * EDID_LENGTH + i;
> >> +                     unsigned int count = min((unsigned int)SUN4I_HDMI_DDC_FIFO_SIZE,
> >> +                                              length - i);
> >> +                     int ret;
> >> +
> >> +                     ret = sun6i_hdmi_read_sub_block(hdmi, blk, offset,
> >> +                                                     buf + i, count);
> >> +                     if (ret)
> >> +                             return ret;
> >> +             }
> >> +     } while (!drm_edid_block_valid(buf, blk, true, NULL) && (retry--));
> >> +
> >> +     return 0;
> >> +}
> >> +
> >> +static int sun6i_hdmi_get_modes(struct drm_connector *connector)
> >> +{
> >> +     struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
> >> +     u32 reg;
> >> +     struct edid *edid;
> >> +     int ret;
> >> +
> >> +     clk_set_rate(hdmi->ddc_clk, 100000);
> >> +     clk_prepare_enable(hdmi->ddc_clk);
> >> +
> >> +     /* Reset i2c controller */
> >> +     writel(SUN6I_HDMI_DDC_CTRL_ENABLE | SUN6I_HDMI_DDC_CTRL_RESET |
> >> +            SUN6I_HDMI_DDC_CTRL_SDA_ENABLE |
> >> +            SUN6I_HDMI_DDC_CTRL_SCL_ENABLE,
> >> +            hdmi->base + SUN6I_HDMI_DDC_CTRL_REG);
> >> +     if (readl_poll_timeout(hdmi->base + SUN6I_HDMI_DDC_CTRL_REG, reg,
> >> +                            !(reg & SUN6I_HDMI_DDC_CTRL_RESET),
> >> +                            100, 2000)) {
> >> +             dev_err(hdmi->dev, "DDC reset timeout: %08x\n", reg);
> >> +             clk_disable_unprepare(hdmi->ddc_clk);
> >> +             return -EIO;
> >> +     }
> >> +
> >> +     edid = drm_do_get_edid(connector, sun6i_hdmi_read_edid_block, hdmi);
> >> +
> >> +     clk_disable_unprepare(hdmi->ddc_clk);
> >> +
> >> +     if (!edid)
> >> +             return 0;
> >> +
> >> +     hdmi->hdmi_monitor = drm_detect_hdmi_monitor(edid);
> >> +     DRM_DEBUG_DRIVER("Monitor is %s monitor\n",
> >> +                      hdmi->hdmi_monitor ? "an HDMI" : "a DVI");
> >> +
> >> +     drm_mode_connector_update_edid_property(connector, edid);
> >> +     ret = drm_add_edid_modes(connector, edid);
> >> +     kfree(edid);
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static const struct drm_connector_helper_funcs sun6i_hdmi_connector_helper_funcs = {
> >> +     .get_modes      = sun6i_hdmi_get_modes,
> >> +};
> >> +
> >
> > Every thing here can be handled through regfield without having to
> > duplicate the logic.
> 
> Hmm... You're right. Does that mean we should convert the entire driver to
> using regmap? Or just the DDC bits here, since they won't conflict with
> any other access patterns in the whole HDMI driver?

I guess we could just convert everything (and I wish I would have done
it before...)

> >>  static enum drm_connector_status
> >>  sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
> >>  {
> >> @@ -367,6 +470,43 @@ static const struct sun4i_hdmi_variant sun5i_variant = {
> >>                                 SUN4I_HDMI_PLL_CTRL_PLL_EN,
> >>  };
> >>
> >> +static const struct sun4i_hdmi_variant sun6i_variant = {
> >> +     .connector_helpers      = &sun6i_hdmi_connector_helper_funcs,
> >> +     .ddc_create             = sun6i_ddc_create,
> >> +     .tmds_create            = sun6i_tmds_create,
> >> +     .has_ddc_parent_clk     = true,
> >> +     .has_reset_control      = true,
> >> +     .pad_ctrl0_init_val     = 0xff |
> >
> > What is this 0xff for?
> 
> Unknown. It is set in the mainline U-boot driver.
> 
> Looking at an old 3.3 kernel from the BSP, it seems the higher 4 bits
> control the transmitter. But the lower 4 bits are still unknown.

Can you add a comment for that?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/54a794d9/attachment.sig>
