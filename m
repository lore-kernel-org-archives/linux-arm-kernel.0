From: panand@redhat.com (Pratyush Anand)
Date: Fri, 13 Feb 2015 13:43:42 +0530
Subject: [PATCH] ARM64: gic: Do not allow bypass FIQ signals to reach
 to processor
In-Reply-To: <b449dac39614ed462c9a479e9de0aa5300d2c7cf.1423462126.git.panand@redhat.com>
References: <b449dac39614ed462c9a479e9de0aa5300d2c7cf.1423462126.git.panand@redhat.com>
Message-ID: <54DDB236.4040503@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Monday 09 February 2015 11:48 AM, Pratyush Anand wrote:
> In some case few signals of an IP(like PMU Overflow in APM88xx0x) can be
> mapped to nLEGACYFIQ, ie nFIQ of CPU. Until ARM64 supports FIQ handling,
> we will get nice "Bad mode in FIQ handler detected"
>
> Therefore force FIQBypDisGrp1 to '1', so that bypass FIQ signal is not
> signaled to the processor.
>

Please review this patch.

~Pratyush

> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>   drivers/irqchip/irq-gic.c       | 9 ++++++++-
>   include/linux/irqchip/arm-gic.h | 1 +
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index d617ee5a3d8a..525dfc966e60 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -362,7 +362,14 @@ static void gic_cpu_if_up(void)
>   	*/
>   	bypass = readl(cpu_base + GIC_CPU_CTRL);
>   	bypass &= GICC_DIS_BYPASS_MASK;
> -
> +#ifdef CONFIG_ARM64
> +	/* FIXME: when ARM64 starts supporting FIQ mode.
> +	 *
> +	 * Until ARM64 supports FIQ handling, force FIQBypDisGrp1 to
> +	 * '1', so that bypass FIQ signal is not signaled to the processor.
> +	 */
> +	bypass |= GICC_DIS_BYPASS_FIQ_TO_CPU;
> +#endif
>   	writel_relaxed(bypass | GICC_ENABLE, cpu_base + GIC_CPU_CTRL);
>   }
>
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 71d706d5f169..c9fdd1972625 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -25,6 +25,7 @@
>   #define GICC_INT_PRI_THRESHOLD		0xf0
>   #define GICC_IAR_INT_ID_MASK		0x3ff
>   #define GICC_INT_SPURIOUS		1023
> +#define GICC_DIS_BYPASS_FIQ_TO_CPU	(1 << 5)
>   #define GICC_DIS_BYPASS_MASK		0x1e0
>
>   #define GIC_DIST_CTRL			0x000
>
