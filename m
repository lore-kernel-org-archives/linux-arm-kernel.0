From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 Mar 2012 15:45:30 +0200
Subject: OMAP DSS device tree design problems
Message-ID: <1331559930.2097.100.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm struggling with the design of the DT data for OMAP display subsystem
driver, and any thoughts and ideas are welcome. This mail is a rather
long one, where I'm trying to show the different approaches I've
thought.

So the .dts format would be something like this, taking 4430SDP as an
example. It's just an outline, missing dispc, hwmods,
compatible-properties etc, which are not so relevant here.

ocp {
	dss {
		dsi1 {
			taal {

			};
		};
	};
};

So there we have a Taal panel, connected to DSI1 output interface, which
is part of the OMAP display subsystem.

One thing to note here is that although there's only one panel under
dsi1 in this case, the current SW supports having multiple panels under
one output interface. And while the output can support only one active
panel at a time, we do have boards where two panels are connected to one
output, and there's some kind of HW switch used to select which panel is
enabled.

The first problem here is that I don't know how to manage the switch
part. With current SW we have had the switch handling in the board
files, in functions called when a display is enabled/disabled. I guess
one option is to have the switch related code in their own drivers,
totally apart from the dss code, perhaps offering a sysfs interface or
such. And then, if the switch happens to be in the wrong position, the
panel will fail in some way.

The second problem is about the DT properties. With multiple panels it's
not possible to do this:

dsi1 {
	dsi-ddr-clk = <250000000>;

	taal {
	};

	some-other-panel {
	};
};

because the panels could require different dsi clock rates. So we need
something like this:

dsi1 {
	taal {
		dsi-ddr-clk = <250000000>;
	};

	some-other-panel {
		dsi-ddr-clk = <350000000>;
	};
};

However, here the problem is that while ultimately we're interested in
the ddr-clk rate, calculation of the rate is non-trivial and may need
customizations at times. So instead of the clock rate we actually need
to define a bunch of dividers/multipliers.

But these dividers are OMAP specific things, and do not belong to Taal
driver. So this bring the question: is the general rule about DT node
properties such that only the driver handling the particular node should
read the properties in that node? So, in the example above, should the
dsi driver only read props in the dsi1 and dsi2 nodes, and never look at
props in the taal nodes?

So basically, can we do this:

dsi1 {
	taal {
		omap-specific-clk-divs = <1 2 3 4 5 6 7>;
	};

	some-other-panel {
		omap-specific-clk-divs = <7 6 5 4 3 2 1>;
	};
};

and the Taal driver would ignore those, but dsi driver would use them?
This looks like quite easy solution to this, but also doesn't feel
right. So my current idea is to have clk-div tables in the dsi node,
something like this:

dsi1 {
	omap-specific-clk-divs = <
		250 1 2 3 4 5 6 7 /* divs that produce 250MHz clk */
		350 7 6 5 4 3 2 1 /* divs that produce 350MHz clk */
	>;

	taal {
		dsi-ddr-clk = <250000000>;
	};

	some-other-panel {
		dsi-ddr-clk = <350000000>;
	};
};

Here the panel drivers would ask the DSI driver to configure DSI DDR clk
of 250/350MHz, and the DSI driver would then use the lookup table to
find the dividers. If the lookup fails, the DSI driver could fail or try
to calculate the dividers itself. Other platforms could handle the DDR
clk configuration however they see best.

---

Another thing related to DSI command mode panels is the DSI lane
configuration, and I can't make my mind if they belong to the panel
driver in some way or not.

So, again taking SDP board and Taal as an example, we have 6 pads on
OMAP which are used for communicating with Taal. The pads need to be
muxed to DSI mode like any other OMAP pads. Currently the pad muxing is
not touched by the driver, but I think it's doable in the DSI driver (as
long as the DSI driver knows the required pad config).

However, that's not enough.

DSI uses differential pairs for communication (a "lane" consists of two
wires), and we have always one clock lane, and a number of data lanes.
In Taal's case we have a clock lane and two data lanes, which means 6
pads/wires.

We need to configure which of the OMAPs pads is used for which function,
so, for example, pad x and x+1 are used for clock lane, and x is the
negative pair and x+1 is the positive pair. And this configuration has
to match the wiring going to the panel, so that clk+ from OMAP goes to
clk+ in the panel.

So it dts data we need something, perhaps, like below. Here we define
the pad numbers and polarities in an array, where the first cell-pair is
for clk, then data1, then data2 and so on (if there are more than two
data lanes).

lanes = <
	/* pad-pair number, polarity */
	1 0	/* DSI pad pair 1 is used for clk, pol +/-  */
	2 1	/* DSI pad pair 2 is used for data1, pol -/+ */
	0 0	/* DSI pad pair 0 is used for data2, pol +/- */
>;

Now, I don't quite know where this data should be. If it's in the
dsi-node, it doesn't work with multiple panels. But then, it's quite
OMAP specific thing. While other platforms probably need some kind of
pad configuration also, it may be something totally different. And so it
doesn't feel right in the taal-node either.

And a look-up table like in the clock case doesn't make much sense
either, as we don't have a key here, as we had in the clock case (the
dsi-ddr-clk).

So basically the only option I've come up with is to define the lane
configuration in the panel's data, and let the dsi driver peek there and
configure the HW. And this doesn't feel right.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/56ed0d5f/attachment-0001.sig>
