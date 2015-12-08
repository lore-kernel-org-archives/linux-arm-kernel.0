From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 8 Dec 2015 14:18:56 +0000
Subject: [PATCH v7 2/6] mfd: syscon: add a DT property to set value width
In-Reply-To: <20151208135040.GH3384@x1>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448899191-13891-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151207094020.GF3384@x1> <20151207194218.GB6030@localhost>
 <20151208135040.GH3384@x1>
Message-ID: <20151208141856.GA14365@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Dec 2015, Lee Jones wrote:

> On Mon, 07 Dec 2015, Damien Riegel wrote:
> 
> > On Mon, Dec 07, 2015 at 09:40:20AM +0000, Lee Jones wrote:
> > > On Mon, 30 Nov 2015, Damien Riegel wrote:
> > > 
> > > > Currently syscon has a fixed configuration of 32 bits for register and
> > > > values widths. In some cases, it would be desirable to be able to
> > > > customize the value width.
> > > > 
> > > > For example, certain boards (like the ones manufactured by Technologic
> > > > Systems) have a FPGA that is memory-mapped, but its registers are only
> > > > 16-bit wide.
> > > > 
> > > > This patch adds an optional "reg-io-width" DT binding for syscon that
> > > > allows to change the width for the data bus (i.e. val_bits). If this
> > > > property is provided, it will also set the register stride to
> > > > reg-io-width's value. If not provided, the default configuration is
> > > > used.
> > > > 
> > > > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mfd/syscon.txt |  4 ++++
> > > >  drivers/mfd/syscon.c                             | 13 +++++++++++++
> > > >  2 files changed, 17 insertions(+)
> > > 
> > > Applied, thanks.
> > > 
> > Hi Lee,
> > 
> > Good to see this patch applied. What's going on now with the other
> > patches of this serie ? How should I handle them ?
> 
> Are there any build dependencies between them?

Looks like Arnd already replied.

I really should refresh my mail before replying. :)

> > > > diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
> > > > index fe8150b..408f768 100644
> > > > --- a/Documentation/devicetree/bindings/mfd/syscon.txt
> > > > +++ b/Documentation/devicetree/bindings/mfd/syscon.txt
> > > > @@ -13,6 +13,10 @@ Required properties:
> > > >  - compatible: Should contain "syscon".
> > > >  - reg: the register region can be accessed from syscon
> > > >  
> > > > +Optional property:
> > > > +- reg-io-width: the size (in bytes) of the IO accesses that should be
> > > > +  performed on the device.
> > > > +
> > > >  Examples:
> > > >  gpr: iomuxc-gpr at 020e0000 {
> > > >  	compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> > > > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > > > index 176bf0f..b7aabee 100644
> > > > --- a/drivers/mfd/syscon.c
> > > > +++ b/drivers/mfd/syscon.c
> > > > @@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
> > > >  	struct syscon *syscon;
> > > >  	struct regmap *regmap;
> > > >  	void __iomem *base;
> > > > +	u32 reg_io_width;
> > > >  	int ret;
> > > >  	struct regmap_config syscon_config = syscon_regmap_config;
> > > >  
> > > > @@ -69,6 +70,18 @@ static struct syscon *of_syscon_register(struct device_node *np)
> > > >  	 else if (of_property_read_bool(np, "little-endian"))
> > > >  		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
> > > >  
> > > > +	/*
> > > > +	 * search for reg-io-width property in DT. If it is not provided,
> > > > +	 * default to 4 bytes. regmap_init_mmio will return an error if values
> > > > +	 * are invalid so there is no need to check them here.
> > > > +	 */
> > > > +	ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
> > > > +	if (ret)
> > > > +		reg_io_width = 4;
> > > > +
> > > > +	syscon_config.reg_stride = reg_io_width;
> > > > +	syscon_config.val_bits = reg_io_width * 8;
> > > > +
> > > >  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> > > >  	if (IS_ERR(regmap)) {
> > > >  		pr_err("regmap init failed\n");
> > > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
