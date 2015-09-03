From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 3 Sep 2015 15:12:11 +0100
Subject: [PATCH 5/7] ARM: STi: DT: STiH407: Add FDMA driver and xbar
 driver dt nodes.
In-Reply-To: <20150826074620.GV19409@x1>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
 <1436371888-27863-6-git-send-email-peter.griffin@linaro.org>
 <20150826074620.GV19409@x1>
Message-ID: <20150903141211.GA5120@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, 26 Aug 2015, Lee Jones wrote:

> On Wed, 08 Jul 2015, Peter Griffin wrote:
> 
> > These nodes are required to get the fdma and xbar driver working
> > on STiH407 based silicon.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 59 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index 838b812..b6d9e20 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -565,5 +565,64 @@
> >  						  <&phy_port2 PHY_TYPE_USB3>;
> >  			};
> >  		};
> > +
> > +		xbar0: fdma-xbar-mpe at 0 {
> 
> The unit address should match the one in the reg property.

Will fix in v2.

> 
> > +			compatible = "st,fdma-xbar-1.0";
> 
> Is that a version number in the compatible string?

Yes it is the version number of the IP.

> 
> > +			reg = <0x8e80000 0x1000>;
> > +			dma-requests = <79>;
> > +			#st,fdma-xbar-cells = <1>;
> 
> Why can't FDMA use the generic DMA properties?

Well the FDMA controller does, but this is a seperate piece of hw
which is really a router rather than a controller.

However I plan on temporarily removing xbar from this series,
as I think it should be re-worked to use the of_dma_router_register
and friends provided by the TI xbar driver.

It looks like the two xbar hw are serving a very similar purpose,
so once that re-work is done it can also use generic DMA propoerties
as I believe using that framework it will get registered as a controller.
> 
> > +		};
> > +
> > +		fdma0: fdma-audio at 0 {
> 
> Same comment as above.

Will fix in v2.

> 
> > +			compatible = "st,fdma_mpe31";
> 
> DT doesn't usually like underscores.

Obviously I can trivially change it, but out of interest is there
a technical reason for doing so? Clearly it works OK with
an underscore and a quick grep reveals a lot of ste, and some tegra
and vexpress compatibles using underscore as well.

> 
> > +			reg = <0x8e20000 0x20000>;
> > +			interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>;
> > +			dma-channels = <16>;
> > +			#dma-cells = <3>;
> > +			st,fw-name = "fdma_STiH407_0.elf";
> 
> I've bought this up before somewhere (although there doesn't appear to
> be a Firmware Maintainer), surely we should define a generic binding
> for passing firmware names?  Many vendors are going to require it.

A generic binding would certainly be useful.

>From what I can see TI are using: -

    ti,pm-firmware in wkup_m3_rproc.c

and Freescale are using: -

fsl,sdma-ram-script-name in imx-sdma.c

So other platforms are putting it in device tree, there are probably other
examples.

Most other STi drivers keep the firmware name in the C code, which is
usually my first preference. However with fdma it is more comlicated
as there is a seperate firmware file for each instance of the IP block.

I will see if there is a way to remove this from DT and keep it in
the driver.

> 
> > +			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
> > +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
> > +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
> > +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> > +			clock-names = "fdma_slim",
> > +				      "fdma_hi",
> > +				      "fdma_low",
> > +				      "fdma_ic";
> > +		};
> > +
> > +		fdma1: fdma-app at 1 {
> 
> As above.

Will fix
> 
> > +			compatible = "st,fdma_mpe31";
> 
> As above.

Will fix
> 
> > +			reg = <0x8e40000 0x20000>;
> > +			interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>;
> > +			dma-channels = <16>;
> > +			#dma-cells = <3>;
> > +			st,fdma-xbar = <&xbar0 0>;
> > +			st,fw-name = "fdma_STiH407_1.elf";
> > +			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
> > +				 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
> > +				 <&clk_s_c0_flexgen CLK_TX_ICN_DMU>,
> > +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> > +			clock-names = "fdma_slim",
> > +				      "fdma_hi",
> > +				      "fdma_low",
> > +				      "fdma_ic";
> > +		};
> > +
> > +		fdma2: fdma-free_running at 2 {
> > +			compatible = "st,fdma_mpe31";
> > +			reg = <0x8e60000 0x20000>;
> > +			interrupts = <GIC_SPI 9 IRQ_TYPE_NONE>;
> > +			dma-channels = <16>;
> > +			#dma-cells = <3>;
> > +			st,fw-name = "fdma_STiH407_2.elf";
> > +			clocks = <&clk_s_c0_flexgen CLK_FDMA>,
> > +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
> > +				 <&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
> > +				 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> > +			clock-names = "fdma_slim",
> > +				      "fdma_hi",
> > +				      "fdma_low",
> > +				      "fdma_ic";
> > +		};
> >  	};
> >  };
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

regards,

Peter.
