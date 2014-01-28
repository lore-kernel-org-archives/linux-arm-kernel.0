From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 28 Jan 2014 14:49:59 +0000
Subject: [RFC 1/1] Device Tree Schema Source format description
In-Reply-To: <3511775.RFRDLM8Ohp@amdc1227>
References: <9610740.2oBMxfeRkE@amdc1227> <3511775.RFRDLM8Ohp@amdc1227>
Message-ID: <20140128144959.8A532C40C84@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some random thoughts ahead of meeting today...

On Fri, 18 Oct 2013 16:57:36 +0200, Tomasz Figa <t.figa@samsung.com> wrote:
> /*
>  * schema.dtss - Sample Device Tree schema file.
>  *
>  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
>  * Author: Tomasz Figa <t.figa@samsung.com>
>  *
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License as
>  * published by the Free Software Foundation version 2.
>  *
>  * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>  * kind, whether express or implied; without even the implied warranty
>  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  */
> 
> /dtss-v1/;

In general I'm concerned about the creation of a new language, even if
it is based on the DTS syntax. It forces us to define grammer that by
necessity will be simple at first just to get things working, but then
need to be extended to handle complex stuff. I've been researching ASN.1
and similar schema languages to see if we can adopt the structure if not
the syntax when writing schema files.

In the mean time I'm now feeling that we should go ahead with the
C-implementation of schema checking just to make some progress and then
migrate the logic out into separately parsed schema files when we have
something better. The low hanging fruit of course is the core bindings.
Interrupts, gpios, regs, clocks, common busses like spi, i2c & pci.

I think the most important thing to get settled now is determining how
we trigger schema checks. For example, given a random node in the tree,
how does the checker know to apply the interrupts and regs tests?

>  * Special keywords:
>  *
>  * /template/
>  *	Defines schema template that can be used to represent generic bindings
>  *	which may be then included in device bindings by /use/ keyword.
>  *	A template can take a set of required or optional parameters.
>  *	Optional parameters need to have default value specified, which is
>  *	used when the parameter is omited from parameters of /use/ clause.
>  *
>  *	Template declaration uses following syntax:
>  *	/template/ template-name {
>  *		/arg/ argument-name-1; // Required argument
>  *		/arg/ argument-name-2 = <1>; // Optional argument
>  *		// Here follows binding specification described further
>  *		// in this document.
>  *	};

I'm wary of the template approach. I think schemas should be schemas,
and it should alwasy be possible for a schema to derive from any other
schema. For instance, a device binding will pull in the interrupt
consumer and reg core schemas. Also, a special purpose UART device
may use a simple extension of the ns16550 binding.

I guess my point is that templates shouldn't be a special case. All
bindings should be derivable, but what we do need is a mechanism to
constrain bindings. For example, the interrupts binding would describe
one or more interrupts in a list, but a given device may need to
constrain a minimum of 2 interrupts. For an initial C implementation that
could merely be a argument when invoking the binding test.

>  *
>  *	A template argument is dereferenced by its name prefixed with
>  *	a dollar ($) sign. An arbitrary property specified in parsed
>  *	tree can be dereferenced by its absolute or relative path or
>  *	by a lookup up the tree (interrupt-parent like).
>  *
>  * /arg/
>  *	Marks following property declaration as a template argument.
>  *	Can be used only inside a template declaration, to declare template
>  *	arguments, as described above in /template/ keyword description.
>  *
>  * /use/
>  *	Instantiates binding template. Causes the specified template to be
>  *	included as a part of the binding specified by current node.
>  *
>  * 	Syntax used to instatiate templates:
>  *	/use/ template-name {
>  *		// List of template arguments and their values, e.g.
>  *		argument-name-1 = <int-value>;
>  *		argument-name-2 = "string-value";
>  *		// etc.
>  *	};

On the syntax, this feels very verbose. If we were to draw inspiration
from the ASN.1 syntax, we might do somehting like this:

FdtDevice ::= SET {
	interrupts FdtInterrupt (SIZE(1))
	reg FdtReg
}

FdtDevice is a type that makes use of the FdtReg and FdtInterrupt types.

