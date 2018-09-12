From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 12 Sep 2018 15:50:03 +0200
Subject: [PATCH v4 6/6] drm/rockchip: dw_hdmi: add dw-hdmi support for the
 rk3328
In-Reply-To: <AM0PR03MB46769977FF55C3AC6F65E001AC050@AM0PR03MB4676.eurprd03.prod.outlook.com>
References: <20180910092223.1106-1-heiko@sntech.de>
 <20180910092223.1106-7-heiko@sntech.de>
 <AM0PR03MB46769977FF55C3AC6F65E001AC050@AM0PR03MB4676.eurprd03.prod.outlook.com>
Message-ID: <12703438.MgSoJEdsAQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 10. September 2018, 17:15:46 CEST schrieb Jonas Karlman:
> Hi Heiko,
> 
> CEC is not working when CEC 5V is enabled
> 
> On 2018-09-10 11:22, Heiko Stuebner wrote:
> 
> > The rk3328 uses a dw-hdmi controller with an external hdmi phy from
> > Innosilicon which uses the generic phy framework for access.
> > Add the necessary data and the compatible for the rk3328 to the
> > rockchip dw-hdmi driver.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Robin Murphy <robin.murphy@arm.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > changes in v3:
> > - reword as suggested by Rob to show that it's a dw-hdmi + Inno phy
> > ---
> >  .../display/rockchip/dw_hdmi-rockchip.txt     |   1 +
> >  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   | 106 ++++++++++++++++++
> >  2 files changed, 107 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> > index 937bfb472e1d..39143424a474 100644
> > --- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> > +++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> > @@ -13,6 +13,7 @@ Required properties:
> >  
> >  - compatible: should be one of the following:
> >  		"rockchip,rk3288-dw-hdmi"
> > +		"rockchip,rk3328-dw-hdmi"
> >  		"rockchip,rk3399-dw-hdmi"
> >  - reg: See dw_hdmi.txt.
> >  - reg-io-width: See dw_hdmi.txt. Shall be 4.
> > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > index 19f002fa0a09..237f31fd8403 100644
> > --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> > @@ -25,6 +25,24 @@
> >  
> >  #define RK3288_GRF_SOC_CON6		0x025C
> >  #define RK3288_HDMI_LCDC_SEL		BIT(4)
> > +#define RK3328_GRF_SOC_CON2		0x0408
> > +
> > +#define RK3328_HDMI_SDAIN_MSK		BIT(11)
> > +#define RK3328_HDMI_SCLIN_MSK		BIT(10)
> > +#define RK3328_HDMI_HPD_IOE		BIT(2)
> > +#define RK3328_GRF_SOC_CON3		0x040c
> > +/* need to be unset if hdmi or i2c should control voltage */
> > +#define RK3328_HDMI_SDA5V_GRF		BIT(15)
> > +#define RK3328_HDMI_SCL5V_GRF		BIT(14)
> > +#define RK3328_HDMI_HPD5V_GRF		BIT(13)
> > +#define RK3328_HDMI_CEC5V_GRF		BIT(12)
> > +#define RK3328_GRF_SOC_CON4		0x0410
> > +#define RK3328_HDMI_HPD_SARADC		BIT(13)
> > +#define RK3328_HDMI_CEC_5V		BIT(11)
> > +#define RK3328_HDMI_SDA_5V		BIT(10)
> > +#define RK3328_HDMI_SCL_5V		BIT(9)
> > +#define RK3328_HDMI_HPD_5V		BIT(8)
> > +
> >  #define RK3399_GRF_SOC_CON20		0x6250
> >  #define RK3399_HDMI_LCDC_SEL		BIT(6)
> >  
> > @@ -292,6 +310,68 @@ static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_fun
> >  	.atomic_check = dw_hdmi_rockchip_encoder_atomic_check,
> >  };
> >  
> > +static int dw_hdmi_rockchip_genphy_init(struct dw_hdmi *dw_hdmi, void *data,
> > +			     struct drm_display_mode *mode)
> > +{
> > +	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
> > +
> > +	return phy_power_on(hdmi->phy);
> > +}
> > +
> > +static void dw_hdmi_rockchip_genphy_disable(struct dw_hdmi *dw_hdmi, void *data)
> > +{
> > +	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
> > +
> > +	phy_power_off(hdmi->phy);
> > +}
> > +
> > +static enum drm_connector_status
> > +dw_hdmi_rk3328_read_hpd(struct dw_hdmi *dw_hdmi, void *data)
> > +{
> > +	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
> > +	enum drm_connector_status status;
> > +
> > +	status = dw_hdmi_phy_read_hpd(dw_hdmi, data);
> > +
> > +	if (status == connector_status_connected)
> > +		regmap_write(hdmi->regmap,
> > +			RK3328_GRF_SOC_CON4,
> > +			HIWORD_UPDATE(RK3328_HDMI_CEC_5V | RK3328_HDMI_SDA_5V |
> > +				      RK3328_HDMI_SCL_5V,
> > +				      RK3328_HDMI_CEC_5V | RK3328_HDMI_SDA_5V |
> > +				      RK3328_HDMI_SCL_5V));
> 
> This differs from BSP kernel and enable of CEC 5V stops CEC from working.
> BSP kernel do not set write enable bit for CEC 5V:
> 
> RK3328_IO_5V_DOMAIN ((7 << 9) | (3 << (9 + 16)))
> 
> https://github.com/Kwiboo/linux-rockchip/commit/e74ac6a3a581bcb7b2ac9f4d70cf7298df01e417 makes CEC work on v3 of this patch.

thanks for checking the cec functionality. I've incorporated your change
and sent off v6. Maybe you can take another look and possible provide
some Tested-by (or even Reviewed-by/Acked-by) tags? :-)


Thanks
Heiko
