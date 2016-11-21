From: yt.shen@mediatek.com (YT Shen)
Date: Mon, 21 Nov 2016 21:59:12 +0800
Subject: [PATCH v9 09/10] drm/mediatek: update DSI sub driver flow for
 sending commands to panel
In-Reply-To: <CAGS+omBCN5BpYZFozkjpnGPHUS2DUZw+B3Vo9LVZYyHLGD+iKQ@mail.gmail.com>
References: <1478865346-19043-1-git-send-email-yt.shen@mediatek.com>
 <1478865346-19043-10-git-send-email-yt.shen@mediatek.com>
 <CAGS+omBCN5BpYZFozkjpnGPHUS2DUZw+B3Vo9LVZYyHLGD+iKQ@mail.gmail.com>
Message-ID: <1479736752.15207.31.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for the review.

On Fri, 2016-11-18 at 11:21 +0800, Daniel Kurtz wrote:
> Hi YT,
> 
> Sorry for the very late review.
> 
> My biggest problem with this patch is it describes itself as adding
> support for a new use case "DSI -> panel", but makes many changes to
> the existing working flow "DSI -> bridge -> panel".
> If these changes are really needed, or improve the existing flow, I'd
> expect to see those changes added first in a preparatory patch,
> followed by a second smaller, simpler
> patch that adds any additional functionality required to enable the new flow.
We will split this patch into several smaller preparatory patches
necessary in the next version.

> 
> See detailed comments inline.
> 
> 
> On Fri, Nov 11, 2016 at 7:55 PM, YT Shen <yt.shen@mediatek.com> wrote:
> >
> > This patch update enable/disable flow of DSI module and MIPI TX module.
> > Original flow works on there is a bridge chip: DSI -> bridge -> panel.
> > In this case: DSI -> panel, the DSI sub driver flow should be updated.
> > We need to initialize DSI first so that we can send commands to panel.
> >
> > Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c     | 110 ++++++++++++++++++++++++++-------
> >  drivers/gpu/drm/mediatek/mtk_mipi_tx.c |  32 +++++-----
> >  2 files changed, 103 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 860b84f..12a1206 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -94,6 +94,8 @@
> >  #define DSI_RACK               0x84
> >  #define RACK                           BIT(0)
> >
> > +#define DSI_MEM_CONTI          0x90
> > +
> >  #define DSI_PHY_LCCON          0x104
> >  #define LC_HS_TX_EN                    BIT(0)
> >  #define LC_ULPM_EN                     BIT(1)
> > @@ -126,6 +128,10 @@
> >  #define CLK_HS_POST                    (0xff << 8)
> >  #define CLK_HS_EXIT                    (0xff << 16)
> >
> > +#define DSI_VM_CMD_CON         0x130
> > +#define VM_CMD_EN                      BIT(0)
> > +#define TS_VFP_EN                      BIT(5)
> > +
> >  #define DSI_CMDQ0              0x180
> >  #define CONFIG                         (0xff << 0)
> >  #define SHORT_PACKET                   0
> > @@ -219,12 +225,12 @@ static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
> >         writel(timcon3, dsi->regs + DSI_PHY_TIMECON3);
> >  }
> >
> > -static void mtk_dsi_enable(struct mtk_dsi *dsi)
> > +static void mtk_dsi_engine_enable(struct mtk_dsi *dsi)
> 
> I don't think we need to change these names.
OK.

> 
> >  {
> >         mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_EN, DSI_EN);
> >  }
> >
> > -static void mtk_dsi_disable(struct mtk_dsi *dsi)
> > +static void mtk_dsi_engine_disable(struct mtk_dsi *dsi)
> >  {
> >         mtk_dsi_mask(dsi, DSI_CON_CTRL, DSI_EN, 0);
> >  }
> > @@ -249,7 +255,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >          * mipi_ratio is mipi clk coefficient for balance the pixel clk in mipi.
> >          * we set mipi_ratio is 1.05.
> >          */
> > -       dsi->data_rate = dsi->vm.pixelclock * 3 * 21 / (1 * 1000 * 10);
> > +       dsi->data_rate = dsi->vm.pixelclock * 12 * 21;
> > +       dsi->data_rate /= (dsi->lanes * 1000 * 10);
> > +       dev_info(dev, "set mipitx's data rate: %dMHz\n", dsi->data_rate);
> 
> I don't think we want to spam the log like this.  Use dev_dbg.... or
> use the DRM_() messaging like elsewhere in this driver?
OK, we will remove logs like this in the patch series.