>  *
>  * /incomplete/
>  *	Tells the validator that the schema is not complete, i.e.
>  *	only specified properties and subnodes should be validated,
>  *	without complaining about ones not specified in the schema.
>  *
>  *	Example of use:
>  *	{
>  *		compatible = "simple-bus";
>  *		#address-cells = <1>;
>  *		#size-cells = <1>;
>  *
>  *		*.* { // Zero or more subnodes
>  *			/incomplete/; // of unspecified contents
>  *		};
>  *	};
>  *
>  * /inheritable/
>  *	Marks property as inheritable by subnodes of node in which
>  *	it is defined. An example of such property is interrupt-parent,
>  *	which, if not specified in the same node as interrupts property,
>  *	is assumed to be the same as the closest interrupt-parent property
>  *	found when walking up the tree.
>  *
>  * 	This is purely a helper construct to allow referencing to
>  *	a property from inside of a DTSS, even if it is not specified
>  *	in referred node explicitly.
>  *
>  *	Example of use:
>  *	{
>  *		/inheritable/ interrupt-parent = phandle;
>  *
>  *		.* {
>  *			// interrupt-parent is defined for this node
>  *			// implicitly, even if not specified explicitly
>  *		};
>  *	};

Some bindings are just core, like interrupts. It would probablay be
better to just leave those in C even when we're happy with a schema
language.

>  * Binding description
>  *
>  * A binding starts with a top level node that must be described using at
>  * least one of the key node attributes specified below. The top level node
>  * can contains a set of properties and subnodes that describe the binding.
>  * They can be specified using the DTS Schema syntax, which is basically
>  * the standard DTS syntax modified to convey information about the schema,
>  * not contents.

It seems to me that what you're getting at is that a binding needs to
describe how it is matched (key attributes) and then the set of
constraints. That is a good start, but it feels to me like the matching
isn't very well defined yet. We need some pretty firm rules about how
the checker know when it can apply rules, and those rules will change
depending on where in the tree you are. For example, the cpus schema
only is applicable under the /cpus node, and device nodes with
compatible properties should only match on nodes that are under bus
nodes. (there's another issue of checking for nodes placed where they
shouldn't be, but I'll leave that aside for now).

