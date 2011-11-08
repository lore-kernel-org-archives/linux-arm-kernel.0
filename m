From: robherring2@gmail.com (Rob Herring)
Date: Tue, 08 Nov 2011 08:34:42 -0600
Subject: [RFC 6/6] ARM: vexpress: DT-based support for Coretile Express
 A5x2 (V2P-CA5s)
In-Reply-To: <1320758169-22668-7-git-send-email-pawel.moll@arm.com>
References: <1320758169-22668-1-git-send-email-pawel.moll@arm.com>
 <1320758169-22668-7-git-send-email-pawel.moll@arm.com>
Message-ID: <4EB93E02.9000100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2011 07:16 AM, Pawel Moll wrote:
> This patch adds Device Tree for ARM Ltd. Coretile Express A5x2
> used with V2M motherboard and an initial implementation of the
> DT machine support.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |  196 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/vexpress-v2p-ca5s.dts |  121 +++++++++++++++++++
>  arch/arm/mach-vexpress/Kconfig          |    5 +
>  arch/arm/mach-vexpress/Makefile         |    1 +
>  arch/arm/mach-vexpress/v2p-ca5s.c       |   97 +++++++++++++++

I really think v2p-ca5s.c and v2p-ca9.c should be combined into 1 file.
There's a lot of duplication and the parts that are different can go in
the DT.

