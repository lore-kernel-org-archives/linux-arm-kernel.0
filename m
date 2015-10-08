From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 8 Oct 2015 19:13:02 +0800
Subject: [PATCH 4/5] dt-bindings: add binding for marvell berlin4ct SoC
In-Reply-To: <20151001225027.GT19319@codeaurora.org>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
 <1442931156-5877-5-git-send-email-jszhang@marvell.com>
 <20151001225027.GT19319@codeaurora.org>
Message-ID: <20151008191302.6d6d636b@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, 1 Oct 2015 15:50:27 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 09/22, Jisheng Zhang wrote:
> > +This binding uses the common clock binding[1].
> > +
> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +The berlin4ct clock subsystem generates and supplies clock to various
> > +controllers within the berlin4ct SoC. The berlin4ct contains 3 clock controller
> > +blocks: pll, gateclk, berlin-clk.
> > +
> > +Required Properties:
> > +
> > +- compatible: should be one of the following.
> > +  - "marvell,berlin-pll" - pll compatible
> > +  - "marvell,berlin4ct-clk" - berlin clk compatible
> > +  - "marvell,berlin4ct-gateclk" - gateclk compatible
> > +- reg: physical base address of the clock controller and length of memory mapped
> > +  region. For pll, the second reg defines the bypass register base address and
> > +  length of memory mapped region.
> > +- #clock-cells: for pll should 0, for gateclk and berlin clk should be 1.
> > +- #bypass-shift: the bypass bit in bypass register.
> > +
> > +Example:
> > +
> > +syspll: syspll {
> > +	compatible = "marvell,berlin-pll";
> > +	reg = <0xea0200 0x14>, <0xea0710 4>;
> > +	#clock-cells = <0>;
> > +	clocks = <&osc>;
> > +	bypass-shift = /bits/ 8 <0>;
> > +};
> > +
> > +clk: clk {
> > +	compatible = "marvell,berlin4ct-clk";
> > +	reg = <0xea0720 0x144>;
> > +	#clock-cells = <1>;
> > +	clocks = <&syspll>;
> > +};
> 
> Is there one clock controller at 0xea0000 of size 0x1000? We've

there's no clock controller at 0xea0000 with so big size. In BG4CT, we have
the following different kind of plls/clks

1. cpupll/syspll/mempll: the same IP, the pll register is put with the user
together, plus one shared bypass control register. For example: mempll register
is put with DDR controller registers together. cpupll, syspll and mempll share
the same bypass register: 0xea0710. 

2. gateclks: the clk can only be enabled or disabled, the control bits are put
into one(or two) register(s)

3. clks: can be disabled/enabled, change the divider, etc.. all these clks
registers are put together. In this register space, some space may not be used.


[PATCH 5/5] shows the layout of the clk/pll registers

> been trying to push people towards using the device model and
> writing drivers with probe instead of using CLK_OF_DECLARE() for

Is there any existing clk drivers switched to this type. I'll grep and
take that for an example.

> their platform clocks. From the looks of this binding, we're
> splitting up the different types of clocks into their own nodes
> and then registering them with CLK_OF_DECLARE.

Could you please kindly give advice about how to avoid the splitting?

Thanks a lot for review,
Jisheng
