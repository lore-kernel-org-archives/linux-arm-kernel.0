From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 May 2018 10:59:06 +0530
Subject: [PATCH V3] ARM: dts: da850-evm: Enable LCD and Backlight
In-Reply-To: <20180513232033.22571-1-aford173@gmail.com>
References: <20180513232033.22571-1-aford173@gmail.com>
Message-ID: <aba13450-1e8f-4aed-6248-16b71abcc0dd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Monday 14 May 2018 04:50 AM, Adam Ford wrote:
> When using the board files the LCD works, but not with the DT.
> This adds enables the original da850-evm to work with the same
> LCD in device tree mode.
> 
> The EVM has a gpio for the regulator and a gpio enable.  The LCD and
> the vpif display pins are mutually exclusive, so if using the LCD,
> do not load the vpif driver.

Its not sufficient just note this in patch description.

a) Disable (status = "disabled") the VPIF node which clashes for pins
with LCD.
b) Add a comment on top of the status = "disabled" giving information on
how user can enable it (disable lcdc node and then change to status =
"okay").

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Fix errant GPIO, label GPIO pins, and rename the regulator to be more explict to
>      backlight which better matches the schematic.  Updated the description to explain
>      that it cannot be used at the same time as the vpif driver.
> 
> V2:  Add regulator and GPIO enable pins. Remove PWM backlight and replace with GPIO  
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 2e817da37fdb..3f1c8be07efe 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -27,6 +27,50 @@
>  		spi0 = &spi1;
>  	};
>  
> +	backlight {
> +		compatible = "gpio-backlight";
> +		enable-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>; /* GP0[7] */

The gpio-backlight binding does not describe a property called
enable-gpios. It should just be gpios.

a) Are you using gpio-backlight because you are not able to get the PWM
to work?

b) What is GP0[7] connected to in the schematic you have? In the
schematic I have I see LCD_PWM0 is connected to
SPI1_SCS[0]/EPWM1B/GP2[14]/TM64P3_IN12.

c) The /* GP0[7] */ comment is not really useful on its own as it can be
computed. What I wanted to see is the schematic symbol like "LCD_PWM0".
Same for other places like this below.

> @@ -35,6 +79,16 @@
>  		regulator-boot-on;
>  	};
>  
> +	backlight_reg: backlight-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_backlight_pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio 47 GPIO_ACTIVE_HIGH>; /* GP2[15] */
> +		regulator-always-on;

Why should this regulator never be disabled?

Thanks,
Sekhar
