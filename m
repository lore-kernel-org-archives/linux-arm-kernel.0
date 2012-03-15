From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 15 Mar 2012 13:49:54 +0530
Subject: [PATCH v2] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <1331737232-25477-1-git-send-email-sr@denx.de>
References: <1331737232-25477-1-git-send-email-sr@denx.de>
Message-ID: <4F61A62A.3040501@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stefan,

Thanks for your patch. :)

I have looked carefully at the patch, regarding addresses and irq numbers,
and they look fine. Just few minor comments below:

On 3/14/2012 8:30 PM, Stefan Roese wrote:

> diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi

> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               ranges;
> +

> +
> +               gmac0: ethernet at e0800000 {

There is no gmac1, so can name it gmac only.

> +                       compatible = "st,spear600-gmac";
> +                       reg = <0xe0800000 0x8000>;
> +                       interrupt-parent = <&vic1>;
> +                       interrupts = <24 23>;
> +                       interrupt-names = "macirq", "eth_wake_irq";
> +                       mac-address = [000000000000]; /* Filled in by U-Boot */
> +               };
> +

> +               fsmc0: flash at d1800000 {

same.

> +                       status = "disabled";
> +                       compatible = "st,spear600-fsmc-nand";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       reg = <0xd1800000 0x1000        /* FSMC Register */
> +                              0xd2000000 0x4000>;      /* NAND Base */
> +                       reg-names = "fsmc_regs", "nand_data";
> +               };
> +
> +               smi0: flash at fc000000 {

same

> +                       status = "disabled";
> +                       compatible = "st,spear600-smi";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       reg = <0xfc000000 0x1000>;
> +                       interrupt-parent = <&vic1>;
> +                       interrupts = <12>;
> +               };
> +

> diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
> index c6e4254..c4949aa 100644
> --- a/arch/arm/mach-spear6xx/spear600_evb.c
> +++ b/arch/arm/mach-spear6xx/spear600_evb.c
> @@ -32,9 +32,6 @@ static void __init spear600_evb_init(void)
>  {
>         unsigned int i;
> 

Why don't we remove the devices from arrays above, which are now
supported by DT?

> -       /* call spear600 machine init function */
> -       spear600_init();
> -
>         /* Add Platform Devices */
>         platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
> 
> diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c

> +static const struct of_device_id vic_of_match[] __initconst = {
> +       { .compatible = "arm,pl190-vic", .data = vic_of_init, },
> +       { /* Sentinel */ }
> +};
> +
> +static void __init spear6xx_dt_init_irq(void)
> +{
> +       of_irq_init(vic_of_match);
> +}
> +

Did you checked this out?

-- 
viresh
