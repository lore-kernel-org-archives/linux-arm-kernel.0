From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 14 May 2018 19:52:07 +0300
Subject: [PATCH 3/3] arm64: dts: renesas: draak: Describe HDMI input
In-Reply-To: <20180514094900.GF30519@bigcity.dyn.berto.se>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
 <26780153.JLo9OE30iv@avalon> <20180514094900.GF30519@bigcity.dyn.berto.se>
Message-ID: <3200357.ZFfGXgsVol@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Monday, 14 May 2018 12:49:00 EEST Niklas S?derlund wrote:
> On 2018-05-14 05:49:41 +0300, Laurent Pinchart wrote:
> 
> [snip]
> 
> >>> +&vin4 {
> >>> +	pinctrl-0 = <&vin4_pins>;
> >>> +	pinctrl-names = "default";
> >>> +
> >>> +	status = "okay";
> >>> +
> >>> +	ports {
> >>> +		#address-cells = <1>;
> >>> +		#size-cells = <0>;
> >>> +
> >>> +		port at 0 {
> >>> +			reg = <0>;
> >>> +			vin4_in: endpoint {
> >>> +				hsync-active = <0>;
> >>> +				vsync-active = <0>;
> >> 
> >> Comparing this to the Gen2 bindings some properties are missing,
> >> 
> >> bus-width = <24>;
> >> pclk-sample = <1>;
> >> data-active = <1>;
> >> 
> >> This is not a big deal as the VIN driver don't use these properties so
> >> no functional change should come of this but still a difference.
> > 
> > I think the VIN DT bindings should be updated to explicitly list the
> > endpoint properties that are mandatory, optional, or not allowed.
> 
> I think it's documented as it reference video-interfaces.txt which lists
> all these properties as optional. And in deed they are all optional.

I don't think that's good enough. They're all listed as optional in video-
interfaces.txt as the generic documentation can't know whether a particular 
device will require a particular property or not. It's the responsibility of 
device DT bindings to refine the bindings description. The VIN DT bindings 
should explicitly list the properties that apply to the VIN and tell whether 
they're optional or mandatory for the VIN. For optional properties, the 
default behaviour when the property is not specified should be documented too.

For instance, does VIN support selecting which pixel clock edge to sample data 
on ? If so the pclk-sample property should listed as either mandatory or 
optional with a documented default, even if not used by the driver today.

> If the VIN driver makes use of all the optional ones is another matter. How
> do we know that the remote subdevice is not looking at its remote
> endpoint for bus parameters not considered by the rcar-vin driver?

No driver should parse properties of remote nodes, as those properties are to 
be interpreted in the context of the remote node's DT bindings, which the 
driver doesn't know about. Parsing OF graph properties (ports and endpoints) 
is an exception, as by connecting a remote node to the local node with OF 
graph properties you imply that the remote node uses OF graph DT bindings, so 
those properties (and only those properties) can be parsed.

> The thing is that the rcar-vin driver only looks at the remote endpoint
> for these properties and ignores the on its local endpoint. Maybe some
> v4l2 framework change is needed here to make sure the bus properties are
> the same on both endpoints of a link. But I fear such a change would
> break a lot of stuff.

Properties are specified on both endpoints to account for components such as 
inverter gates between the two devices. They can thus be different on the two 
sides, that's perfectly valid. The VIN driver should parse its local 
properties, not the remote properties.

-- 
Regards,

Laurent Pinchart