Also the key properties or matching criteria will not be present for
some bindings because they are only ever directly instantiated. ie. the
interrupts binding doesn't stand on its own, it is only ever called out
to by another binding. (I know, you've addressed some of this above, but
I'm working through a though process).

As we talked about on the call today, if we can hammer out how the
schemas will get selected at test time, then we can start to implement a
hybrid approach where core stuff is implemented in C code and schema
files can instantiate the core bindings as needed.

g.

>  * 
>  * Node description
>  *
>  * A node starts with a node-name, then { and ends with matching } and
>  * a semicolon. It can be described by a set of key attributes, which are:
>  * - compatible property,
>  * - device_type property,
>  * - node name (DEPRECATED for top level nodes of bindings).
>  *
>  * Once a node matches all specified key attributes of a defined binding
>  * it is validated according to description of this binding.
>  *
>  * Property specification
>  *
>  * Each property inside a node is specified just as in a normal DTS file,
>  * except that the value specified determines value type and range of
>  * allowed values, not a particular value itself. In addition, property
>  * name can be prefixed with an optionality quantifier, marking the property
>  * as optional (specified 0 or 1 times).
>  *
>  * Property type can be specified using type specification syntax. It is
>  * a regular expression like syntax, but including special type keywords,
>  * that represent all the defined DTS value types, which is:
>  *  1) string: a string of characters enclosed by quotation marks,
>  *  2) cell: a single, unsigned 32-bit value,
>  *  3) phandle: a valid phandle to any device node,
>  *  4) binary: a sequence of bytes (NOTE: quantifiers work as byte count here).
>  * Property types can be mixed inside the property, so the value can consist
>  * of followed multiple blocks of data of different types.
>  *
>  * In addition, string and cell types can be limited to specified set
>  * of allowed values, discrete or contiguous (cell only), by using
>  * parentheses after type name. Regular expressions are allowed when
>  * specifying allowed string values.
>  *
>  * Inside property specifiers, other properties and template arguments
>  * can be dereferenced by preceding their names with dollar "$" sign.
>  * Element count of a property that is an array can be received by
>  * preceding its name with at "@" sign. The property name following
>  * $ or @ sign is interpreted as a path in device tree, either absolute
>  * if started by a slash "/" or relative otherwise.
>  *
>  * Example properties built from strings:
>  *
>  *	string-property-1 = string; // one string
>  *	string-property-2 = string+; // array of strings
>  *	string-property-3 = string{@clock-names}; // same count as in
>  *						  // clock-names property
>  *	string-property-4 = string("one", "two", "three"); // three
>  *						// allowed values
>  *	string-property-5 = string("[a-zA-Z]+[0-9]"); // allowed values
>  *						// defined using a regexp
>  *
>  * Example properties built from cells:
>  *
>  *	cell-property-1 = cell; // one cell
>  *	cell-property-2 = (cell{$#cell-property-2-cells})+; // cell count
>  *			// specified by #cell-property-name-cells property
>  *	cell-property-3 = cell(0, 1, 2, 3, 4); // integers from 0 to 4
>  *	cell-property-4 = cell(0..4); // same as above, but using a range
>  *
>  * Example proprerties built from phandles:
>  *
>  *	phandle-property-1 = phandle; // one phandle
>  *
>  * Example properties built from binary data:
>  *
>  *	binary-property-1 = binary+; // one or more bytes of binary data
>  *	binary-property-2 = binary{6}; // 6 bytes of binary data
>  *
>  * Example mixed properties:
>  *
>  *	mixed-property-1 = ((phandle),cell{$\2/#mixed-property-1-cells})+;
>  *	// typical specifier - phandle of controller node and a set of cells
>  *	// defined by #*-cells property of controller node. Note the use
>  *	// of backreferences here.
>  *	// TODO: How to represent references to properties in a node
>  *	// pointed by a phandle?
>  *
>  * Quantifiers
>  *
>  * Determines valid iteration count for element after the quantifier
>  * symbol, which can be a property or a child node. <quantifier> can be
>  * any valid quantifier according to POSIX extended regular expression
>  * syntax.
>  *
>  * Examples of use:
>  *
>  * // For properties
>  * property-name-1; // Required property
>  * ?property-name-2; // Optional property
>  *
>  * // For subnodes
>  * node-name-1 {}; // Required node (exactly 1 time)
>  * ?node-name-2 {}; // Optional node (0 or 1 times)
>  * +node-name-3 {}; // Required node (1 or more times)
>  * *node-name-4 {}; // Optional nodes (0 or more times)
>  * {1,3}node-name-5 {}; // From 1 to 3 subnodes must be present
>  *
>  * // For data types
>  * property-name-1 = cell; // One cell
>  * property-name-2 = string+; // One or more strings
>  * property-name-3 = phandle{3,8}; // From three to eight phandles
>  *
>  * Real-life examples
>  *
>  * Following is a set of examples of DTS Schema syntax use, based on existing
>  * device tree bindings. All examples are commented to explain used mechanisms.
>  * Note that all the examples are valid and should compile fine using a DTS
>  * Schema enabled version of the DTC compiler.
>  */
> 
> /*
>  * Utility schema templates.
>  */
> /template/ reg-property {
> 	/*
> 	 * This template takes one argument reg-count, which is optional
> 	 * and if omitted, takes the default value of 1.
> 	 */
> 	/arg/ reg-count = <1>;
> 
> 	/*
> 	 * The example below defines a mandatory "reg" property, consisting
> 	 * of exactly reg-count groups, each consisting of (#address-cells +
> 	 * #size-cells) cells each.
> 	 */
> 	reg = (cell{$../#address-cells},cell{$../#size-cells}){$reg-count};
> };
> 
> /template/ status-property {
> 	/*
> 	 * Template without arguments.
> 	 *
> 	 * Defines a single, optional status property that can take one of
> 	 * enumerated values.
> 	 */
> 	?status = string("okay", "disabled");
> };
> 
> /template/ device {
> 	/* Optional argument, defaulting to 1. */
> 
> 	/* TODO: How to specify variable entry count? */
> 	/arg/ reg-count = <1>;
> 
> 	/* Use a template. */
> 	/use/ reg-property {
> 		/*
> 		 * Specify value of template argument.
> 		 * Note the reference to argument of this template.
> 		 */
> 		reg-count = $reg-count;
> 	};
> 	/* Use another template. This time without arguments specified. */
> 	/use/ status-property;
> };
> 
> /template/ bus {
> 	#address-cells = cell;
> 	#size-cells = cell;
> 
> 	/default/ #address-cells = <2>;
> 	/default/ #size-cells = <1>;
> };
> 
> /*
>  * Generic SPI bindings.
>  */
> /template/ spi {
> 	/* Mandatory argument, without default value. */
> 	/arg/ cs-cells = cell;
> 
> 	/* #address-cells property equal to cs-cells argument. */
> 	#address-cells = <$cs-cells>;
> 	/* Fixed value of #size-cells property. */
> 	#size-cells = <0>;
> 	/* A single-cell property num-cs. */
> 	num-cs = cell;
> 
> 	/* From 0 to $num-cs subnodes with any name. */
> 	{0,$num-cs}.* {
> 		/* This node must have a reg property, with one entry. */
> 		/use/ reg-property {
> 			reg-count = <1>;
> 		};
> 		/* This binding does not fully define node contents. */
> 		/incomplete/;
> 	};
> };
> 
> /*
>  * Generic interrupt bindings.
>  */
> /template/ interrupts {
> 	/*
> 	 * Optional argument, specifying number of entries in interrupts
> 	 * property. Defaults to 1.
> 	 * TODO: How to specify optional interrupts or interrupt lists
> 	 * that vary with compatible string?
> 	 */
> 	/arg/ interrupt-count = <1>;
> 
> 	/* Optional phandle to interrupt controller. */
> 	/inheritable/ ?interrupt-parent = phandle;
> 	/*
> 	 * List of interrupts.
> 	 * TODO: variable interrupt count?
> 	 */
> 	interrupts = (cell{$($interrupt-parent)/#interrupt-cells}){$interrupt-count};
> };
> 
> /*
>  * Generic clock bindings.
>  */
> /template/ clocks {
> 	/*
> 	 * Required argument specifying number of clocks.
> 	 * TODO: Optional clocks?
> 	 */
> 	/arg/ clock-count = cell;
> 
> 	/*
> 	 * List of exactly $count clock specifiers.
> 	 * TODO: How to dereference phandles of specifiers properly.
> 	 */
> 	clocks = ((phandle),cell{$\2/#clock-cells}){$count};
> };
> 
> /*
>  * Generic pinctrl bindings.
>  */
> /template/ pinctrl {
> 	/*
> 	 * List of pinctrl names.
> 	 * TODO: Optional pinctrl states?
> 	 */
> 	/arg/ names = string+;
> 
> 	/* Pinctrl names, as specified in $names. */
> 	pinctrl-names = $names;
> 	/*
> 	 * Pinctrl groups for every entry of pinctrl-names property.
> 	 * TODO: Find a correct way to define a series of properties.
> 	 */
> 	pinctrl-[0- at names] = phandle+;
> };
> 
> /template/ pinctrl-default {
> 	/* Fixed value of required pinctrl-names property. */
> 	pinctrl-names = "default";
> 	/*
> 	 * List of pinctrl groups for default pinctrl state.
> 	 * NOTE that an empty list of groups can be specified too.
> 	 */
> 	pinctrl-0 = phandle*;
> };
> 
> /*
>  * Generic video interface (V4L2/media) bindings.
>  */
> /template/ video-port {
> 	port {
> 		/* Bus with 1-cell addresses and no sizes. */
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		/* One or more endpoint nodes. */
> 		+endpoint {
> 			/* Single entry reg property. */
> 			/use/ reg-property;
> 			/*
> 			 * Required phandle to remote endpoint.
> 			 * TODO: Do we need to check things like bidirectional
> 			 * connectivity? I.e. whether the node pointed by
> 			 * $remote-endpoint points to this node?
> 			 */
> 			remote-endpoint = phandle;
> 			/* Optional property indicating slave mode operation. */
> 			?slave-mode;
> 			/* Optional bus width */
> 			?bus-width = cell;
> 			/* ... */
> 		};
> 	};
> };
> 
> /template/ video-ports {
> 	/* Bus with 1-cell addresses and no sizes. */
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> 	/* Include video port template. */
> 	/use/ video-port {
> 		/* Override quantifier of port subnodes. */
> 		+port {
> 			/* Single entry reg property. */
> 			/use/ reg-property;
> 		};
> 	};
> };
> 
> /*
>  * Skeleton schema for all DTSes according to ePAPR 1.1.
>  *
>  * NOTE explicit node location specified.
>  */
> &{/} {
> 	/* Human readable board model. */
> 	model = string;
> 	/* Set of board compatible values. */
> 	compatible = string+;
> 	/* Optional version of ePAPR spec this device tree complies to. */
> 	?epapr-version = string;
> 	/* Top level bus */
> 	/use/ bus;
> 
> 	/* Required chosen node. */
> 	chosen {
> 		/* Optional bootargs string. */
> 		?bootargs = string;
> 		/* Optional stdout-path string. */
> 		?stdout-path = string;
> 		/* Optional stdin-path string. */
> 		?stdin-path = string;
> 	};
> 
> 	/* Required aliases node. */
> 	aliases {
> 		/*
> 		 * Optional list of aliases with arbitrary names, pointing
> 		 * to device nodes either by path...
> 		 */
> 		?[a-z0-9_]+ = string; /* TODO: Should we check path validity? */
> 		/* ...or phandle. */
> 		?[a-z0-9_]+ = phandle;
> 	};
> 
> 	/* Required memory node. */
> 	memory {
> 		/* Required single entry reg property. */
> 		/use/ reg-property {
> 			reg-count = /* TODO: how to specify a range here */;
> 		};
> 
> 		/* Required device_type set to "memory". */
> 		device_type = "memory";
> 		/* Optional property containing multiple reg-like entries. */
> 		?initial-mapped-area = (cell{../#address-cells},cell{../#size-cells})+;
> 	};
> 
> 	/* Required cpus node. */
> 	cpus {
> 		/* A bus with 1-cell address and 0-cell size specifiers. */
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		/* A set of CPU nodes. At least one is required. */
> 		+cpu {
> 			/* 1-entry reg property, for CPU MPIDR. */
> 			/use/ reg-property;
> 			/* This node can have status property. */
> 			/use/ status-property;
> 			/* The device_type property must be set to "cpu". */
> 			device_type = "cpu";
> 			/*
> 			 * Optional clock-frequency property, specified
> 			 * using 1 or 2 cells, depending on the platform.
> 			 */
> 			?clock-frequency = cell{1,2};
> 
> 			/*
> 			 * Additional platform-specific properties might be
> 			 * present here, which are out of scope of this
> 			 * binding.
> 			 */
> 			/incomplete/;
> 		};
> 	};
> 
> 	/* Any optional device nodes. */
> 	*.* {
> 		/* Out of scope of this binding. */
> 		/incomplete/;
> 	};
> };
> 
> /*
>  * Davinci SPI controller device bindings
>  */
> {
> 	/* Binding is defined for any of following compatible values. */
> 	compatible = string("ti,dm64410-spi", "ti,da830-spi");
> 
> 	/* Use generic device bindings. */
> 	/use/ device;
> 	/* Use generic SPI bindings. */
> 	/use/ spi {
> 		/* Chip select is identified using one cell. */
> 		cs-cells = <1>;
> 	};
> 	/* Use generic interrupt bindings. */
> 	/use/ interrupts {
> 		/* This device has one interrupt signal. */
> 		interrupt-count = <1>;
> 	};
> 	/* Use generic clock bindings. */
> 	/use/ clocks {
> 		/*
> 		 * This device consumes one clock, without the need to
> 		 * specify its name.
> 		 */
> 		count = <1>;
> 	};
> 
> 	/*
> 	 * Device-specific property that defines which IP interrupt signal
> 	 * is tied to SoC's interrupt controller.
> 	 *
> 	 * TODO: Is this correct?
> 	 */
> 	ti,davinci-spi-intr-line = cell(<0>, <1>);
> };
> 
> /*
>  * Samsung S5P/EXYNOS SoC Camera Subsystem (FIMC)
>  */
> {
> 	/* Binding is defined for following compatible value. */
> 	compatible = "samsung,fimc";
> 
> 	/* Use generic clock bindings. */
> 	/use/ clocks {
> 		clock-count = <4>;
> 	};
> 	/* Clocks with following names must be specified. */
> 	clock-names = "sclk_cam0", "sclk_cam1", "pxl_async0", "pxl_async1";
> 	/* Use generic pinctrl bindings. */
> 	/use/ pinctrl {
> 		/*
> 		 * At least "default" state must be specified. Remaining
> 		 * three states are optional.
> 		 * TODO: Revise handling of optional states.
> 		 */
> 		names = "default", ("idle", "active-a", "active-b")?;
> 	};
> 	/* This node can have a status property. */
> 	/use/ status-property;
> 	/* This node represents a bus with 1-cell addresses and sizes. */
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 
> 	/* Optional node representing parallel camera ports. */
> 	?parallel-ports {
> 		/*
> 		 * This node represents a bus with 1-cell addresses and
> 		 * no sizes.
> 		 */
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		/* Use generic video port bindings. */
> 		/use/ video-port;
> 	};
> 
> 	/* At least one fimc node is required */
> 	+fimc {
> 		/* Compatible should be set to one of following values. */
> 		compatible = string("samsung,s5pv210-fimc",
> 				  "samsung,exynos4210-fimc",
> 				  "samsung,exynos4212-fimc");
> 		/* This is a device. */
> 		/use/ device;
> 		/* This device has a single interrupt signal. */
> 		/use/ interrupts;
> 		/* Clocks are used. */
> 		/use/ clocks {
> 			clock-count = <2>;
> 		};
> 		/* With following clock names. */
> 		clock-names = "fimc", "sclk_fimc";
> 
> 		/*
> 		 * Here follows an example set of properties described
> 		 * as in existing binding documentation files.
> 		 * 
> 		 * NOTE: Each property is followed by its description.
> 		 */
> 
> 		/* Required properties: */
> 		samsung,pix-limits = cell{4};
> 		/*
> 		 * an array of maximum supported image sizes in pixels, for
> 		 * details refer to Table 2-1 in the S5PV210 SoC User Manual; The meaning of
> 		 * each cell is as follows:
> 		 * 0 - scaler input horizontal size,
> 		 * 1 - input horizontal size for the scaler bypassed,
> 		 * 2 - REAL_WIDTH without input rotation,
> 		 * 3 - REAL_HEIGHT with input rotation.
> 		 */
> 		samsung,sysreg = phandle;
> 		/* A phandle to the SYSREG node. */
> 
> 		/* Optional properties: */
> 		?clock-frequency = cell;
> 		/* maximum FIMC local clock (LCLK) frequency */
> 		?samsung,min-pix-sizes = cell{2};
> 		/*
> 		 * An array specifying minimum image size in pixels at
> 		 * the FIMC input and output DMA, in the first and second cell
> 		 * respectively. Default value when this property is not
> 		 * present is <16 16>
> 		 */
> 		?samsung,min-pix-alignment = cell{2};
> 		/*
> 		 * minimum supported image height alignment (first cell)
> 		 * and the horizontal image offset (second cell). The values
> 		 * are in pixels and default to <2 1> when this property is
> 		 * not present
> 		 */
> 		?samsung,mainscaler-ext;
> 		/*
> 		 * A boolean property indicating whether the FIMC IP
> 		 * supports extended image size and has CIEXTEN register.
> 		 */
> 		?samsung,rotators = cell;
> 		/*
> 		 * A bitmask specifying whether this IP has the input and
> 		 * the output rotator. Bits 4 and 0 correspond to input and
> 		 * output rotator respectively. If a rotator is present its
> 		 * corresponding bit should be set. Default value when this
> 		 * property is not specified is 0x11.
> 		 */
> 		?samsung,cam-if;
> 		/*
> 		 * A bolean property indicating whether the IP block includes
> 		 * the camera input interface.
> 		 */
> 		?samsung,isp-wb;
> 		/*
> 		 * This property must be present if the IP block has the ISP
> 		 * writeback input.
> 		 */
> 		?samsung,lcd-wb;
> 		/*
> 		 * This property must be present if the IP block has the LCD
> 		 * writeback input.
> 		 */
> 	};
> 
> 	/*
> 	 * One or more optional csis node.
> 	 * Contents unspecified by this binding.
> 	 */
> 	*csis {
> 		/incomplete/;
> 	};
> 
> 	/*
> 	 * One or more optional fimc-lite node.
> 	 * Contents unspecified by this binding.
> 	 */
> 	*fimc-lite {
> 		/incomplete/;
> 	};
> };
> 
> /*
>  * PCI device binding template (used by PCI bus binding)
>  */
> /template/ pci-device {
> 	/* Compatible string matching any of listed regular expressions. */
> 	compatible = string("pciclass,([0-9a-f]{4})([0-9a-f]{2})?",
> 			"pci([1-9a-f][0-9a-f]{0,3}|0),([1-9a-f][0-9a-f]{0,3}|0)\.([1-9a-f][0-9a-f]{0,3})\.([1-9a-f][0-9a-f]{0,3}|0)\.([1-9a-f][0-9a-f]?|0)",
> 			"pci([1-9a-f][0-9a-f]{0,3}|0),([1-9a-f][0-9a-f]{0,3}|0)\.([1-9a-f][0-9a-f]{0,3})\.([1-9a-f][0-9a-f]{0,3}|0)",
> 			"pci([1-9a-f][0-9a-f]{0,3}),([1-9a-f][0-9a-f]{0,3}|0)",
> 			"pci([1-9a-f][0-9a-f]{0,3}|0),([1-9a-f][0-9a-f]{0,3}|0)\.([1-9a-f][0-9a-f]?|0)",
> 			"pci([1-9a-f][0-9a-f]{0,3}|0),([1-9a-f][0-9a-f]{0,3}|0)",
> 			"pciclass,([0-9a-f]{4})([0-9a-f]{2})?");
> 	/* Device name string. */
> 	name = string;
> 	/*
> 	 * A set of 5-cell reg entries defined accordign to PCI binding
> 	 * specification.
> 	 */
> 	reg = (cell{5})+;
> 	/* Optional interrupt specifier. */
> 	/use/ ?interrupts = {
> 		interrupt-count = <1>;
> 	};
> 
> 	/* Optional alternate reg property. */
> 	?alternate-reg = (cell{5})+;
> 	/* Optional single cell property. */
> 	?fcode-rom-offset = cell;
> 	/* Optional list of up to 6 Assigned addresses. */
> 	?assigned-addresses = (cell{5}){0,6};
> 	/* Optional list of power consumption values - from 1 to 10 cells. */
> 	?power-consumption = cell{1,10};
> 
> 	/*
> 	 * Simple single cell properties defined in PCI binding
> 	 * specification.
> 	 */
> 	vendor-id = cell;
> 	device-id = cell;
> 	revision-id = cell;
> 	class-code = cell;
> 	min-grant = cell;
> 	max-latency = cell;
> 	devsel-speed = cell;
> 	?cache-line-size = cell;
> 	?fast-back-to-back;
> 	?subsystem-id = cell;
> 	?subsystem-vendor-id = cell;
> 
> 	/* Boolean properties. */
> 	?66mhz-capable;
> 	?udf-supported;
> 
> 	/* Extra per-device attributes are allowed. */
> 	/incomplete/;
> };
> 
> /*
>  * PCI bus binding template
>  */
> /template/ pci-bus {
> 	/* PCI bus node must have device_type set to "pci". */
> 	device_type = "pci";
> 	/* Standard bus attributes. */
> 	#address-cells = <3>;
> 	#size-cells = <2>;
> 	ranges;
> 
> 	/* A set of optional properties. */
> 	?bus-range = cell{2};
> 	?clock-frequency = cell;
> 	?slot-names = cell, string+;
> 	?bus-master-capable = cell;
> 
> 	/* PCI devices */
> 	* {
> 		/use/ pci-device;
> 	};
> };
> 
> /*
>  * NVIDIA Tegra PCIe controller
>  */
> {
> 	/* Binding is identified by following compatible list. */
> 	compatible = string("nvidia,tegra20-pcie", "nvidia,tegra30-pcie");
> 	/* It is a PCI bus. */
> 	/use/ pci-bus;
> 	/* Needs 3 reg entries. */
> 	/use/ reg-property {
> 		reg-count = <3>;
> 	};
> 	/* Names of reg entries must be specified as follows. */
> 	reg-names = "pads", "afi", "cs";
> 	/* Neds 2 interrupts. */
> 	/use/ interrupts {
> 		interrupt-count = <2>;
> 	};
> 	/* With names as specified below. */
> 	interrupt-names = "intr", "msi";
> 	/* Needs 5 clocks. */
> 	/use/ clocks {
> 		clock-count = <5>;
> 	};
> 	/* With following input names. */
> 	clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml";
> 	/* Needs pex-clk regulator. */
> 	/use/ regulator {
> 		supply-name = "pex-clk";
> 	};
> 	/* Needs vdd regulator. */
> 	/use/ regulator {
> 		supply-name = "vdd";
> 	};
> 	/* Needs avdd regulator. */
> 	/use/ regulator {
> 		supply-name = "avdd";
> 	};
> 
> 	/* Root port nodes. */
> 	*pci {
> 		/use/ pci-bus;
> 		nvidia,num-lanes = cell;
> 	};
> };
> 
