From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 05 Aug 2015 11:29:34 +0100
Subject: [PATCH 1/3] clk: versatile: Switch to assigned clock parents
In-Reply-To: <55BFAB11.7080600@codeaurora.org>
References: <55BBB2FC.9030102@codeaurora.org>
 <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
 <1438386285-5070-2-git-send-email-sboyd@codeaurora.org>
 <1438610480.2142.14.camel@arm.com> <55BFAB11.7080600@codeaurora.org>
Message-ID: <1438770574.2142.80.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-03 at 18:55 +0100, Stephen Boyd wrote:
> On 08/03/2015 07:01 AM, Pawel Moll wrote:
> > On Sat, 2015-08-01 at 00:44 +0100, Stephen Boyd wrote:
> >> @@ -179,6 +124,15 @@ static void __init clk_sp810_of_setup(struct device_node *node)
> >>   		sp810->timerclken[i].channel = i;
> >>   		sp810->timerclken[i].hw.init = &init;
> >>   
> >> +		/*
> >> +		 * If DT isn't setting the parent, force it to be
> >> +		 * the 1 MHz clock without going through the framework.
> >> +		 * We do this before clk_register() so that it can determine
> >> +		 * the parent and setup the tree properly.
> >> +		 */
> >> +		if (deprecated)
> >> +			init.ops->set_parent(&sp810->timerclken[i].hw, 1);
> >> +
> >>   		sp810->timerclken[i].clk = clk_register(NULL,
> >>   				&sp810->timerclken[i].hw);
> >>   		WARN_ON(IS_ERR(sp810->timerclken[i].clk));
> > So that's one thing I've got a (small) problem here...
> >
> > The above change assumes that SP810 always have 32kHz clock on input 0
> > and 1MHz clock on input 1. Yes, this is how it made on VExpress, but it
> > doesn't have to be the case. The magic picking up the faster clock was
> > added to handle all possible cases.
> >
> > The bottom line is: if all we care is VExpress than it works, but it's
> > still a hack. Personally I don't like it, however I won't nak the patch
> > because of this.
> 
> All current dts files in the kernel tree have 1MHz on input 1, so we 
> make this change here to set the parent to input 1 if there isn't an 
> assigned-clock-parents property.

That's what I said - all VE platforms known to me will work, because
they all have the clocks wired up the same way. And I still don't like
code in a "generic SP810 driver" assuming this. Call me what you
want ;-)

> Presumably new dts files should have 
> the new property so that things work properly. 

Sure, no argument here.

> I tried to find the 
> binding document, but it doesn't look to exist, so I didn't have 
> anything to update.

Right, that's probably my fault. The sp810 nodes appeared in the VE
trees very early (in terms of the "DT era"), when we weren't so strict
about documentation. So far, it would be fairly simple, something like
the text below - feel free to take it, mend it, extend it with your
changes and include in the series:

Thanks!

Pawel

8<-------------------------

SP810 System Controller
-----------------------

Required properties:

- compatible:	standard compatible string for a Primecell peripheral,
		see Documentation/devicetree/bindings/arm/primecell.txt
		for more details
		should be: "arm,sp810", "arm,primecell"

- reg:		standard registers property, physical address and size
		of the control registers

- clock-names:	from the common clock bindings, for more details see
		Documentation/devicetree/bindings/clock/clock-bindings.txt;
		should be: "refclk", "timclk", "apb_pclk"

- clocks:	from the common clock bindings, phandle and clock
		specifier pairs for the entries of clock-names property

- #clock-cells:	from the common clock bindings;
		should be: <1>

- clock-output-names:	from the common clock bindings;
		should be: "timerclken0", "timerclken1", "timerclken2", "timerclken3"

Example:
	sysctl at 020000 {
		compatible = "arm,sp810", "arm,primecell";
		reg = <0x020000 0x1000>;
		clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>,	<&smbclk>;
		clock-names = "refclk", "timclk", "apb_pclk";
		#clock-cells = <1>;
		clock-output-names = "timerclken0", "timerclken1", "timerclken2", "timerclken3";
	};
