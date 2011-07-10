From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 10 Jul 2011 16:35:10 +0900
Subject: [PATCH] ARM: mmp: add DTS file
In-Reply-To: <1310120428-22700-12-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-9-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-10-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-11-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-12-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110710073510.GG10912@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 06:20:28PM +0800, Haojian Zhuang wrote:
> Add DTS file to support brownstone & ttc-dkb.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Hi Haojian.

Overall, the patch series is moving in the right direction.  I've made
a lot of comments, but they shouldn't be difficult to resolve.  I look
forward to seeing the next version of the series.  Comments below...

> ---
>  arch/arm/boot/dts/mmp2-brownstone.dts |  319 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/ttc-dkb.dts         |  176 ++++++++++++++++++
>  arch/arm/mach-mmp/brownstone.c        |   66 ++-----
>  arch/arm/mach-mmp/ttc_dkb.c           |   21 ++-
>  4 files changed, 530 insertions(+), 52 deletions(-)
>  create mode 100644 arch/arm/boot/dts/mmp2-brownstone.dts
>  create mode 100644 arch/arm/boot/dts/ttc-dkb.dts
> 
> diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
> new file mode 100644
> index 0000000..5fdabc3
> --- /dev/null
> +++ b/arch/arm/boot/dts/mmp2-brownstone.dts
> @@ -0,0 +1,319 @@
> +/dts-v1/;
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "Marvell MMP2 Brownstone";
> +	compatible = "mrvl,mmp2-brownstone", "mrvl,armada610-brownstone";

You've already heard me harp on this, but I'll say it one more time
and then shut up.  Every new compatible property must be documented as
to what it means.

> +	interrupt-parent = <&mmp_intc>;
> +
> +	memory {
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:192.168.1.101::255.255.255.0::eth0:on";
> +		linux,stdout-path = &uart2;
> +	};
> +
> +	soc at d4000000 {
> +		compatible = "mrvl,mmp2", "mrvl,armada610", "simple-bus";
> +		device_type = "soc";

Drop device_type.

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mmp_intc: interrupt-controller at d4282000 {
> +			compatible = "mrvl,mmp-intc";
> +			/*device_type = "intc";*/

Even the commented out device_type should be removed.  :-)

> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			/*
> +			 * interrupts: irq index of parent's irq domain
> +			 */
> +			interrupts = <0>;

Drop this property.  Linux gets to decide what the first irq should
be.  It isn't a characteristic of hardware, and 'interrupts' already
has a strict definition.

> +			interrupt-parent = <&mmp_intc>;

Drop this, it doesn't make sense for an interrupt controller to claim
itself as its interrupt parent.

> +			sub-interrupts = <64>;

What is this for?

> +
> +			/* enable bits in conf register */
> +			enable_mask = <0x20>;

Convention is to not use underscore '_' in property names.  Use a dash '-' instead.
> +
> +			/* reg: <offset & size> */
> +			reg = <0xd4282000 0x400>;
> +		};
> +
> +		mux_intc4: interrupt-controller at d4282150 {
> +			compatible = "mrvl,mux-intc";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			interrupts = <4>;
> +			interrupt-parent = <&mmp_intc>;

This line can be dropped since the root node already has mmp_intc as
the default interrupt parent.

> +			sub-interrupts = <2>;
> +			reg = <0xd4282150 0>;
> +			status-mask = <0x150 0x168>;
> +			/* mfp register & interrupt index */
> +			mfp-edge-interrupt = <0xd401e2c4 1>;
> +		};
[...]
> +		gpio: gpio-controller {
> +			compatible = "pxa,gpio";

mrvl,pxa255-gpio, or similar.

> +			gpio-controller;
> +			reg = <
> +				0xd4019000 0xb0
> +				0xd4019004 0xb0
> +				0xd4019008 0xb0
> +				0xd4019100 0xb0
> +				0xd4019104 0xb0
> +				0xd4019108 0xb0>;

This looks wrong.  The address ranges overlap.  Why not simply:
<0xd4019000 0x200>;

> +
> +			/* gpio-clk-value: <offset & value> */
> +			gpio-clk-value = <0xd4015038 0x3>;
> +
> +			/* gpio-mask: <offset & value> */
> +			gpio-mask = <
> +				0xd401909c 0xffffffff
> +				0xd40190a0 0xffffffff
> +				0xd40190a4 0xffffffff
> +				0xd401919c 0xffffffff
> +				0xd40191a0 0xffffffff
> +				0xd40191a4 0xffffffff>;
> +			gpio-pins = <0 192>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			interrupts = <49>;
> +			interrupt-parent = <&mmp_intc>;
> +			sub-interrupts = <192>;
> +		};

[...]

> diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
> index 7bb78fd..c9848ad 100644
> --- a/arch/arm/mach-mmp/brownstone.c
> +++ b/arch/arm/mach-mmp/brownstone.c
> @@ -12,6 +12,9 @@
>  
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/gpio.h>
> @@ -105,30 +108,6 @@ static unsigned long brownstone_pin_config[] __initdata = {
>  	GPIO89_GPIO,
>  };
>  
> -static struct regulator_consumer_supply max8649_supply[] = {
> -	REGULATOR_SUPPLY("vcc_core", NULL),
> -};
> -
> -static struct regulator_init_data max8649_init_data = {
> -	.constraints	= {
> -		.name		= "vcc_core range",
> -		.min_uV		= 1150000,
> -		.max_uV		= 1280000,
> -		.always_on	= 1,
> -		.boot_on	= 1,
> -		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
> -	},
> -	.num_consumer_supplies	= 1,
> -	.consumer_supplies	= &max8649_supply[0],
> -};
> -
> -static struct max8649_platform_data brownstone_max8649_info = {
> -	.mode		= 2,	/* VID1 = 1, VID0 = 0 */
> -	.extclk		= 0,
> -	.ramp_timing	= MAX8649_RAMP_32MV,
> -	.regulator	= &max8649_init_data,
> -};
> -
>  static struct regulator_consumer_supply brownstone_v_5vp_supplies[] = {
>  	REGULATOR_SUPPLY("v_5vp", NULL),
>  };
> @@ -158,47 +137,38 @@ static struct platform_device brownstone_v_5vp_device = {
>  	},
>  };
>  
> -static struct max8925_platform_data brownstone_max8925_info = {
> -	.irq_base		= IRQ_BOARD_START,
> -};
> -
> -static struct i2c_board_info brownstone_twsi1_info[] = {
> -	[0] = {
> -		.type		= "max8649",
> -		.addr		= 0x60,
> -		.platform_data	= &brownstone_max8649_info,
> -	},
> -	[1] = {
> -		.type		= "max8925",
> -		.addr		= 0x3c,
> -		.irq		= IRQ_MMP2_PMIC,
> -		.platform_data	= &brownstone_max8925_info,
> -	},
> -};
> -
>  static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
>  	.max_speed	= 25000000,
>  };
>  
> +static __initdata struct of_device_id of_bus_ids[] = {
> +	{ .compatible = "simple-bus", },
> +	{},
> +};
> +
>  static void __init brownstone_init(void)
>  {
>  	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
>  
> -	/* on-chip devices */
> -	mmp2_add_uart(1);
> -	mmp2_add_uart(3);
> -	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
> +	if (of_platform_bus_probe(NULL, of_bus_ids, NULL) < 0)
> +		BUG();
> +
>  	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
>  
>  	/* enable 5v regulator */
>  	platform_device_register(&brownstone_v_5vp_device);
>  }
>  
> +static const char *brownstone_dt_match[] __initdata = {
> +	"mrvl,mmp2-brownstone",
> +	NULL,
> +};
> +
>  MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
>  	/* Maintainer: Haojian Zhuang <haojian.zhuang@marvell.com> */
>  	.map_io		= mmp_map_io,
> -	.nr_irqs	= BROWNSTONE_NR_IRQS,
> -	.init_irq	= mmp2_init_irq,
> +	.init_irq	= mmp_init_intc,
>  	.timer		= &mmp2_timer,
>  	.init_machine	= brownstone_init,
> +	.dt_compat	= brownstone_dt_match,
>  MACHINE_END

I suggest instead of directly modifying the brownstone board file,
create a new DT board file, make it support the brownstone and other
boards, than then remove the old board files when the DT
implementation is equal to the non-dt version.

> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index e411039..c19b4dc 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -10,6 +10,9 @@
>  
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -113,21 +116,31 @@ static struct platform_device *ttc_dkb_devices[] = {
>  	&ttc_dkb_device_onenand,
>  };
>  
> +static __initdata struct of_device_id of_bus_ids[] = {
> +	{ .compatible = "simple-bus", },
> +	{},
> +};
> +
>  static void __init ttc_dkb_init(void)
>  {
>  	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
>  
> -	/* on-chip devices */
> -	pxa910_add_uart(1);
> +	if (of_platform_bus_probe(NULL, of_bus_ids, NULL) < 0)
> +		BUG();
>  
>  	/* off-chip devices */
>  	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
>  }
>  
> +static const char *ttc_dkb_dt_match[] __initdata = {
> +	"mrvl,ttc-dkb",
> +	NULL,
> +};
> +
>  MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
>  	.map_io		= mmp_map_io,
> -	.nr_irqs	= TTCDKB_NR_IRQS,
> -	.init_irq       = pxa910_init_irq,
> +	.init_irq       = mmp_init_intc,
>  	.timer          = &pxa910_timer,
>  	.init_machine   = ttc_dkb_init,
> +	.dt_compat	= ttc_dkb_dt_match,
>  MACHINE_END
> -- 
> 1.5.6.5
> 
