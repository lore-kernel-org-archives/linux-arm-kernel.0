From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 11 Aug 2014 21:15:14 +0200
Subject: [PATCH 3/4] ARM: dts: rockchip: add rk3288 dma controllers
In-Reply-To: <53E90D69.6000307@suse.de>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
 <1560376.L4H27Lgx9N@diego> <53E90D69.6000307@suse.de>
Message-ID: <1897828.6acYlvjf7S@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 11. August 2014, 19:37:29 schrieb Andreas F?rber:
> Am 11.08.2014 19:01, schrieb Heiko St?bner:
> > Also for an upcoming v2, I've also changed the structure a bit, as the
> > first dma-controller has both a secure and non-secure version of it.
> > 
> > So currently the rk3288.dtsi looks like [0]:
> > 	amba {
> > 	
> > 		compatible = "arm,amba-bus";
> > 		#address-cells = <1>;
> > 		#size-cells = <1>;
> > 		ranges;
> > 		
> > 		/* dma1 in secure state */
> > 		dma-controller at ffb20000 {
> > 		
> > 			compatible = "arm,pl330", "arm,primecell";
> > 			reg = <0xffb20000 0x4000>;
> > 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> > 			
> > 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> > 			
> > 			#dma-cells = <1>;
> > 			clocks = <&cru ACLK_DMAC1>;
> > 			clock-names = "apb_pclk";
> > 			status = "disabled";
> > 		
> > 		};
> > 		
> > 		/* dma1 in non-secure state */
> > 		dma-controller at ffb60000 {
> > 		
> > 			compatible = "arm,pl330", "arm,primecell";
> > 			reg = <0xffb60000 0x4000>;
> > 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> > 			
> > 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> > 			
> > 			#dma-cells = <1>;
> > 			clocks = <&cru ACLK_DMAC1>;
> > 			clock-names = "apb_pclk";
> > 			status = "disabled";
> > 		
> > 		};
> > 		
> > 		dmac2: dma-controller at ff250000 {
> > 		
> > 			compatible = "arm,pl330", "arm,primecell";
> > 			reg = <0xff250000 0x4000>;
> > 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> > 			
> > 				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> > 			
> > 			#dma-cells = <1>;
> > 			clocks = <&cru ACLK_DMAC2>;
> > 			clock-names = "apb_pclk";
> > 		
> > 		};
> > 	
> > 	};
> > 
> > and the board is responsible for enabling the correct variant [1], as most
> > 
> > likely the bootloader decides in which mode to start the dma controller:
> > 	amba {
> > 	
> > 		/* dma1 in secure state */
> > 		dmac1: dma-controller at ffb20000 {
> > 		
> > 			status = "okay";
> > 		
> > 		};
> > 	
> > 	};
> > 
> > This is based on some mailinglist discussion, I found at some point, about
> > this but for the life of me am not able to find anymore. So of course
> > feedback would appreciated there too.
> 
> I would suggest to give labels such as dmac1_s and dmac1_ns like you did
> for dmac2 in the former snippet, so that you can override the status in
> the latter without replicating the amba/dma-controller hierarchy.

I was hoping to just keep it to one handle, so that dma consumers would just 
work and not have to care which dma controller variant was available :-) .


> However, for the Zynq SoC we chose to just model the secure DMAC though
> [*]. I was told that either the bootloader or the user should change the
> DT when running in such a non-secure scenario.

ok, this sounds interesting too, as I haven't seen a board that used the dmac 
in question in non-secure mode, yet.

So I guess one way to handle it could be to declare the non-secure dma, but 
set it to a disabled state and use the secure one as default for everything:

		dmac_bus_s: dma-controller at ffb20000 {
			compatible = "arm,pl330", "arm,primecell";
			reg = <0xffb20000 0x4000>;
			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
			#dma-cells = <1>;
			clocks = <&cru ACLK_DMAC1>;
			clock-names = "apb_pclk";
		};

		dmac_bus_ns: dma-controller at ffb60000 {
			compatible = "arm,pl330", "arm,primecell";
			reg = <0xffb60000 0x4000>;
			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
			#dma-cells = <1>;
			clocks = <&cru ACLK_DMAC1>;
			clock-names = "apb_pclk";
			status = "disabled";
		};

and a board wanting to use the non-secure variant would then be required to 
override the status and the dma channels in question (this dmac does mainly 
i2s and spdif):

&dmac_bus_s {
	status = "disabled";
}:

&dmac_bus_ns {
	status = "okay";
};

&i2s0 {
	dmas = <&dmac_bus_ns 6>, <&dmac_bus_ns 7>;
};


> [*] https://patchwork.kernel.org/patch/4620251/
> 
> > [0]
> > https://github.com/mmind/linux-rockchip/blob/devel/workbench/arch/arm/boo
> > t/dts/rk3288.dtsi [1]
> > https://github.com/mmind/linux-rockchip/blob/devel/workbench/arch/arm/boo
> > t/dts/rk3288-evb.dtsi
> [snip]
