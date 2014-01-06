From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 06 Jan 2014 10:27:35 +0100
Subject: [PATCH v3] ARM: prima2: move to generic reset controller driver
 framework
In-Reply-To: <1388998927-9227-1-git-send-email-21cnbao@gmail.com>
References: <1388998927-9227-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1389000455.5590.4.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

Am Montag, den 06.01.2014, 17:02 +0800 schrieb Barry Song:
> this moves to generic IP module reset framework, and make other drivers
> use common device_reset() API.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> ---
>  -v3:
>  rebase to 3.13-rc;
>  add dt-binding document;
>  correct reset bit set for each module by Bin Shi
> 
>  .../devicetree/bindings/reset/sirf,rstc.txt        |   42 +++++++++++
>  arch/arm/boot/dts/atlas6.dtsi                      |    3 +-
>  arch/arm/boot/dts/marco.dtsi                       |    3 +-
>  arch/arm/boot/dts/prima2.dtsi                      |    3 +-
>  arch/arm/mach-prima2/Kconfig                       |    1 +
>  arch/arm/mach-prima2/common.c                      |   12 +++-
>  arch/arm/mach-prima2/common.h                      |    1 +
>  arch/arm/mach-prima2/rstc.c                        |   80 +++++++++++--------
>  8 files changed, 107 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/sirf,rstc.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/sirf,rstc.txt b/Documentation/devicetree/bindings/reset/sirf,rstc.txt
> new file mode 100644
> index 0000000..0505de7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/sirf,rstc.txt
> @@ -0,0 +1,42 @@
> +CSR SiRFSoC Reset Controller
> +======================================
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible: Should be "sirf,prima2-rstc" or "sirf,marco-rstc"
> +- reg: should be register base and length as documented in the
> +  datasheet
> +- #reset-cells: 1, see below
> +
> +example:
> +
> +rstc: reset-controller at 88010000 {
> +	compatible = "sirf,prima2-rstc";
> +	reg = <0x88010000 0x1000>;
> +	#reset-cells = <1>;
> +};
> +
> +Specifying reset lines connected to IP modules
> +==============================================
> +
> +The reset controller(rstc) manages various reset sources. This module provides
> +reset signals for most blocks in system. Those device nodes should specify the
> +reset line on the rstc in their resets property, containing a phandle to the
> +rstc device node and a RESET_INDEX specifying which module to reset, as described
> +in reset.txt.
> +
> +For SiRFSoC, RESET_INDEX is just reset_bit defined in SW_RST0 and SW_RST1 registers.
> +For modules whose rest_bit is in SW_RST0, its RESET_INDEX is 0~31. For modules whose
> +rest_bit is in SW_RST1, its RESET_INDEX is 32~63.
> +
> +example:
> +
> +vpp at 90020000 {
> +	compatible = "sirf,prima2-vpp";
> +	reg = <0x90020000 0x10000>;
> +	interrupts = <31>;
> +	clocks = <&clks 35>;
> +	resets = <&rstc 6>;
> +};
> diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
> index 978bab4..b63cfef 100644
> --- a/arch/arm/boot/dts/atlas6.dtsi
> +++ b/arch/arm/boot/dts/atlas6.dtsi
> @@ -56,9 +56,10 @@
>  				#clock-cells = <1>;
>  			};
>  
> -			reset-controller at 88010000 {
> +			rstc: reset-controller at 88010000 {
>  				compatible = "sirf,prima2-rstc";
>  				reg = <0x88010000 0x1000>;
> +				#reset-cells = <1>;
>  			};
>  
>  			rsc-controller at 88020000 {
> diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
> index 1579c34..0c9647d 100644
> --- a/arch/arm/boot/dts/marco.dtsi
> +++ b/arch/arm/boot/dts/marco.dtsi
> @@ -58,9 +58,10 @@
>  			#size-cells = <1>;
>  			ranges = <0xc2000000 0xc2000000 0x1000000>;
>  
> -			reset-controller at c2000000 {
> +			rstc: reset-controller at c2000000 {
>  				compatible = "sirf,marco-rstc";
>  				reg = <0xc2000000 0x10000>;
> +				#reset-cells = <1>;
>  			};
>  		};
>  
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index daee5894..b292a5c 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -67,9 +67,10 @@
>  				#clock-cells = <1>;
>  			};
>  
> -			reset-controller at 88010000 {
> +			rstc: reset-controller at 88010000 {
>  				compatible = "sirf,prima2-rstc";
>  				reg = <0x88010000 0x1000>;
> +				#reset-cells = <1>;
>  			};
>  
>  			rsc-controller at 88020000 {
> diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
> index 6988b11..f37a1de 100644
> --- a/arch/arm/mach-prima2/Kconfig
> +++ b/arch/arm/mach-prima2/Kconfig
> @@ -1,5 +1,6 @@
>  config ARCH_SIRF
>  	bool "CSR SiRF" if ARCH_MULTI_V7
> +	select ARCH_HAS_RESET_CONTROLLER
>  	select ARCH_REQUIRE_GPIOLIB
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_IRQ_CHIP
> diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
> index d49aff7..1b6f676 100644
> --- a/arch/arm/mach-prima2/common.c
> +++ b/arch/arm/mach-prima2/common.c
> @@ -15,7 +15,14 @@
>  #include <linux/of_platform.h>
>  #include "common.h"
>  
> -void __init sirfsoc_init_late(void)
> +static void __init sirfsoc_init_mach(void)
> +{
> +        sirfsoc_of_rstc_init();
> +        of_platform_populate(NULL, of_default_bus_match_table,
> +                NULL, NULL);
> +}
> +
> +static void __init sirfsoc_init_late(void)
>  {
>  	sirfsoc_pm_init();
>  }
> @@ -35,6 +42,7 @@ static const char *atlas6_dt_match[] __initdata = {
>  DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
>  	/* Maintainer: Barry Song <baohua.song@csr.com> */
>  	.map_io         = sirfsoc_map_io,
> +	.init_machine   = sirfsoc_init_mach,
>  	.init_late	= sirfsoc_init_late,
>  	.dt_compat      = atlas6_dt_match,
>  	.restart	= sirfsoc_restart,
> @@ -51,6 +59,7 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
>  	/* Maintainer: Barry Song <baohua.song@csr.com> */
>  	.map_io         = sirfsoc_map_io,
>  	.dma_zone_size	= SZ_256M,
> +	.init_machine   = sirfsoc_init_mach,
>  	.init_late	= sirfsoc_init_late,
>  	.dt_compat      = prima2_dt_match,
>  	.restart	= sirfsoc_restart,
> @@ -67,6 +76,7 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
>  	/* Maintainer: Barry Song <baohua.song@csr.com> */
>  	.smp            = smp_ops(sirfsoc_smp_ops),
>  	.map_io         = sirfsoc_map_io,
> +	.init_machine   = sirfsoc_init_mach,
>  	.init_late	= sirfsoc_init_late,
>  	.dt_compat      = marco_dt_match,
>  	.restart	= sirfsoc_restart,
> diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
> index 4b76806..0896efd 100644
> --- a/arch/arm/mach-prima2/common.h
> +++ b/arch/arm/mach-prima2/common.h
> @@ -22,6 +22,7 @@ extern struct smp_operations   sirfsoc_smp_ops;
>  extern void sirfsoc_secondary_startup(void);
>  extern void sirfsoc_cpu_die(unsigned int cpu);
>  
> +extern void __init sirfsoc_of_rstc_init(void);
>  extern void __init sirfsoc_of_irq_init(void);
>  extern void sirfsoc_restart(enum reboot_mode, const char *);
>  extern asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs);
> diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
> index ccb5339..d2d777f 100644
> --- a/arch/arm/mach-prima2/rstc.c
> +++ b/arch/arm/mach-prima2/rstc.c
> @@ -14,56 +14,34 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/reboot.h>
> +#include <linux/reset-controller.h>
> +
> +#define SIRFSOC_RSTBIT_NUM	64
>  
>  void __iomem *sirfsoc_rstc_base;
>  static DEFINE_MUTEX(rstc_lock);
>  
> -static struct of_device_id rstc_ids[]  = {
> -	{ .compatible = "sirf,prima2-rstc" },
> -	{ .compatible = "sirf,marco-rstc" },
> -	{},
> -};
> -
> -static int __init sirfsoc_of_rstc_init(void)
> -{
> -	struct device_node *np;
> -
> -	np = of_find_matching_node(NULL, rstc_ids);
> -	if (!np) {
> -		pr_err("unable to find compatible sirf rstc node in dtb\n");
> -		return -ENOENT;
> -	}
> -
> -	sirfsoc_rstc_base = of_iomap(np, 0);
> -	if (!sirfsoc_rstc_base)
> -		panic("unable to map rstc cpu registers\n");
> -
> -	of_node_put(np);
> -
> -	return 0;
> -}
> -early_initcall(sirfsoc_of_rstc_init);
> -
> -int sirfsoc_reset_device(struct device *dev)
> +static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
> +					unsigned long sw_reset_idx)
>  {
> -	u32 reset_bit;
> +	u32 reset_bit = sw_reset_idx;
>  
> -	if (of_property_read_u32(dev->of_node, "reset-bit", &reset_bit))

It seems switching to the reset controller framework is an incompatible
device tree change. I take it this is not an issue because the old
binding was never documented / is not used in the wild?
If so, apart from a few whitespace issues, this looks good to me.

regards
Philipp
