From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 23 Nov 2015 16:14:29 +0800
Subject: [PATCH v2 6/6] arm64: dts: berlin4ct: add pll and clock nodes
In-Reply-To: <20151123152158.483aa6b5@xhacker>
References: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
 <1448008952-1787-7-git-send-email-jszhang@marvell.com>
 <564F8B73.7070403@gmail.com>	<20151123152158.483aa6b5@xhacker>
Message-ID: <20151123161429.2a3a9243@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

On Mon, 23 Nov 2015 15:21:58 +0800
Jisheng Zhang wrote:

> Dear Sebastian,
> 
> On Fri, 20 Nov 2015 22:06:59 +0100
> Sebastian Hesselbarth wrote:
> 
> > On 20.11.2015 09:42, Jisheng Zhang wrote:  
> > > Add syspll, mempll, cpupll, gateclk and berlin-clk nodes.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > ---
> > >  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 38 ++++++++++++++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > > index a4a1876..808a997 100644
> > > --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> > > @@ -42,6 +42,7 @@
> > >   *     OTHER DEALINGS IN THE SOFTWARE.
> > >   */
> > >  
> > > +#include <dt-bindings/clock/berlin4ct.h>
> > >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >  
> > >  / {
> > > @@ -135,6 +136,22 @@
> > >  			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> > >  		};
> > >  
> > > +		cpupll: cpupll {
> > > +			compatible = "marvell,berlin-pll";
> > > +			reg = <0x922000 0x14>, <0xea0710 4>;
> > > +			#clock-cells = <0>;
> > > +			clocks = <&osc>, <&clk CLK_CPUFASTREF>;
> > > +			bypass-shift = /bits/ 8 <2>;
> > > +		};
> > > +
> > > +		mempll: mempll {
> > > +			compatible = "marvell,berlin-pll";
> > > +			reg = <0x940034 0x14>, <0xea0710 4>;    
> > 
> > Whenever you see overlapping/repeating reg ranges, e.g. <0xea0710 4>
> > you can be sure you are not representing HW structure but driver
> > structure here.
> > 
> > Please merge clocks/gates/plls to a single clock complex node
> > and deal with the internals by using "simple-mfd" and "syscon" regmaps.
> >   
> > > +			#clock-cells = <0>;
> > > +			clocks = <&osc>, <&clk CLK_MEMFASTREF>;
> > > +			bypass-shift = /bits/ 8 <1>;
> > > +		};
> > > +
> > >  		apb at e80000 {
> > >  			compatible = "simple-bus";
> > >  			#address-cells = <1>;
> > > @@ -225,6 +242,27 @@
> > >  			};
> > >  		};
> > >  
> > > +		syspll: syspll {
> > > +			compatible = "marvell,berlin-pll";
> > > +			reg = <0xea0200 0x14>, <0xea0710 4>;
> > > +			#clock-cells = <0>;
> > > +			clocks = <&osc>;
> > > +			bypass-shift = /bits/ 8 <0>;
> > > +		};
> > > +
> > > +		gateclk: gateclk {
> > > +			compatible = "marvell,berlin4ct-gateclk";
> > > +			reg = <0xea0700 4>;
> > > +			#clock-cells = <1>;
> > > +		};
> > > +
> > > +		clk: clk {
> > > +			compatible = "marvell,berlin4ct-clk";
> > > +			reg = <0xea0720 0x144>;    
> > 
> > Looking at the reg ranges, I'd say that they are all clock related
> > and pretty close to each other:
> > 
> > gateclk: reg = <0xea0700 4>;
> > bypass:  reg = <0xea0710 4>;
> > clk:     reg = <0xea0720 0x144>;  
> 
> Although these ranges sit close, but we should represent HW structure as you
> said.
> 
> First of all, let me describe the clks/plls in BG4CT. BG4CT contains:
> 
> two kinds of PLL: normal PLL and AVPLL. These PLLs are put with their users
> together. For example: mempll pll registers <0xf7940034, 0x14> is put together
> with mem controller registers. AVPLL control registers are put with AV devices.
> You can also check mempll, cpupll and syspll ranges:
> 
> cpupll: <0x922000 0x14>
> 
> mempll: <0x940034 0x14>
> 
> syspll: <0xea0200 0x14>
> 
> 
> We have three normal PLLS: cpupll, mempll and syspll. All these three PLLs use
> 25MHZ osc as clocksource. These plls can be bypassed. when syspll is bypassed
> the 25MHZ osc is directly output to syspllclk. When mempll/cpupll is bypassed,
> its corresponding fastrefclk is directly output to ddrphyclk/cpuclk: 
> 
> 
>        ---25MHZ osc----------|\
>            ________            | |-- syspllclk
>        ---| SYSPLL |---------|/
> 
> 
> 
>        ---cpufastrefclk------|\
>            ________            | |-- cpuclk
>        ---| CPUPLL |---------|/
> 
> 
>        ---memfastrefclk------|\
>            ________            | |-- ddrphyclk
>        ---| MEMPLL |---------|/
> 
> NOTE: the fastrefclk is the so called normal clk below.
> 
> 
> 
> two kinds of clk: normal clk and gate clk. The normal clk supports changing
> divider, selecting clock source, disabling/enabling etc. The gate clk only
> supports disabling/enabling. normal clks use syspllclk as clocksource, while
> gate clks use perifsysclk as clocksource.
> 


I hope I have described the BG4CT HW clk/pll clearly, I really need your advice
about my proposal. The clk nodes in my proposal will finally look like:


                cpupll: cpupll {
                        compatible = "marvell,berlin-pll";
                        reg = <0x922000 0x14>
                        #clock-cells = <0>;
                        clocks = <&osc>;
                };

		mempll: mempll {
                        compatible = "marvell,berlin-pll";
                        reg = <0x940034 0x14>
                        #clock-cells = <0>;
                        clocks = <&osc>;
                };

                syspll: syspll {
                        compatible = "marvell,berlin-pll";
                        reg = <0xea0200 0x14>
                        #clock-cells = <0>;
                        clocks = <&osc>;
                };

		pllclk: pllclk {
                        compatible = "marvell,berlin4ct-pllclk";
                        reg = <0xea0710 4>
                        #clock-cells = <1>;
		};

                gateclk: gateclk {
                        compatible = "marvell,berlin4ct-gateclk";
                        reg = <0xea0700 4>;
                        #clock-cells = <1>;
                };

                clk: clk {
                        compatible = "marvell,berlin4ct-clk";
                        reg = <0xea0720 0x144>;
                        #clock-cells = <1>;
                        clocks = <&pllclk SYSPLLCLK>;
                };

Using the ccf clk-mux, there's no overlapping/repeating reg ranges any more.

If you want more BG4CT clk/pll details, please let me know.

Thanks,
Jisheng

> 
> So what's the representing HW structure in fact? Here is my proposal:
> 
> 1. have mempll, cpupll and syspll node in dts
> 
> 2. one gateclk node in dts for gateclks
> 
> 3. one normalclk node in dts for normal clks
> 
> 4. one ccf clock-mux for cpuclk, ddrphyclk and syspllclk.
> 
> what do you think?
> 
> 
> From another side, let's have a look at driver/clk/mvebu. As can be seen,
> different clks register are close each other, for example, gateclk and coreclk
> in arch/arm/boot/dts/armada-xp.dtsi.
> 
> And drivers/clk/sunxi, arch/arm/boot/dts/sun7i-a20.dtsi, the pll4, pll12, gt_clk
> and ahb*, apb* etc... 
> 
> why these SoCs don't merge clocks/gates/plls to a single clock complex node? 
> I think that's because they are representing real HW structure.
> 
> Thanks,
> Jisheng
> 
> 
> > 
> > So, please just follow the OF/driver structure we already
> > have for Berlin2.
> > 
> > Sebastian
> >   
> > > +			#clock-cells = <1>;
> > > +			clocks = <&syspll>;
> > > +		};
> > > +
> > >  		soc_pinctrl: pin-controller at ea8000 {
> > >  			compatible = "marvell,berlin4ct-soc-pinctrl";
> > >  			reg = <0xea8000 0x14>;
> > >     
> >   
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
