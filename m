From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 23 Apr 2012 16:55:11 -0600
Subject: [PATCH] ARM: msm: Fix gic irqdomain support
In-Reply-To: <1335221222-30879-1-git-send-email-davidb@codeaurora.org>
References: <1335221222-30879-1-git-send-email-davidb@codeaurora.org>
Message-ID: <CACxGe6sPkW8WviMX=oJEj+-G7XMeaWaQYfe_hg2quB-Sh2gEDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 4:47 PM, David Brown <davidb@codeaurora.org> wrote:
> As of
>
> ? ?commit 75294957be1dee7d22dd7d90bd31334ba410e836
> ? ?Author: Grant Likely <grant.likely@secretlab.ca>
> ? ?Date: ? Tue Feb 14 14:06:57 2012 -0700
>
> ? ? ? ?irq_domain: Remove 'new' irq_domain in favour of the ppc one
>
> the ARM gic controller uses proper irq domains. ?Fix the MSM gic
> initialization and DT so that it works again.
>
> Signed-off-by: David Brown <davidb@codeaurora.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

This should go via the arm-soc tree I think

g.

> ---
> ?arch/arm/boot/dts/msm8660-surf.dts | ? ?4 ++--
> ?arch/arm/mach-msm/board-msm8x60.c ?| ? 25 +++++++++++++++----------
> ?2 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/msm8660-surf.dts b/arch/arm/boot/dts/msm8660-surf.dts
> index 15ded0d..45bc4bb 100644
> --- a/arch/arm/boot/dts/msm8660-surf.dts
> +++ b/arch/arm/boot/dts/msm8660-surf.dts
> @@ -10,7 +10,7 @@
> ? ? ? ?intc: interrupt-controller at 02080000 {
> ? ? ? ? ? ? ? ?compatible = "qcom,msm-8660-qgic";
> ? ? ? ? ? ? ? ?interrupt-controller;
> - ? ? ? ? ? ? ? #interrupt-cells = <1>;
> + ? ? ? ? ? ? ? #interrupt-cells = <3>;
> ? ? ? ? ? ? ? ?reg = < 0x02080000 0x1000 >,
> ? ? ? ? ? ? ? ? ? ? ?< 0x02081000 0x1000 >;
> ? ? ? ?};
> @@ -19,6 +19,6 @@
> ? ? ? ? ? ? ? ?compatible = "qcom,msm-hsuart", "qcom,msm-uart";
> ? ? ? ? ? ? ? ?reg = <0x19c40000 0x1000>,
> ? ? ? ? ? ? ? ? ? ? ?<0x19c00000 0x1000>;
> - ? ? ? ? ? ? ? interrupts = <195>;
> + ? ? ? ? ? ? ? interrupts = <0 195 0x0>;
> ? ? ? ?};
> ?};
> diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
> index 962e711..fb3496a 100644
> --- a/arch/arm/mach-msm/board-msm8x60.c
> +++ b/arch/arm/mach-msm/board-msm8x60.c
> @@ -17,6 +17,7 @@
> ?#include <linux/irqdomain.h>
> ?#include <linux/of.h>
> ?#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> ?#include <linux/of_platform.h>
> ?#include <linux/memblock.h>
>
> @@ -49,10 +50,22 @@ static void __init msm8x60_map_io(void)
> ? ? ? ?msm_map_msm8x60_io();
> ?}
>
> +#ifdef CONFIG_OF
> +static struct of_device_id msm_dt_gic_match[] __initdata = {
> + ? ? ? { .compatible = "qcom,msm-8660-qgic", .data = gic_of_init },
> + ? ? ? {}
> +};
> +#endif
> +
> ?static void __init msm8x60_init_irq(void)
> ?{
> - ? ? ? gic_init(0, GIC_PPI_START, MSM_QGIC_DIST_BASE,
> - ? ? ? ? ? ? ? ?(void *)MSM_QGIC_CPU_BASE);
> + ? ? ? if (!of_have_populated_dt())
> + ? ? ? ? ? ? ? gic_init(0, GIC_PPI_START, MSM_QGIC_DIST_BASE,
> + ? ? ? ? ? ? ? ? ? ? ? ?(void *)MSM_QGIC_CPU_BASE);
> +#ifdef CONFIG_OF
> + ? ? ? else
> + ? ? ? ? ? ? ? of_irq_init(msm_dt_gic_match);
> +#endif
>
> ? ? ? ?/* Edge trigger PPIs except AVS_SVICINT and AVS_SVICINTSWDONE */
> ? ? ? ?writel(0xFFFFD7FF, MSM_QGIC_DIST_BASE + GIC_DIST_CONFIG + 4);
> @@ -73,16 +86,8 @@ static struct of_dev_auxdata msm_auxdata_lookup[] __initdata = {
> ? ? ? ?{}
> ?};
>
> -static struct of_device_id msm_dt_gic_match[] __initdata = {
> - ? ? ? { .compatible = "qcom,msm-8660-qgic", },
> - ? ? ? {}
> -};
> -
> ?static void __init msm8x60_dt_init(void)
> ?{
> - ? ? ? irq_domain_generate_simple(msm_dt_gic_match, MSM8X60_QGIC_DIST_PHYS,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? GIC_SPI_START);
> -
> ? ? ? ?if (of_machine_is_compatible("qcom,msm8660-surf")) {
> ? ? ? ? ? ? ? ?printk(KERN_INFO "Init surf UART registers\n");
> ? ? ? ? ? ? ? ?msm8x60_init_uart12dm();
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
