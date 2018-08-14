From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 14 Aug 2018 14:52:00 +0200
Subject: [PATCH v3 RESEND 2/2] phy: add Rockchip Innosilicon hdmi phy
In-Reply-To: <a0a84907-c51f-b484-33fa-592a23c756f9@ti.com>
References: <20180710134949.25203-1-heiko@sntech.de>
 <20180710134949.25203-2-heiko@sntech.de>
 <a0a84907-c51f-b484-33fa-592a23c756f9@ti.com>
Message-ID: <4194245.uYZyAYm7Hd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

thanks for your review.


Am Freitag, 3. August 2018, 11:24:06 CEST schrieb Kishon Vijay Abraham I:
> On Tuesday 10 July 2018 07:19 PM, Heiko Stuebner wrote:
> > +config PHY_ROCKCHIP_INNO_HDMI
> > +	tristate "Rockchip INNO HDMI PHY Driver"
> > +	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
> 
> depends on COMMON_CLK since the phy registers a clock provider?

ok

> > +static const struct phy_config rk3228_phy_cfg[] = {
> > +	{	165000000, {
> > +			0xaa, 0x00, 0x44, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +			0x00, 0x00, 0x00, 0x00, 0x00,
> 
> If these register configurations are not a tuning value or dividers (which can
> have absolute values), then we should have macros for each of these configurations.

That might get difficult.

That phy register set is completely undocumented even in the vendor TRMs
of the 2 socs. I pieced together most existing macros from code comments
and such from the vendor kernel. And Innosilicon is not known to willingly
share much of their register documentation it seems.


> > +static unsigned long inno_hdmi_phy_get_tmdsclk(struct inno_hdmi_phy *inno,
> > +					       unsigned long rate)
> > +{
> > +	int bus_width = phy_get_bus_width(inno->phy);
> 
> hmm, the bus_width could be a member of struct inno_hdmi_phy. PHY API's don't
> have to be used for getting data within the PHY driver itself.
> Looking at the phy_get_bus_width() implementation, we should have protected
> bus-width set and get with mutex. With that there might be a deadlock here.

ok, so just read phy->attrs.bus_width directly here?

I don't see how this can be part of struct inno_hdmi_phy, as the bus-width
depends on the color-depth used on the hdmi-controller side, so
depending on that it will want to adapt the phy's bus_width.

Right now our dw_hdmi in mainline only supports one output format
requiring a bus_width of 8, but the vendor kernel shows [0] how this
wants to be used with multiple output formats.

[0] https://github.com/rockchip-linux/kernel/blob/release-4.4/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c#L817


> > +static irqreturn_t inno_hdmi_phy_rk3328_irq(int irq, void *dev_id)
> > +{
> > +	struct inno_hdmi_phy *inno = dev_id;
> > +
> > +	inno_update_bits(inno, 0x02, RK3328_PDATA_EN, 0);
> > +	usleep_range(9, 10);
> 
> This range looks very narrow. 10 to 20 should be okay?

ok


> > +static void inno_hdmi_phy_action(void *data)
> > +{
> > +	struct inno_hdmi_phy *inno = data;
> > +
> > +	clk_disable_unprepare(inno->refpclk);
> > +	clk_disable_unprepare(inno->sysclk);
> > +}
> > +
> > +static int inno_hdmi_phy_probe(struct platform_device *pdev)
> > +{
> > +	struct inno_hdmi_phy *inno;
> > +	const struct of_device_id *match;
> > +	struct phy_provider *phy_provider;
> > +	struct resource *res;
> > +	void __iomem *regs;
> > +	int ret;
> > +

[...]

> > +	/*
> > +	 * Refpclk needs to be on, on at least the rk3328 for still
> > +	 * unknown reasons.
> > +	 */
> > +	ret = clk_prepare_enable(inno->refpclk);
> > +	if (ret) {
> > +		dev_err(inno->dev, "failed to enable refpclk\n");
> > +		clk_disable_unprepare(inno->sysclk);
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(inno->dev, inno_hdmi_phy_action,
> > +				       inno);
> > +	if (ret) {
> > +		clk_disable_unprepare(inno->refpclk);
> > +		clk_disable_unprepare(inno->sysclk);
> > +		return ret;
> > +	}
> > +
> > +	inno->regmap = devm_regmap_init_mmio(inno->dev, regs,
> > +					     &inno_hdmi_phy_regmap_config);
> > +	if (IS_ERR(inno->regmap))
> 
> here too clk_disable_unprepare and all error handling below?
> It's better if we just handle error handling at the bottom of the function.

Nope ;-) ... I.e. the goal of registering the devm_action above is to have
the clocks get disabled in the correct order when devm undoes the other
things in sequence.

Manual error handling for the clocks would also break devm, as then
the clocks would get disabled before the devm cleanup kicks in.


> > +	phy_provider = devm_of_phy_provider_register(inno->dev,
> > +						     of_phy_simple_xlate);
> > +	if (IS_ERR(phy_provider)) {
> > +		dev_err(inno->dev, "failed to register PHY provider\n");
> > +		return PTR_ERR(phy_provider);
> > +	}
> return PTR_ERR_OR_ZERO(phy_provider);?

ok

Thanks
Heiko
