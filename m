From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 5 Mar 2014 13:53:32 +0530
Subject: [PATCH 1/1] ARM: EXYNOS: Map SYSRAM address through DT
In-Reply-To: <1392876308-4748-1-git-send-email-sachin.kamat@linaro.org>
References: <1392876308-4748-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAK9yfHz6wJPdC=DjgaiNOsPHY8k9zaB+p3-ahpwOOcPQtoWEHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2014 11:35, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Instead of hardcoding the SYSRAM details for each SoC,
> pass this information through device tree (DT) and make
> the code SoC agnostic.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Based on top of my earlier patch
> "ARM: EXYNOS: Consolidate CPU init code" at
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/26560
> ---
>  .../devicetree/bindings/arm/samsung-boards.txt     |   11 +++
>  arch/arm/boot/dts/exynos4210-universal_c210.dts    |    5 +
>  arch/arm/boot/dts/exynos4210.dtsi                  |   10 ++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |   10 ++
>  arch/arm/boot/dts/exynos5.dtsi                     |    5 +
>  arch/arm/boot/dts/exynos5250.dtsi                  |    5 +
>  arch/arm/mach-exynos/common.c                      |  104 ++++++++------------
>  arch/arm/mach-exynos/include/mach/map.h            |    7 --
>  8 files changed, 86 insertions(+), 71 deletions(-)
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
> index d2e3f5f5916d..3ca3fb6aa5f4 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -28,6 +28,11 @@
>                 bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>         };
>
> +       sysram at 02020000 {
> +               compatible = "samsung,exynos4210-sysram";
> +               reg = <0x02025000 0x1000>;
> +       };
> +
>         mct at 10050000 {
>                 compatible = "none";
>         };
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 48ecd7a755ab..7f02c029ba68 100644
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
> +       };
> +
>         pd_lcd1: lcd1-power-domain at 10023CA0 {
>                 compatible = "samsung,exynos4210-pd";
>                 reg = <0x10023CA0 0x20>;
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 5c412aa14738..05006cab698b 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -31,6 +31,16 @@
>                 mshc0 = &mshc_0;
>         };
>
> +       sysram at 02020000 {
> +               compatible = "samsung,exynos4210-sysram";
> +               reg = <0x02020000 0x1000>;
> +       };
> +
> +       sysram-ns at 0204F000 {
> +               compatible = "samsung,exynos4210-sysram-ns";
> +               reg = <0x0204F000 0x1000>;
> +       };
> +
>         pd_isp: isp-power-domain at 10023CA0 {
>                 compatible = "samsung,exynos4210-pd";
>                 reg = <0x10023CA0 0x20>;
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index 258dca441f36..b70a54ec7157 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -18,6 +18,11 @@
>  / {
>         interrupt-parent = <&gic>;
>
> +       sysram at 02020000 {
> +               compatible = "samsung,exynos4210-sysram";
> +               reg = <0x02020000 0x1000>;
> +       };
> +
>         chipid at 10000000 {
>                 compatible = "samsung,exynos4210-chipid";
>                 reg = <0x10000000 0x100>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index b7dec41e32af..3ecdbd8e2b19 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -70,6 +70,11 @@
>                 };
>         };
>
> +       sysram-ns at 0204F000 {
> +               compatible = "samsung,exynos4210-sysram-ns";
> +               reg = <0x0204F000 0x1000>;
> +       };
> +
>         pd_gsc: gsc-power-domain at 10044000 {
>                 compatible = "samsung,exynos4210-pd";
>                 reg = <0x10044000 0x20>;
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 02d0aaa7af59..6a16f4659ec7 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -131,51 +131,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
>         },
>  };
>
> -static struct map_desc exynos4_iodesc0[] __initdata = {
> -       {
> -               .virtual        = (unsigned long)S5P_VA_SYSRAM,
> -               .pfn            = __phys_to_pfn(EXYNOS4_PA_SYSRAM0),
> -               .length         = SZ_4K,
> -               .type           = MT_DEVICE,
> -       },
> -};
> -
> -static struct map_desc exynos4_iodesc1[] __initdata = {
> -       {
> -               .virtual        = (unsigned long)S5P_VA_SYSRAM,
> -               .pfn            = __phys_to_pfn(EXYNOS4_PA_SYSRAM1),
> -               .length         = SZ_4K,
> -               .type           = MT_DEVICE,
> -       },
> -};
> -
> -static struct map_desc exynos4210_iodesc[] __initdata = {
> -       {
> -               .virtual        = (unsigned long)S5P_VA_SYSRAM_NS,
> -               .pfn            = __phys_to_pfn(EXYNOS4210_PA_SYSRAM_NS),
> -               .length         = SZ_4K,
> -               .type           = MT_DEVICE,
> -       },
> -};
> -
> -static struct map_desc exynos4x12_iodesc[] __initdata = {
> -       {
> -               .virtual        = (unsigned long)S5P_VA_SYSRAM_NS,
> -               .pfn            = __phys_to_pfn(EXYNOS4x12_PA_SYSRAM_NS),
> -               .length         = SZ_4K,
> -               .type           = MT_DEVICE,
> -       },
> -};
> -
> -static struct map_desc exynos5250_iodesc[] __initdata = {
> -       {
> -               .virtual        = (unsigned long)S5P_VA_SYSRAM_NS,
> -               .pfn            = __phys_to_pfn(EXYNOS5250_PA_SYSRAM_NS),
> -               .length         = SZ_4K,
> -               .type           = MT_DEVICE,
> -       },
> -};
> -
>  static struct map_desc exynos5_iodesc[] __initdata = {
>         {
>                 .virtual        = (unsigned long)S3C_VA_SYS,
> @@ -198,11 +153,6 @@ static struct map_desc exynos5_iodesc[] __initdata = {
>                 .length         = SZ_4K,
>                 .type           = MT_DEVICE,
>         }, {
> -               .virtual        = (unsigned long)S5P_VA_SYSRAM,
> -               .pfn            = __phys_to_pfn(EXYNOS5_PA_SYSRAM),
> -               .length         = SZ_4K,
> -               .type           = MT_DEVICE,
> -       }, {
>                 .virtual        = (unsigned long)S5P_VA_CMU,
>                 .pfn            = __phys_to_pfn(EXYNOS5_PA_CMU),
>                 .length         = 144 * SZ_1K,
> @@ -292,6 +242,44 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
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
> +               }
> +       }
> +       return 0;
> +}
> +
>  /*
>   * exynos_map_io
>   *
> @@ -308,6 +296,8 @@ void __init exynos_init_io(void)
>         s5p_init_cpu(S5P_VA_CHIPID);
>
>         exynos_map_io();
> +
> +       of_scan_flat_dt(exynos_fdt_map_sysram, NULL);
>  }
>
>  static void __init exynos_map_io(void)
> @@ -317,20 +307,6 @@ static void __init exynos_map_io(void)
>
>         if (soc_is_exynos5250() || soc_is_exynos5420())
>                 iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
> -
> -       if (soc_is_exynos4210()) {
> -               if (samsung_rev() == EXYNOS4210_REV_0)
> -                       iotable_init(exynos4_iodesc0,
> -                                               ARRAY_SIZE(exynos4_iodesc0));
> -               else
> -                       iotable_init(exynos4_iodesc1,
> -                                               ARRAY_SIZE(exynos4_iodesc1));
> -               iotable_init(exynos4210_iodesc, ARRAY_SIZE(exynos4210_iodesc));
> -       }
> -       if (soc_is_exynos4212() || soc_is_exynos4412())
> -               iotable_init(exynos4x12_iodesc, ARRAY_SIZE(exynos4x12_iodesc));
> -       if (soc_is_exynos5250())
> -               iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
>  }
>
>  struct bus_type exynos_subsys = {
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 7b046b59d9ec..548269a60634 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -23,13 +23,6 @@
>
>  #include <plat/map-s5p.h>
>
> -#define EXYNOS4_PA_SYSRAM0             0x02025000
> -#define EXYNOS4_PA_SYSRAM1             0x02020000
> -#define EXYNOS5_PA_SYSRAM              0x02020000
> -#define EXYNOS4210_PA_SYSRAM_NS                0x0203F000
> -#define EXYNOS4x12_PA_SYSRAM_NS                0x0204F000
> -#define EXYNOS5250_PA_SYSRAM_NS                0x0204F000
> -
>  #define EXYNOS_PA_CHIPID               0x10000000
>
>  #define EXYNOS4_PA_SYSCON              0x10010000
> --
> 1.7.9.5
>

ping..

-- 
With warm regards,
Sachin
