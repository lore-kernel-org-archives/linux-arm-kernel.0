From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 21 Sep 2011 15:24:25 +0100
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4E79E588.6010703@gmail.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
	<4E79E588.6010703@gmail.com>
Message-ID: <20110921142425.GE2872@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 08:24:24AM -0500, Rob Herring wrote:
> Dave,
> 
> On 09/21/2011 04:19 AM, Dave Martin wrote:
> > This patch implements initial support for booting using a flattened
> > device tree on the Versatile Express platform.
> > 
> > Eventually, it should be possible to present a single, core-tile-
> > independent board, but in this transitional patch the baseboard +
> > Cortex-A9x4 core tile combination is the only directly supported
> > platform, since the implementation is not yet fully generic.
> > 
> > For now, clocks and timers are not handled via the device tree.
> > Implementation of these can follow in later patches.
> > 
> > Thanks to Lorenzo Pieralisi, Grant Likely and Pawe? Moll for their
> > help and contributions.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > Acked-by: Pawe? Moll <Pawel.Moll@arm.com>
> > ---
> > 
> > There are some outstanding issues which need to be discussed, listed
> > below.
> > 
> >   * This patch is not currently based on the GIC bindings being
> >     discussed by Rob Herring et al.  Once that discussion reaches a
> >     conclusion, it should be straightforward to rebase onto the result.
> > 
> >   * The following added bindings are not present upstream and need
> >     documentation / discussion:
> > 
> >       * arm,vexpress -- the global board binding for all platform
> >         combinations using the Versatile Express motherboard.
> > 
> >       * arm,vexpress-v2p-ca9 -- the specific binding for the Versatile
> >         Express motherboard with Cortex-A9x4 core tile installed.  It
> >         is only mentioned as the most-specific match in vexpress-v2p-
> >         ca9.dts
> > 
> >         Since it's intended that the motherboard code should be fully
> >         generic, and because no other core tiles are upstream yet,
> >         perhaps we can get rid of this binding right away.
> > 
> >       * edid -- It should be possible to have a fairly generic binding
> >         for EDID interfaces, but none seems to exist yet.  Discussion
> >         is needed regarding what form this should take.
> > 
> >         This might more appropriately be called "ddc" (or some
> >         variation on that), since EDID seems only to describe the
> >         format of the ID data retrievable via this interface; not the
> >         interface itself.
> > 
> >       * arm,vexpress-flash -- Needed because of the requirement to
> >         provide the physmap_flash driver with a special .set_vpp
> >         handler.
> > 
> >       * idt,89hpes32h8 -- This is the IDT 89HPES32H8 PCI express
> >         interconnect switch.  This isn't needed for the Versatile
> >         Express to work, but would be needed if using PCI-e peripherals
> >         for real.  I expect that more driver support needs to go
> >         upstream before this is actually usable.
> > 
> >       * nxp,isp1761 -- The driver support for this is already upstream
> >         (with some minor issues for ARM support).
> > 
> >       * arm,amba-bus -- widely used by other boards and patchsets, but
> >         seems not to be documented.
> > 
> 
> This should be dropped. There's not really any bus component to an amba
> bus. All the probing info is within the primecell peripherals.

So, just use "simple-bus"?

> >       * The following bindings for ARM primecell peripherals are used
> >         elsewhere but not documented.  They should be pretty simple and
> >         uncontraversial.
> >           * arm,pl031
> >           * arm,pl041
> >           * arm,pl050
> >           * arm,pl180
> >           * arm,sp805
> > 
> 
> Plus pl011, pl010, sp804, pl022, pl061

It looks like I missed pl011 and sp804 (though I don't currently declare
the timers in the device tree because of the way they are initialised).

> >         Rob Herring suggested documenting simple bindings for these
> >         (and others) along with his initial amba device tree probe
> >         patches, but these bindings don't seem to be documented
> >         upstream for now.
> > 
> 
> pl330 went the other route with a file for itself. That may be better to
> avoid conflicts. But yes, ARM should document all their peripherals. ;)
> 
> I'll do the ones on highbank if you want to do the rest on VExp.

