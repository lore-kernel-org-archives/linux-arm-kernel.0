From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 18 Jun 2013 11:35:22 +0200
Subject: [PATCH 2/4] ARM: rockchip: add sram dt nodes and documentation
In-Reply-To: <51BFC656.8020704@gmail.com>
References: <201306180043.11785.heiko@sntech.de>
 <201306180317.42820.heiko@sntech.de> <51BFC656.8020704@gmail.com>
Message-ID: <201306181135.22610.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. Juni 2013, 04:30:46 schrieb Rob Herring:
> On 06/17/2013 08:17 PM, Heiko St?bner wrote:
> > Am Dienstag, 18. Juni 2013, 01:41:27 schrieb Rob Herring:
> >> On 06/17/2013 05:44 PM, Heiko St?bner wrote:
> >>> The Rockchip SoCs need a special part of their sram for bringup
> >>> of additional cores. Therefore the mapped area should be split
> >>> into a special area for the smp code and a generic area that gets
> >>> handled by mmio-sram.
> >>> 
> >>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >>> ---
> >>> 
> >>>  .../devicetree/bindings/arm/rockchip/smp-sram.txt  |   29
> >>>  ++++++++++++++++++++ arch/arm/boot/dts/rk3066a.dtsi
> >>>  
> >>>  |   14 ++++++++++ 2 files changed, 43 insertions(+)
> >>>  
> >>>  create mode 100644
> >>>  Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
> >>> 
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
> >>> b/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt new file
> >>> mode 100644
> >>> index 0000000..9c81fac
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
> >>> @@ -0,0 +1,29 @@
> >>> +Rockchip SRAM for smp bringup:
> >>> +------------------------------
> >>> +
> >>> +Rockchip smp-capable SoCs use the first part of the sram for the
> >>> bringup +of the cores. Once the core gets powered up it executes the
> >>> code that is +residing at the very beginning of the sram.
> >>> +
> >>> +While the suspend also needs to have code in the sram that can be
> >>> realized +with the generic mmio-sram driver and only the smp specific
> >>> part needs to +be mapped specially in the smp code.
> >>> +
> >>> +Therefore split the sram mapping in a smp-specific part that gets used
> >>> +by the smp code exclusively and a bigger generic part for mmio-sram
> >>> +
> >>> +Required node properties:
> >>> +- compatible value : = "rockchip,rk3066-smp-sram";
> >>> +- reg : physical base address and the size of the registers window
> >>> +
> >>> +Example:
> >>> +
> >>> +	sram at 10080000 {
> >>> +		compatible = "rockchip,rk3066-smp-sram";
> >>> +		reg = <0x10080000 0x100>;
> >>> +	};
> >>> +
> >>> +	sram: sram at 10080100 {
> >>> +		compatible = "mmio-sram";
> >>> +		reg = <0x10080100 0x9900>;
> >> 
> >> I think a better way would be to specify some portion of the sram as
> >> reserved rather than defining the s/w use of the sram in DT.
> >> Something like this:
> >> 
> >> mmio-sram-reserved = <base size base size>;
> >> 
> >> where base values are relative to reg property base.
> > 
> > hmm, but I don't see how to get then access to the reserved part. As can
> > be seen in patch 4 [which I've forgotton to cc you in, sorry] the
> > smp-trampoline gets copied into this area for the core to execute after
> > poweron, so I need to get the mapped representation of the reserved
> > area.
> 
> That's helpful to know.
> 
> > Or do you mean
> > 
> > - let mmio-sram only allocate the non-reserved spaces for itself
> > - grab mmio-sram node in the smp code and map the necessary reserved
> > space
> 
> That would work. Another alternative would be having a way in the kernel
> to reserve a specific region of sram.

Problem is, that the mmio-sram driver that gets to control the sram via 
genalloc only runs later in the boot process, so when bringing up smp cores 
it's not present yet.

So I'll try it with the reserve-variant above.


> If you have to know what to put in the sram and are putting that into
> the kernel, then having to know where to put it is not really much more
> kernel data. So I don't really see the point to put a "smp boot" area
> into device tree.
> 
> Seems like we're getting several platforms that are putting all their
> secondary core boot code into the kernel. I'm not sure this is something
> we want in the kernel. We may need to define the boot protocol for
> secondary cores just like the boot core and start pushing this into
> bootloaders.

sorry, but you've lost me here somewhere - but smp is also very new to me :-)

What gets put into sram for the Rockchip SoCs is

	ENTRY(rockchip_secondary_trampoline)
		ldr	pc, 1f
	ENDPROC(rockchip_secondary_trampoline)
		.globl	rockchip_boot_fn
	rockchip_boot_fn:
	1:	.space	4
	ENTRY(rockchip_secondary_trampoline_end)

that then simply points the core back to the regular kernel code, that does 
the real bringup:

	ENTRY(rockchip_secondary_startup)
		bl	v7_invalidate_l1
		b	secondary_startup
	ENDPROC(rockchip_secondary_startup)

and I currently fail to see how this would only be done in the bootloader, 
especially, as it probably needs to be rerun after turning the core off and on 
again via cpu hotplug, so the sram content there would also need to stay 
untouched.

And from what I've seen, how this is done in general in different SoCs varies 
a lot.


Heiko
