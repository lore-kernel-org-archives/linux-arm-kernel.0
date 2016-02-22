From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 22 Feb 2016 09:14:23 +0100
Subject: [PATCH 2/3] clk: mvebu: add AP806 core clock driver
In-Reply-To: <20160222025357.GE15973@rob-hp-laptop>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455521698-7905-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222025357.GE15973@rob-hp-laptop>
Message-ID: <20160222091423.4756a579@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Sun, 21 Feb 2016 20:53:57 -0600, Rob Herring wrote:

> > +The Marvell MVEBU Armada 7K/8K SoCs contain a block called AP806,
> > +hosting the CPU and other core components of the CPU. This Device Tree
> > +binding allows to describe the core clocks of the AP806, whose
> > +frequencies are determined by reading the Sample-At-Reset (SAR)
> > +register.
> 
> What else is in the AP806?

Lots of things: CPU core, caches, GIC, XOR engines, UART, I2C
controller, etc.

> > +Clock consumers must specify the desired clock by having the clock ID
> > +in its "clocks" phandle cell.
> > +
> > +The following is a list of provided IDs and clock names for the core
> > +Armada AP806 clocks:
> > +
> > + 0 = DDR
> > + 1 = Ring
> > + 2 = CPU
> > +
> > +Required properties:
> > +- compatible: must be be one of the following:
> > +	"marvell,armada-ap806-core-clock"
> 
> I'd expect this to be a sub-node of a syscon block or just a single 
> clock provider for the full block. Hard to tell reviewing this without 
> context of what the full clock tree looks like. 

I indeed wondered about adding a syscon block. However, I don't have at
this point a full datasheet for the AP806, so it is hard to get a good
view of what the register set looks like to create a proper syscon. And
I don't have better informations about the full clock tree.

Such information will come later, and we can rework the drivers and DT
bindings accordingly. Those DT bindings cannot be stable, as the
platform is under heavy development and we'll probably discover some
issues down the road.

Right now, the only information I have about the AP806 clock tree are
about those core clocks and ring clocks.

> > +- reg: must be the register address of the Sample-At-Reset (SAR) register
> > +- #clock-cells: from common clock binding; shall be set to 1
> > +- clock-output-names: name of the output clocks
> > +
> > +Example:
> > +
> > +	coreclk: clk at 0x6F8204 {
> 
> Drop 0x and lowercase hex.
> 
> > +		compatible = "marvell,armada-ap806-core-clock";
> > +		reg = <0x6F8204 0x04>;
> 
> lowercase hex.

Sure, will fix.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
