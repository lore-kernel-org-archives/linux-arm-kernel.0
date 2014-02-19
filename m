From: david@gibson.dropbear.id.au (David Gibson)
Date: Thu, 20 Feb 2014 02:01:05 +1100
Subject: [RFC 1/1] Device Tree Schema Source format description
In-Reply-To: <20140128144959.8A532C40C84@trevor.secretlab.ca>
References: <9610740.2oBMxfeRkE@amdc1227> <3511775.RFRDLM8Ohp@amdc1227>
 <20140128144959.8A532C40C84@trevor.secretlab.ca>
Message-ID: <20140219150105.GB11025@voom.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 02:49:59PM +0000, Grant Likely wrote:
> Some random thoughts ahead of meeting today...
> 
> On Fri, 18 Oct 2013 16:57:36 +0200, Tomasz Figa <t.figa@samsung.com> wrote:
> > /*
> >  * schema.dtss - Sample Device Tree schema file.
> >  *
> >  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> >  * Author: Tomasz Figa <t.figa@samsung.com>
> >  *
> >  * This program is free software; you can redistribute it and/or
> >  * modify it under the terms of the GNU General Public License as
> >  * published by the Free Software Foundation version 2.
> >  *
> >  * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> >  * kind, whether express or implied; without even the implied warranty
> >  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >  * GNU General Public License for more details.
> >  */
> > 
> > /dtss-v1/;
> 
> In general I'm concerned about the creation of a new language, even if
> it is based on the DTS syntax. It forces us to define grammer that by
> necessity will be simple at first just to get things working, but then
> need to be extended to handle complex stuff. I've been researching ASN.1
> and similar schema languages to see if we can adopt the structure if not
> the syntax when writing schema files.

I share your concerns.  Let me know what you find in your researches.

My current guess is that a new schema language will be the right
solution in the long term.  But I'd think of it more as "inspired by"
dts syntax.

> In the mean time I'm now feeling that we should go ahead with the
> C-implementation of schema checking just to make some progress and then
> migrate the logic out into separately parsed schema files when we have
> something better. The low hanging fruit of course is the core bindings.
> Interrupts, gpios, regs, clocks, common busses like spi, i2c & pci.

I agree.  There's also a whole bunch of stuff we can (gradually) add
to dtc that will be useful on its own, but also more-or-less necessary
to implement a schema language.

The most obvious is richer expression support - first because schema
patterns are likely to want to use expressions, and also because I
think we'll need basically the same datastructures for tracking schema
patterns as we do for richer expressions.

> I think the most important thing to get settled now is determining how
> we trigger schema checks. For example, given a random node in the tree,
> how does the checker know to apply the interrupts and regs tests?

Right.  So I think there basically need to be two ways of applying a
schema to a node.  First one schema needs to be able to assert that
another applies - that covers inheritance and common patterns used in
device schemas.  Second, we need a database of rules asserting that
various schemas apply based on compatible, path or other
characteristics of a node.

Possibly you could combine those two by treating the overall set of
rules as a sort of meta-schema.  Not sure if that's a useful way to
think about it or not though.

> >  * Special keywords:
> >  *
> >  * /template/
> >  *	Defines schema template that can be used to represent generic bindings
> >  *	which may be then included in device bindings by /use/ keyword.
> >  *	A template can take a set of required or optional parameters.
> >  *	Optional parameters need to have default value specified, which is
> >  *	used when the parameter is omited from parameters of /use/ clause.
> >  *
> >  *	Template declaration uses following syntax:
> >  *	/template/ template-name {
> >  *		/arg/ argument-name-1; // Required argument
> >  *		/arg/ argument-name-2 = <1>; // Optional argument
> >  *		// Here follows binding specification described further
> >  *		// in this document.
> >  *	};
> 
> I'm wary of the template approach. I think schemas should be schemas,
> and it should alwasy be possible for a schema to derive from any other
> schema. For instance, a device binding will pull in the interrupt
> consumer and reg core schemas. Also, a special purpose UART device
> may use a simple extension of the ns16550 binding.

I'm not entirely sure what distinction you're drawing between a
template and a schema here.

My feeling is that a schema should essentially be a bundle of
assertions about the node.

> I guess my point is that templates shouldn't be a special case. All
> bindings should be derivable, but what we do need is a mechanism to
> constrain bindings. For example, the interrupts binding would describe
> one or more interrupts in a list, but a given device may need to
> constrain a minimum of 2 interrupts. For an initial C implementation that
> could merely be a argument when invoking the binding test.

One way I've been thinking about this is for schemas to (optionally)
have several named outputs in addition to just pass/fail.  e.g. the
interrupts schema as well as doing the basic validation provides a
"number-of-interrupts" output / variable.  A device scheme which
implies the interrupts schema could make a further assertion about
that number-of-interrupts output.

