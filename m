From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 26 Sep 2016 11:44:50 -0700
Subject: [RFC/PATCH] usb: misc: Add a driver for TC7USB40MU
In-Reply-To: <20160926032927.GA25395@b29397-desktop>
References: <20160914014246.31847-1-stephen.boyd@linaro.org>
 <147384330268.13546.17843140335600627152@sboyd-linaro>
 <20160917011605.GB10392@b29397-desktop>
 <147457026249.9057.8712383708019243942@sboyd-linaro>
 <20160926032927.GA25395@b29397-desktop>
Message-ID: <147491549050.5206.9497559526723777799@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-09-25 20:29:27)
> On Thu, Sep 22, 2016 at 11:51:02AM -0700, Stephen Boyd wrote:
> > Quoting Peter Chen (2016-09-16 18:16:05)
> > > On Wed, Sep 14, 2016 at 01:55:02AM -0700, Stephen Boyd wrote:
> > > > Quoting Stephen Boyd (2016-09-13 18:42:46)
> > > > > On the db410c 96boards platform we have a TC7USB40MU[1] on the
> > > > > board to mux the D+/D- lines from the SoC between a micro usb
> > > > > "device" port and a USB hub for "host" roles. Upon a role switch,
> > > > > we need to change this mux to forward the D+/D- lines to either
> > > > > the port or the hub. Therefore, introduce a driver for this
> > > > > device that intercepts extcon USB_HOST events and logically
> > > > > asserts a gpio to mux the "host" D+/D- lines when a host cable is
> > > > > attached. When the cable goes away, it will logically deassert
> > > > > the gpio and mux the "device" lines.
> > > > > 
> > > > > [1] https://toshiba.semicon-storage.com/ap-en/product/logic/bus-switch/detail.TC7USB40MU.html
> > > > > 
> > > > > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > > > > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > > > > Cc: <devicetree@vger.kernel.org>
> > > > > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> > > > > ---
> > > > > 
> > > > > Should I make the extcon part optional? I could see a case where there are two
> > > > > "OTG" ports connected to the mux (or two hubs), and for some reason the
> > > > > software may want to mux between them at runtime. If we mandate an extcon,
> > > > > that won't be possible to support. Perhaps it would be better to have
> > > > > the node, but connect it to the usb controller with a phandle (maybe of_graph
> > > > > endpoints would be useful too) so that when the controller wants to mux over
> > > > > a port it can do so.
> > > > 
> > > > Here's some dts mock-up on top of the db410c for the of_graph stuff. I
> > > > haven't written any code around it, but the idea is to allow the binding
> > > > to specify how the mux is connected to upstream and downstream D+/D-
> > > > lines. This way, we can do some dt parsing of the endpoints and their
> > > > parent nodes to figure out if the mux needs to be set high or low to use
> > > > a device connector or a usb hub based on if the id cable is present.
> > > > Maybe I'm over thinking things though and we could just have a DT
> > > > property for that.
> > > > 
> > > >       soc {
> > > >               usb at 78d9000 {
> > > >                       extcon = <&usb_id>, <&usb_id>;
> > > 
> > > Why you have two same extcon phandler? From my mind, one should id,
> > > another should is vbus. Besides, I find extcon-usb-gpio.c is lack of
> > > vbus support, how you support vbus detection for
> > > connection/disconnection with PC for your chipidea msm patch set?
> > 
> > This was already in the dts files for db410c. In the chipidea binding
> > one is for EXTCON_USB (vbus) and one is for EXTCON_USB_HOST (id). My
> > understanding is that extcon-usb-gpio.c sends events for both EXTCON_USB
> > and EXTCON_USB_HOST when the gpio changes state. vbus detection is not
> > that great on this board because we only have on gpio for this.
> 
> I think extcon-usb-gpio.c needs to extend for supporting vbus event,
> otherwise, the micro-b cable's connect/disconnect will introduce
> EXTCON_USB_HOST event, if you use two <&usb_idx> for both id and
> vbus event.
> 

Sorry, I'm lost now. extcon-usb-gpio.c already supports EXTCON_USB as an
event. Is the problem that we're using two of the same phandles in the
binding?
