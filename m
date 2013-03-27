From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Mar 2013 11:21:34 +0100
Subject: [PATCH 2/2] ARM: kirkwood: extend the kirkwood i2s driver for
 DT usage
In-Reply-To: <5151F8FE.5040005@gmail.com>
References: <20130326190539.494d96d9@armhf>
	<5151F8FE.5040005@gmail.com>
Message-ID: <20130327112134.50ba5d61@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013 20:37:34 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 03/26/2013 07:05 PM, Jean-Francois Moine wrote:
> > The kirkwood i2s driver is used without DT in the Kirkwood machine.
> > This patch adds a DT compatible definition for use in other Marvell
> > machines as the Armada 88AP510 (Dove).
> >
> > Signed-off-by: Jean-Francois Moine<moinejf@free.fr>
> > ---
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
> > +- reg: physical base address of the controller and length of memory mapped
> > +  region.
> > +- interrupts: list of two irq numbers.
> > +  The first irq is used for data flow and the second one is used for errors.
> > +- clocks: phandle of the internal or external clock.
> 
> Jean-Francois,
> 
> have you tested the driver with external clock set instead of internal clock?

Hi Sebastian,

No, I don't know yet how to install and start the audio subsystem.

> I guess it will hang on access, as internal clock comes from a clock gate that
> needs to be enabled prior use of i2s core. I suggest to have two clocks, 0 for
> internal and optional (1) for external clock. You can get them with
> of_clk_get(np, 0) and of_clk_get(np, 1) respectively.

You are right.

Trying to code this, I came across an other (but surely known) problem:
the synchronization of the module initialization.

If you want to use some external clock given by, say, the si5351
module, as all modules are loaded at the same time, the module
kirkwood-i2s may be initialized before the si5351 and, so, the clock
will not be seen as available.

Question: is there a module synchronization mechanism for the DT?
(late_initcall does not work for modules)

There is an other problem, tied to the si5351 module unload: how can
the kirkwood-i2s know that the clock driver is unloaded, or how can it
do to lock this driver? (the module of the clock driver is not seen
from the clock user)

A response to this problem could simply be: increase the use count of
the clock module (try_module_get) when a clock is used (clk prepare or
enable).

> > +
> > +Non-standard property:
> > +
> > +- marvell,burst-size (optional): burst size which can be only 32 or 128.
> > +  Default is 128.
> 
> Do we really want to expose this to the device node? If this is set to different
> values for kirkwood, dove, and a370, we can still have it set by corresponding
> compatible strings and match data. (See below)

	[snip]
> > diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> > index afca1ec..dceb9f8 100644
> > --- a/sound/soc/kirkwood/kirkwood-i2s.c
> > +++ b/sound/soc/kirkwood/kirkwood-i2s.c
	[snip]
> > @@ -556,12 +577,23 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
> >   	return 0;
> >   }
> >
> > +#ifdef CONFIG_OF
> > +static struct of_device_id kirkwood_i2s_of_match[] = {
> > +	{ .compatible = "marvell,kirkwood-i2s" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, kirkwood_i2s_of_match);
> > +#endif
> 
> If there is SoC specific data (e.g. burst_size) you can use
> .data to pass it according to the compatible string:
> 
> static struct of_device_id kirkwood_i2s_of_match[] = {
> 	{ .compatible = "marvell,kirkwood-i2s", .data = (void *)32 },
> 	{ .compatible = "marvell,dove-i2s", .data = (void *)128 },
> 	{ .compatible = "marvell,armada-370-i2s", .data = (void *)128 },
> 	{ }
> };

I don't like this solution: the burst value is hidden and hard coded.
If a new machine uses this same driver, it is easier to change the DT
instead of recompiling a whole kernel.

> Or have some SoC specific struct i2s_soc_data passed with .data,
> if there is more than one value you need to pass.
> 
> > +
> >   static struct platform_driver kirkwood_i2s_driver = {
> >   	.probe  = kirkwood_i2s_dev_probe,
> >   	.remove = kirkwood_i2s_dev_remove,
> >   	.driver = {
> >   		.name = DRV_NAME,
> >   		.owner = THIS_MODULE,
> > +#ifdef CONFIG_OF
> > +		.of_match_table = kirkwood_i2s_of_match,
> > +#endif
> 
> Remove the $ifdef and have .of_match_table = of_match_ptr(kirkwood_i2s_of_match),
> 
> >   	},
> >   };
> >
> 
> Sebastian

OK.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
