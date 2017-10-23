From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Oct 2017 10:08:37 +0800
Subject: [PATCH] phy: add inno-usb2-phy driver for hi3798cv200 SoC
In-Reply-To: <68cd23ae-544d-a60a-14a9-347b7aaf76bf@ti.com>
References: <1508078958-16966-1-git-send-email-shawnguo@kernel.org>
 <68cd23ae-544d-a60a-14a9-347b7aaf76bf@ti.com>
Message-ID: <20171023020836.GA16644@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 06:08:01PM +0530, Kishon Vijay Abraham I wrote:
> > +	usb2_phy1: usb2-phy1 {
> > +		compatible = "hisilicon,hi3798cv200-usb2-phy";
> > +		#phy-cells = <1>;
> > +		hisilicon,peripheral-syscon = <&peri_ctrl 0x120>;
> > +		clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
> > +		resets = <&crg 0xbc 4>,
> > +			 <&crg 0xbc 8>,
> > +			 <&crg 0xbc 9>;
> > +		reset-names = "power_on", "utmi0", "utmi1";
> > +	};
> 
> please send the devicetree binding documentation as a separate patch.

Yes, I should have done that.

<snip>

> > +static int hisi_inno_phy_exit(struct phy *phy)
> > +{
> > +	struct hisi_inno_phy_port *port = phy_get_drvdata(phy);
> > +	struct hisi_inno_phy_priv *priv = dev_get_drvdata(port->dev);
> > +
> > +	reset_control_assert(port->utmi_rst);
> > +	reset_control_assert(priv->por_rst);
> > +	clk_disable_unprepare(priv->ref_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct phy_ops hisi_inno_phy_ops = {
> > +	.init = hisi_inno_phy_start,
> 
> in order to make it identical you can just end it with *_init().

Yes, good suggestion.

Shawn
