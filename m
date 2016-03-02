From: robh@kernel.org (Rob Herring)
Date: Wed, 2 Mar 2016 11:09:35 -0600
Subject: [PATCH v2 1/6] dt-bindings: arm/marvell: add DT bindings for
 AP806 DFX Server
In-Reply-To: <20160226235549.GB28849@codeaurora.org>
References: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456326866-30854-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160225233710.GJ28849@codeaurora.org>
 <20160226093227.5d4dc1a7@free-electrons.com>
 <20160226235549.GB28849@codeaurora.org>
Message-ID: <20160302170935.GA11407@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 03:55:49PM -0800, Stephen Boyd wrote:
> On 02/26, Thomas Petazzoni wrote:
> > I would entirely agree with you if this DFX Server was some sort of
> > "system control" IP block that provided clocks, resets, and all sort of
> > other features.
> > 
> > But this DFX server thing is just a bunch of registers with absolutely
> > no relation to clocks. Due to this, it would be completely awkward to
> > have clock references like:
> > 
> > 	serial {
> > 		clocks = <&dfxserver 42>;
> > 	};
> > 
> > One will wonder "why the heck this UART controller is using a clock
> > from this really odd dfxserver thing" ? Currently we have:
> > 
> > 	serial {
> > 		clocks = <&coreclk 4>;
> > 	};
> > 
> > which makes a *lot* more sense.

Really, this is your argument?

> Sorry I don't see the difference and I don't agree with this
> argument. dfxserver is just a phandle and possibly a poorly named
> one at that. So is coreclk. The second example doesn't make a
> *lot* more sense or really any more sense than the first example.
> Maybe some #define should be used to make things readable:
> &dfxserver CORE_CLK_X or something. Why someone would care what
> the name of the phandle is for where the clk is coming from makes
> no sense to me.
> 
> The miscellaneous register dumping ground, i.e. dfxserver, is a
> total mess in hardware, agreed, but it doesn't mean we need to
> pick it apart and describe the bits and pieces of it so that our
> DT can be read as &coreclk 4 instead of &dfxserver 42.
> 
> Somebody delivered this dfxserver hardware block into the SoC.
> They decided to put random clk control in there. In terms of
> hardware blocks, I would guess that dfxserver has a couple clk
> wires coming out and some SoC integration engineer had to wire
> those up to the places like the uart that actually use them.
> Embrace these hardware design decisions. Represent the hardware
> in DT as it is represented in hardware by making one node for the
> dfxserver because dfxserver is a hardware block.

Agreed.

> > Also, your idea of just hiding everything behind a MFD bothers me quite
> > a bit. If I push this idea further, then why shouldn't I replace my
> > entire DT with a single node, that covers the entire register space of
> > my SoC, and then handle *everything* as a huge MFD. In a way, it would
> > be quite useful for me, as it would resolve the on-going dispute over
> > DT binding stability with Rob and Mark.
> 
> That's a straw man fallacy. Nobody is asking for this. DT is
> about describing relations between hardware blocks and the
> resources they use. It is *not* about describing register level
> details of hardware blocks and providing some data heavy format
> so that drivers are nothing besides DT data driven husks of code.
> Nor is it about grouping clk subtypes into different DT subnodes
> to make writing drivers easier. That's what gets us into the mess
> of DT backward compatibility when the data that should have been
> in the driver has been put into DT.
> 
> > 
> > For sure, I wouldn't have any DT backward compatibility issue, because
> > everything is hidden in my big MFD. But in terms of the DT as a
> > representation of the different HW blocks and the relations between
> > then, such a choice would be quite a failure.

What other functions do you have? You previously said the block was DFT 
registers which I would not expect s/w to ever touch.

> I don't see any failure. The dfxserver is a hardware block and
> that happens to be a clk provider, plain and simple. Consumers of
> those clks are related to the dfxserver and we've properly
> expressed the relations between them.

And you could have other types of consumers. Nothing requires nodes and 
providers to be 1-1.

You're being told to do it this way by multiple maintainers both because 
it is the preferred way to describe clocks and it gives a better chance 
for stable bindings. 

Rob
