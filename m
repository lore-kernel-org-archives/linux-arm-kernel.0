From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Apr 2014 13:16:31 +0200
Subject: [GIT PULL v3] Xilinx Zynq changes for v3.15
In-Reply-To: <535A2F93.3010304@monstr.eu>
References: <53061EBA.1080002@monstr.eu> <201404251100.51068.arnd@arndb.de>
 <535A2F93.3010304@monstr.eu>
Message-ID: <5729174.EqI67ku3fz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 April 2014 11:49:07 Michal Simek wrote:
> On 04/25/2014 11:00 AM, Arnd Bergmann wrote:
> > On Thursday 27 March 2014, Michal Simek wrote:
> 
> > What I was mostly thinking of is board-level devices that are
> > not part of the soc address hierarchy, such as external clocks
> > or leds that just use GPIO lines.
> 
> Then let's discuss this based on our zynq dtsi.
> GIC, PL310, (OCM controller - we will discuss this later), UARTS, CADENCE GEM,
> ARASAN MMC, A9 global timer, TTC timer, SCUTIMER
> - all of these are just the part of the soc address hierarchy and shouldn't
> be any problem with them to be under soc0 - all of them are in silicon.

Yes, sounds good.

> DEVCFG - it is the part of first group - it is hard IP which can program
> programmable logic. Address is FIXED just wanted to list it separately.
> 
> I2C - I have just sent pull request for adding it there.
> i2c childs/devices are added to the i2c node based on binding that's why
> this should be fine.
> 
> PMU - Currently I have it in root but maybe better location should be used.
> 
> SLCR - which is our system controller where everything is together.

I think these should also all be considered part of the SoC.

> There is just ps-clk-frequency which is user setup and come externally.
> The part of this is clock driver which is probably that problematic one
> but on the other hand it is targetting exact register addresses which
> are used by this driver to describe internal clk description.

If you just have a 'ps-clk-frequency' property, that should still keep
the node inside of the SoC. If this had been modeled as a fixed-rate
clock node as the clock parent of the xlnx,ps7-clkc node, that one
should have been outside.

I don't think it's worth changing it now, just something to keep in
mind.

> I have looked at ux500 platform which has also SOC_BUS and
> based your thinking for example cpufreq-cooling, regulator-gpio shouldn't
> be there and probably more than this. Regarding clock description there
> is even not register range specified that's why it should be easily moved
> out of soc bus.

Good point.

> If you have any example how this should be done, please send it to me.
> I would like to have this in good shape.

>From all I can tell, all the nodes you have today actually make sense being
part of the soc device hierarchy. The only problem is that there is no
way to add nodes outside of it if that becomes necessary.

Generally speaking, the hierarchy should reflect the actual hardware layout,
which usually has multiple levels of nested buses, starting with an AXI
bus that contains the high-speed devices along with bridges to lower-speed
buses. You probably have access to documentation that describes the
real layout, so try to match that to the degree that you can, and move the
pmu into whatever bus you need.

Then change the code to match the top-level bus node with the soc0 device.

	Arnd