> >  *	A template argument is dereferenced by its name prefixed with
> >  *	a dollar ($) sign. An arbitrary property specified in parsed
> >  *	tree can be dereferenced by its absolute or relative path or
> >  *	by a lookup up the tree (interrupt-parent like).
> >  *
> >  * /arg/
> >  *	Marks following property declaration as a template argument.
> >  *	Can be used only inside a template declaration, to declare template
> >  *	arguments, as described above in /template/ keyword description.
> >  *
> >  * /use/
> >  *	Instantiates binding template. Causes the specified template to be
> >  *	included as a part of the binding specified by current node.
> >  *
> >  * 	Syntax used to instatiate templates:
> >  *	/use/ template-name {
> >  *		// List of template arguments and their values, e.g.
> >  *		argument-name-1 = <int-value>;
> >  *		argument-name-2 = "string-value";
> >  *		// etc.
> >  *	};
> 
> On the syntax, this feels very verbose. If we were to draw inspiration
> from the ASN.1 syntax, we might do somehting like this:
> 
> FdtDevice ::= SET {
> 	interrupts FdtInterrupt (SIZE(1))
> 	reg FdtReg
> }
> 
> FdtDevice is a type that makes use of the FdtReg and FdtInterrupt types.
> 
> >  *
> >  * /incomplete/
> >  *	Tells the validator that the schema is not complete, i.e.
> >  *	only specified properties and subnodes should be validated,
> >  *	without complaining about ones not specified in the schema.
> >  *
> >  *	Example of use:
> >  *	{
> >  *		compatible = "simple-bus";
> >  *		#address-cells = <1>;
> >  *		#size-cells = <1>;
> >  *
> >  *		*.* { // Zero or more subnodes
> >  *			/incomplete/; // of unspecified contents
> >  *		};
> >  *	};
> >  *
> >  * /inheritable/
> >  *	Marks property as inheritable by subnodes of node in which
> >  *	it is defined. An example of such property is interrupt-parent,
> >  *	which, if not specified in the same node as interrupts property,
> >  *	is assumed to be the same as the closest interrupt-parent property
> >  *	found when walking up the tree.
> >  *
> >  * 	This is purely a helper construct to allow referencing to
> >  *	a property from inside of a DTSS, even if it is not specified
> >  *	in referred node explicitly.
> >  *
> >  *	Example of use:
> >  *	{
> >  *		/inheritable/ interrupt-parent = phandle;
> >  *
> >  *		.* {
> >  *			// interrupt-parent is defined for this node
> >  *			// implicitly, even if not specified explicitly
> >  *		};
> >  *	};
> 
> Some bindings are just core, like interrupts. It would probablay be
> better to just leave those in C even when we're happy with a schema
> language.
> 
> >  * Binding description
> >  *
> >  * A binding starts with a top level node that must be described using at
> >  * least one of the key node attributes specified below. The top level node
> >  * can contains a set of properties and subnodes that describe the binding.
> >  * They can be specified using the DTS Schema syntax, which is basically
> >  * the standard DTS syntax modified to convey information about the schema,
> >  * not contents.
> 
> It seems to me that what you're getting at is that a binding needs to
> describe how it is matched (key attributes) and then the set of
> constraints. That is a good start, but it feels to me like the matching
> isn't very well defined yet. We need some pretty firm rules about how
> the checker know when it can apply rules, and those rules will change
> depending on where in the tree you are. For example, the cpus schema
> only is applicable under the /cpus node, and device nodes with
> compatible properties should only match on nodes that are under bus
> nodes. (there's another issue of checking for nodes placed where they
> shouldn't be, but I'll leave that aside for now).

So, I still think the right approach is to think in terms of
"patterns" that a node can match.  A schema will then typically be an
assertion that if pattern A matches (usually a simple pattern matching
just 'compatible') then pattern B matches as well (a complex pattern
giving all the constraints that this type of node should satisfy)

> Also the key properties or matching criteria will not be present for
> some bindings because they are only ever directly instantiated. ie. the
> interrupts binding doesn't stand on its own, it is only ever called out
> to by another binding. (I know, you've addressed some of this above, but
> I'm working through a though process).
> 
> As we talked about on the call today, if we can hammer out how the
> schemas will get selected at test time, then we can start to implement a
> hybrid approach where core stuff is implemented in C code and schema
> files can instantiate the core bindings as needed.

To start on this I think we want to do some cleanup of the current
"checks"  infrastructure.  Such as:
  * Add a concept of relevance - rather than a single check function,
there's a "does_this_apply" function and the check is only called if
that returns true.
  * Look at making prerequisite handling be handled on a per-node
rather than global basis.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/61d9f021/attachment.sig>
