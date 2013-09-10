From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Tue, 10 Sep 2013 15:48:04 -0300
Subject: [PATCH ] ARM: sunxi: Add Emac,SMP and Arch_timer support for
 sunxi A20;Add phy cnt arch timer for ARMv7 support.
In-Reply-To: <16b7467c.1f121.141089f3d81.Coremail.coosty@163.com>
References: <16b7467c.1f121.141089f3d81.Coremail.coosty@163.com>
Message-ID: <522F6964.9060603@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 10/09/13 13:05, cini escribi?:
>
> It has been tested on a Cubieboard 2. To use SMP you must set ARM_ARCH_TIMER and ARM_ARCH_TIMER_USE_PHYCNT when make xconfig.
> If you have any questions or comments please feel free to contact me.  Have a wonderful day!

First of all, thanks for working on this! It is very much appreciated :)

Having said that, it would be nice to get properly split git patches, 
with a description and signoff tag. You can read 
Documentation/SubmittingPatches on the kernel tree (I think it's a bit 
outdated, but it covers the basics), or watch this video from Greg which 
explains it nicely:

https://www.youtube.com/watch?v=LLBrBBImJt4

> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   arch/arm/mach-sunxi/headsmp.S
> #	new file:   arch/arm/mach-sunxi/platform.h
> #	new file:   arch/arm/mach-sunxi/platsmp.c

I couldn't find these files on either of your emails by the way

> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #	modified:   arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> #	modified:   arch/arm/boot/dts/sun7i-a20.dtsi
> #	modified:   arch/arm/include/asm/arch_timer.h
> #	modified:   arch/arm/mach-sunxi/Makefile
> #	modified:   arch/arm/mach-sunxi/sunxi.c
> #	modified:   drivers/clocksource/Kconfig
> #	modified:   drivers/clocksource/arm_arch_timer.c
>
>
>
>
>
>
>
>
> 1 Add Emac,SMP and Arch_timer support for sunxi A20 patch:
>
>
>
>
>
>
>
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> old mode 100644
> new mode 100755
> index 31b76f0..2e9c57c
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -19,6 +19,22 @@
>   	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
>
>   	soc at 01c00000 {
> +		emac: ethernet at 01c0b000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&emac_pins_a>;
> +			phy = <&phy1>;
> +			status = "okay";
> +		};
> +
> +		mdio at 01c0b080 {
> +			status = "okay";
> +
> +			phy1: ethernet-phy at 1 {
> +				reg = <1>;
> +			};
> +		};
> +	
> +	
>   		pinctrl at 01c20800 {
>   			led_pins_cubieboard2: led_pins at 0 {
>   				allwinner,pins = "PH20", "PH21";
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> old mode 100644
> new mode 100755
> index 999ff45..4c7dd37
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -20,16 +20,18 @@
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>
> -		cpu at 0 {
> +		cpu0: cpu at 0  {
>   			compatible = "arm,cortex-a7";
>   			device_type = "cpu";
>   			reg = <0>;
> +			clock-frequency = <1000000000>;

Is this frequency correct? I thought A20 cores ran on 900-something MHz

>   		};
>
> -		cpu at 1 {
> +		cpu1: cpu at 1 {
>   			compatible = "arm,cortex-a7";
>   			device_type = "cpu";
>   			reg = <1>;
> +			clock-frequency = <1000000000>;			
>   		};
>   	};
>
> @@ -161,12 +163,36 @@
>   		};
>   	};
>
> +
> +
>   	soc at 01c00000 {
>   		compatible = "simple-bus";
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		ranges;
>
> +		cc: cpuconfig at 01c25c00 {
> +			compatible = "allwinner,sun7i-cc";
> +			reg = <0x01c25c00 0x400>;
> +		};
> +
> +		emac: ethernet at 01c0b000 {
> +			compatible = "allwinner,sun4i-emac";
> +			reg = <0x01c0b000 0x1000>;
> +			interrupts = <0 55 1>;
> +			clocks = <&ahb_gates 17>;
> +			status = "disabled";
> +		};
> +
> +		mdio: mdio at 01c0b080 {
> +			compatible = "allwinner,sun4i-mdio";
> +			reg = <0x01c0b080 0x14>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +
>   		pio: pinctrl at 01c20800 {
>   			compatible = "allwinner,sun7i-a20-pinctrl";
>   			reg = <0x01c20800 0x400>;
> @@ -198,6 +224,18 @@
>   				allwinner,drive = <0>;
>   				allwinner,pull = <0>;
>   			};
> +
> +			emac_pins_a: emac0 at 0 {
> +				allwinner,pins = "PA0", "PA1", "PA2",
> +						"PA3", "PA4", "PA5", "PA6",
> +						"PA7", "PA8", "PA9", "PA10",
> +						"PA11", "PA12", "PA13", "PA14",
> +						"PA15", "PA16";
> +				allwinner,function = "emac";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};			
> +			
>   		};
>
>   		timer at 01c20c00 {
> @@ -307,5 +345,15 @@
>   			#interrupt-cells = <3>;
>   			interrupts = <1 9 0xf04>;
>   		};
> +		
> +		timer {
> +			compatible ="arm,armv7-timer";
> +			interrupts = <1 13 0x308>,
> +				     <1 14 0x308>,
> +				     <1 11 0x308>,
> +				     <1 10 0x308>;
> +			clock-frequency = <24000000>;
> +		};		
> +		
>   	};
>   };
> diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
> index 93bebfc..d7f1ef4 100644
> --- a/arch/arm/mach-sunxi/Makefile
> +++ b/arch/arm/mach-sunxi/Makefile
> @@ -1 +1,3 @@
>   obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
> +obj-$(CONFIG_ARCH_SUNXI) += platsmp.o
> +obj-$(CONFIG_ARCH_SUNXI) += headsmp.o
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> old mode 100644
> new mode 100755
> index e79fb34..b6ccf20
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -137,8 +137,10 @@ static const char * const sunxi_board_dt_compat[] = {
>   	"allwinner,sun7i-a20",
>   	NULL,
>   };
> +extern struct smp_operations sunxi7i_smp_ops;
>
>   DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
> +	.smp		= smp_ops(sunxi7i_smp_ops),	
>   	.init_machine	= sunxi_dt_init,
>   	.init_time	= sunxi_timer_init,
>   	.dt_compat	= sunxi_board_dt_compat,
>
>
>
>
>
>
>
>
> /***************************************************/
> /***************************************************/
> /***************************************************/
> 2 Add phy cnt arch timer for ARMv7 support:
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> old mode 100644
> new mode 100755
> index 5665134..24c904a
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -87,6 +87,17 @@ static inline u64 arch_counter_get_cntvct(void)
>   	return cval;
>   }
>
> +static inline u64 arch_counter_get_cntpct(void)
> +{
> +	u64 cval;
> +
> +	isb();
> +	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (cval));
> +	return cval;
> +}
> +
> +
> +
>   static inline void arch_counter_set_user_access(void)
>   {
>   	u32 cntkctl;
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> old mode 100644
> new mode 100755
> index 41c6946..ae67190
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -109,3 +109,12 @@ config VF_PIT_TIMER
>   	bool
>   	help
>   	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
> +menu "Clock Source"
> +
> +config ARM_ARCH_TIMER_USE_PHYCNT
> +	bool "Use Physical Count Timer"
> +	depends on ARM_ARCH_TIMER
> +	---help---
> +          If bootloader dont set Virtual Offset register,Physical Count Timer is needed to replace Virtual Count Timer.
> +
> +endmenu	
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> old mode 100644
> new mode 100755
> index fbd9ccd..e2fc20a
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -372,7 +372,11 @@ static u64 arch_counter_get_cntvct_mem(void)
>    * to exist on arm64. arm doesn't use this before DT is probed so even
>    * if we don't have the cp15 accessors we won't have a problem.
>    */
> -u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
> +#ifdef CONFIG_ARM_ARCH_TIMER_USE_PHYCNT
> +	u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntpct;
> +#else
> +	u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
> +#endif

This will certainly not play nice with multiplatform kernel. Is this 
something we can fix on u-boot to use the virtual count timer as the 
rest of the platforms do?

Cheers,

Emilio