> 
> >
> >         ret = clk_set_rate(dsi->hs_clk, dsi->data_rate * 1000000);
> >         if (ret < 0) {
> > @@ -271,7 +279,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >                 goto err_disable_engine_clk;
> >         }
> >
> > -       mtk_dsi_enable(dsi);
> > +       mtk_dsi_engine_enable(dsi);
> >         mtk_dsi_reset_engine(dsi);
> >         mtk_dsi_phy_timconfig(dsi);
> >
> > @@ -289,7 +297,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
> >  static void mtk_dsi_clk_ulp_mode_enter(struct mtk_dsi *dsi)
> >  {
> >         mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_HS_TX_EN, 0);
> > -       mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, 0);
> > +       mtk_dsi_mask(dsi, DSI_PHY_LCCON, LC_ULPM_EN, LC_ULPM_EN);
> 
> What does this change do?
> It looks like a pure bug fix (ie, previoulsy we were'nt actually
> enabling ULP MODE before).
> If so, can you please move it to a separate preliminary patch.
OK.

> 
> >  }
> >
> >  static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
> > @@ -302,7 +310,7 @@ static void mtk_dsi_clk_ulp_mode_leave(struct mtk_dsi *dsi)
> >  static void mtk_dsi_lane0_ulp_mode_enter(struct mtk_dsi *dsi)
> >  {
> >         mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_HS_TX_EN, 0);
> > -       mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, 0);
> > +       mtk_dsi_mask(dsi, DSI_PHY_LD0CON, LD0_ULPM_EN, LD0_ULPM_EN);
> 
> Same here.
> 
> >  }
> >
> >  static void mtk_dsi_lane0_ulp_mode_leave(struct mtk_dsi *dsi)
> > @@ -338,11 +346,21 @@ static void mtk_dsi_set_mode(struct mtk_dsi *dsi)
> >                 if ((dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) &&
> >                     !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE))
> >                         vid_mode = BURST_MODE;
> > +               else
> > +                       vid_mode = SYNC_EVENT_MODE;
> 
> So, when do we use SYNC_PULSE_MODE (set just before the 'if')?
We will update this part.

