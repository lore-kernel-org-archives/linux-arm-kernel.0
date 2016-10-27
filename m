From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 27 Oct 2016 22:42:53 +0800
Subject: [PATCH v3 2/3] drm: zte: add initial vou drm driver
In-Reply-To: <CAOw6vbKbdWJ8eJD3oXwPd6-ykaOu+QP6isqAz8HkjS0p+2wX=w@mail.gmail.com>
Message-ID: <20161027144132.GR30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Oct 20, 2016 at 3:30 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > It adds the initial ZTE VOU display controller DRM driver.  There are
> > still some features to be added, like overlay plane, scaling, and more
> > output devices support.  But it's already useful with dual CRTCs and
> > HDMI monitor working.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

<snip>

> > +static int zx_drm_bind(struct device *dev)
> > +{
> > +       struct drm_device *drm;
> > +       struct zx_drm_private *priv;
> > +       int ret;
> > +
> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       drm = drm_dev_alloc(&zx_drm_driver, dev);
> > +       if (!drm)
> > +               return -ENOMEM;
> > +
> > +       drm->dev_private = priv;
> > +       dev_set_drvdata(dev, drm);
> > +
> > +       drm_mode_config_init(drm);
> > +       drm->mode_config.min_width = 16;
> > +       drm->mode_config.min_height = 16;
> > +       drm->mode_config.max_width = 4096;
> > +       drm->mode_config.max_height = 4096;
> > +       drm->mode_config.funcs = &zx_drm_mode_config_funcs;
> > +
> > +       ret = component_bind_all(dev, drm);
> > +       if (ret) {
> > +               dev_err(dev, "failed to bind all components: %d\n", ret);
> 
> Consider using the new DRM_DEV_* messages instead of the plain old dev_*

Okay, I will switch to DRM_DEV_* for log messages.

> 
> > +               goto out_unregister;
> > +       }
> > +
> > +       ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
> > +       if (ret < 0) {
> > +               dev_err(dev, "failed to init vblank: %d\n", ret);
> > +               goto out_unbind;
> > +       }
> > +
> > +       /*
> > +        * We will manage irq handler on our own.  In this case, irq_enabled
> > +        * need to be true for using vblank core support.
> > +        */
> > +       drm->irq_enabled = true;
> > +
> > +       drm_mode_config_reset(drm);
> > +       drm_kms_helper_poll_init(drm);
> > +
> > +       priv->fbdev = drm_fbdev_cma_init(drm, 32, drm->mode_config.num_crtc,
> > +                                        drm->mode_config.num_connector);
> > +       if (IS_ERR(priv->fbdev)) {
> > +               ret = PTR_ERR(priv->fbdev);
> > +               dev_err(dev, "failed to init cma fbdev: %d\n", ret);
> > +               priv->fbdev = NULL;
> > +               goto out_poll_fini;
> > +       }
> > +
> > +       ret = drm_dev_register(drm, 0);
> > +       if (ret)
> > +               goto out_fbdev_fini;
> > +
> > +       return 0;
> > +
> > +out_fbdev_fini:
> > +       if (priv->fbdev) {
> > +               drm_fbdev_cma_fini(priv->fbdev);
> > +               priv->fbdev = NULL;
> > +       }
> > +out_poll_fini:
> > +       drm_kms_helper_poll_fini(drm);
> > +       drm_mode_config_cleanup(drm);
> > +       drm_vblank_cleanup(drm);
> > +out_unbind:
> > +       component_unbind_all(dev, drm);
> > +out_unregister:
> > +       dev_set_drvdata(dev, NULL);
> > +       drm->dev_private = NULL;
> > +       drm_dev_unref(drm);
> > +       return ret;
> > +}

<snip>

