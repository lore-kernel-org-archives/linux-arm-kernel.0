From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 Sep 2011 08:24:24 -0500
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
Message-ID: <4E79E588.6010703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,

On 09/21/2011 04:19 AM, Dave Martin wrote:
> This patch implements initial support for booting using a flattened
> device tree on the Versatile Express platform.
> 
> Eventually, it should be possible to present a single, core-tile-
> independent board, but in this transitional patch the baseboard +
> Cortex-A9x4 core tile combination is the only directly supported
> platform, since the implementation is not yet fully generic.
> 
> For now, clocks and timers are not handled via the device tree.
> Implementation of these can follow in later patches.
> 
> Thanks to Lorenzo Pieralisi, Grant Likely and Pawe? Moll for their
> help and contributions.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Pawe? Moll <Pawel.Moll@arm.com>
> ---
> 
> There are some outstanding issues which need to be discussed, listed
> below.
> 
>   * This patch is not currently based on the GIC bindings being
>     discussed by Rob Herring et al.  Once that discussion reaches a
>     conclusion, it should be straightforward to rebase onto the result.
> 
>   * The following added bindings are not present upstream and need
>     documentation / discussion:
> 
>       * arm,vexpress -- the global board binding for all platform
>         combinations using the Versatile Express motherboard.
> 
>       * arm,vexpress-v2p-ca9 -- the specific binding for the Versatile
>         Express motherboard with Cortex-A9x4 core tile installed.  It
>         is only mentioned as the most-specific match in vexpress-v2p-
>         ca9.dts
> 
>         Since it's intended that the motherboard code should be fully
>         generic, and because no other core tiles are upstream yet,
>         perhaps we can get rid of this binding right away.
> 
>       * edid -- It should be possible to have a fairly generic binding
>         for EDID interfaces, but none seems to exist yet.  Discussion
>         is needed regarding what form this should take.
> 
>         This might more appropriately be called "ddc" (or some
>         variation on that), since EDID seems only to describe the
>         format of the ID data retrievable via this interface; not the
>         interface itself.
> 
>       * arm,vexpress-flash -- Needed because of the requirement to
>         provide the physmap_flash driver with a special .set_vpp
>         handler.
> 
>       * idt,89hpes32h8 -- This is the IDT 89HPES32H8 PCI express
>         interconnect switch.  This isn't needed for the Versatile
>         Express to work, but would be needed if using PCI-e peripherals
>         for real.  I expect that more driver support needs to go
>         upstream before this is actually usable.
> 
>       * nxp,isp1761 -- The driver support for this is already upstream
>         (with some minor issues for ARM support).
> 
>       * arm,amba-bus -- widely used by other boards and patchsets, but
>         seems not to be documented.
> 

This should be dropped. There's not really any bus component to an amba
bus. All the probing info is within the primecell peripherals.

>       * The following bindings for ARM primecell peripherals are used
>         elsewhere but not documented.  They should be pretty simple and
>         uncontraversial.
>           * arm,pl031
>           * arm,pl041
>           * arm,pl050
>           * arm,pl180
>           * arm,sp805
> 

Plus pl011, pl010, sp804, pl022, pl061

>         Rob Herring suggested documenting simple bindings for these
>         (and others) along with his initial amba device tree probe
>         patches, but these bindings don't seem to be documented
>         upstream for now.
> 

pl330 went the other route with a file for itself. That may be better to
avoid conflicts. But yes, ARM should document all their peripherals. ;)

I'll do the ones on highbank if you want to do the rest on VExp.