> 
> >         }
> >
> >         writel(vid_mode, dsi->regs + DSI_MODE_CTRL);
> >  }
> >
> > +static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
> > +{
> > +       writel(0x3c, dsi->regs + DSI_MEM_CONTI);
> 
> Please use #defined constants, especially if this register is a bit field.
> Also, this looks like new behavior which doesn't seem related to
> changing the enable order.
> If this is a general fix, please use a separate patch.
We will remove this part.  This change is not necessary.

> 
> > +
> > +       mtk_dsi_mask(dsi, DSI_VM_CMD_CON, VM_CMD_EN, VM_CMD_EN);
> > +       mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
> > +}
> > +
> >  static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
> >  {
> >         struct videomode *vm = &dsi->vm;
> > @@ -399,6 +417,9 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
> >                 break;
> >         }
> >
> > +       tmp_reg |= (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) << 6;
> > +       tmp_reg |= (dsi->mode_flags & MIPI_DSI_MODE_EOT_PACKET) >> 3;
> > +
> 
> ditto
> 
> >         writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
> >  }
> >
> > @@ -477,6 +498,16 @@ static void mtk_dsi_start(struct mtk_dsi *dsi)
> >         writel(1, dsi->regs + DSI_START);
> >  }
> >
> > +static void mtk_dsi_stop(struct mtk_dsi *dsi)
> > +{
> > +       writel(0, dsi->regs + DSI_START);
> > +}
> > +
> > +static void mtk_dsi_set_cmd_mode(struct mtk_dsi *dsi)
> > +{
> > +       writel(CMD_MODE, dsi->regs + DSI_MODE_CTRL);
> > +}
> > +
> >  static void mtk_dsi_set_interrupt_enable(struct mtk_dsi *dsi)
> >  {
> >         u32 inten = LPRX_RD_RDY_INT_FLAG | CMD_DONE_INT_FLAG | VM_DONE_INT_FLAG;
> > @@ -506,7 +537,7 @@ static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
> >         if (ret == 0) {
> >                 dev_info(dsi->dev, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
> >
> > -               mtk_dsi_enable(dsi);
> > +               mtk_dsi_engine_enable(dsi);
> >                 mtk_dsi_reset_engine(dsi);
> >         }
> >
> > @@ -535,6 +566,17 @@ static irqreturn_t mtk_dsi_irq(int irq, void *dev_id)
> >         return IRQ_HANDLED;
> >  }
> >
> > +static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
> > +{
> > +       mtk_dsi_irq_data_clear(dsi, irq_flag);
> > +       mtk_dsi_set_cmd_mode(dsi);
> > +
> > +       if (!mtk_dsi_wait_for_irq_done(dsi, irq_flag, t))
> > +               return -1;
> 
> No, use a real linux errno, and return an int, and print an error
> message if this is unexpected.
Will use a real errno: ETIME.

> 
> > +       else
> > +               return 0;
> > +}
> > +
> >  static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
> >  {
> >         if (WARN_ON(dsi->refcount == 0))
> > @@ -543,11 +585,6 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
> >         if (--dsi->refcount != 0)
> >                 return;
> >
> > -       mtk_dsi_lane0_ulp_mode_enter(dsi);
> > -       mtk_dsi_clk_ulp_mode_enter(dsi);
> > -
> > -       mtk_dsi_disable(dsi);
> > -
> >         clk_disable_unprepare(dsi->engine_clk);
> >         clk_disable_unprepare(dsi->digital_clk);
> >
> > @@ -561,35 +598,45 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
> >         if (dsi->enabled)
> >                 return;
> >
> > -       if (dsi->panel) {
> > -               if (drm_panel_prepare(dsi->panel)) {
> > -                       DRM_ERROR("failed to setup the panel\n");
> > -                       return;
> > -               }
> > -       }
> > -
> >         ret = mtk_dsi_poweron(dsi);
> >         if (ret < 0) {
> >                 DRM_ERROR("failed to power on dsi\n");
> >                 return;
> >         }
> >
> > +       usleep_range(20000, 21000);
> > +
> 
> Why are you adding a 20 ms delay where there was none before?
After checking, we will remove redundant codes and the delay.

> 
> >         mtk_dsi_rxtx_control(dsi);
> > +       mtk_dsi_phy_timconfig(dsi);
> > +       mtk_dsi_ps_control_vact(dsi);
> > +       mtk_dsi_set_vm_cmd(dsi);
> > +       mtk_dsi_config_vdo_timing(dsi);
> > +       mtk_dsi_set_interrupt_enable(dsi);
> >
> > +       mtk_dsi_engine_enable(dsi);
> >         mtk_dsi_clk_ulp_mode_leave(dsi);
> >         mtk_dsi_lane0_ulp_mode_leave(dsi);
> >         mtk_dsi_clk_hs_mode(dsi, 0);
> > -       mtk_dsi_set_mode(dsi);
> >
> > -       mtk_dsi_ps_control_vact(dsi);
> > -       mtk_dsi_config_vdo_timing(dsi);
> > -       mtk_dsi_set_interrupt_enable(dsi);
> > +       if (dsi->panel) {
> > +               if (drm_panel_prepare(dsi->panel)) {
> > +                       DRM_ERROR("failed to prepare the panel\n");
> > +                       return;
> > +               }
> > +       }
> >
> >         mtk_dsi_set_mode(dsi);
> >         mtk_dsi_clk_hs_mode(dsi, 1);
> >
> >         mtk_dsi_start(dsi);
> >
> > +       if (dsi->panel) {
> > +               if (drm_panel_enable(dsi->panel)) {
> > +                       DRM_ERROR("failed to enable the panel\n");
> 
> In case of error, you must undo everything done to this point.  At least:
>  (1) unprepare the panel
>  (2) stop dsi
>  (3) poweroff dsi
OK.

> 
> > +                       return;
> > +               }
> > +       }
> > +
> >         dsi->enabled = true;
> >  }
> >
> > @@ -605,6 +652,21 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
> >                 }
> >         }
> >
> > +       mtk_dsi_stop(dsi);
> > +       mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
> 
> This function can return an error, so please check it.  Although,
> there probably isn't much you can do here about it.
OK.

