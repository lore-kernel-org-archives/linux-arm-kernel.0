From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Nov 2015 13:52:54 +0000
Subject: Preprocessor arithmetic in dtsi files (base + offset)
In-Reply-To: <56570620.3070106@free.fr>
References: <56570620.3070106@free.fr>
Message-ID: <20151126135254.GD32343@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 02:16:16PM +0100, Mason wrote:
> Hello,
> 
> In the device tree for my ARM platform, I have several nodes with
> addresses within the SCU block:
> 
> 	scu: scu at 20000000 {
> 		compatible = "arm,cortex-a9-scu";
> 		reg = <0x20000000 0x100>;
> 
> 	gic: interrupt-controller at 20001000 {
> 		compatible = "arm,cortex-a9-gic";
> 		reg = <0x20001000 0x1000>, <0x20000100 0x0100>;
> 
> 	twd-timer at 20000600 {
> 		compatible = "arm,cortex-a9-twd-timer";
> 		reg = <0x20000600 0x10>;
> 
> Can I use preprocessor arithmetic to abstract the base address,
> as would be done in C?
> 
> #define SCU_BASE 0x20000000
> 
> 	scu: scu at XXX {
> 		compatible = "arm,cortex-a9-scu";
> 		reg = <SCU_BASE 0x100>;
> 	
> 	gic: interrupt-controller at XXX {
> 		compatible = "arm,cortex-a9-gic";
> 		reg = <SCU_BASE+0x1000 0x1000>, <SCU_BASE+0x100 0x0100>;

The pre-processor would only do substitution, not arithmetic. So the '+'
would flow all the way to DTC.

DTC does have some basic integer expression support (see [1]), but it
looks like it can only work at the cell level, so generally it needs to
be avoided (in case #address-cells >1, for example).

So generally I think that such arithmetic should be avoided.

> 	twd-timer at XXX {
> 		compatible = "arm,cortex-a9-twd-timer";
> 		reg = <SCU_BASE+0x600 0x10>;
> 
> Are the @XXX important? Can they be removed altogether?

The bit after the @ is called the unit-address.

It's meant to be there (matching the base address of the first reg
entry) to disambiguate nodes and make it simple to figure out where a
node lives in the physical address space.

They should stay.

Thanks,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/jdl/dtc.git/commit/?id=5f0c3b2d6235dec65fff1628a97f45e21680b36d