> 
>   * Shawn Guo's smsc911x patch is needed for Ethernet to work.  This is
>     headed upstream but not yet in mainline.  It is available in -next.
> 
>   * Minor patches are needed to the isp1760 and pata_generic drivers,
>     to allow OF-based initialisation across a wider group of
>     architectures.  These are being discussed independently, but are
>     not yet accepted for merging upstream.
> 
>   * Most core-tile peripherals are currently not described in the core-
>     tile device tree fragment.  This is a lower-priority issue since
>     the motherboard code already autodetects the core-tile (though only
>     one core-tile is fully upstream at the moment).
> 
>   * Static peripheral mappings are not yet handled in a generic way in
>     the board support code.  This is a prerequisite for supporting
>     multiple core-tiles int the same kernel.  It well need to get fixed
>     later, when extra core tile support is merged (or before).
> 
>     Pawe? Moll is looking into this separately.
> 
>   * The Kconfig logic for ensuring that at least one boot protocol and
>     at least one core tile are selected is a bit ugly.  Suggestions for
>     improving this are certainly welcome.
> 
>  arch/arm/Kconfig                           |    1 +
>  arch/arm/boot/dts/vexpress-v2m-legacy.dtsi |  163 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/vexpress-v2p-ca9.dts     |   80 ++++++++++++++
>  arch/arm/configs/vexpress_defconfig        |    1 +
>  arch/arm/mach-vexpress/Kconfig             |   45 ++++++++-
>  arch/arm/mach-vexpress/ct-ca9x4.c          |    7 ++
>  arch/arm/mach-vexpress/v2m.c               |   54 +++++++++-
>  7 files changed, 349 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
>  create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5ebc5d9..a6e90d5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -282,6 +282,7 @@ config ARCH_VERSATILE
>  
>  config ARCH_VEXPRESS
>  	bool "ARM Ltd. Versatile Express family"
> +	select ARCH_VEXPRESS_SANE_CONFIG
>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARM_AMBA
>  	select ARM_TIMER_SP804
> diff --git a/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi b/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
> new file mode 100644
> index 0000000..fd6e4e4
> --- /dev/null
> +++ b/arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
> @@ -0,0 +1,163 @@
> +// ARM Ltd. Versatile Express Motherboard V2M-P1 (HBI-0190D)
> +// Legacy memory map

Not sure, but C++ style comments are probably frowned upon in dts too.

> +
> +/ {
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +	};
> +
> +	motherboard {
> +		compatible = "simple-bus";
> +		#address-cells = <2>; // SMB chipselect number and offset
> +		#size-cells = <1>;
> +		#interrupt-cells = <1>;
> +
> +		flash at 0,00000000 {
> +			compatible = "arm,vexpress-flash", "cfi-flash";
> +			reg = <0 0x00000000 0x04000000
> +			       1 0x00000000 0x04000000>;
> +			bank-width = <4>;
> +		};
> +
> +		psram at 2,00000000 {
> +			compatible = "mtd-ram";
> +			reg = <2 0x00000000 0x02000000>;
> +			bank-width = <4>;
> +		};
> +
> +		ethernet at 3,02000000 {
> +			compatible = "smsc,lan9118", "smsc,lan9115";
> +			reg = <3 0x02000000 0x10000>;
> +			reg-io-width = <4>;
> +			interrupts = <15>;
> +			smsc,irq-active-high;
> +			smsc,irq-push-pull;
> +		};
> +
> +		usb at 3,03000000 {
> +			compatible = "nxp,usb-isp1761";
> +			reg = <3 0x03000000 0x20000>;
> +			interrupts = <16>;
> +			port1-otg;
> +		};
> +
> +		peripherals at 7,00000000 {
> +			compatible = "arm,amba-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 7 0 0x20000>;
> +
> +			// PCI-E I2C bus
> +			i2c0: i2c at 02000 {
> +				compatible = "arm,versatile-i2c";
> +				reg = <0x02000 0x1000>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				pcie-switch at 60 {
> +					compatible = "idt,89hpes32h8";
> +					reg = <0x60>;
> +				};
> +			};
> +
> +			aaci at 04000 {
> +				compatible = "arm,pl041", "arm,primecell";
> +				reg = <0x04000 0x1000>;
> +				interrupts = <11>;
> +			};
> +
> +			mmci at 05000 {
> +				compatible = "arm,pl180", "arm,primecell";
> +				reg = <0x05000 0x1000>;
> +				interrupts = <9 10>;
> +			};
> +
> +			kmi at 06000 {
> +				compatible = "arm,pl050", "arm,primecell";
> +				reg = <0x06000 0x1000>;
> +				interrupts = <12>;
> +			};
> +
> +			kmi at 07000 {
> +				compatible = "arm,pl050", "arm,primecell";
> +				reg = <0x07000 0x1000>;
> +				interrupts = <13>;
> +			};
> +
> +			uart0: uart at 09000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x09000 0x1000>;
> +				interrupts = <5>;
> +			};
> +
> +			uart1: uart at 0a000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x0a000 0x1000>;
> +				interrupts = <6>;
> +			};
> +
> +			uart2: uart at 0b000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x0b000 0x1000>;
> +				interrupts = <7>;
> +			};
> +
> +			uart3: uart at 0c000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x0c000 0x1000>;
> +				interrupts = <8>;
> +			};
> +
> +			wdt at 0f000 {
> +				compatible = "arm,sp805", "arm,primecell";
> +				reg = <0x0f000 0x1000>;
> +				interrupts = <0>;
> +			};
> +
> +			// Timer init is hardcoded in v2m_timer_init(), for now.
> +			// timer at 11000 {
> +			//	compatible = "arm,arm-sp804";

