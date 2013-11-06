From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Nov 2013 11:56:58 -0700
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <334037D0-02FB-459F-9E40-129EC830AF65@antoniou-consulting.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com>
 <20131106190308.01f7a4a9@skate>
 <334037D0-02FB-459F-9E40-129EC830AF65@antoniou-consulting.com>
Message-ID: <20131106185658.GC25879@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 08:33:39PM +0200, Pantelis Antoniou wrote:

> On DT this fall downs completely, and you get abominations like the
> OMAP GPMC bindings...

This looks similar to Ezequiel's expansion bus bindings for MVEBU.

Maybe you can clarify the issue you see?

The general pattern I expect is something like this:

  some_bus_bridge {
     compatible = 'bridge bus driver';
     
     ranges <[CS#] 0  [CS window base]  [size]>;

     chip-select,1 {
       < All Parameters to configure timing, etc, for this
         chip select>
       ranges = <0  1 0  [size]>;

       my device {
           compatble = 'camera'
           reg = <0 [size]>
       }
     }

The way it works is the DT machinery instantiates a some_bus_bridge.

The bridge driver goes through and parses the ranges, it sets up the
address mappings as necessary to create a window for each CS. If this
address assignment is dynamic then it needs to make the 'ranges'
correct. (MVEBU land does this in the mbus driver)

The bridge driver parses each child and configures the bus CS timing
parameters. (this is done in the external memory driver, IIRC)

The bridge driver constructs a struct device for each child in every
chip-select (the 'my device' node). Normal OF address translation
makes this work fine.

Your camera driver attaches to the 'my device' node, not to the chip
select node. The chip select node is used only by the bus bridge
driver to setup that specific chip select.

The example you have looks close to that except for a few details:
 
> Observe:
> 
> >                         status = "okay";
> > 
> >                         #address-cells = <2>;
> >                         #size-cells = <1>;
> > 
> >                         pinctrl-names = "default";
> >                         pinctrl-0 = <&gpmc_pins>;
> > 
> >                         /* chip select ranges */
> >                         ranges = <0 0 0x08000000 0x10000000>,        /* bootloader has this enabled */
> >                                  <1 0 0x18000000 0x08000000>,
> >                                  <2 0 0x20000000 0x08000000>,
> >                                  <3 0 0x28000000 0x08000000>,
> >                                  <4 0 0x30000000 0x08000000>,
> >                                  <5 0 0x38000000 0x04000000>,
> >                                  <6 0 0x3c000000 0x04000000>;

OK, seems reasonable, setting up chip select windows, giving them base
addresess and sizes.

> >                         camera {
> >                                 compatible = "cssp-camera";
> >                                 status = "okay";
> >                                 pinctrl-names = "default";
> >                                 pinctrl-0 = <&cssp_camera_pins>;
> > 
> >                                 reg = <1 0 0x01000000>;       /* CS1 */

Here we want to hoist bus specific stuff out of 'camera' and into
'cs1@', so:

No reg at this point.

> >                                 bank-width = <2>;                /* GPMC_CONFIG1_DEVICESIZE(1) */
> >                                 gpmc,burst-read;                /* GPMC_CONFIG1_READMULTIPLE_SUPP */
[...]

Timing parameters seem reasonable.

> > 
> >                                 /* not using dma engine yet, but we can get the channel number here */
> >                                 dmas = <&edma 20>;
> >                                 dma-names = "cssp";

DMA's/gpios, etc probably belong in the child. Maybe clocks belong in
the CS? Depends on the bridge driver..

> >                                 /* clocks */
> >                                 cssp,camera-clk-name = "adjustable_clkout2_ck";
> >                                 cssp,camera-clk-rate = <32000000>;
> > 
> >                                 /* reset */
> >                                 reset-gpio = <&gpio1 4 0>;
> > 
> >                                 /* orientation; -> MT9T112_FLAG_VFLIP */
> >                                 orientation-gpio = <&gpio1 30 0>;
> > 
> >                                 /* reset controller (for the black) */
> >                                 reset = <&rstctl 0 0>;
> >                                 reset-names = "eMMC_RSTn-CAM3";

Missing:

ranges = <0  1 0  0x01000000>;

Missing:

 camera at 0 {
    reg = <0 0x01000000>;

Put DMA's/etc here.

> >                                 /* camera sensor */
> >                                 cssp,sensor {
> >                                         i2c-adapter = <&i2c2>;

Yikes!

If there is an i2c component then a phandle to the component itself is
way better:

    i2c-component = <&i2c_camera>

i2c2: ...
{ 
         i2c_camera: m59t112 {
             compatible = "aptina,mt9t112";
             reg = <0x3c>;
         }
}

Sprinkle address-cells/size-cells as necessary.

> 	gpmc {
> 		compatible = "ti,gpmc";
> 
> 		camera_gpmc_config {
> 
>                          bank-width = <2>;                /* GPMC_CONFIG1_DEVICESIZE(1) */
> 
>                          gpmc,burst-read;                /* GPMC_CONFIG1_READMULTIPLE_SUPP */
>                          gpmc,sync-read;                        /* GPMC_CONFIG1_READTYPE_SYNC */
>                          gpmc,sync-write;                /* GPMC_CONFIG1_WRITETYPE_SYNC */
>                          gpmc,clk-activation-ns = <20>;        /* GPMC_CONFIG1_CLKACTIVATIONTIME(2) */
>                          gpmc,burst-length = <16>;        /* GPMC_CONFIG1_PAGE_LEN(2) */
>                          gpmc,mux-add-data = <2>;        /* GPMC_CONFIG1_MUXTYPE(2) */
> 		};
> 	}

Similar idea, but you have thrown away the nesting.

DT should reflect the address translation hierarchy of the system, so
'ti,gpmc' does address translation, the things it translates for
should be its children.

Jason