OK, I'll try to propose documentation for these:

	* arm,pl011
	* arm,pl031
	* arm,pl041
	* arm,pl050
	* arm,pl180
	* arm,sp804
	* arm,sp805

...if you can pick the other ones that are relevant to highbank -- thanks.

> 
> > 
> >   * Shawn Guo's smsc911x patch is needed for Ethernet to work.  This is
> >     headed upstream but not yet in mainline.  It is available in -next.
> > 
> >   * Minor patches are needed to the isp1760 and pata_generic drivers,
> >     to allow OF-based initialisation across a wider group of
> >     architectures.  These are being discussed independently, but are
> >     not yet accepted for merging upstream.
> > 
> >   * Most core-tile peripherals are currently not described in the core-
> >     tile device tree fragment.  This is a lower-priority issue since
> >     the motherboard code already autodetects the core-tile (though only
> >     one core-tile is fully upstream at the moment).
> > 
> >   * Static peripheral mappings are not yet handled in a generic way in
> >     the board support code.  This is a prerequisite for supporting
> >     multiple core-tiles int the same kernel.  It well need to get fixed
> >     later, when extra core tile support is merged (or before).
> > 
> >     Pawe? Moll is looking into this separately.
> > 
> >   * The Kconfig logic for ensuring that at least one boot protocol and
> >     at least one core tile are selected is a bit ugly.  Suggestions for
> >     improving this are certainly welcome.
> > 
> >  arch/arm/Kconfig                           |    1 +
> >  arch/arm/boot/dts/vexpress-v2m-legacy.dtsi |  163 ++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/vexpress-v2p-ca9.dts     |   80 ++++++++++++++
> >  arch/arm/configs/vexpress_defconfig        |    1 +
> >  arch/arm/mach-vexpress/Kconfig             |   45 ++++++++-
> >  arch/arm/mach-vexpress/ct-ca9x4.c          |    7 ++
> >  arch/arm/mach-vexpress/v2m.c               |   54 +++++++++-
> >  7 files changed, 349 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
> >  create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 5ebc5d9..a6e90d5 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -282,6 +282,7 @@ config ARCH_VERSATILE
> >  
> >  config ARCH_VEXPRESS
> >  	bool "ARM Ltd. Versatile Express family"
> > +	select ARCH_VEXPRESS_SANE_CONFIG
> >  	select ARCH_WANT_OPTIONAL_GPIOLIB
> >  	select ARM_AMBA
> >  	select ARM_TIMER_SP804
> > diff --git a/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi b/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
> > new file mode 100644
> > index 0000000..fd6e4e4
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
> > @@ -0,0 +1,163 @@
> > +// ARM Ltd. Versatile Express Motherboard V2M-P1 (HBI-0190D)
> > +// Legacy memory map
> 
> Not sure, but C++ style comments are probably frowned upon in dts too.
> 
> > +
> > +/ {
> > +	aliases {
> > +		serial0 = &uart0;
> > +		serial1 = &uart1;
> > +		serial2 = &uart2;
> > +		serial3 = &uart3;
> > +		i2c0 = &i2c0;
> > +		i2c1 = &i2c1;
> > +	};
> > +
> > +	motherboard {
> > +		compatible = "simple-bus";
> > +		#address-cells = <2>; // SMB chipselect number and offset
> > +		#size-cells = <1>;
> > +		#interrupt-cells = <1>;
> > +
> > +		flash at 0,00000000 {
> > +			compatible = "arm,vexpress-flash", "cfi-flash";
> > +			reg = <0 0x00000000 0x04000000
> > +			       1 0x00000000 0x04000000>;
> > +			bank-width = <4>;
> > +		};
> > +
> > +		psram at 2,00000000 {
> > +			compatible = "mtd-ram";
> > +			reg = <2 0x00000000 0x02000000>;
> > +			bank-width = <4>;
> > +		};
> > +
> > +		ethernet at 3,02000000 {
> > +			compatible = "smsc,lan9118", "smsc,lan9115";
> > +			reg = <3 0x02000000 0x10000>;
> > +			reg-io-width = <4>;
> > +			interrupts = <15>;
> > +			smsc,irq-active-high;
> > +			smsc,irq-push-pull;
> > +		};
> > +
> > +		usb at 3,03000000 {
> > +			compatible = "nxp,usb-isp1761";
> > +			reg = <3 0x03000000 0x20000>;
> > +			interrupts = <16>;
> > +			port1-otg;
> > +		};
> > +
> > +		peripherals at 7,00000000 {
> > +			compatible = "arm,amba-bus", "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0 7 0 0x20000>;
> > +
> > +			// PCI-E I2C bus
> > +			i2c0: i2c at 02000 {
> > +				compatible = "arm,versatile-i2c";
> > +				reg = <0x02000 0x1000>;
> > +
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pcie-switch at 60 {
> > +					compatible = "idt,89hpes32h8";
> > +					reg = <0x60>;
> > +				};
> > +			};
> > +
> > +			aaci at 04000 {
> > +				compatible = "arm,pl041", "arm,primecell";
> > +				reg = <0x04000 0x1000>;
> > +				interrupts = <11>;
> > +			};
> > +
> > +			mmci at 05000 {
> > +				compatible = "arm,pl180", "arm,primecell";
> > +				reg = <0x05000 0x1000>;
> > +				interrupts = <9 10>;
> > +			};
> > +
> > +			kmi at 06000 {
> > +				compatible = "arm,pl050", "arm,primecell";
> > +				reg = <0x06000 0x1000>;
> > +				interrupts = <12>;
> > +			};
> > +
> > +			kmi at 07000 {
> > +				compatible = "arm,pl050", "arm,primecell";
> > +				reg = <0x07000 0x1000>;
> > +				interrupts = <13>;
> > +			};
> > +
> > +			uart0: uart at 09000 {
> > +				compatible = "arm,pl011", "arm,primecell";
> > +				reg = <0x09000 0x1000>;
> > +				interrupts = <5>;
> > +			};
> > +
> > +			uart1: uart at 0a000 {
> > +				compatible = "arm,pl011", "arm,primecell";
> > +				reg = <0x0a000 0x1000>;
> > +				interrupts = <6>;
> > +			};
> > +
> > +			uart2: uart at 0b000 {
> > +				compatible = "arm,pl011", "arm,primecell";
> > +				reg = <0x0b000 0x1000>;
> > +				interrupts = <7>;
> > +			};
> > +
> > +			uart3: uart at 0c000 {
> > +				compatible = "arm,pl011", "arm,primecell";
> > +				reg = <0x0c000 0x1000>;
> > +				interrupts = <8>;
> > +			};
> > +
> > +			wdt at 0f000 {
> > +				compatible = "arm,sp805", "arm,primecell";
> > +				reg = <0x0f000 0x1000>;
> > +				interrupts = <0>;
> > +			};
> > +
> > +			// Timer init is hardcoded in v2m_timer_init(), for now.
> > +			// timer at 11000 {
> > +			//	compatible = "arm,arm-sp804";
> 
> arm,sp804 is more consistent. I believe the sp804 does have the periphid
> registers, so arm,primecell should also be added.

Do you mean "does not have"?  If so, the periphid will be needed -- thanks for
pointing it out in that case.

I will make the names consistent.  These were pasted from someone Lorenzo's
older patches, and failed to sport e the inconsistency since I wasn't
actually making use of these entries yet.

> > +			//	reg = <0x11000 0x1000>;
> > +			//	interrupts = <2>;
> > +			// };
> > +
> > +			// timer at 12000 {
> > +			//	compatible = "arm,arm-sp804";
> > +			//	reg = <0x12000 0x1000>;
> > +			// };
> 
> Just because Linux is not using it, doesn't mean you should comment it out.
