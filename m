From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 5 Feb 2015 23:46:29 +0800
Subject: [PATCH v3 04/15] drm: bridge/dw_hdmi: add indentification
 registers parse and record
In-Reply-To: <1422976283-30071-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
 <1422976283-30071-1-git-send-email-ykk@rock-chips.com>
Message-ID: <CAGS+omCiGh0-4BbPjPS+KqMW9-OpJ8Je7o37Web06w1CR7RPgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 3, 2015 at 11:11 PM, Yakir Yang <ykk@rock-chips.com> wrote:
> By parsing the indentification registers we can know what functions
> are present on the hdmi ip.
>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v3:
> - Add ID registers parse and record
>
> Changes in v2: None
>
>  drivers/gpu/drm/bridge/dw_hdmi.c | 59 ++++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/bridge/dw_hdmi.h | 23 ++++++++++++++++
>  2 files changed, 82 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> index 08f10da..7b5b664 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.c
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> @@ -79,6 +79,23 @@ static const u16 csc_coeff_rgb_in_eitu709[3][4] = {
>         { 0x6756, 0x78ab, 0x2000, 0x0200 }
>  };
>
> +struct hdmi_id {
> +       u8 design;
> +       u8 revision;
> +
> +       bool prepen;
> +       bool audspdif;
> +       bool audi2s;
> +       bool hdmi14;
> +       bool csc;
> +       bool hdcp;
> +       bool hdmi20;
> +       bool confapb;
> +       bool ahbauddma;
> +       bool gpaud;
> +       u8 phy_type;
> +};
> +
>  struct hdmi_vmode {
>         bool mdvi;
>         bool mhsyncpolarity;
> @@ -111,6 +128,8 @@ struct dw_hdmi {
>         struct clk *isfr_clk;
>         struct clk *iahb_clk;
>
> +       struct hdmi_id id;
> +
>         struct hdmi_data_info hdmi_data;
>         const struct dw_hdmi_plat_data *plat_data;
>
> @@ -1259,6 +1278,36 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>         return 0;
>  }
>
> +static void hdmi_parse_id(struct dw_hdmi *hdmi)
> +{
> +       u8 config0_id, config1_id, config2_id, config3_id;
> +
> +       config0_id = hdmi_readb(hdmi, HDMI_CONFIG0_ID);
> +       config1_id = hdmi_readb(hdmi, HDMI_CONFIG1_ID);
> +       config2_id = hdmi_readb(hdmi, HDMI_CONFIG2_ID);
> +       config3_id = hdmi_readb(hdmi, HDMI_CONFIG3_ID);
> +
> +       hdmi->id.prepen = config0_id & HDMI_CONFIG0_ID_PREPEN ? true : false;

These could all be "!!(A & B)", but perhaps that is just a matter of
personal preference.

> +       hdmi->id.audi2s = config0_id & HDMI_CONFIG0_ID_AUDI2S ? true : false;
> +       hdmi->id.hdmi14 = config0_id & HDMI_CONFIG0_ID_HDMI14 ? true : false;
> +       hdmi->id.hdcp = config0_id & HDMI_CONFIG0_ID_HDCP ? true : false;
> +       hdmi->id.csc = config0_id & HDMI_CONFIG0_ID_CSC ? true : false;
> +       hdmi->id.audspdif = config0_id & HDMI_CONFIG0_ID_AUDSPDIF ?
> +                           true : false;
> +
> +       hdmi->id.confapb = config1_id & HDMI_CONFIG1_ID_CONFAPB ? true : false;
> +       hdmi->id.hdmi20 = config1_id & HDMI_CONFIG1_ID_HDMI20 ? true : false;
> +
> +       hdmi->id.phy_type = config2_id & HDMI_CONFIG2_ID;

HDMI_CONFIG2_ID is a register offset, not a mask.

> +
> +       hdmi->id.gpaud = config3_id & HDMI_CONFIG3_ID_GPAUD ? true : false;
> +       hdmi->id.ahbauddma = config3_id & HDMI_CONFIG3_ID_AHBAUDDMA ?
> +                            true : false;
> +
> +       hdmi->id.design = hdmi_readb(hdmi, HDMI_DESIGN_ID);
> +       hdmi->id.revision = hdmi_readb(hdmi, HDMI_REVISION_ID);
> +}
> +
>  /* Wait until we are registered to enable interrupts */
>  static int dw_hdmi_fb_registered(struct dw_hdmi *hdmi)
>  {
> @@ -1670,6 +1719,16 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
>                  hdmi_readb(hdmi, HDMI_PRODUCT_ID0),
>                  hdmi_readb(hdmi, HDMI_PRODUCT_ID1));
>
> +       /* Config IDs */
> +       dev_info(dev,
> +                "Detected HDMI config_id 0x%x:0x%x:0x%x:0x%x\n",
> +                hdmi_readb(hdmi, HDMI_CONFIG0_ID),
> +                hdmi_readb(hdmi, HDMI_CONFIG1_ID),
> +                hdmi_readb(hdmi, HDMI_CONFIG2_ID),
> +                hdmi_readb(hdmi, HDMI_CONFIG3_ID));
> +
> +       hdmi_parse_id(hdmi);

It seems a bit silly to read the regs once to print them, and then
again in hdmi_parse_id().
Perhaps move the dev_info() inside hdmi_parse_id().
It would also be nice to print a full summary of all of the parsed fields.

> +
>         initialize_hdmi_ih_mutes(hdmi);
>
>         ret = devm_request_threaded_irq(dev, irq, dw_hdmi_hardirq,
> diff --git a/drivers/gpu/drm/bridge/dw_hdmi.h b/drivers/gpu/drm/bridge/dw_hdmi.h
> index 175dbc8..e4ba634 100644
> --- a/drivers/gpu/drm/bridge/dw_hdmi.h
> +++ b/drivers/gpu/drm/bridge/dw_hdmi.h
> @@ -545,6 +545,29 @@
>  #define HDMI_I2CM_FS_SCL_LCNT_0_ADDR            0x7E12
>
>  enum {
> +/* HDMI_CONFIG0_ID */
> +       HDMI_CONFIG0_ID_PREPEN = 0x80,
> +       HDMI_CONFIG0_ID_AUDSPDIF = 0x20,
> +       HDMI_CONFIG0_ID_AUDI2S = 0x10,
> +       HDMI_CONFIG0_ID_HDMI14 = 0x08,
> +       HDMI_CONFIG0_ID_CSC = 0x04,
> +       HDMI_CONFIG0_ID_HDCP = 0x01,
> +
> +/* HDMI_CONFIG1_ID */
> +       HDMI_CONFIG1_ID_HDMI20 = 0x20,
> +       HDMI_CONFIG1_ID_CONFAPB = 0x02,
> +
> +/* HDMI_CONFIG2_ID */
> +       HDMI_CONFIG2_ID_PHY_GEN2 = 0xf2,
> +       HDMI_CONFIG2_ID_PHY_GEN2_HECA = 0xe2,
> +       HDMI_CONFIG2_ID_PHY_HDMI_MHL = 0xc2,
> +       HDMI_CONFIG2_ID_PHY_HDMI_MHL_HECA = 0xb2,
> +       HDMI_CONFIG2_ID_LEGACY_PHY = 0x00,
> +
> +/* HDMI_CONFIG3_ID */
> +       HDMI_CONFIG3_ID_AHBAUDDMA = 0x02,
> +       HDMI_CONFIG3_ID_GPAUD = 0x01,
> +
>  /* IH_FC_INT2 field values */
>         HDMI_IH_FC_INT2_OVERFLOW_MASK = 0x03,
>         HDMI_IH_FC_INT2_LOW_PRIORITY_OVERFLOW = 0x02,
> --
> 2.1.2
>
>
