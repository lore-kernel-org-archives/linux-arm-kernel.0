From: panto@antoniou-consulting.com (Pantelis Antoniou)
Date: Wed, 6 Nov 2013 20:33:39 +0200
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20131106190308.01f7a4a9@skate>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com> <20131106190308.01f7a4a9@skate>
Message-ID: <334037D0-02FB-459F-9E40-129EC830AF65@antoniou-consulting.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Nov 6, 2013, at 8:03 PM, Thomas Petazzoni wrote:

> Dear Jason Gunthorpe,
> 

[snip]

> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

I don't know if that's really revevant, but this sounds very similar to the way that the GPMC driver 
works (badly) on OMAPs.

In the old days we used to rely on the bootloader setting up things like chip selects, address windows
and what nots, and the kernel being very careful not messing with them.

So the drivers needed nothing more to work than being pointed the address windows that their device
happened to be configured by the bootloader.

Now that with the trend in bootloaders being really minimal, that task falls to the kernel.
Using board files one can get away with it using some per-board specific initialization.

On DT this fall downs completely, and you get abominations like the OMAP GPMC bindings...

Observe:

>                         status = "okay";
> 
>                         #address-cells = <2>;
>                         #size-cells = <1>;
> 
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&gpmc_pins>;
> 
>                         /* chip select ranges */
>                         ranges = <0 0 0x08000000 0x10000000>,        /* bootloader has this enabled */
>                                  <1 0 0x18000000 0x08000000>,
>                                  <2 0 0x20000000 0x08000000>,
>                                  <3 0 0x28000000 0x08000000>,
>                                  <4 0 0x30000000 0x08000000>,
>                                  <5 0 0x38000000 0x04000000>,
>                                  <6 0 0x3c000000 0x04000000>;
> 
>                         /*
>                          * This is complete and utter cr*p
>                          * It doesn't belong here, but we don't
>                          * have a memory controller abstraction.
>                          * So we muddle along...
>                          */
>                         camera {
>                                 compatible = "cssp-camera";
>                                 status = "okay";
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&cssp_camera_pins>;
> 
>                                 reg = <1 0 0x01000000>;                /* CS1 */
> 
>                                 bank-width = <2>;                /* GPMC_CONFIG1_DEVICESIZE(1) */
> 
>                                 gpmc,burst-read;                /* GPMC_CONFIG1_READMULTIPLE_SUPP */
>                                 gpmc,sync-read;                        /* GPMC_CONFIG1_READTYPE_SYNC */
>                                 gpmc,sync-write;                /* GPMC_CONFIG1_WRITETYPE_SYNC */
>                                 gpmc,clk-activation-ns = <20>;        /* GPMC_CONFIG1_CLKACTIVATIONTIME(2) */
>                                 gpmc,burst-length = <16>;        /* GPMC_CONFIG1_PAGE_LEN(2) */
>                                 gpmc,mux-add-data = <2>;        /* GPMC_CONFIG1_MUXTYPE(2) */
> 
>                                 gpmc,sync-clk-ps = <20000>;        /* CONFIG2 */
> 
>                                 gpmc,cs-on-ns = <1>;
>                                 gpmc,cs-rd-off-ns = <160>;
>                                 gpmc,cs-wr-off-ns = <310>;
> 
>                                 gpmc,adv-on-ns = <0>;                /* CONFIG3 */
>                                 gpmc,adv-rd-off-ns = <40>;
>                                 gpmc,adv-wr-off-ns = <40>;
> 
>                                 gpmc,we-on-ns = <60>;                /* CONFIG4 */
>                                 gpmc,we-off-ns = <310>;
>                                 gpmc,oe-on-ns = <60>;
>                                 gpmc,oe-off-ns = <160>;
> 
>                                 gpmc,page-burst-access-ns = <20>;        /* CONFIG 5 */
>                                 gpmc,access-ns = <140>;
>                                 gpmc,rd-cycle-ns = <160>;
>                                 gpmc,wr-cycle-ns = <310>;
> 
>                                 gpmc,wr-access-ns = <100>;                /* CONFIG 6 */
>                                 gpmc,wr-data-mux-bus-ns = <60>;
> 
>                                 gpmc,bus-turnaround-ns = <40>;                /* CONFIG6:3:0 = 4 */
>                                 gpmc,cycle2cycle-samecsen;                /* CONFIG6:7 = 1 */
>                                 gpmc,cycle2cycle-delay-ns = <40>;        /* CONFIG6:11:8 = 4 */
> 
>                                 /* not using dma engine yet, but we can get the channel number here */
>                                 dmas = <&edma 20>;
>                                 dma-names = "cssp";
> 
>                                 /* clocks */
>                                 cssp,camera-clk-name = "adjustable_clkout2_ck";
>                                 cssp,camera-clk-rate = <32000000>;
> 
>                                 /* reset */
>                                 reset-gpio = <&gpio1 4 0>;
> 
>                                 /* orientation; -> MT9T112_FLAG_VFLIP */
>                                 orientation-gpio = <&gpio1 30 0>;
> 
>                                 /* reset controller (for the black) */
>                                 reset = <&rstctl 0 0>;
>                                 reset-names = "eMMC_RSTn-CAM3";
> 
>                                 /* camera sensor */
>                                 cssp,sensor {
>                                         i2c-adapter = <&i2c2>;
> 
>                                         /* need it to stop the whinning */
>                                         #address-cells = <1>;
>                                         #size-cells = <0>;
> 
>                                         /* fake i2c device node */
>                                         m59t112 {
>                                                 compatible = "aptina,mt9t112";
>                                                 reg = <0x3c>;
> 
>                                                 /* m, n, p1-7 */
>                                                 flags = <0>;
>                                                 pll-divider = <24 1 0 7 0 10 14 7 0>;
>                                         };
>                                 };
> 
>                         };
> 
>    

This is a fragment from a camera instantiation that happens to be connected to the GPMC interface.

The GPMC driver has to be hacked to support _any_ possible device it might be connected, and
there is a abundance of GPMC configuration properties in an unrelated device driver.

I could be wrong and jumped in the wrong thread, but I believe what we really need is a generic GPMC
framework, similar to the way pinctrl works.

So instead of doing the above we could just add a property that contains a reference to the required GPMC
configuration.

i.e.


	gpmc {
		compatible = "ti,gpmc";

		camera_gpmc_config {

                         bank-width = <2>;                /* GPMC_CONFIG1_DEVICESIZE(1) */

                         gpmc,burst-read;                /* GPMC_CONFIG1_READMULTIPLE_SUPP */
                         gpmc,sync-read;                        /* GPMC_CONFIG1_READTYPE_SYNC */
                         gpmc,sync-write;                /* GPMC_CONFIG1_WRITETYPE_SYNC */
                         gpmc,clk-activation-ns = <20>;        /* GPMC_CONFIG1_CLKACTIVATIONTIME(2) */
                         gpmc,burst-length = <16>;        /* GPMC_CONFIG1_PAGE_LEN(2) */
                         gpmc,mux-add-data = <2>;        /* GPMC_CONFIG1_MUXTYPE(2) */
		};
	}
	
        camera {
                compatible = "cssp-camera";
                reg = <0 0x01000000>;                /* CS1 */
		gpmc-config = <&camera_gpmc_config 1>	/* CS1 */
 		...
	};

Regards

-- Pantelis
 

 
