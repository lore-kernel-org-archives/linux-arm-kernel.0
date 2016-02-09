From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 12:04 +0100
Subject: [PATCH 1/3] input: cygnus-update touchscreen dt node document
In-Reply-To: <1455008277-8312-2-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1455008277-8312-2-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <2631849.GeOulu78vx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 February 2016 14:27:55 Raveendra Padasalagi wrote:
> +
> +One of the below 2 property is mandatory.
> +- ts_syscon: handler of syscon node defining physical base address
> +  of the controller and length of memory mapped region.
> +  If this property is selected please make sure MFD_SYSCON config
> +  is enabled in the defconfig file.
> +or
> +- reg: physical base address of the controller and length of memory
> +  mapped region.
> +
>  - clocks:  The clock provided by the SOC to driver the tsc
>  - clock-name:  name for the clock
>  - interrupts: The touchscreen controller's interrupt
> @@ -54,12 +62,16 @@ Optional properties:
>  - touchscreen-inverted-y: Y axis is inverted (boolean)
>  
>  Example:
> +       ts_adc_syscon: ts_adc_syscon at 0x180a6000 {
> +               compatible = "syscon";
> +               reg = <0x180a6000 0xc30>;
> +       };
>  
>         touchscreen: tsc at 0x180A6000 {
>                 compatible = "brcm,iproc-touchscreen";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> -               reg = <0x180A6000 0x40>;
> +               syscon = <&ts_adc_syscon>;
>                 clocks = <&adc_clk>;
>                 clock-names = "tsc_clk";
>                 interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;

This doesn't seem right: For one thing, it's an incompatible binding
change which you should try to avoid.

Worse, the syscon has a name indicating that it really has a particular
function, but the name is completely generic (just "syscon"). Please
add a specific compatible string identifying the device that owns
the registers, and put any other associated properties (clocks,
interrupts, ...) that are for that device in general rather than just
the touchscreen in there.

Your changelog text fails to describe why you do this change in
the first place, and why you can't do it in a backward-compatible
way, so please rewrite that text.

	Arnd
