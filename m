From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 15:20 +0200
Subject: [PATCH v3 2/2] soc: Add driver for Freescale Vybrid Platform
In-Reply-To: <61585e4449cfc1f36e16a64b9b4a54fe@agner.ch>
References: <cover.1432290463.git.maitysanchayan@gmail.com>
 <35561091.AtkcGa6qVG@wuerfel> <61585e4449cfc1f36e16a64b9b4a54fe@agner.ch>
Message-ID: <3574233.JhJlJx8SSu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 May 2015 14:02:52 Stefan Agner wrote:
> > Can you use syscon_regmap_lookup_by_phandle instead, and put the
> > phandles in the fsl,vf610-mscm-cpucfg node?
> 
> Hm, with that we would wire up hardware modules which does nothing has
> to do with each other. We just happen to need a driver which collects
> information accross the SoC. I'm not sure we should put the modules
> required into the device tree.
> 
> I don't think its nice to have the compatible strings in the source
> code, however it feels more appropriate than in the device tree, IMHO...

I see. Another option would be to point directly to the registers
you need:

	ocotp-cfg0 = <&ocotp 0x10>;
	ocotp-cfg1 = <&ocotp 0x20>;
	rom-revision = <&rom 0x80>;

We don't yet have an abstraction to access a register from a syscon
reference like this, but you could either roll your own here, or 
add a generic abstraction.

> > Also, I'd argue that the mscm should not be a syscon device at all,
> > but instead I'd use platform_get_resource()/devm_ioremap_resource()
> > to get an __iomem pointer.
> 
> We need to have mscm-cpucfg to be syscon because we need to get the CPU
> personality in the MSCM interrupt router driver (irq-vf610-mscm-ir.c). 

It can be both at the same time now.

	Arnd
