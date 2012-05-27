From: kmpark@infradead.org (Kyungmin Park)
Date: Sun, 27 May 2012 10:29:55 +0900
Subject: [PATCH 05/20] ARM: EXYNOS: Redefine IRQ_MCT_L0,1 definition
In-Reply-To: <1335813270-13083-6-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAH9JG2VwwXBWMvnK3ZYK37Gvsv9ORV7pqwM5rYtP-UEAxk_u-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 1, 2012 at 4:14 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
>
> Redefine IRQ_MCT_L0,1 irq definition as it is changed in rev1 of EXYNOS5.
>
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-exynos/include/mach/irqs.h | ? ?4 ++--
> ?arch/arm/mach-exynos/mct.c ? ? ? ? ? ? ? | ? 17 +++++++++++------
> ?2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
> index 591e7852..ef52f61 100644
> --- a/arch/arm/mach-exynos/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos/include/mach/irqs.h
> @@ -331,6 +331,8 @@
> ?#define EXYNOS5_IRQ_SATA ? ? ? ? ? ? ? IRQ_SPI(115)
> ?#define EXYNOS5_IRQ_NFCON ? ? ? ? ? ? ?IRQ_SPI(116)
>
> +#define EXYNOS5_IRQ_MCT_L0 ? ? ? ? ? ? IRQ_SPI(120)
> +#define EXYNOS5_IRQ_MCT_L1 ? ? ? ? ? ? IRQ_SPI(121)
> ?#define EXYNOS5_IRQ_MMC44 ? ? ? ? ? ? ?IRQ_SPI(123)
> ?#define EXYNOS5_IRQ_MDMA1 ? ? ? ? ? ? ?IRQ_SPI(124)
> ?#define EXYNOS5_IRQ_FIMC_LITE0 ? ? ? ? IRQ_SPI(125)
> @@ -410,8 +412,6 @@
> ?#define EXYNOS5_IRQ_FIMD1_SYSTEM ? ? ? COMBINER_IRQ(18, 6)
>
> ?#define EXYNOS5_IRQ_EINT0 ? ? ? ? ? ? ?COMBINER_IRQ(23, 0)
> -#define EXYNOS5_IRQ_MCT_L0 ? ? ? ? ? ? COMBINER_IRQ(23, 1)
> -#define EXYNOS5_IRQ_MCT_L1 ? ? ? ? ? ? COMBINER_IRQ(23, 2)
> ?#define EXYNOS5_IRQ_MCT_G0 ? ? ? ? ? ? COMBINER_IRQ(23, 3)
> ?#define EXYNOS5_IRQ_MCT_G1 ? ? ? ? ? ? COMBINER_IRQ(23, 4)
> ?#define EXYNOS5_IRQ_MCT_G2 ? ? ? ? ? ? COMBINER_IRQ(23, 5)
> diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
> index 897d9a9..b601fb8 100644
> --- a/arch/arm/mach-exynos/mct.c
> +++ b/arch/arm/mach-exynos/mct.c
> @@ -388,6 +388,7 @@ static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
> ?{
> ? ? ? ?struct mct_clock_event_device *mevt;
> ? ? ? ?unsigned int cpu = smp_processor_id();
> + ? ? ? int mct_lx_irq;
>
> ? ? ? ?mevt = this_cpu_ptr(&percpu_mct_tick);
> ? ? ? ?mevt->evt = evt;
> @@ -414,14 +415,18 @@ static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
>
> ? ? ? ?if (mct_int_type == MCT_INT_SPI) {
> ? ? ? ? ? ? ? ?if (cpu == 0) {
> + ? ? ? ? ? ? ? ? ? ? ? mct_lx_irq = soc_is_exynos4210() ? EXYNOS4_IRQ_MCT_L0 :
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? EXYNOS5_IRQ_MCT_L0;
Does it still valid for exynos4x12?. It means exynos4x12 uses
EXYNOS5_IRQ_MCT_L0?
> ? ? ? ? ? ? ? ? ? ? ? ?mct_tick0_event_irq.dev_id = mevt;
> - ? ? ? ? ? ? ? ? ? ? ? evt->irq = EXYNOS4_IRQ_MCT_L0;
> - ? ? ? ? ? ? ? ? ? ? ? setup_irq(EXYNOS4_IRQ_MCT_L0, &mct_tick0_event_irq);
> + ? ? ? ? ? ? ? ? ? ? ? evt->irq = mct_lx_irq;
> + ? ? ? ? ? ? ? ? ? ? ? setup_irq(mct_lx_irq, &mct_tick0_event_irq);
> ? ? ? ? ? ? ? ?} else {
> + ? ? ? ? ? ? ? ? ? ? ? mct_lx_irq = soc_is_exynos4210() ? EXYNOS4_IRQ_MCT_L1 :
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? EXYNOS5_IRQ_MCT_L1;
ditto
> ? ? ? ? ? ? ? ? ? ? ? ?mct_tick1_event_irq.dev_id = mevt;
> - ? ? ? ? ? ? ? ? ? ? ? evt->irq = EXYNOS4_IRQ_MCT_L1;
> - ? ? ? ? ? ? ? ? ? ? ? setup_irq(EXYNOS4_IRQ_MCT_L1, &mct_tick1_event_irq);
> - ? ? ? ? ? ? ? ? ? ? ? irq_set_affinity(EXYNOS4_IRQ_MCT_L1, cpumask_of(1));
> + ? ? ? ? ? ? ? ? ? ? ? evt->irq = mct_lx_irq;
> + ? ? ? ? ? ? ? ? ? ? ? setup_irq(mct_lx_irq, &mct_tick1_event_irq);
> + ? ? ? ? ? ? ? ? ? ? ? irq_set_affinity(mct_lx_irq, cpumask_of(1));
> ? ? ? ? ? ? ? ?}
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?enable_percpu_irq(EXYNOS_IRQ_MCT_LOCALTIMER, 0);
> @@ -473,7 +478,7 @@ static void __init exynos4_timer_resources(void)
>
> ?static void __init exynos4_timer_init(void)
> ?{
> - ? ? ? if (soc_is_exynos4210())
> + ? ? ? if ((soc_is_exynos4210()) || (soc_is_exynos5250()))
> ? ? ? ? ? ? ? ?mct_int_type = MCT_INT_SPI;
> ? ? ? ?else
> ? ? ? ? ? ? ? ?mct_int_type = MCT_INT_PPI;

BTW exynos4x12 uses MCT_INT_PPI?

Kyungmin Park
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