>  5 files changed, 420 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>  create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
>  create mode 100644 arch/arm/mach-vexpress/v2p-ca5s.c
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> new file mode 100644
> index 0000000..dd5fed0
> --- /dev/null
> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> @@ -0,0 +1,196 @@
> +/*
> + * ARM Ltd. Versatile Express
> + *
> + * Motherboard Express uATX
> + * V2M-P1
> + *
> + * HBI-0190D
> + *
> + * RS1 memory map (a.k.a. ARM Cortex-A Series memory map)
> + */
> +
> +/ {
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		timer01 = &timer01;
> +		timer23 = &timer23;
> +		sysreg = &sysreg;
> +		sysctl = &sysctl;
> +	};
> +
> +	motherboard {
> +		compatible = "simple-bus";
> +		#address-cells = <2>; /* SMB chipselect number and offset */
> +		#size-cells = <1>;
> +		#interrupt-cells = <1>;
> +
> +		flash at 0,00000000 {
> +			compatible = "arm,vexpress-flash", "cfi-flash";
> +			reg = <0 0x00000000 0x04000000
> +			       4 0x00000000 0x04000000>;
> +			bank-width = <4>;
> +		};
> +
> +		psram at 1,00000000 {
> +			compatible = "mtd-ram";
> +			reg = <1 0x00000000 0x02000000>;
> +			bank-width = <4>;
> +		};
> +
> +		ethernet at 2,02000000 {
> +			compatible = "smsc,lan9118", "smsc,lan9115";
> +			reg = <2 0x02000000 0x10000>;
> +			interrupts = <15>;
> +			phy-mode = "mii";
> +			reg-io-width = <32>;
> +			smsc,irq-active-high;
> +			smsc,irq-push-pull;
> +		};
> +
> +		usb at 2,03000000 {
> +			compatible = "nxp,usb-isp1761";
> +			reg = <2 0x03000000 0x20000>;
> +			interrupts = <16>;
> +			port1-otg;
> +		};
> +
> +		peripherals at 3,00000000 {
> +			compatible = "arm,amba-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 3 0 0x200000>;
> +
> +			sysreg: sysreg at 010000 {
> +				compatible = "arm,vexpress-sysreg";
> +				reg = <0x010000 0x1000>;
> +			};
> +
> +			sysctl: sysctl at 020000 {
> +				compatible = "arm,sp810";
> +				reg = <0x020000 0x1000>;
> +			};
> +
> +			/* PCI-E I2C bus */
> +			i2c0: i2c at 030000 {
> +				compatible = "arm,versatile-i2c";
> +				reg = <0x030000 0x1000>;
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
> +			aaci at 040000 {
> +				compatible = "arm,pl041", "arm,primecell";
> +				reg = <0x040000 0x1000>;
> +				interrupts = <11>;
> +			};
> +
> +			mmci at 050000 {
> +				compatible = "arm,pl180", "arm,primecell";
> +				reg = <0x050000 0x1000>;
> +				interrupts = <9 10>;
> +			};
> +
> +			kmi at 060000 {
> +				compatible = "arm,pl050", "arm,primecell";
> +				reg = <0x060000 0x1000>;
> +				interrupts = <12>;
> +			};
> +
> +			kmi at 070000 {
> +				compatible = "arm,pl050", "arm,primecell";
> +				reg = <0x070000 0x1000>;
> +				interrupts = <13>;
> +			};
> +
> +			uart0: uart at 090000 {

Use generic names:

s/uart/serial/

> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x090000 0x1000>;
> +				interrupts = <5>;
> +			};
> +
> +			uart1: uart at 0a0000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x0a0000 0x1000>;
> +				interrupts = <6>;
> +			};
> +
> +			uart2: uart at 0b0000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x0b0000 0x1000>;
> +				interrupts = <7>;
> +			};
> +
> +			uart3: uart at 0c0000 {
> +				compatible = "arm,pl011", "arm,primecell";
> +				reg = <0x0c0000 0x1000>;
> +				interrupts = <8>;
> +			};
> +
> +			wdt at 0f0000 {
> +				compatible = "arm,sp805", "arm,primecell";
> +				reg = <0x0f0000 0x1000>;
> +				interrupts = <0>;
> +			};
> +
> +			timer01: timer at 110000 {
> +				compatible = "arm,sp804", "arm,primecell";
> +				reg = <0x110000 0x1000>;
> +				interrupts = <2>;
> +			};
> +
> +			timer23: timer at 120000 {
> +				compatible = "arm,sp804", "arm,primecell";
> +				reg = <0x120000 0x1000>;
> +			};
> +
> +			/* DVI I2C bus */
> +			i2c1: i2c at 160000 {
> +				compatible = "arm,versatile-i2c";
> +				reg = <0x160000 0x1000>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				dvi-switch-a at 39 {
> +					compatible = "sil,sii9022";
> +					reg = <0x39>;
> +				};
> +
> +				dvi-switch-b at 60 {
> +					compatible = "sil,sii9022";
> +					reg = <0x60>;
> +				};
> +			};
> +
> +			rtc at 170000 {
> +				compatible = "arm,pl031", "arm,primecell";
> +				reg = <0x170000 0x1000>;
> +				interrupts = <4>;
> +			};
> +
> +			compact-flash at 1a0000 {
> +				compatible = "ata-generic";
> +				reg = <0x1a0000 0x100
> +				       0x1a0100 0xf00>;
> +				reg-shift = <2>;
> +			};
> +
> +			clcd at 1f0000 {
> +				compatible = "arm,pl111", "arm,primecell";
> +				reg = <0x1f0000 0x1000>;
> +				interrupts = <14>;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> new file mode 100644
> index 0000000..2614c75
> --- /dev/null
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
> @@ -0,0 +1,121 @@
> +/*
> + * ARM Ltd. Versatile Express
> + *
> + * Coretile Express A5x2
> + * Cortex-A5 MPCore (V2P-CA5s)
> + *
> + * HBI-0225B
> + */
> +
> +/dts-v1/;
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "V2P-CA5s";
> +	compatible = "arm,vexpress-v2p-ca5s", "arm,vexpress";
> +	interrupt-parent = <&gic>;
> +
> +	memory {

memory at 80000000

> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	hdlcd at 2a110000 {
> +		compatible = "arm,hdlcd";
> +		reg = <0x2a110000 0x1000>;
> +		interrupts = <0 85 4>;
> +	};
> +	
> +	dmc at 2a150000 {
> +		compatible = "arm,pl341", "arm,primecell";
> +		reg = <0x2a150000 0x1000>;
> +	};
> +
> +	smc at 2a190000 {
> +		compatible = "arm,pl354", "arm,primecell";
> +		reg = <0x2a190000 0x1000>;
> +		interrupts = <0 86 4>,
> +			     <0 87 4>;
> +	};
> +
> +	gic: interrupt-controller at 2c001000 {
> +		compatible = "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0x2c001000 0x1000>,
> +		      <0x2c000100 0x100>;
> +	};
> +
> +	L2: cache-controller at 2c0f0000 {
> +		compatible = "arm,pl310-cache";
> +		reg = <0x2c0f0000 0x1000>;
> +		interrupts = <0 84 4>;
> +		cache-level = <2>;
> +		arm,data-latency = <0>;
> +		arm,tag-latency = <0>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a5-pmu";
> +		interrupts = <0 68 4>,
> +			     <0 69 4>;
> +	};
> +
> +	motherboard {
> +		ranges = <0 0 0x08000000 0x04000000>,
> +			 <1 0 0x14000000 0x04000000>,
> +			 <2 0 0x18000000 0x04000000>,
> +			 <3 0 0x1c000000 0x04000000>,
> +			 <4 0 0x0c000000 0x04000000>,
> +			 <5 0 0x10000000 0x04000000>;
> +
> +		interrupt-map-mask = <0 0 63>;
> +		interrupt-map = <0 0  0 &gic 0  0 4>,
> +				<0 0  1 &gic 0  1 4>,
> +				<0 0  2 &gic 0  2 4>,
> +				<0 0  3 &gic 0  3 4>,
> +				<0 0  4 &gic 0  4 4>,
> +				<0 0  5 &gic 0  5 4>,
> +				<0 0  6 &gic 0  6 4>,
> +				<0 0  7 &gic 0  7 4>,
> +				<0 0  8 &gic 0  8 4>,
> +				<0 0  9 &gic 0  9 4>,
> +				<0 0 10 &gic 0 10 4>,
> +				<0 0 11 &gic 0 11 4>,
> +				<0 0 12 &gic 0 12 4>,
> +				<0 0 13 &gic 0 13 4>,
> +				<0 0 14 &gic 0 14 4>,
> +				<0 0 15 &gic 0 15 4>,
> +				<0 0 16 &gic 0 16 4>,
> +				<0 0 17 &gic 0 17 4>,
> +				<0 0 18 &gic 0 18 4>,
> +				<0 0 19 &gic 0 19 4>,
> +				<0 0 20 &gic 0 20 4>,
> +				<0 0 21 &gic 0 21 4>,
> +				<0 0 22 &gic 0 22 4>,
> +				<0 0 23 &gic 0 23 4>,
> +				<0 0 24 &gic 0 24 4>,
> +				<0 0 25 &gic 0 25 4>,
> +				<0 0 26 &gic 0 26 4>,
> +				<0 0 27 &gic 0 27 4>,
> +				<0 0 28 &gic 0 28 4>,
> +				<0 0 29 &gic 0 29 4>,
> +				<0 0 30 &gic 0 30 4>,
> +				<0 0 31 &gic 0 31 4>,
> +				<0 0 32 &gic 0 32 4>,
> +				<0 0 33 &gic 0 33 4>,
> +				<0 0 34 &gic 0 34 4>,
> +				<0 0 35 &gic 0 35 4>,
> +				<0 0 36 &gic 0 36 4>,
> +				<0 0 37 &gic 0 37 4>,
> +				<0 0 38 &gic 0 38 4>,
> +				<0 0 39 &gic 0 39 4>,
> +				<0 0 40 &gic 0 40 4>,
> +				<0 0 41 &gic 0 41 4>,
> +				<0 0 42 &gic 0 42 4>;
> +	};
> +};
> +
> +/include/ "vexpress-v2m-rs1.dtsi"
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 9747125..e5d309e 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -22,6 +22,11 @@ config ARCH_VEXPRESS_DT
>  	bool
>  	select OF
>  
> +config ARCH_VEXPRESS_V2P_CA5S
> +	bool "CoreTile Express A5x2 (V2P-CA5s) - DT"
> +	select ARCH_VEXPRESS_RS1
> +	select ARCH_VEXPRESS_DT
> +
>  config ARCH_VEXPRESS_V2P_CA9
>  	bool "CoreTile Express A9x4 (V2P-CA9) - DT"
>  	select ARCH_VEXPRESS_LEGACY
> diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> index 9cc4a21..4d37963 100644
> --- a/arch/arm/mach-vexpress/Makefile
> +++ b/arch/arm/mach-vexpress/Makefile
> @@ -4,6 +4,7 @@
>  
>  obj-y					:= v2m.o
>  obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
> +obj-$(CONFIG_ARCH_VEXPRESS_V2P_CA5S)	+= v2p-ca5s.o
>  obj-$(CONFIG_ARCH_VEXPRESS_V2P_CA9)	+= v2p-ca9.o
>  obj-$(CONFIG_SMP)			+= platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> diff --git a/arch/arm/mach-vexpress/v2p-ca5s.c b/arch/arm/mach-vexpress/v2p-ca5s.c
> new file mode 100644
> index 0000000..46eec0c
> --- /dev/null
> +++ b/arch/arm/mach-vexpress/v2p-ca5s.c
> @@ -0,0 +1,97 @@
> +/*
> + * Device Tree based support for ARM Versatile Express board
> + * with CoreTile Express A5x2 (V2P-CA5s)
> + */
> +
> +#include <linux/init.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/smp_scu.h>
> +#include <asm/smp_twd.h>
> +#include <asm/hardware/cache-l2x0.h>
> +#include <asm/hardware/gic.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include "core.h"
> +
> +#define V2P_CA5_MPCORE_PERIPH	0x2c000000
> +
> +#define A5_MPCORE_SCU		0x0000
> +#define A5_MPCORE_TWD		0x0600
> +
> +static struct map_desc v2p_ca5s_io_desc[] __initdata = {
> +	{
> +		.virtual        = V2TILE_PERIPH,
> +		.pfn            = __phys_to_pfn(V2P_CA5_MPCORE_PERIPH),
> +		.length         = SZ_8K,
> +		.type           = MT_DEVICE,
> +	},
> +};
> +
> +#ifdef CONFIG_SMP
> +static void v2p_ca5s_init_cpu_map(void)
> +{
> +	int i, ncores = scu_get_core_count(V2TILE_PERIPH_P2V(A5_MPCORE_SCU));

This works on A9, does it work on A5? If not, an SCU binding should be
created.

	/* Get SCU base */
	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));

> +
> +	for (i = 0; i < ncores; ++i)
> +		set_cpu_possible(i, true);
> +
> +	set_smp_cross_call(gic_raise_softirq);
> +}
> +
> +static void v2p_ca5s_smp_enable(unsigned int max_cpus)
> +{
> +	scu_enable(V2TILE_PERIPH_P2V(A5_MPCORE_SCU));
> +}
> +#endif
> +
> +static void __init v2p_ca5s_map_io(void)
> +{
> +	v2m_dt_map_io(v2m_memory_map_rs1);
> +	iotable_init(v2p_ca5s_io_desc, ARRAY_SIZE(v2p_ca5s_io_desc));
> +#ifdef CONFIG_SMP
> +	vexpress_init_cpu_map = v2p_ca5s_init_cpu_map;
> +	vexpress_smp_enable = v2p_ca5s_smp_enable;
> +#endif
> +}
> +
> +static void __init v2p_ca5s_init_early(void)
> +{
> +#ifdef CONFIG_LOCAL_TIMERS
> +	twd_base = V2TILE_PERIPH_P2V(A5_MPCORE_TWD);
> +#endif
> +	v2m_dt_init_early();
> +}
> +
> +const static struct of_device_id v2p_ca5s_irq_match[] = {
> +	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> +	{}
> +};
> +
> +static void __init v2p_ca5s_init_irq(void)
> +{
> +	of_irq_init(v2p_ca5s_irq_match);
> +}
> +
> +static void __init v2p_ca5s_init(void)
> +{
> +	l2x0_of_init(0x00400000, 0xfe0fffff);
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +			v2m_dt_get_auxdata(v2m_memory_map_rs1), NULL);
> +}
> +
> +static const char *v2p_ca5s_dt_match[] __initdata = {
> +	"arm,vexpress-v2p-ca5s",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(VEXPRESS_V2P_CA5, "ARM Versatile Express V2P-CA5s")
> +	.map_io		= v2p_ca5s_map_io,
> +	.init_early	= v2p_ca5s_init_early,
> +	.init_irq	= v2p_ca5s_init_irq,
> +	.timer		= &v2m_timer,
> +	.init_machine	= v2p_ca5s_init,
> +	.dt_compat	= v2p_ca5s_dt_match,
> +MACHINE_END
