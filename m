From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Feb 2014 11:23:24 +0000
Subject: [PATCH 1/2] clk: fixed-rate: use full DT node name
In-Reply-To: <52FE4798.3010605@wwwdotorg.org>
References: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
 <20140214103556.GC9907@e106331-lin.cambridge.arm.com>
 <52FE4798.3010605@wwwdotorg.org>
Message-ID: <20140218112323.GB6051@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 04:43:04PM +0000, Stephen Warren wrote:
> On 02/14/2014 03:35 AM, Mark Rutland wrote:
> > On Fri, Feb 14, 2014 at 06:16:52AM +0000, Stephen Warren wrote:
> >> clk-fixed-rate currently names clocks according to a node's name without
> >> the unit address. When faced with the legal and technically correct DT
> >> structure below, this causes rgistration attempts for 3 clocks with the
> >> same name, 2 of which fail.
> >>
> >> 	clocks {
> >> 		compatible = "simple-bus";
> >> 		#address-cells = <1>;
> >> 		#size-cells = <0>;
> >>
> >> 		clk_mmc: clock at 0 {
> >> 			compatible = "fixed-clock";
> >> 			reg = <0>;
> >> ...
> >> 		clk_i2c: clock at 1 {
> >> 			compatible = "fixed-clock";
> >> 			reg = <1>;
> >> ...
> >> 		clk_spi: clock at 2 {
> >> 			compatible = "fixed-clock";
> >> 			reg = <2>;
> >> ...
> > 
> > I'd argue that this case isn't valid.
> 
> Well, it's very widely used, and was the result of numerous discussions
> of how this kind of thing should be represented:-/

Maybe we have to live with it then. :/

> 
> > The fixed-clock binding doesn't define a reg, yet simple bus binding
> > implies that the reg property of child nodes should be interpretted as
> > the same address space as their parent (MMIO in this case?). The
> > fixed-clock nodes reg proeprties clearly aren't MMIO addresses.
> > 
> > Additionally, the _requred_ ranges property is missing.
> 
> Perhaps we need to invent a simple-container instead then?

As you mention in your other reply, it makes some sense to omit ranges
if the address space is disjoint. My concern is that the address space
is meaningless and arbitrary. If we had a real disjoint address space
we'd have another kind of bus node as the container.

> 
> > It's just nonsensical; rename them to clock_{0,1,..} instead and get rid
> > of the reg properties. Then they're named uniquely.
> 
> That's not legal either. DT node names are supposed to represent the
> type of device/object (i.e. just "clock"), not the identity of the
> device/object (i.e. not include IDs etc.). Hence, the node name needs to
> be "clock" for all of them, and the unit address must be used to
> differentiate them.

As far as I can see from ePAPR, the only requriement is:

  The node-name shall start with a lower or uppercase character and
  should describe the general class of device.

IMO clock_1 describes the general class of device as well as clock at 1,
while also not filling a unexpected property with a meaningless value.

Thanks,
Mark.
