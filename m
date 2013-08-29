From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Aug 2013 13:45:56 +0530
Subject: [PATCH v4 02/10] ARM: dts: list the CPU nodes for Exynos5250
In-Reply-To: <1371536962-13322-3-git-send-email-chander.kashyap@linaro.org>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
 <1371536962-13322-3-git-send-email-chander.kashyap@linaro.org>
Message-ID: <CAOh2x=nsQ5paiMHSH8z9drsqr7_+TvMtNefczf8QNQNbYo0y=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:59 AM, Chander Kashyap
<chander.kashyap@linaro.org> wrote:
> Instead of having to specify the number for CPUs in Exynos5250 in platsmp.c
> file, let the number of CPUs be determined by having this information listed
> in Exynos5250 device tree file.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   16 ++++++++++++++++
>  arch/arm/mach-exynos/platsmp.c    |   10 +++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 63ca03d..1aeef98 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -50,6 +50,22 @@
>                 pinctrl3 = &pinctrl_3;
>         };
>
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       reg = <0>;
> +               };
> +               cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       reg = <1>;
> +               };
> +       };
> +
>         pd_gsc: gsc-power-domain at 0x10044000 {
>                 compatible = "samsung,exynos4210-pd";
>                 reg = <0x10044000 0x20>;
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 1a4e4e5..85ea4ca 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -180,10 +180,14 @@ static void __init exynos_smp_init_cpus(void)
>         void __iomem *scu_base = scu_base_addr();
>         unsigned int i, ncores;
>
> -       if (soc_is_exynos5250())
> -               ncores = 2;
> -       else
> +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>                 ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> +       else
> +               /*
> +                * CPU Nodes are passed thru DT and set_cpu_possible
> +                * is set by "arm_dt_init_cpu_maps".
> +                */
> +               return;
>
>         /* sanity check */
>         if (ncores > nr_cpu_ids) {

After this patch only one cpu is coming up for me on my Arndale board..
Revert of this one fixes the issue though (Tested over v3.11-rc7)
