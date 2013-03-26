From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 26 Mar 2013 20:54:22 +0100
Subject: [PATCH 2/2] ARM: kirkwood: extend the kirkwood i2s driver for
 DT usage
In-Reply-To: <20130326184758.GE631@lunn.ch>
References: <20130326190539.494d96d9@armhf>
	<20130326184758.GE631@lunn.ch>
Message-ID: <20130326205422.65391983@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013 19:47:58 +0100
Andrew Lunn <andrew@lunn.ch> wrote:
	[snip]
> > diff --git a/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt b/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt
> > new file mode 100644
> > index 0000000..a089504
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt
> > @@ -0,0 +1,24 @@
> > +* Kirkwood I2S controller
> > +
> > +Required properties:
> > +
> > +- compatible: "marvell,kirkwood-i2s"
> 
> Hi Jean-Francois
> 
> We should maybe change this to marvell,mvebu-i2s. Kirkwood, Dove, and
> 370 have i2s. We know Dove and Kirkwood are compatible, and its likely
> 370 is also compatible. So a renaming will avoid confusion in the long
> run. We can leave the filename of the driver alone for the moment,
> since that is not an ABI.

OK. I will do an other version of the dove DT extension.

> > +- reg: physical base address of the controller and length of memory mapped
> > +  region.
> > +- interrupts: list of two irq numbers.
> > +  The first irq is used for data flow and the second one is used for errors.
> > +- clocks: phandle of the internal or external clock.
> > +
> > +Non-standard property:
> 
> There does not appear to be an i2s standard, so saying a property is
> non-standard is a bit odd. I would just say Optional Properties, and
> drop the (optional) below.

No problem. I just did a copy/yank from an other binding.

> > +
> > +- marvell,burst-size (optional): burst size which can be only 32 or 128.
> > +  Default is 128.
> > +
> > +Example:
> > +
> > +i2s1: audio-controller at b4000 {
> > +	compatible = "marvell,kirkwood-i2s";
> > +	reg = <0xb4000 0x4000>;
> 
> I've not looked, but 0x4000 seem rather large for an register range.

I got the value from kirkwood/common.c (SZ_16K). But, yes, in the
88AP510 doc, it seems that the last register is 2208. I will put 2210.

> > +	interrupts = <21>, <22>;
> > +	clocks = <&gate_clk 13>;
> > +};
> > diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> > index afca1ec..dceb9f8 100644
> > --- a/sound/soc/kirkwood/kirkwood-i2s.c
> > +++ b/sound/soc/kirkwood/kirkwood-i2s.c
	[snip]
> > @@ -485,10 +486,30 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
> >  		return -ENXIO;
> >  	}
> >  
> > +#ifdef CONFIG_OF
> > +	if (!data) {
> > +		struct device_node *np = pdev->dev.of_node;
> > +		u32 val;
> > +
> > +		if (!np
> > +		 || of_property_read_u32(np, "marvell,burst-size", &val)) {
> 
> It is normal to put the || on the previous line.

I find || and && are clearer on the next line when the condition is
somewhat complex. I may change that, but I did not see any constraint
in the CodingStyle...

> > +			val = 128;
> > +		} else if (val != 32 && val != 128) {
> > +			dev_warn(&pdev->dev,
> > +				"'marvell,burst-size' can be only 32 or 128"
> > +				 "- value forced to 128\n");
> 
> I would prefer to return EINVAL, or some other error code. Invalid DT
> contents will get noticed faster that way.

OK.

	[snip]
> > @@ -556,12 +577,23 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static struct of_device_id kirkwood_i2s_of_match[] = {
> > +	{ .compatible = "marvell,kirkwood-i2s" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, kirkwood_i2s_of_match);
> > +#endif
> > +
> >  static struct platform_driver kirkwood_i2s_driver = {
> >  	.probe  = kirkwood_i2s_dev_probe,
> >  	.remove = kirkwood_i2s_dev_remove,
> >  	.driver = {
> >  		.name = DRV_NAME,
> >  		.owner = THIS_MODULE,
> > +#ifdef CONFIG_OF
> > +		.of_match_table??=??kirkwood_i2s_of_match,
> > +#endif
> 
> You should be able to skip all these #ifdefs.

OK.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