> > +static int zx_hdmi_i2c_read(struct zx_hdmi *hdmi, struct i2c_msg *msg)
> > +{
> > +       int len = msg->len;
> > +       u8 *buf = msg->buf;
> > +       int retry = 0;
> > +       int ret = 0;
> > +
> > +       /* Bits [9:8] of bytes */
> > +       hdmi_writeb(hdmi, ZX_DDC_DIN_CNT2, (len >> 8) & 0xff);
> > +       /* Bits [7:0] of bytes */
> > +       hdmi_writeb(hdmi, ZX_DDC_DIN_CNT1, len & 0xff);
> > +
> > +       /* Clear FIFO */
> > +       hdmi_writeb_mask(hdmi, ZX_DDC_CMD, DDC_CMD_MASK, DDC_CMD_CLEAR_FIFO);
> > +
> > +       /* Kick off the read */
> > +       hdmi_writeb_mask(hdmi, ZX_DDC_CMD, DDC_CMD_MASK,
> > +                        DDC_CMD_SEQUENTIAL_READ);
> > +
> > +       while (len > 0) {
> > +               int cnt, i;
> > +
> > +               /* FIFO needs some time to get ready */
> > +               usleep_range(500, 1000);
> > +
> > +               cnt = hdmi_readb(hdmi, ZX_DDC_DOUT_CNT) & DDC_DOUT_CNT_MASK;
> > +               if (cnt == 0) {
> > +                       if (++retry > 5) {
> > +                               dev_err(hdmi->dev, "DDC FIFO read timed out!");
> > +                               ret = -ETIMEDOUT;
> > +                               break;
> 
> Why not just return -ETIMEDOUT here?

Yes.  Stupid me.

> > +                       }
> > +                       continue;
> > +               }
> > +
> > +               for (i = 0; i < cnt; i++)
> > +                       *buf++ = hdmi_readb(hdmi, ZX_DDC_DATA);
> > +               len -= cnt;
> > +       }
> > +
> > +       return ret;
> > +}

<snip>