arm,sp804 is more consistent. I believe the sp804 does have the periphid
registers, so arm,primecell should also be added.

> +			//	reg = <0x11000 0x1000>;
> +			//	interrupts = <2>;
> +			// };
> +
> +			// timer at 12000 {
> +			//	compatible = "arm,arm-sp804";
> +			//	reg = <0x12000 0x1000>;
> +			// };

Just because Linux is not using it, doesn't mean you should comment it out.

> +
> +			// DVI I2C bus (DDC)
> +			i2c1: i2c at 16000 {
> +				compatible = "arm,versatile-i2c";
> +				reg = <0x16000 0x1000>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				edid at 50 {
> +					compatible = "edid";
> +					reg = <0x50>;
> +				};
> +			};
> +
> +			rtc at 17000 {
> +				compatible = "arm,pl031", "arm,primecell";
> +				reg = <0x017000 0x1000>;
> +				interrupts = <4>;
> +			};
> +
> +			compact-flash at 1a000 {
> +				compatible = "ata-generic";
> +				reg = <0x1a000 0x100
> +				       0x1a100 0xf00>;
> +				reg-shift = <2>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> new file mode 100644
> index 0000000..059be97
> --- /dev/null
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> @@ -0,0 +1,80 @@
> +// ARM Ltd. Versatile Express Corex-A9 (Quad Core) Core Tile V2P-CA9 (HBI-0191B)
> +
> +/dts-v1/;
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "ARM Versatile Express (Cortex-A9 Quad Core Tile)";
> +	compatible = "arm,vexpress-v2p-ca9", "arm,vexpress";
> +	interrupt-parent = <&intc>;
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x60000000 0x40000000>;
> +	};
> +
> +	intc: interrupt-controller at 1e001000 {
> +		compatible = "arm,cortex-a9-gic";
> +		#interrupt-cells = <2>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0x1e001000 0x1000>,
> +		      <0x1e000100 0x100>;
> +	};

Is this really all by itself? It should be in the sub-tree of the
appropriate bus.

You need an "interrupt-parent;" line so the parent is not itself.

