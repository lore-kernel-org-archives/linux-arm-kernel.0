From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Mon, 11 Aug 2014 19:37:29 +0100
Subject: [PATCH 3/4] ARM: dts: rockchip: add rk3288 dma controllers
In-Reply-To: <1560376.L4H27Lgx9N@diego>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
 <1406661128-7614-4-git-send-email-heiko@sntech.de>
 <CAD=FV=VWBh3STfZWLDuYerS9wiceQL=UEJyjqp0-GLh0=-hTdw@mail.gmail.com>
 <1560376.L4H27Lgx9N@diego>
Message-ID: <53E90D69.6000307@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.08.2014 19:01, schrieb Heiko St?bner:
> Also for an upcoming v2, I've also changed the structure a bit, as the first 
> dma-controller has both a secure and non-secure version of it.
> So currently the rk3288.dtsi looks like [0]:
> 
> 	amba {
> 		compatible = "arm,amba-bus";
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges;
> 
> 		/* dma1 in secure state */
> 		dma-controller at ffb20000 {
> 			compatible = "arm,pl330", "arm,primecell";
> 			reg = <0xffb20000 0x4000>;
> 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> 			#dma-cells = <1>;
> 			clocks = <&cru ACLK_DMAC1>;
> 			clock-names = "apb_pclk";
> 			status = "disabled";
> 		};
> 
> 		/* dma1 in non-secure state */
> 		dma-controller at ffb60000 {
> 			compatible = "arm,pl330", "arm,primecell";
> 			reg = <0xffb60000 0x4000>;
> 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> 			#dma-cells = <1>;
> 			clocks = <&cru ACLK_DMAC1>;
> 			clock-names = "apb_pclk";
> 			status = "disabled";
> 		};
> 
> 		dmac2: dma-controller at ff250000 {
> 			compatible = "arm,pl330", "arm,primecell";
> 			reg = <0xff250000 0x4000>;
> 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> 				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> 			#dma-cells = <1>;
> 			clocks = <&cru ACLK_DMAC2>;
> 			clock-names = "apb_pclk";
> 		};
> 	};
> 
> and the board is responsible for enabling the correct variant [1], as most 
> likely the bootloader decides in which mode to start the dma controller:
> 
> 	amba {
> 		/* dma1 in secure state */
> 		dmac1: dma-controller at ffb20000 {
> 			status = "okay";
> 		};
> 	};
> 
> This is based on some mailinglist discussion, I found at some point, about 
> this but for the life of me am not able to find anymore. So of course feedback 
> would appreciated there too.

I would suggest to give labels such as dmac1_s and dmac1_ns like you did
for dmac2 in the former snippet, so that you can override the status in
the latter without replicating the amba/dma-controller hierarchy.

However, for the Zynq SoC we chose to just model the secure DMAC though
[*]. I was told that either the bootloader or the user should change the
DT when running in such a non-secure scenario.

Cheers,
Andreas

[*] https://patchwork.kernel.org/patch/4620251/

> [0] https://github.com/mmind/linux-rockchip/blob/devel/workbench/arch/arm/boot/dts/rk3288.dtsi
> [1] https://github.com/mmind/linux-rockchip/blob/devel/workbench/arch/arm/boot/dts/rk3288-evb.dtsi
[snip]

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