> > +static int zx_hdmi_bind(struct device *dev, struct device *master, void *data)
> > +{
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct drm_device *drm = data;
> > +       struct resource *res;
> > +       struct zx_hdmi *hdmi;
> > +       int irq;
> > +       int ret;
> > +
> > +       hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> > +       if (!hdmi)
> > +               return -ENOMEM;
> > +
> > +       hdmi->dev = dev;
> > +       hdmi->drm = drm;
> > +       hdmi->inf = &vou_inf_hdmi;
> > +
> > +       dev_set_drvdata(dev, hdmi);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       hdmi->mmio = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(hdmi->mmio)) {
> > +               ret = PTR_ERR(hdmi->mmio);
> > +               dev_err(dev, "failed to remap hdmi region: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq < 0)
> > +               return irq;
> > +
> > +       hdmi->cec_clk = devm_clk_get(hdmi->dev, "osc_cec");
> > +       if (IS_ERR(hdmi->cec_clk)) {
> > +               ret = PTR_ERR(hdmi->cec_clk);
> > +               dev_err(dev, "failed to get cec_clk: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       hdmi->osc_clk = devm_clk_get(hdmi->dev, "osc_clk");
> > +       if (IS_ERR(hdmi->osc_clk)) {
> > +               ret = PTR_ERR(hdmi->osc_clk);
> > +               dev_err(dev, "failed to get osc_clk: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       hdmi->xclk = devm_clk_get(hdmi->dev, "xclk");
> > +       if (IS_ERR(hdmi->xclk)) {
> > +               ret = PTR_ERR(hdmi->xclk);
> > +               dev_err(dev, "failed to get xclk: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       zx_hdmi_hw_init(hdmi);
> > +
> > +       ret = clk_prepare_enable(hdmi->cec_clk);
> > +       if (ret) {
> > +               dev_err(dev, "failed to enable cec_clk: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = clk_prepare_enable(hdmi->osc_clk);
> > +       if (ret) {
> > +               dev_err(dev, "failed to enable osc_clk: %d\n", ret);
> > +               goto disable_cec_clk;
> > +       }
> > +
> > +       ret = clk_prepare_enable(hdmi->xclk);
> > +       if (ret) {
> > +               dev_err(dev, "failed to enable xclk: %d\n", ret);
> > +               goto disable_osc_clk;
> > +       }
> 
> Perhaps add a TODO above hdmi_hw_init() to move it and the clock
> enables to .enable and conversely implement .disable?

Instead of leaving a TODO item there, I would like to change it right
away in the next version.

> > +
> > +
> > +       ret = zx_hdmi_ddc_register(hdmi);
> > +       if (ret) {
> > +               dev_err(dev, "failed to register ddc: %d\n", ret);
> > +               goto disable_xclk;
> > +       }
> > +
> > +       ret = zx_hdmi_register(drm, hdmi);
> > +       if (ret) {
> > +               dev_err(dev, "failed to register hdmi: %d\n", ret);
> > +               goto disable_xclk;
> > +       }
> > +
> > +       ret = devm_request_threaded_irq(dev, irq, zx_hdmi_irq_handler,
> > +                                       zx_hdmi_irq_thread, IRQF_SHARED,
> > +                                       dev_name(dev), hdmi);
> > +       if (ret) {
> > +               dev_err(dev, "failed to request threaded irq: %d\n", ret);
> > +               goto disable_xclk;
> > +       }
> > +
> > +       return 0;
> > +
> > +disable_xclk:
> > +       clk_disable_unprepare(hdmi->xclk);
> > +disable_osc_clk:
> > +       clk_disable_unprepare(hdmi->osc_clk);
> > +disable_cec_clk:
> > +       clk_disable_unprepare(hdmi->cec_clk);
> > +       return ret;
> > +}

<snip>

> > +static int zx_gl_plane_atomic_check(struct drm_plane *plane,
> > +                                   struct drm_plane_state *plane_state)
> > +{
> > +       struct drm_framebuffer *fb = plane_state->fb;
> > +       struct drm_crtc *crtc = plane_state->crtc;
> > +       struct drm_crtc_state *crtc_state;
> > +       struct drm_rect clip;
> > +
> > +       if (!crtc || !fb)
> > +               return 0;
> > +
> > +       crtc_state = drm_atomic_get_existing_crtc_state(plane_state->state,
> > +                                                       crtc);
> > +       if (WARN_ON(!crtc_state))
> > +               return -EINVAL;
> > +
> > +       /* plane must match crtc enable state */
> > +       if (crtc_state->enable != !!plane_state->crtc)
> > +               return -EINVAL;
> > +
> > +       /* nothing to check when disabling or disabled */
> > +       if (!crtc_state->enable)
> > +               return 0;
> 
> I think you can shuffle things around here to read a bit clearer:
> 
> if (!crtc_state->enable)
>         return 0;
> 
> if (!plane_state->crtc)
>         return -EINVAL

Indeed.

> > +
> > +       clip.x1 = 0;
> > +       clip.y1 = 0;
> > +       clip.x2 = crtc_state->adjusted_mode.hdisplay;
> > +       clip.y2 = crtc_state->adjusted_mode.vdisplay;
> > +
> > +       return drm_plane_helper_check_state(plane_state, &clip,
> > +                                           DRM_PLANE_HELPER_NO_SCALING,
> > +                                           DRM_PLANE_HELPER_NO_SCALING,
> > +                                           false, true);
> > +}

<snip>

> > +/* Sub-module offset */
> > +#define MAIN_GL_OFFSET                 0x130
> > +#define MAIN_CSC_OFFSET                        0x580
> > +#define MAIN_HBSC_OFFSET               0x820
> > +#define MAIN_RSZ_OFFSET                        0x600 /* OTFPPU sub-module */
> > +
> > +#define AUX_GL_OFFSET                  0x200
> > +#define AUX_CSC_OFFSET                 0x5d0
> > +#define AUX_HBSC_OFFSET                        0x860
> > +#define AUX_RSZ_OFFSET                 0x800
> > +
> > +/* OSD (GPC_GLOBAL) registers */
> > +#define OSD_INT_STA                    0x04
> > +#define OSD_INT_CLRSTA                 0x08
> > +#define OSD_INT_MSK                    0x0c
> > +#define OSD_INT_AUX_UPT                        BIT(14)
> > +#define OSD_INT_MAIN_UPT               BIT(13)
> > +#define OSD_INT_GL1_LBW                        BIT(10)
> > +#define OSD_INT_GL0_LBW                        BIT(9)
> > +#define OSD_INT_VL2_LBW                        BIT(8)
> > +#define OSD_INT_VL1_LBW                        BIT(7)
> > +#define OSD_INT_VL0_LBW                        BIT(6)
> > +#define OSD_INT_BUS_ERR                        BIT(3)
> > +#define OSD_INT_CFG_ERR                        BIT(2)
> > +#define OSD_INT_ERROR (\
> > +       OSD_INT_GL1_LBW | OSD_INT_GL0_LBW | \
> > +       OSD_INT_VL2_LBW | OSD_INT_VL1_LBW | OSD_INT_VL0_LBW | \
> > +       OSD_INT_BUS_ERR | OSD_INT_CFG_ERR \
> > +)
> > +#define OSD_INT_ENABLE (OSD_INT_ERROR | OSD_INT_AUX_UPT | OSD_INT_MAIN_UPT)
> > +#define OSD_CTRL0                      0x10
> > +#define OSD_CTRL0_GL0_EN               BIT(7)
> > +#define OSD_CTRL0_GL0_SEL              BIT(6)
> > +#define OSD_CTRL0_GL1_EN               BIT(5)
> > +#define OSD_CTRL0_GL1_SEL              BIT(4)
> > +#define OSD_RST_CLR                    0x1c
> > +#define RST_PER_FRAME                  BIT(19)
> > +
> > +/* Main/Aux channel registers */
> > +#define OSD_MAIN_CHN                   0x470
> > +#define OSD_AUX_CHN                    0x4d0
> > +#define CHN_CTRL0                      0x00
> > +#define CHN_ENABLE                     BIT(0)
> > +#define CHN_CTRL1                      0x04
> > +#define CHN_SCREEN_W_SHIFT             18
> > +#define CHN_SCREEN_W_MASK              (0x1fff << CHN_SCREEN_W_SHIFT)
> > +#define CHN_SCREEN_H_SHIFT             5
> > +#define CHN_SCREEN_H_MASK              (0x1fff << CHN_SCREEN_H_SHIFT)
> > +#define CHN_UPDATE                     0x08
> > +
> > +/* TIMING_CTRL registers */
> > +#define TIMING_TC_ENABLE               0x04
> > +#define AUX_TC_EN                      BIT(1)
> > +#define MAIN_TC_EN                     BIT(0)
> > +#define FIR_MAIN_ACTIVE                        0x08
> > +#define FIR_AUX_ACTIVE                 0x0c
> > +#define V_ACTIVE_SHIFT                 16
> > +#define V_ACTIVE_MASK                  (0xffff << V_ACTIVE_SHIFT)
> > +#define H_ACTIVE_SHIFT                 0
> > +#define H_ACTIVE_MASK                  (0xffff << H_ACTIVE_SHIFT)
> > +#define FIR_MAIN_H_TIMING              0x10
> > +#define FIR_MAIN_V_TIMING              0x14
> > +#define FIR_AUX_H_TIMING               0x18
> > +#define FIR_AUX_V_TIMING               0x1c
> > +#define SYNC_WIDE_SHIFT                        22
> > +#define SYNC_WIDE_MASK                 (0x3ff << SYNC_WIDE_SHIFT)
> > +#define BACK_PORCH_SHIFT               11
> > +#define BACK_PORCH_MASK                        (0x7ff << BACK_PORCH_SHIFT)
> > +#define FRONT_PORCH_SHIFT              0
> > +#define FRONT_PORCH_MASK               (0x7ff << FRONT_PORCH_SHIFT)
> > +#define TIMING_CTRL                    0x20
> > +#define AUX_POL_SHIFT                  3
> > +#define AUX_POL_MASK                   (0x7 << AUX_POL_SHIFT)
> > +#define MAIN_POL_SHIFT                 0
> > +#define MAIN_POL_MASK                  (0x7 << MAIN_POL_SHIFT)
> > +#define POL_DE_SHIFT                   2
> > +#define POL_VSYNC_SHIFT                        1
> > +#define POL_HSYNC_SHIFT                        0
> > +#define TIMING_INT_CTRL                        0x24
> > +#define TIMING_INT_STATE               0x28
> > +#define TIMING_INT_AUX_FRAME           BIT(3)
> > +#define TIMING_INT_MAIN_FRAME          BIT(1)
> > +#define TIMING_INT_AUX_FRAME_SEL_VSW   (0x2 << 10)
> > +#define TIMING_INT_MAIN_FRAME_SEL_VSW  (0x2 << 6)
> > +#define TIMING_INT_ENABLE (\
> > +       TIMING_INT_MAIN_FRAME_SEL_VSW | TIMING_INT_AUX_FRAME_SEL_VSW | \
> > +       TIMING_INT_MAIN_FRAME | TIMING_INT_AUX_FRAME \
> > +)
> > +#define TIMING_MAIN_SHIFT              0x2c
> > +#define TIMING_AUX_SHIFT               0x30
> > +#define H_SHIFT_VAL                    0x0048
> > +#define TIMING_MAIN_PI_SHIFT           0x68
> > +#define TIMING_AUX_PI_SHIFT            0x6c
> > +#define H_PI_SHIFT_VAL                 0x000f
> > +
> > +#define V_ACTIVE(x)    (((x) << V_ACTIVE_SHIFT) & V_ACTIVE_MASK)
> > +#define H_ACTIVE(x)    (((x) << H_ACTIVE_SHIFT) & H_ACTIVE_MASK)
> > +
> > +#define SYNC_WIDE(x)   (((x) << SYNC_WIDE_SHIFT) & SYNC_WIDE_MASK)
> > +#define BACK_PORCH(x)  (((x) << BACK_PORCH_SHIFT) & BACK_PORCH_MASK)
> > +#define FRONT_PORCH(x) (((x) << FRONT_PORCH_SHIFT) & FRONT_PORCH_MASK)
> > +
> > +/* DTRC registers */
> > +#define DTRC_F0_CTRL                   0x2c
> > +#define DTRC_F1_CTRL                   0x5c
> > +#define DTRC_DECOMPRESS_BYPASS         BIT(17)
> > +#define DTRC_DETILE_CTRL               0x68
> > +#define TILE2RASTESCAN_BYPASS_MODE     BIT(30)
> > +#define DETILE_ARIDR_MODE_MASK         (0x3 << 0)
> > +#define DETILE_ARID_ALL                        0
> > +#define DETILE_ARID_IN_ARIDR           1
> > +#define DETILE_ARID_BYP_BUT_ARIDR      2
> > +#define DETILE_ARID_IN_ARIDR2          3
> > +#define DTRC_ARID                      0x6c
> > +#define DTRC_ARID3_SHIFT               24
> > +#define DTRC_ARID3_MASK                        (0xff << DTRC_ARID3_SHIFT)
> > +#define DTRC_ARID2_SHIFT               16
> > +#define DTRC_ARID2_MASK                        (0xff << DTRC_ARID2_SHIFT)
> > +#define DTRC_ARID1_SHIFT               8
> > +#define DTRC_ARID1_MASK                        (0xff << DTRC_ARID1_SHIFT)
> > +#define DTRC_ARID0_SHIFT               0
> > +#define DTRC_ARID0_MASK                        (0xff << DTRC_ARID0_SHIFT)
> > +#define DTRC_DEC2DDR_ARID              0x70
> > +
> > +#define DTRC_ARID3(x)  (((x) << DTRC_ARID3_SHIFT) & DTRC_ARID3_MASK)
> > +#define DTRC_ARID2(x)  (((x) << DTRC_ARID2_SHIFT) & DTRC_ARID2_MASK)
> > +#define DTRC_ARID1(x)  (((x) << DTRC_ARID1_SHIFT) & DTRC_ARID1_MASK)
> > +#define DTRC_ARID0(x)  (((x) << DTRC_ARID0_SHIFT) & DTRC_ARID0_MASK)
> > +
> > +/* VOU_CTRL registers */
> > +#define VOU_INF_EN                     0x00
> > +#define VOU_INF_CH_SEL                 0x04
> > +#define VOU_INF_DATA_SEL               0x08
> > +#define VOU_SOFT_RST                   0x14
> > +#define VOU_CLK_SEL                    0x18
> > +#define VOU_CLK_GL1_SEL                        BIT(5)
> > +#define VOU_CLK_GL0_SEL                        BIT(4)
> > +#define VOU_CLK_REQEN                  0x20
> > +#define VOU_CLK_EN                     0x24
> > +
> > +/* OTFPPU_CTRL registers */
> > +#define OTFPPU_RSZ_DATA_SOURCE         0x04
> > +
> 
> I find the register definitions pretty distracting here (and elsewhere
> in the driver), I suppose my personal preference would be to hide them
> in the headers.

I do not have a strong preference on this.  Okay, will do that to make
it easier for you to look at the driver :)

> > +#define GL_NUM                         2
> > +#define VL_NUM                         3
> > +
> > +enum vou_chn_type {
> > +       VOU_CHN_MAIN,
> > +       VOU_CHN_AUX,
> > +};
> > +
> > +struct zx_crtc_regs {
> > +       u32 fir_active;
> > +       u32 fir_htiming;
> > +       u32 fir_vtiming;
> > +       u32 timing_shift;
> > +       u32 timing_pi_shift;
> > +};

<snip>

> > +static inline struct drm_crtc *zx_find_crtc(struct drm_device *drm, int pipe)
> > +{
> > +       struct drm_crtc *crtc;
> > +       int i = 0;
> > +
> > +       list_for_each_entry(crtc, &drm->mode_config.crtc_list, head)
> > +               if (i++ == pipe)
> > +                       return crtc;
> > +
> > +       return NULL;
> > +}
> 
> We have drm_plane_from_index, it seems like at least 2 drivers would
> benefit from drm_crtc_from_index. Either way, you should probably
> change this code to compare pipe to crtc->index instead of rolling
> your own index counter.

Right.  I will change it to use crtc->index at this point.  And after
the driver gets landed, I will cook up a patch for drm_crtc_from_index.

> > +int zx_vou_enable_vblank(struct drm_device *drm, unsigned int pipe)
> > +{
> > +       struct drm_crtc *crtc;
> > +       struct zx_vou_hw *vou;
> > +
> > +       crtc = zx_find_crtc(drm, pipe);
> > +       if (!crtc)
> > +               return 0;
> > +
> > +       vou = crtc_to_vou(crtc);
> > +
> > +       if (pipe == 0)
> > +               zx_writel_mask(vou->timing + TIMING_INT_CTRL,
> > +                              TIMING_INT_MAIN_FRAME, TIMING_INT_MAIN_FRAME);
> > +       else
> > +               zx_writel_mask(vou->timing + TIMING_INT_CTRL,
> > +                              TIMING_INT_AUX_FRAME, TIMING_INT_AUX_FRAME);
> > +
> 
> It seems like this could also benefit from crtc_bits/crtc_regs

Yes, you're right.

Thanks for all the comments.

Shawn

> > +       return 0;
> > +}
