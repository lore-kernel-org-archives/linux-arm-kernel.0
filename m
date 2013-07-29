From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 30 Jul 2013 00:20:35 +0200
Subject: Defining schemas for Device Tree
In-Reply-To: <51F6E30B.7060106@wwwdotorg.org>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
Message-ID: <6809706.cRofzbG9CV@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 of July 2013 15:47:55 Stephen Warren wrote:
> On 07/28/2013 06:21 PM, Tomasz Figa wrote:
> ...
> 
> > b) What information should be specified in schemas? What level of
> > 
> >    granularity is required?
> > 
> > For each property we need to have at least following data specified:
> >  - property name (or property name format, e.g. regex),
> >  - whether the property is mandatory or optional,
> >  - data type of value.
> 
> We might want general restrictions on node/property names, e.g. it seems
> we generally prefer - rather than _ in them, although there are a few
> entrenched exceptions.

Yes.

> > As for now, I can think of following data types used in device trees:
> >  - boolean (i.e. without value),
> >  - array of strings (including single string),
> >  - array of u32 (including single u32),
> >  - specifier (aka phandle with args, including cases with 0 args),
> >  - variable-length cells (e.g. #address-cells of u32s).
> > 
> > Some properties might require a combination of data types to be specified
> 
> I believe phandles are just cells in terms of the storage type at least.
> Hence, I'd argue we don't need mixing of types (boolean, cell, string),
> but I see your point about semantically needing to represent different
> cells meaning different things.

Let me return to this point a bit later in this message.

> > or even an array of combinations, like interrupt-map property, which is an
> > 
> > array of entries consisting of:
> >  - #address-cells u32s,
> >  - #interrupt-cells u32s,
> >  - specifier (phandle of interrupt controller and u32 of count defined by
> >  
> >    #interrupt-cells of the controller).
> > 
> > We probably want to define allowed range of values for given property, be
> > it contiguous or enumerated.
> 
> Where defining the length of a property (or part of it) in terms of
> another #xxx-cells property, we need to specify where that other
> property exists. Sometimes it's the nearest parent node containing the
> property (typical for #address-cells), sometimes it's the node
> containing the property itself (typical for one of the #address-cells
> referenced by a ranges property), and sometimes it's in the node
> referenced by the phandle associated with a specifier.
> 
> Other content restrictions might be:
> 
> * List must contain (at least) these entries/values.
> 
> * List can't contain any other entries/values not specified here.
> 
> * List must be in this order vs. any order.
> 
> * List logical length (in entries, not bytes/cells) must match the
> logical length of another cell (consider clocks/clock-names).
> 
> * Ordering of one property must match ordering of another property
> (again consider clocks/clock-names), although it'd be difficult to tell
> whether this condition was met, perhaps we can at least document it.
> 
> I'm sure there will be many more criteria to validate that we're
> forgetting. This is possible the most complex area?

Right. Still, this is about the granularity of checks we really need. Do we 
need to check for all those restrictions?

> > As for subnodes, I think we need to define following constraints:
> >  - node name (or node name format, e.g. regex),
> 
> I don't think node names are supposed to convey any semantic meaning, so
> they probably shouldn't be restricted (much?) by schema.

There are bindings currently that require specific node names. Since 
of_match_node() can do matching by names as well, I think we should care about 
node names too,

> > d) When should the validation happen and what should handle it?
> 
> ...
> 
> > well. Nothing stops us from running validation on already compiled dtbs,
> > though, using an extra tool.
> 
> In a DTB, I'm not sure whether all the type information is still present.
> 
> For example, in DTS, the following are very obviously different:
> 
> prop = "abc", "def";
> prop = <0x61626300> <0x64656600>;
> 
> ... whereas in the DTB, I think they are both just two 32-bit values
> that just happen to encode string data or not. Presumably we want the
> validator to force string properties to be specified using string syntax?
> 
> Equally, I'm not sure there's any difference between:
> 
> prop = <&node>;
> prop = <0x23648689>;
> 
> ... in the DTB, except that the value just *happens* to match another
> node's phandle value, which could end up leading to false positive
> matches if only applied on the raw values not the syntax?

This is a good point. From driver's perspective it doesn't matter how you 
specify value of some property, as long as it can be parsed using the same 
code. As a more trivial example, consider following dts code:

	array-prop = <0>, <1>, <2>;
	array-prop-2 = <0 1 2>;

Both array props contain the same data and can be parsed using the same code, 
but from reader's perspective they mean something slightly different - an array 
with 1 cell per element and a single entry of 3 cells.

Now back to the point I deferred my reply to, I think we need different 
handling for at least phandles and properties of which number of cells is 
specified by one or more properties (possibly in other nodes).

At DTS level phandle properties should use the phandle syntax, pointing at 
some node, while at DTB level a raw phandle value could be validated by 
checking if it matches with phandle of some node.

For properties ussing #xxx-cells properties we need to check for correct 
number of cells., which involves getting values of right #xxx-cells 
properties.

Best regards,
Tomasz
