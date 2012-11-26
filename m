From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Nov 2012 13:23:12 +0900
Subject: [PATCH 6/7] ARM: mach-shmobile: sh73a0: Minimal setup using DT
In-Reply-To: <1353889014-17142-7-git-send-email-horms@verge.net.au>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
 <1353889014-17142-7-git-send-email-horms@verge.net.au>
Message-ID: <CANqRtoQmNh5Sz-YLPMvEbp0FhYW=s2tBez+Duex1vyr=yVnPuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thanks for your efforts.

On Mon, Nov 26, 2012 at 9:16 AM, Simon Horman <horms@verge.net.au> wrote:
> Allow a minimal setup of the sh73a0 SoC using a flattened device tree.
>
> * Allow configuration of the i2c controllers using a flattened device tree.
>
> * SCI serial controller and CMT clock source, whose drivers do not yet
>   support configuration using a flattened device tree, are still configured
>   using C code in order to allow booting of a board with this SoC.
>
> An example dts snuppet follows:
>
>         i2c0: i2c at 0xe6820000 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 compatible = "renesas,rmobile-iic";
>                 reg = <0xe6820000 0x425>;
>                 interrupt-parent = <&gic>;
>                 interrupts = <0 167 0x4
>                               0 170 0x4>;
>         };
>
>         i2c1: i2c at 0xe6822000 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 compatible = "renesas,rmobile-iic";
>                 reg = <0xe6822000 0x425>;
>                 interrupt-parent = <&gic>;
>                 interrupts = <0 51 0x4
>                               0 44 0x4>;
>
>                 touchscreen at 55 {
>                         compatible = "sitronix,st1232";
>                         reg = <0x55>;
>                         interrupt-parent = <&gic>;
>                         interrupts = <0 9 0x4>;
>                 };
>         };
>
>         i2c2: i2c at 0xe6824000 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 compatible = "renesas,rmobile-iic";
>                 reg = <0xe6824000 0x425>;
>                 interrupt-parent = <&gic>;
>                 interrupts = <0 171 0x4
>                               0 174 0x4>;
>         };
>
>         i2c3: i2c at 0xe6826000 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 compatible = "renesas,rmobile-iic";
>                 reg = <0xe6826000 0x425>;
>                 interrupt-parent = <&gic>;
>                 interrupts = <0 183 0x4
>                               0 186 0x4>;
>         };
>
>         i2c4: i2c at 0xe6828000 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 compatible = "renesas,rmobile-iic";
>                 reg = <0xe6828000 0x425>;
>                 interrupt-parent = <&gic>;
>                 interrupts = <0 187 0x4
>                               0 190 0x4>;
>         };

Uhm, doesn't the above want to go into sh73a0.dtsi?

> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  arch/arm/mach-shmobile/include/mach/common.h |    2 ++
>  arch/arm/mach-shmobile/setup-sh73a0.c        |   41 ++++++++++++++++++++++----
>  2 files changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index b50447e..06b905e 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -52,7 +52,9 @@ extern void sh73a0_init_irq(void);
>  extern void sh73a0_init_irq_dt(void);
>  extern void sh73a0_map_io(void);
>  extern void sh73a0_add_early_devices(void);
> +extern void sh73a0_add_early_devices_dt(void);
>  extern void sh73a0_add_standard_devices(void);
> +extern void sh73a0_add_standard_devices_dt(void);
>  extern void sh73a0_clock_init(void);
>  extern void sh73a0_pinmux_init(void);
>  extern struct clk sh73a0_extal1_clk;
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index db99a4a..9096caa 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -23,6 +23,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/delay.h>
>  #include <linux/input.h>
>  #include <linux/io.h>
> @@ -754,7 +755,7 @@ static struct platform_device pmu_device = {
>         .resource       = pmu_resources,
>  };
>
> -static struct platform_device *sh73a0_early_devices[] __initdata = {
> +static struct platform_device *sh73a0_early_devices_dt[] __initdata = {
>         &scif0_device,
>         &scif1_device,
>         &scif2_device,
> @@ -765,6 +766,9 @@ static struct platform_device *sh73a0_early_devices[] __initdata = {
>         &scif7_device,
>         &scif8_device,
>         &cmt10_device,
> +};
> +
> +static struct platform_device *sh73a0_early_devices[] __initdata = {
>         &tmu00_device,
>         &tmu01_device,
>  };
> @@ -782,11 +786,18 @@ static struct platform_device *sh73a0_late_devices[] __initdata = {
>
>  #define SRCR2          IOMEM(0xe61580b0)
>
> -void __init sh73a0_add_standard_devices(void)
> +void __init sh73a0_add_standard_devices_dt(void)
>  {
>         /* Clear software reset bit on SY-DMAC module */
>         __raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
>
> +       platform_add_devices(sh73a0_early_devices_dt,
> +                            ARRAY_SIZE(sh73a0_early_devices_dt));
> +}
> +
> +void __init sh73a0_add_standard_devices(void)
> +{
> +       sh73a0_add_standard_devices_dt();
>         platform_add_devices(sh73a0_early_devices,
>                             ARRAY_SIZE(sh73a0_early_devices));
>         platform_add_devices(sh73a0_late_devices,
> @@ -803,14 +814,34 @@ static void __init sh73a0_earlytimer_init(void)
>         sh73a0_register_twd();
>  }
>
> -void __init sh73a0_add_early_devices(void)
> +static void __init
> +sh73a0_add_early_devices_start(void)
>  {
> -       early_platform_add_devices(sh73a0_early_devices,
> -                                  ARRAY_SIZE(sh73a0_early_devices));
> +       early_platform_add_devices(sh73a0_early_devices_dt,
> +                                  ARRAY_SIZE(sh73a0_early_devices_dt));
> +}
>
> +static void __init
> +sh73a0_add_early_devices_finish(void)
> +{
>         /* setup early console here as well */
>         shmobile_setup_console();
>
>         /* override timer setup with soc-specific code */
>         shmobile_timer.init = sh73a0_earlytimer_init;
>  }
> +
> +void __init sh73a0_add_early_devices_dt(void)
> +{
> +       sh73a0_add_early_devices_start();
> +       sh73a0_add_early_devices_finish();
> +}

What's the reason behind using sh73a0_earlytimer_init() for the sh73a0
DT case instead of using shmobile_setup_delay() as the DT code for
sh7372 does?

For the DT case on sh7372 we don't really use early platform driver
timers at all, instead we use timers as regular platform devices. For
this to work as expected we need to setup a worst case udelay
calculation via shmobile_setup_delay(). I suggest using the same style
for sh73a0.

> +void __init sh73a0_add_early_devices(void)
> +{
> +       sh73a0_add_early_devices_start();
> +       early_platform_add_devices(sh73a0_early_devices,
> +                                  ARRAY_SIZE(sh73a0_early_devices));
> +       sh73a0_add_early_devices_finish();
> +}
> +

Hm, without sh73a0_earlytimer_init() the functions
sh73a0_add_early_devices_start() and sh73a0_add_early_devices_finish()
look overly complicated compared to the sh7372 DT implementation.

However, I have not checked your code in detail but if your DT code
for sh73a0 happens to be shorter than the DT code for sh7372 then
please adjust the sh7372 code to be as short and simple as possible.

Thanks,

/ magnus
