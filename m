From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 24 Nov 2015 10:35:04 +0800
Subject: [PATCH v2 6/6] arm64: dts: berlin4ct: add pll and clock nodes
In-Reply-To: <20151123165444.740b457c@xhacker>
References: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
 <1448008952-1787-7-git-send-email-jszhang@marvell.com>
 <564F8B73.7070403@gmail.com>	<20151123152158.483aa6b5@xhacker>
 <5652CEB2.9030902@gmail.com>	<20151123165444.740b457c@xhacker>
Message-ID: <20151124103504.0a07b258@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Mon, 23 Nov 2015 16:54:44 +0800
Jisheng Zhang wrote:

> On Mon, 23 Nov 2015 09:30:42 +0100
> Sebastian Hesselbarth wrote:
> 
> > On 23.11.2015 08:21, Jisheng Zhang wrote:  
> > > On Fri, 20 Nov 2015 22:06:59 +0100
> > > Sebastian Hesselbarth wrote:    
> > >> On 20.11.2015 09:42, Jisheng Zhang wrote:    
> > >>> Add syspll, mempll, cpupll, gateclk and berlin-clk nodes.
> > >>>
> > >>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > >>> ---    
> > [...]  
> > >>> +		syspll: syspll {
> > >>> +			compatible = "marvell,berlin-pll";
> > >>> +			reg = <0xea0200 0x14>, <0xea0710 4>;
> > >>> +			#clock-cells = <0>;
> > >>> +			clocks = <&osc>;
> > >>> +			bypass-shift = /bits/ 8 <0>;
> > >>> +		};
> > >>> +
> > >>> +		gateclk: gateclk {
> > >>> +			compatible = "marvell,berlin4ct-gateclk";
> > >>> +			reg = <0xea0700 4>;
> > >>> +			#clock-cells = <1>;
> > >>> +		};
> > >>> +
> > >>> +		clk: clk {
> > >>> +			compatible = "marvell,berlin4ct-clk";
> > >>> +			reg = <0xea0720 0x144>;    
> > >>
> > >> Looking at the reg ranges, I'd say that they are all clock related
> > >> and pretty close to each other:
> > >>
> > >> gateclk: reg = <0xea0700 4>;
> > >> bypass:  reg = <0xea0710 4>;
> > >> clk:     reg = <0xea0720 0x144>;    
> > >
> > > Although these ranges sit close, but we should represent HW structure as you
> > > said.    
> > 
> > Then how do you argue that you have to share the gate clock register
> > with every PLL? The answer is quite simple: You are not separating by
> > HW either but existing SW API.  
> 
> No, PLLs don't share register any more. You can find what all clock nodes will
> look like in:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/387322.html
> 
> > 
> > If you would really want to just describe the HW, then you'd have to
> > have a single node for _all_ clocks that get controlled by 0xea0700/0x4,
> > feed some 32+ clocks into the node, and out again. Obviously, this
> > isn't what we want, right?  
> 
> I represented the HW by "kind", for example, gateclks, common-clks, pllclk.
> And let common PLLs follow this rule as well:
> 
> one node for all common plls
> 
> reg <0x922000 0x14>, <0x940034 0x14>, <0xea0200 0x14>
> 
> > 
> > So, the idea of berlin2 sysctrl nodes (and similar other SoCs) is: Some
> > SoCs just dump some functions into a bunch of registers with no
> > particular order. We'd never find a good representation for that in DT,
> > so we don't bother to try but let the driver implementation deal with
> > the mess. Using "simple-mfd" is a nice solution to scattered registers
> > please have a look at it and come up with a cleaner separation for bg4
> > clock.
> >   
> > > First of all, let me describe the clks/plls in BG4CT. BG4CT contains:
> > >
> > > two kinds of PLL: normal PLL and AVPLL. These PLLs are put with their users
> > > together. For example: mempll pll registers <0xf7940034, 0x14> is put together
> > > with mem controller registers. AVPLL control registers are put with AV devices.    
> > 
> > Why didn't you choose to have a memory-controller node that provides
> > mempll clock then? I am open to having multiple nodes providing clocks
> > but having a node for every clock in any subsystem is something I'll
> > not even think about.  
> 
> OK. As you said, "SoCs just dump some functions into a bunch of registers with
> no particular order", BG4CT is now cleaner, all common-clks are put together,
> gate-clks are put together, pllclks are put together, only the common PLLs
> are dumped here and there. So how about representing the HW by "kind", one
> node for common plls, one node for gateclks, one node for common clks and 
> one node for pllclks?
> 
>                 pll: pll {
>                         compatible = "marvell,berlin4ct-pll";
>                         reg = <0x922000 0x14>, <0x940034 0x14>, <0xea0200 0x14>
>                         #clock-cells = <0>;

should be "#clock-cells = <1>;"

>                         clocks = <&osc>;
>                 };
> 
> 		pllclk: pllclk {
>                         compatible = "marvell,berlin4ct-pllclk";
>                         reg = <0xea0710 4>
>                         #clock-cells = <1>;
> 		};
> 
>                 gateclk: gateclk {
>                         compatible = "marvell,berlin4ct-gateclk";
>                         reg = <0xea0700 4>;
>                         #clock-cells = <1>;
>                 };
> 
>                 clk: clk {
>                         compatible = "marvell,berlin4ct-clk";
>                         reg = <0xea0720 0x144>;
>                         #clock-cells = <1>;
>                         clocks = <&pllclk SYSPLLCLK>;
>                 };
> 

there's no a node for every clock with this proposal, all clks/plls are separated
by "kind". Is this OK for you?

thanks
