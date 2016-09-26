From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 26 Sep 2016 11:59:32 -0700
Subject: [RFC/PATCH] usb: misc: Add a driver for TC7USB40MU
In-Reply-To: <20160923143513.GA29714@rob-hp-laptop>
References: <20160914014246.31847-1-stephen.boyd@linaro.org>
 <147384330268.13546.17843140335600627152@sboyd-linaro>
 <20160923143513.GA29714@rob-hp-laptop>
Message-ID: <147491637201.5206.2359406340350020245@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2016-09-23 07:35:13)
> On Wed, Sep 14, 2016 at 01:55:02AM -0700, Stephen Boyd wrote:
> > Quoting Stephen Boyd (2016-09-13 18:42:46)
> > > On the db410c 96boards platform we have a TC7USB40MU[1] on the
> > > board to mux the D+/D- lines from the SoC between a micro usb
> > > "device" port and a USB hub for "host" roles. Upon a role switch,
> > > we need to change this mux to forward the D+/D- lines to either
> > > the port or the hub. Therefore, introduce a driver for this
> > > device that intercepts extcon USB_HOST events and logically
> > > asserts a gpio to mux the "host" D+/D- lines when a host cable is
> > > attached. When the cable goes away, it will logically deassert
> > > the gpio and mux the "device" lines.
> > > 
> > > [1] https://toshiba.semicon-storage.com/ap-en/product/logic/bus-switch/detail.TC7USB40MU.html
> > > 
> > > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > > Cc: <devicetree@vger.kernel.org>
> > > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> > > ---
> > > 
> > > Should I make the extcon part optional? I could see a case where there are two
> > > "OTG" ports connected to the mux (or two hubs), and for some reason the
> > > software may want to mux between them at runtime. If we mandate an extcon,
> > > that won't be possible to support. Perhaps it would be better to have
> > > the node, but connect it to the usb controller with a phandle (maybe of_graph
> > > endpoints would be useful too) so that when the controller wants to mux over
> > > a port it can do so.
> 
> I've mentioned my opinion on extcon before. The first clue that it needs 
> work is a Linux subsystem name is used for the binding. 
> 
> > Here's some dts mock-up on top of the db410c for the of_graph stuff. I
> > haven't written any code around it, but the idea is to allow the binding
> > to specify how the mux is connected to upstream and downstream D+/D-
> > lines. This way, we can do some dt parsing of the endpoints and their
> > parent nodes to figure out if the mux needs to be set high or low to use
> > a device connector or a usb hub based on if the id cable is present.
> > Maybe I'm over thinking things though and we could just have a DT
> > property for that.
> 
> I think the connector nodes are on the right track, but of-graph doesn't 
> work here because we already have a way to describe USB buses in DT. 
> Following that, would something like this work for you? The vbus-supply 
> and id-gpios are just examples and may not always be there like if the 
> hub controls each port's vbus directly.

My philosophical problem with this is that I don't view this usb-switch
as a usb device. It isn't addressable via the typical USB addressing
scheme. It's just a simple chip wired down on the board that muxes two
wires without considering what goes across those wires.

I would agree if this switch was a usb device itself that had a vid/pid
that we could talk to to switch the mux. But that isn't the case here.

> 
> usb-controller at 1234 {
>         usb-switch at 0 {
>                 compatible = "toshiba,tc7usb40mu";
>                 hub at 0 {
>                         compatible = "some-hub";
>                         port at 0 {
>                                 compatible = "usb-A-connector"
>                                 vbus-supply = ...;
>                         };
>                         port at 1 {
>                                 compatible = "usb-A-connector"
>                                 vbus-supply = ...;
>                         };
> 
>                 };
>                 connector at 1 {
>                         compatible = "usb-ub-connector";
>                         vbus-supply = ...;
>                         id-gpios = <>;
>                 };
>         };
> };
> 

What do we do about a hub downstream of the mux like usb3503? If that's
on the i2c bus and we need to do some initial setup, shouldn't we put
the hub under the i2c bus (because that's the addressing scheme) instead
of under the switch and then use of-graph to describe the connections
that aren't being used for addressing? My understanding of of-graph is
pretty weak so perhaps I missed something.
