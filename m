From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 15 Mar 2012 16:33:29 +0530
Subject: [PATCH v3] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <1331808632-22585-1-git-send-email-sr@denx.de>
References: <1331808632-22585-1-git-send-email-sr@denx.de>
Message-ID: <4F61CC81.1020902@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2012 4:20 PM, Stefan Roese wrote:

> diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi

> +/ {
> +       compatible = "st,spear600";
> +
> +       cpus {
> +               cpu at 0 {
> +                       compatible = "arm,arm926ejs";
> +               };
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0 0x40000000>; /* Real value updated by U-Boot */
> +       };
> +
> +       ahb {

What is the significance of this name? As i see gpio/spi etc in this list,
which are on apb bus.

> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               ranges;
> +

> +               /* local/cpu GPIO */
> +               gpio0: gpio at f0100000 {
> +                       #gpio-cells = <2>;
> +                       compatible = "arm,pl061", "arm,primecell";
> +                       gpio-controller;
> +                       reg = <0xf0100000 0x1000>;
> +                       interrupt-parent = <&vic0>;
> +                       interrupts = <18>;
> +               };
> +
> +               /* basic GPIO */
> +               gpio1: gpio at fc980000 {
> +                       #gpio-cells = <2>;
> +                       compatible = "arm,pl061", "arm,primecell";
> +                       gpio-controller;
> +                       reg = <0xfc980000 0x1000>;
> +                       interrupt-parent = <&vic1>;
> +                       interrupts = <19>;
> +               };
> +
> +               /* appl GPIO */
> +               gpio2: gpio at d8100000 {
> +                       #gpio-cells = <2>;
> +                       compatible = "arm,pl061", "arm,primecell";
> +                       gpio-controller;
> +                       reg = <0xd8100000 0x1000>;
> +                       interrupt-parent = <&vic1>;
> +                       interrupts = <4>;
> +               };
> +

> +};

> diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
> index ac70e0d..358f280 100644
> --- a/arch/arm/mach-spear6xx/clock.c
> +++ b/arch/arm/mach-spear6xx/clock.c
> @@ -641,8 +641,8 @@ static struct clk_lookup spear_clk_lookups[] = {
>         { .con_id = "gpt0_synth_clk",   .clk = &gpt0_synth_clk},
>         { .con_id = "gpt2_synth_clk",   .clk = &gpt2_synth_clk},
>         { .con_id = "gpt3_synth_clk",   .clk = &gpt3_synth_clk},
> -       { .dev_id = "uart0",            .clk = &uart0_clk},
> -       { .dev_id = "uart1",            .clk = &uart1_clk},
> +       { .dev_id = "d0000000.serial",  .clk = &uart0_clk},
> +       { .dev_id = "d0080000.serial",  .clk = &uart1_clk},

I didn't got Jean's comment at that time, but now it is ultra clear.

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