> 
> > +
> > +       if (dsi->panel) {
> > +               if (drm_panel_unprepare(dsi->panel)) {
> > +                       DRM_ERROR("failed to unprepare the panel\n");
> > +                       return;
> 
> I think you should probably just ignore this error and continue
> disabling dsi, since it isn't really recoverable and you can't roll
> back and re-enable dsi.
OK.

> 
> 
> > +               }
> > +       }
> > +
> > +       mtk_dsi_reset_engine(dsi);
> > +       mtk_dsi_lane0_ulp_mode_enter(dsi);
> > +       mtk_dsi_clk_ulp_mode_enter(dsi);
> > +       mtk_dsi_engine_disable(dsi);
> > +
> >         mtk_dsi_poweroff(dsi);
> >
> >         dsi->enabled = false;
> > @@ -845,7 +907,7 @@ static void mtk_dsi_wait_for_idle(struct mtk_dsi *dsi)
> >         if (timeout_ms == 0) {
> >                 dev_info(dsi->dev, "polling dsi wait not busy timeout!\n");
> >
> > -               mtk_dsi_enable(dsi);
> > +               mtk_dsi_engine_enable(dsi);
> >                 mtk_dsi_reset_engine(dsi);
> >         }
> >  }
> > diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > index 108d31a..34e95c6 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> > @@ -177,7 +177,9 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> >
> >         dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
> >
> > -       if (mipi_tx->data_rate >= 500000000) {
> > +       if (mipi_tx->data_rate > 1250000000) {
> > +               return -EINVAL;
> > +       } else if (mipi_tx->data_rate >= 500000000) {
> 
> Capping the max data rate looks like an unrelated fix.
Will prepare additional patch for max data rate.

> 
> >                 txdiv = 1;
> >                 txdiv0 = 0;
> >                 txdiv1 = 0;
> > @@ -201,6 +203,10 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> >                 return -EINVAL;
> >         }
> >
> > +       mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> > +                               RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
> > +                               (8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
> > +
> >         mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_BG_CON,
> >                                 RG_DSI_VOUT_MSK |
> >                                 RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN,
> > @@ -210,24 +216,18 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> >
> >         usleep_range(30, 100);
> >
> > -       mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> > -                               RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
> > -                               (8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
> > -
> > -       mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_CON,
> > -                            RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
> > +       mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_CON,
> > +                               RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN,
> > +                               RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
> 
> Changing from set_bits to update_bits does not do anything.  Please
> leave this alone.
OK.

> 
> >
> >         mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
> >                                 RG_DSI_MPPLL_SDM_PWR_ON |
> >                                 RG_DSI_MPPLL_SDM_ISO_EN,
> >                                 RG_DSI_MPPLL_SDM_PWR_ON);
> >
> > -       mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> > -                              RG_DSI_MPPLL_PLL_EN);
> > -
> 
> Why don't you need to disable the PLL first now?
Yes, we need.  Will fix this.

> 
> >         mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> > -                               RG_DSI_MPPLL_TXDIV0 | RG_DSI_MPPLL_TXDIV1 |
> > -                               RG_DSI_MPPLL_PREDIV,
> > +                               RG_DSI_MPPLL_PREDIV | RG_DSI_MPPLL_TXDIV0 |
> > +                               RG_DSI_MPPLL_TXDIV1 | RG_DSI_MPPLL_POSDIV,
> >                                 (txdiv0 << 3) | (txdiv1 << 5));
> 
> If I read this right, the only thing you are changing is clearing
> "RG_DSI_MPPLL_POSDIV".
> This would be more clear if you kept the field order: TXDIV0, TXDIV1, PREDIV.
> 
> And why are you making this change in this patch?
Hmm, we will provide another patch for this part if necessary.
Sometimes settings are changed not in kernel stage (maybe display from
bootloader)  This change just make sure kernel have the right
configuration.

> 
> 
> >
> >         /*
> > @@ -242,10 +242,12 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> >                       26000000);
> >         writel(pcw, mipi_tx->regs + MIPITX_DSI_PLL_CON2);
> >
> > -       mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
> > -                            RG_DSI_MPPLL_SDM_FRA_EN);
> > +       mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
> > +                               RG_DSI_MPPLL_SDM_FRA_EN,
> > +                               RG_DSI_MPPLL_SDM_FRA_EN);
> 
> AFAICT, this change does not do anything but make the code more confusing.
OK.

> 
> >
> > -       mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON0, RG_DSI_MPPLL_PLL_EN);
> > +       mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> > +                               RG_DSI_MPPLL_PLL_EN, RG_DSI_MPPLL_PLL_EN);
> 
> AFAICT, this change does not do anything but make the code more confusing.
OK.

> 
> >
> >         usleep_range(20, 100);
> >
> > --
> > 1.9.1
> >
