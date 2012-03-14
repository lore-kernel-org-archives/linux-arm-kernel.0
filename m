From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 14 Mar 2012 14:06:34 +0200
Subject: OMAP DSS device tree design problems
In-Reply-To: <4F5FCE64.5070902@ti.com>
References: <1331559930.2097.100.camel@deskari>  <4F5FCE64.5070902@ti.com>
Message-ID: <1331726794.2386.66.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-03-13 at 23:47 +0100, Cousson, Benoit wrote:

> I'm just wondering if the multiple panels is something supported by the 
> DSI protocol or it is a HW hacks done on TI board only?

In theory both, but the driver doesn't support multiple panels connected
to single DSI output at the same time. And that is, in a way, easier
regarding DT, as all the configuration parameters are specific to DSI
and the panel.

But the case at hand is that two panels are connected to single DSI
output, but there's an external switch/mux between the DSI output or
GPIO lines and the panels. It's not a HW hack on TI development boards
only. The means to switch between the two displays can be anything, from
setting a single GPIO to, say, sending i2c commands to some mux chip.

> > However, here the problem is that while ultimately we're interested in
> > the ddr-clk rate, calculation of the rate is non-trivial and may need
> > customizations at times. So instead of the clock rate we actually need
> > to define a bunch of dividers/multipliers.
> 
> Well, in theory you should not. This is up to the clock provider to 
> convert the clock rate in the proper n/m value. This is how it is done 
> for the regular OMAP DPLLs.

Right. But it's a non trivial problem. There are multiple
dividers/multipliers in the path, and the clocks from different points
at that path are used for different purposes. Some of the div/mul fields
are quite wide, so there are a lot of numbers to iterate. 

And in many cases it's important to get sometimes exact, and sometimes
almost exact, clock rate, but still at times go with a less exact clock
rate if that gives you lower power consumption, or some other similar
side effect.

So we currently calculate the dividers manually in most cases.

> > and the Taal driver would ignore those, but dsi driver would use them?
> > This looks like quite easy solution to this, but also doesn't feel
> > right. So my current idea is to have clk-div tables in the dsi node,
> > something like this:
> >
> > dsi1 {
> > 	omap-specific-clk-divs =<
> > 		250 1 2 3 4 5 6 7 /* divs that produce 250MHz clk */
> > 		350 7 6 5 4 3 2 1 /* divs that produce 350MHz clk */
> > 	>;
> 
> That's the idea, except that this will represent the clock provider.

Hmm... So. Should I have something like:

dsi1 {
	dsi1-pll: dsipll {
	 	clk-table = <
 			250 1 2 3 4 5 6 7 /* 250MHz clk */
 			350 7 6 5 4 3 2 1 /* 350MHz clk */
		>;
	};

	taal {
		dsi-clk-src = <&dsi1-pll>;
		dsi-clk-rate = <250000000>;
	};
}

But no, I don't think that's correct. The panel is not using the DSI
PLL. DSI protocol engine and DSI PHY are using the DSI PLL, and they
produce the output on the DSI bus, with the speed that the panel wants.

> > 	taal {
> > 		dsi-ddr-clk =<250000000>;
> 
> And here you will have a phandle to the clock provider. And use it to 
> set the proper clock rate.

I'm not sure if a "clock provider" is correct here. It's not really a
clock, in the strict sense, that goes to the panel from OMAP. It's the
speed of the DSI bus we are talking about here.

> > lanes =<
> > 	/* pad-pair number, polarity */
> > 	1 0	/* DSI pad pair 1 is used for clk, pol +/-  */
> > 	2 1	/* DSI pad pair 2 is used for data1, pol -/+ */
> > 	0 0	/* DSI pad pair 0 is used for data2, pol +/- */
> >> ;
> >
> > Now, I don't quite know where this data should be. If it's in the
> > dsi-node, it doesn't work with multiple panels.
> 
> Is the lane configuration only dependent of the panel?

If you mean, is the lane config the same on every board that uses the
panel, then no. The lane config tells which pin on OMAP is used for
which purpose in the DSI bus.

So if the DSI panel supports two datalanes, it means it has 6 DSI pins:
2 for clk +/-, 2 for data1, 2 for data2. The HW designed then connects,
say, the panel's CLK+ pin to one of OMAPs DSI pins. The OMAP pin has to
be configured in the system config level for DSI operation, and also we
need to configure the function of the pin to CLK+ in the DSI HW module.

> > But then, it's quite
> > OMAP specific thing. While other platforms probably need some kind of
> > pad configuration also, it may be something totally different. And so it
> > doesn't feel right in the taal-node either.
> >
> > And a look-up table like in the clock case doesn't make much sense
> > either, as we don't have a key here, as we had in the clock case (the
> > dsi-ddr-clk).
> 
> The lane configuration code will belong to the DSI driver. The data will 
> belong to the panel. The panel might use some phandle to the various DSI 
> lane config a provide the needed information.
> 
> This look pretty similar to the pinmux device tree binding that is 
> currently under discussion.
> 
> > So basically the only option I've come up with is to define the lane
> > configuration in the panel's data, and let the dsi driver peek there and
> > configure the HW. And this doesn't feel right.
> 
> This is fine, except for the last part. The panel driver should retrieve 
> the data from the panel node, and call some DSI configuration API using 
> the DSI phandle retrieved from the panel node as well or using the 
> parent node directly if the hierarchy is always the same.

Ok. Then the data format for the lane configuration needs to be generic
so that it fits to all platforms. The one I had is omap specific.

Hmm... Perhaps then something like this:

lanes = <
	2	/* clk + */
	3	/* clk - */
	4	/* data1 + */
	5	/* data1 - */
	0	/* data2 + */
	1	/* data2 - */
	>;

Here the number maps to a DSI pin on the particular DSI output used by
the panel. The DSI driver then needs to use some logic to decide what to
do to convert the pin number in the lane data to actual HW
configuration.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/90d018e7/attachment-0001.sig>
