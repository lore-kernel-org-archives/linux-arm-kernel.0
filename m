From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 Apr 2014 10:16:12 -0500
Subject: [PATCH Resend] ARM: EXYNOS: Map SYSRAM address through DT
In-Reply-To: <1397649051-3288-1-git-send-email-sachin.kamat@linaro.org>
References: <1397649051-3288-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAL_JsqLjPZmPrd=qmcxUCosx=Xu87NSTvG0d-LrGR=uncBHE5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 6:50 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Instead of hardcoding the SYSRAM details for each SoC,
> pass this information through device tree (DT) and make
> the code SoC agnostic.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Rebased on latest linux-next.
> ---
>  .../devicetree/bindings/arm/samsung-boards.txt     |   11 +++
>  arch/arm/boot/dts/exynos4210-universal_c210.dts    |    9 ++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   10 ++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   10 ++
>  arch/arm/boot/dts/exynos5.dtsi                     |    5 +
>  arch/arm/boot/dts/exynos5250.dtsi                  |    5 +
>  arch/arm/boot/dts/exynos5420.dtsi                  |    5 +
>  arch/arm/mach-exynos/exynos.c                      |  104 ++++++++------------
>  arch/arm/mach-exynos/include/mach/map.h            |    7 --
>  9 files changed, 95 insertions(+), 71 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> index 2168ed31e1b0..f79710eb7e79 100644
> --- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> @@ -7,6 +7,17 @@ Required root node properties:
>          (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
>          (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
>
> +    - sysram node, specifying the type (secure or non-secure) of SYSRAM
> +       - compatible: following types are supported
> +               "samsung,exynos4210-sysram" : Secure SYSRAM
> +               "samsung,exynos4210-sysram-ns" : Non-secure SYSRAM

Base this on mmio-sram binding please.

> +       - reg: address of SYSRAM bank
> +
> +       sysram at 02020000 {
> +               compatible = "samsung,exynos4210-sysram";
> +               reg = <0x02020000 0x1000>;
> +       };
> +
>  Optional:
>      - firmware node, specifying presence and type of secure firmware:
>          - compatible: only "samsung,secure-firmware" is currently supported
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 63e34b24b04f..cf4158728108 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -28,6 +28,15 @@
>                 bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>         };
>
> +       sysram at 02020000 {
> +               status = "disabled";
> +       };
> +
> +       sysram at 02025000 {
> +               compatible = "samsung,exynos4210-sysram";
> +               reg = <0x02025000 0x1000>;
> +       };
> +
>         mct at 10050000 {
>                 compatible = "none";
>         };
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index cacf6140dd2f..a3f4bba099e6 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -31,6 +31,16 @@
>                 pinctrl2 = &pinctrl_2;
>         };
>
> +       sysram at 02020000 {
> +               compatible = "samsung,exynos4210-sysram";
> +               reg = <0x02020000 0x1000>;
> +       };
> +
> +       sysram-ns at 0203F000 {
> +               compatible = "samsung,exynos4210-sysram-ns";
> +               reg = <0x0203F000 0x1000>;

hex should be lower case.


[...]

> @@ -268,6 +218,44 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
>         return 1;
>  }
>
> +struct __sysram_desc {
> +       char name[32];
> +       unsigned long addr;
> +};
> +
> +static struct __sysram_desc sysram_desc[] __initdata = {
> +       {
> +               .name = "samsung,exynos4210-sysram",
> +               .addr = (unsigned long)S5P_VA_SYSRAM,
> +       }, {
> +               .name = "samsung,exynos4210-sysram-ns",
> +               .addr = (unsigned long)S5P_VA_SYSRAM_NS,
> +       },
> +};
> +
> +static int __init exynos_fdt_map_sysram(unsigned long node, const char *uname,
> +                                       int depth, void *data)
> +{
> +       struct map_desc iodesc;
> +       __be32 *reg;
> +       unsigned long len;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(sysram_desc); i++) {
> +               if (of_flat_dt_is_compatible(node, sysram_desc[i].name)) {
> +                       reg = of_get_flat_dt_prop(node, "reg", &len);
> +                       if (!reg || len != (sizeof(unsigned long) * 2))
> +                               return -ENODEV;
> +                       iodesc.virtual = sysram_desc[i].addr;
> +                       iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
> +                       iodesc.length = be32_to_cpu(reg[1]);
> +                       iodesc.type = MT_DEVICE;
> +                       iotable_init(&iodesc, 1);

I don't think this needs to be a static mapping at all. Fix your SMP
code. Move the code setting the boot address in prepare_cpus to
boot_secondary.

Also, the pen code is all unnecessary if you can properly reset a core
on hotplug. Given this code:

if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
__raw_writel(S5P_CORE_LOCAL_PWR_EN,
    S5P_ARM_CORE1_CONFIGURATION);

and:

/* make cpu1 to be turned off at next WFI command */
if (cpu == 1)
__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);

It would appear you probably have this capability and the exynos smp
code is pure mindless cut n' paste.

Rob