> +
> +	motherboard {
> +		ranges = <0 0 0x40000000 0x04000000
> +			  1 0 0x44000000 0x04000000
> +			  2 0 0x48000000 0x04000000
> +			  3 0 0x4c000000 0x04000000
> +			  7 0 0x10000000 0x00020000>;
> +
> +		interrupt-map-mask = <0 0 63>;
> +		interrupt-map = <0 0 0 &intc 32 8
> +				 0 0 1 &intc 33 4
> +				 0 0 2 &intc 34 4
> +				 0 0 3 &intc 35 4
> +				 0 0 4 &intc 36 4
> +				 0 0 5 &intc 37 4
> +				 0 0 6 &intc 38 4
> +				 0 0 7 &intc 39 4
> +				 0 0 8 &intc 40 4
> +				 0 0 9 &intc 41 4
> +				 0 0 10 &intc 42 4
> +				 0 0 11 &intc 43 4
> +				 0 0 12 &intc 44 4
> +				 0 0 13 &intc 45 4
> +				 0 0 14 &intc 46 4
> +				 0 0 15 &intc 47 4
> +				 0 0 16 &intc 48 4
> +				 0 0 17 &intc 49 4
> +				 0 0 18 &intc 50 4
> +				 0 0 19 &intc 51 4
> +				 0 0 20 &intc 52 4
> +				 0 0 21 &intc 53 4
> +				 0 0 22 &intc 54 4
> +				 0 0 23 &intc 55 4
> +				 0 0 24 &intc 56 4
> +				 0 0 25 &intc 57 4
> +				 0 0 26 &intc 58 4
> +				 0 0 27 &intc 59 4
> +				 0 0 28 &intc 60 4
> +				 0 0 29 &intc 61 4
> +				 0 0 30 &intc 62 4
> +				 0 0 31 &intc 63 4
> +				 0 0 32 &intc 64 4
> +				 0 0 33 &intc 65 4
> +				 0 0 34 &intc 66 4
> +				 0 0 35 &intc 67 4
> +				 0 0 36 &intc 68 4
> +				 0 0 37 &intc 69 4
> +				 0 0 38 &intc 70 4
> +				 0 0 39 &intc 71 4
> +				 0 0 40 &intc 72 4
> +				 0 0 41 &intc 73 4
> +				 0 0 42 &intc 74 4>;
> +	};
> +};
> +
> +/include/ "vexpress-v2m-legacy.dtsi"
> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> index f2de51f..6c3c5f6 100644
> --- a/arch/arm/configs/vexpress_defconfig
> +++ b/arch/arm/configs/vexpress_defconfig
> @@ -22,6 +22,7 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
>  CONFIG_ARCH_VEXPRESS=y
> +CONFIG_ARCH_VEXPRESS_ATAGS=y
>  CONFIG_ARCH_VEXPRESS_CA9X4=y
>  # CONFIG_SWP_EMULATE is not set
>  CONFIG_SMP=y
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 9311484..ea64630 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -1,12 +1,55 @@
>  menu "Versatile Express platform type"
>  	depends on ARCH_VEXPRESS
>  
> +# ARCH_VEXPRESS ensures a sane minimal config is selected by selecting
> +# ARCH_VEXPRESS_SANE_CONFIG.
> +# Extend the logic here when adding new core tiles.
> +
> +config ARCH_VEXPRESS_SANE_CONFIG
> +	bool
> +	select ARCH_VEXPRESS_CA9X4
> +	select ARCH_VEXPRESS_ATAGS if !ARCH_VEXPRESS_DT
> +
> +
> +comment "At least one boot type must be selected"
> +
> +config ARCH_VEXPRESS_ATAGS
> +	bool "Boot via ATAGs"
> +	default y
> +	help
> +	  This option enables support for the board using the standard
> +	  ATAGs boot protocol.
> +
> +	  If your bootloader supports FDT-based booting and you do not
> +	  intend ever to boot via the traditional ATAGs method, you can say
> +	  N here.
> +
> +config ARCH_VEXPRESS_DT
> +	bool "Boot via Device Tree"
> +	select USE_OF
> +	help
> +	  This option enables support for the board, and enables booting
> +	  via a Flattened Device Tree provided by the bootloader.
> +
> +	  If your bootloader supports FDT-based booting, you can say Y
> +	  here, otherwise, say N.
> +
> +
> +# Core Tile support options
> +
> +comment "At least one core tile must be selected"
> +
>  config ARCH_VEXPRESS_CA9X4
> -	bool "Versatile Express Cortex-A9x4 tile"
> +	bool "Versatile Express Cortex-A9x4 Core Tile"
> +	default y
>  	select CPU_V7
>  	select ARM_GIC
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_751472
>  	select ARM_ERRATA_753970
> +	help
> +	  Include support for the Cortex-A9x4 Core Tile (HBI-0191B).
> +
> +	  If unsure, say Y.
>  
>  endmenu
> diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
> index bfd32f5..e2fe2c9 100644
> --- a/arch/arm/mach-vexpress/ct-ca9x4.c
> +++ b/arch/arm/mach-vexpress/ct-ca9x4.c
> @@ -9,6 +9,7 @@
>  #include <linux/amba/bus.h>
>  #include <linux/amba/clcd.h>
>  #include <linux/clkdev.h>
> +#include <linux/irqdomain.h>
>  
>  #include <asm/hardware/arm_timer.h>
>  #include <asm/hardware/cache-l2x0.h>
> @@ -59,10 +60,16 @@ static void __init ct_ca9x4_map_io(void)
>  	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
>  }
>  
> +static const struct of_device_id gic_of_match[] __initconst = {
> +	{ .compatible = "arm,cortex-a9-gic", },
> +	{}
> +};
> +
>  static void __init ct_ca9x4_init_irq(void)
>  {
>  	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST),
>  		 MMIO_P2V(A9_MPCORE_GIC_CPU));
> +	irq_domain_generate_simple(gic_of_match, A9_MPCORE_GIC_DIST, 0);
>  }
>  
>  #if 0
> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> index 9e6b93b..6defce6 100644
> --- a/arch/arm/mach-vexpress/v2m.c
> +++ b/arch/arm/mach-vexpress/v2m.c
> @@ -6,6 +6,8 @@
>  #include <linux/amba/mmci.h>
>  #include <linux/io.h>
>  #include <linux/init.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/smsc911x.h>
> @@ -118,7 +120,7 @@ int v2m_cfg_read(u32 devfn, u32 *data)
>  	return !!(val & SYS_CFG_ERR);
>  }
>  
> -
> +#ifdef CONFIG_ARCH_VEXPRESS_ATAGS
>  static struct resource v2m_pcie_i2c_resource = {
>  	.start	= V2M_SERIAL_BUS_PCI,
>  	.end	= V2M_SERIAL_BUS_PCI + SZ_4K - 1,
> @@ -200,6 +202,7 @@ static struct platform_device v2m_usb_device = {
>  	.num_resources	= ARRAY_SIZE(v2m_usb_resources),
>  	.dev.platform_data = &v2m_usb_config,
>  };
> +#endif /* CONFIG_ARCH_VEXPRESS_ATAGS */
>  
>  static void v2m_flash_set_vpp(struct platform_device *pdev, int on)
>  {
> @@ -211,6 +214,7 @@ static struct physmap_flash_data v2m_flash_data = {
>  	.set_vpp	= v2m_flash_set_vpp,
>  };
>  
> +#ifdef CONFIG_ARCH_VEXPRESS_ATAGS
>  static struct resource v2m_flash_resources[] = {
>  	{
>  		.start	= V2M_NOR0,
> @@ -254,6 +258,7 @@ static struct platform_device v2m_cf_device = {
>  	.num_resources	= ARRAY_SIZE(v2m_pata_resources),
>  	.dev.platform_data = &v2m_pata_data,
>  };
> +#endif /* CONFIG_ARCH_VEXPRESS_ATAGS */
>  
>  static unsigned int v2m_mmci_status(struct device *dev)
>  {
> @@ -265,6 +270,7 @@ static struct mmci_platform_data v2m_mmci_data = {
>  	.status		= v2m_mmci_status,
>  };
>  
> +#ifdef CONFIG_ARCH_VEXPRESS_ATAGS
>  static AMBA_DEVICE(aaci,  "mb:aaci",  V2M_AACI, NULL);
>  static AMBA_DEVICE(mmci,  "mb:mmci",  V2M_MMCI, &v2m_mmci_data);
>  static AMBA_DEVICE(kmi0,  "mb:kmi0",  V2M_KMI0, NULL);
> @@ -288,6 +294,7 @@ static struct amba_device *v2m_amba_devs[] __initdata = {
>  	&wdt_device,
>  	&rtc_device,
>  };
> +#endif /* CONFIG_ARCH_VEXPRESS_ATAGS */
>  
>  
>  static long v2m_osc_round(struct clk *clk, unsigned long rate)
> @@ -415,6 +422,8 @@ static void __init v2m_init_irq(void)
>  	ct_desc->init_irq();
>  }
>  
> +
> +#ifdef CONFIG_ARCH_VEXPRESS_ATAGS
>  static void __init v2m_init(void)
>  {
>  	int i;
> @@ -443,3 +452,46 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
>  	.timer		= &v2m_timer,
>  	.init_machine	= v2m_init,
>  MACHINE_END
> +#endif /* CONFIG_ARCH_VEXPRESS_ATAGS */
> +
> +#ifdef CONFIG_ARCH_VEXPRESS_DT
> +struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash", &v2m_flash_data),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_AACI, "mb:aaci", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_WDT, "mb:wdt", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_KMI0, "mb:kmi0", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_KMI1, "mb:kmi1", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_UART0, "mb:uart0", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_UART1, "mb:uart1", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_UART2, "mb:uart2", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_UART3, "mb:uart3", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", V2M_RTC, "mb:rtc", NULL),
> +	{}
> +};
> +
> +static void __init v2m_dt_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +			     v2m_dt_auxdata_lookup, NULL);
> +
> +	pm_power_off = v2m_power_off;
> +	arm_pm_restart = v2m_restart;
> +
> +	ct_desc->init_tile();
> +}
> +
> +static const char *v2m_dt_match[] __initconst = {
> +	"arm,vexpress",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(VEXPRESS_DT, "ARM Versatile Express")
> +	.map_io		= v2m_map_io,
> +	.init_early	= v2m_init_early,
> +	.init_irq	= v2m_init_irq,
> +	.timer		= &v2m_timer,
> +	.init_machine	= v2m_dt_init,
> +	.dt_compat	= v2m_dt_match,
> +MACHINE_END
> +#endif /* CONFIG_ARCH_VEXPRESS_DT */

All the ifdefs are really ugly. Most people are creating new board_dt.c
file and copying over pieces they need. Once DT support is on par with
the old file, the old file can be deleted.

Rob
