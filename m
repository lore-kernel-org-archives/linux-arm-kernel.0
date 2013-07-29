From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 29 Jul 2013 17:49:05 +0100
Subject: Defining schemas for Device Tree
In-Reply-To: <20130729150124.GS29916@titan.lakedaemon.net>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729150124.GS29916@titan.lakedaemon.net>
Message-ID: <20130729164905.GB2280@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 11:01:24AM -0400, Jason Cooper wrote:
> On Mon, Jul 29, 2013 at 02:21:52AM +0200, Tomasz Figa wrote:
> > Hi,
> > 
> > As promised I am starting a discussion about Device Tree schema. Let's 
> > first shortly introduce the problem.
> > 
> > Device Tree is a text-based data structure used to describe hardware.
> 
> Just a clarifying point here:  I think it would be more accurate to say
> "devicetree describes how hardware on a given board is *configured*".
> The driver learns from the compatible property which IP block it is
> dealing with and handles the necessary quirks.  How that IP block is
> attached, and interfaced with is DT territory, that it needs an extra
> 10ns delay (outside of spec) is something the driver should know and
> work around.
> 
> > Its 
> > main point is separation from kernel code, which has a lot of benefits, 
> > but, at the moment, also a huge drawback - there is no verification of 
> > device tree sources against defined bindings. All the dtc compiler does 
> > currently are syntax checks - no semantic analysis is performed (except
> > some really basic things). What this means is that anybody can put
> > anything in their device tree and end up with the dts compiling fine only
> > to find out that something is wrong at boot time.
> > 
> > Currently, device tree bindings are described in plain text documentation 
> > files, which can not be considered a formal way of binding description. 
> > While such documentation provides information for developers/users that 
> > need to work with particular bindings, it can not be easily used as input 
> > for validation of device tree sources. This means that we need to define a 
> > more formal way of binding description, in other words - Device Tree 
> > schema.
> 
> +1
> 
> > To find a solution for this problem, we must first answer several 
> > questions to determine a set of requirements we have to meet.
> > 
> > a) What is a device tree binding?
> >  
> > For our purposes, I will define a binding as internal format of some 
> > device tree node, which can be matched using of_find_matching_node(). In 
> > other words, key for a binding would be node name and/or value of 
> > compatible property and/or node type. Value for a binding would be a list 
> > of properties with their formats and/or subnodes with their bindings.
> >  
> > b) What information should be specified in schemas? What level of 
> >    granularity is required?
> 
> One item I don't see in this list is node ordering.  There's been some
> discussion lately on deferred probing (re boot times).  If we were to
> intentionally declare that DT are parsed in the order written, then a
> lot of deferred probes could be avoided by moving eg the pinctrl node to
> near the top of the tree.
> 
> This doesn't impact buses as much, since the nodes needing the bus are
> already children.  However, anything accessed via phandles: pins,
> clocks, regulators, etc could benefit from declaring and enforcing this.
> Eg having the dtc warn when a phandle is used before it's corresponding
> node is declared.
> 
> Not critical though, just a thought.

I don't think that siblings have any defined order in DT.  If reading a
device tree, there's no guarantee you get nodes or properties out in the
same order as the original .dts file.

Provided child/parent relationships are maintained and the set of nodes
and values is the same, I think completely rearranging a .dts file does
not change its meaning.

"depends-on" relationships mostly have to come from the semantics of
the bindings themselves: for example, if a device is connected to some
clocks and regulators, the kernel may need to probe those first.

Cheers
---Dave
