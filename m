From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 09:35:13 -0500
Subject: [RFC/PATCH] usb: misc: Add a driver for TC7USB40MU
In-Reply-To: <147384330268.13546.17843140335600627152@sboyd-linaro>
References: <20160914014246.31847-1-stephen.boyd@linaro.org>
 <147384330268.13546.17843140335600627152@sboyd-linaro>
Message-ID: <20160923143513.GA29714@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 01:55:02AM -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2016-09-13 18:42:46)
> > On the db410c 96boards platform we have a TC7USB40MU[1] on the
> > board to mux the D+/D- lines from the SoC between a micro usb
> > "device" port and a USB hub for "host" roles. Upon a role switch,
> > we need to change this mux to forward the D+/D- lines to either
> > the port or the hub. Therefore, introduce a driver for this
> > device that intercepts extcon USB_HOST events and logically
> > asserts a gpio to mux the "host" D+/D- lines when a host cable is
> > attached. When the cable goes away, it will logically deassert
> > the gpio and mux the "device" lines.
> > 
> > [1] https://toshiba.semicon-storage.com/ap-en/product/logic/bus-switch/detail.TC7USB40MU.html
> > 
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Cc: <devicetree@vger.kernel.org>
> > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> > ---
> > 
> > Should I make the extcon part optional? I could see a case where there are two
> > "OTG" ports connected to the mux (or two hubs), and for some reason the
> > software may want to mux between them at runtime. If we mandate an extcon,
> > that won't be possible to support. Perhaps it would be better to have
> > the node, but connect it to the usb controller with a phandle (maybe of_graph
> > endpoints would be useful too) so that when the controller wants to mux over
> > a port it can do so.

I've mentioned my opinion on extcon before. The first clue that it needs 
work is a Linux subsystem name is used for the binding. 

> Here's some dts mock-up on top of the db410c for the of_graph stuff. I
> haven't written any code around it, but the idea is to allow the binding
> to specify how the mux is connected to upstream and downstream D+/D-
> lines. This way, we can do some dt parsing of the endpoints and their
> parent nodes to figure out if the mux needs to be set high or low to use
> a device connector or a usb hub based on if the id cable is present.
> Maybe I'm over thinking things though and we could just have a DT
> property for that.

I think the connector nodes are on the right track, but of-graph doesn't 
work here because we already have a way to describe USB buses in DT. 
Following that, would something like this work for you? The vbus-supply 
and id-gpios are just examples and may not always be there like if the 
hub controls each port's vbus directly.

usb-controller at 1234 {
	usb-switch at 0 {
		compatible = "toshiba,tc7usb40mu";
		hub at 0 {
			compatible = "some-hub";
			port at 0 {
				compatible = "usb-A-connector"
				vbus-supply = ...;
			};
			port at 1 {
				compatible = "usb-A-connector"
				vbus-supply = ...;
			};

		};
		connector at 1 {
			compatible = "usb-ub-connector";
			vbus-supply = ...;
			id-gpios = <>;
		};
	};
};

Rob
