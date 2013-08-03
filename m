From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 03 Aug 2013 20:39:34 +0200
Subject: [PATCHv5 01/31] CLK: clkdev: add support for looking up clocks
 from DT
In-Reply-To: <20130803183543.GF23053@n2100.arm.linux.org.uk>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <2002722.lT3pR1Ni8o@flatron> <20130803183543.GF23053@n2100.arm.linux.org.uk>
Message-ID: <1948861.Oxa8mV2HuC@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Saturday 03 of August 2013 19:35:43 Russell King - ARM Linux wrote:
> On Sat, Aug 03, 2013 at 04:02:36PM +0200, Tomasz Figa wrote:
> > > +	if (cl)
> > > +		return cl;
> > > +
> > > +	/* If clock was not found, attempt to look-up from DT */
> > > +	node = of_find_node_by_name(NULL, con_id);
> > 
> > Why are we introducing the "lookup by name" brokenness to the yet
> > (mostly) sane DT world?
> > 
> > We already have a good way of binding things together in DT, which is
> > using phandles.
> > 
> > Not even saying that this (or something this patch relies on) breaks
> > the ePAPR recommendation about node naming, which states that node
> > names should not be used to convey platform-specific data, but
> > instead should be as generic as possible to show what kind of
> > hardware is represented by the node.
> 
> Tell me this: many devices name their clock inputs.  You can find these
> input names in data sheets and the like.  These are the names defined
> by the hardware.  What is wrong about using those names in DT?

Yes, clock inputs. But this is about lookup by clock name, not clock input 
name, as far as I can tell from the patch, based on looking for a node 
with given name over the whole DT.

> Remember that the second argument to clk_get() is the _clock_ _input_
> _name_ on the _device_ passed in the first argument.  It is not *ever*
> some random name of the clock producer unless someone's fscked up their
> use of this API (in which case they're the ones with the problem.)

This is perfectly fine and this is how the generic common clock framework 
DT bindings work - clock-names property is a list of clock input names and 
clocks property contain specifiers of respective clocks.

Best regards,
Tomasz
