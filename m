From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 26 Apr 2013 19:27:39 +0200 (CEST)
Subject: [PATCH 2/6] ARM: shmobile: add SDHI and MMCIF interfaces to
 armadillo800eva-reference
In-Reply-To: <1366993667-23294-3-git-send-email-g.liakhovetski@gmx.de>
References: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
 <1366993667-23294-3-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <Pine.LNX.4.64.1304261926040.32752@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon

On Fri, 26 Apr 2013, Guennadi Liakhovetski wrote:

> Add SDHI0, SDHI1 and MMCIF interfaces to armadillo800eva-reference. With
> no pinctrl DT support we cannot use GPIO card-detection and regulator
> switching.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

It should have been

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

actually, just like in all other patches in this series.

Thanks
Guennadi

> ---
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |   21 +++++++++++-
>  arch/arm/boot/dts/r8a7740.dtsi                     |   33 ++++++++++++++++++
>  .../board-armadillo800eva-reference.c              |   36 +++++++++++++++++++-
>  3 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> index 09ea22c..3752637 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> @@ -32,7 +32,6 @@
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> -
>  };
>  
>  &i2c0 {
> @@ -43,3 +42,23 @@
>  		interrupts = <2 0>; /* IRQ10: hwirq 2 on irqpin1 */
>  	};
>  };
> +
> +&mmcif0 {
> +	vmmc-supply = <&reg_3p3v>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&sdhi0 {
> +	vmmc-supply = <&reg_3p3v>;
> +	bus-width = <4>;
> +	broken-cd;
> +	status = "okay";
> +};
> +
> +&sdhi1 {
> +	vmmc-supply = <&reg_3p3v>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 25dc930..e9a90d8 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -135,4 +135,37 @@
>  			      0 72 0x4
>  			      0 73 0x4>;
>  	};
> +
> +	mmcif0: mmcif at e6bd0000 {
> +		compatible = "renesas,sh-mmcif", "renesas,sh7372-mmcif";
> +		reg = <0xe6bd0000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 56 4
> +				0 57 4>;
> +		status = "disabled";
> +	};
> +
> +	sdhi0: sdhi at e6850000 {
> +		compatible = "renesas,r8a7740-sdhi";
> +		reg = <0xe6850000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 117 4
> +				0 118 4
> +				0 119 4>;
> +		cap-sd-highspeed;
> +		cap-sdio-irq;
> +		status = "disabled";
> +	};
> +
> +	sdhi1: sdhi at e6860000 {
> +		compatible = "renesas,r8a7740-sdhi";
> +		reg = <0xe6860000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 121 4
> +				0 122 4
> +				0 123 4>;
> +		cap-sd-highspeed;
> +		cap-sdio-irq;
> +		status = "disabled";
> +	};
>  };
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> index 03b85fe..d26a9da 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> @@ -123,6 +123,27 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
>  	/* SCIFA1 */
>  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.1", "pfc-r8a7740",
>  				  "scifa1_data", "scifa1"),
> +	/* MMCIF */
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6bd0000.sh-mmcif", "pfc-r8a7740",
> +				  "mmc0_data8_1", "mmc0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6bd0000.sh-mmcif", "pfc-r8a7740",
> +				  "mmc0_ctrl_1", "mmc0"),
> +	/* SDHI0 */
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6850000.sdhi", "pfc-r8a7740",
> +				  "sdhi0_data4", "sdhi0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6850000.sdhi", "pfc-r8a7740",
> +				  "sdhi0_ctrl", "sdhi0"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6850000.sdhi", "pfc-r8a7740",
> +				  "sdhi0_wp", "sdhi0"),
> +	/* SDHI1 */
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6860000.sdhi", "pfc-r8a7740",
> +				  "sdhi1_data4", "sdhi1"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6860000.sdhi", "pfc-r8a7740",
> +				  "sdhi1_ctrl", "sdhi1"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6860000.sdhi", "pfc-r8a7740",
> +				  "sdhi1_cd", "sdhi1"),
> +	PIN_MAP_MUX_GROUP_DEFAULT("e6860000.sdhi", "pfc-r8a7740",
> +				  "sdhi1_wp", "sdhi1"),
>  };
>  
>  static void __init eva_clock_init(void)
> @@ -165,7 +186,6 @@ clock_error:
>   */
>  static void __init eva_init(void)
>  {
> -
>  	r8a7740_clock_init(MD_CK0 | MD_CK2);
>  	eva_clock_init();
>  
> @@ -180,6 +200,20 @@ static void __init eva_init(void)
>  	 */
>  	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
>  
> +	/* SDHI0 */
> +	gpio_request_one(17, GPIOF_OUT_INIT_LOW, NULL);  /* SDHI0_18/33_B */
> +	gpio_request_one(74, GPIOF_OUT_INIT_HIGH, NULL); /* SDHI0_PON */
> +	gpio_request_one(75, GPIOF_OUT_INIT_HIGH, NULL); /* SDSLOT1_PON */
> +
> +	/* We can switch CON8/CON14 by SW1.5, but only after DBGMD_SELECT_B */
> +	gpio_request_one(6, GPIOF_IN, NULL);
> +	if (!gpio_get_value(6)) {
> +		/* CON14 disabled, CON8 (SDHI1) enabled */
> +
> +		/* SDSLOT2_PON */
> +		gpio_request_one(16, GPIOF_OUT_INIT_HIGH, NULL);
> +	}
> +
>  #ifdef CONFIG_CACHE_L2X0
>  	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
>  	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
