From: rob.herring@calxeda.com (Rob Herring)
Date: Tue, 21 Aug 2012 08:11:57 -0500
Subject: [PATCH 2/2] ARM: imx6q: replace clk_register_clkdev with clock
 DT lookup
In-Reply-To: <20120821122753.GU18957@n2100.arm.linux.org.uk>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-3-git-send-email-shawn.guo@linaro.org>
 <503232E0.3000007@gmail.com>
 <CAKGA1bn2uCWE8YkGR4EzTxZ_bXJ_ov2diq63uxQ=dT7b6Fu9GQ@mail.gmail.com>
 <20120820151609.GN24242@S2101-09.ap.freescale.net>
 <CAKGA1bnfhMC8QG9OqBbpy5iq6ZAfEgrYMg_LVd50U7yikLhDAg@mail.gmail.com>
 <20120821122753.GU18957@n2100.arm.linux.org.uk>
Message-ID: <5033891D.90509@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2012 07:27 AM, Russell King - ARM Linux wrote:
> On Mon, Aug 20, 2012 at 12:22:56PM -0500, Matt Sealey wrote:
>> You're going to have to define these clocks as a tree with parents and
>> leaf nodes anyway in the clock subsystem. Why not define these in the
>> device tree in total and reference them by handle when you build the
>> entire clock tree from the ground up? Or will it just be all the
>> clocks defined in Linux, but the lookups (which is what I see here)
>> moved into the DT? Why not form the lookups as part of the definition
>> of the clock tree?
> 
> Well, IMHO the DT conversion of the clk lookup stuff has been done
> completely wrong.
> 
> What should have been done is rather than invent a totally new bloody
> lookup interface that drivers have to use instead of clk_get(), is to
> embed the OF lookup _inside_ clk_get().

That is exactly what was done. Drivers only use clk_get. Only if you
don't have a struct device, then you can use of_clk_get.

Internally, you still need a conversion of clk provider node and cell to
a struct clk. It is up to each clk provider how to do this. The lookup
done here by Shawn is using the struct clk name and using the existing
clk framework lookup.

> What you do is this:
> 
> 1. Have property names in the device node like:
> 
> 	clock_<connection-id> = <&provider-node output>

The connection id is defined by the position in the list and
supplemented with "clock-names" property.

> 
>    In the case of a NULL connection id:
> 
> 	clock = <&provider-node output>
> 
>    Remember that the connection ID is _supposed_ to be something that
>    is described by the hardware (like - for the AACI primecell, the
>    clock which runs the functional side is called "AACICLK" by the TRM,
>    and for the MMCI primecell, it's "MMCICLK" - even though these two
>    clocks may be fed by the same source in an implementation.)
> 
> 2. clkdev's lookup is then modified to look at the struct device, and
>    check for a DT node.  If there is a DT node, it formats a property
>    string:
> 
> 	if (dev->of_node) {
> 		char *propname, *clk_prop = NULL;
> 		struct property *p;
> 
> 		if (conn_id) {
> 			clk_prop = kasprintf("clock_%s", conn_id);
> 			propname = clk_prop;
> 		} else {
> 			propname = "clock";
> 		}
> 
> 		p = of_find_property(dev->of_node, propname, NULL);
> 		if (clk_prop)
> 			kfree(clk_prop);
> 
> 		if (p) {
> 			clk = clk_get_from_of_property(p);
> 			if (clk)
> 				return clk;
> 		}
> 
> 		/* Fallthrough to clkdev table lookup */
> 	}
> 
> So now, you're not dealing with inventing a whole load of names for clocks
> on a platform, instead what you're doing is describing _where_ the clock
> comes from in the system for a particular device by device node and index
> into it - just like we do for interrupts.

That is what we're doing. The names are optional for DT, but happen to
be required for struct clk now. If we don't put something in DT, then
the clock names will have to be something generic like ccm-1..ccm-185.

Rob

> 
> This means there's no need for huge tables and such like of clock names.
> 
> I did mention this idea long ago but got ignored.
> 
