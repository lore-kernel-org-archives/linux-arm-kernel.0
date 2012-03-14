From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 14 Mar 2012 10:57:32 +0530
Subject: [PATCH v3 07/12] ARM: EXYNOS: add interrupt definitions for
 EXYNOS5250
In-Reply-To: <1331652643-12626-8-git-send-email-kgene.kim@samsung.com>
References: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
 <1331652643-12626-8-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAJuYYwTFEV06C+gWEoXDtKoqhujA8HphNuLLJs3EBzaKnTvcfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2012 21:00, Kukjin Kim <kgene.kim@samsung.com> wrote:
> ARM: EXYNOS: irqs.h for exynos4 and exynos5 - WIP
> This patch adds the interrupt definitions for EXYNOS5250 at
> <mach/irqs.h> file. Basically, now it is needed for EXYNOS5250
> interrupt and will be updated for single zImage next time.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-exynos/common.c ? ? ? ? ? ?| ? 97 ++++--
> ?arch/arm/mach-exynos/dev-ahci.c ? ? ? ? ?| ? ?4 +-
> ?arch/arm/mach-exynos/dev-audio.c ? ? ? ? | ? ?4 +-
> ?arch/arm/mach-exynos/include/mach/irqs.h | ?580 ++++++++++++++++++++++--------
> ?arch/arm/mach-exynos/mct.c ? ? ? ? ? ? ? | ? 23 +-
> ?arch/arm/plat-s5p/irq-pm.c ? ? ? ? ? ? ? | ? 25 +-
> ?arch/arm/plat-samsung/irq-vic-timer.c ? ?| ? 16 +
> ?7 files changed, 548 insertions(+), 201 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 7fdb139..0b53018 100644
> --- a/arch/arm/mach-exynos/common.c


[...]

> ? ? ? ?for (irq = 0 ; irq <= 15 ; irq++) {
> ? ? ? ? ? ? ? ?eint0_15_data[irq] = IRQ_EINT(irq);
>
> - ? ? ? ? ? ? ? irq_set_handler_data(exynos4_get_irq_nr(irq),
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&eint0_15_data[irq]);
> - ? ? ? ? ? ? ? irq_set_chained_handler(exynos4_get_irq_nr(irq),
> + ? ? ? ? ? ? ? if (soc_is_exynos5250()) {
> + ? ? ? ? ? ? ? ? ? ? ? irq_set_handler_data(exynos4_eint0_15_src_int[irq],
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&eint0_15_data[irq]);
> + ? ? ? ? ? ? ? ? ? ? ? irq_set_chained_handler(exynos4_eint0_15_src_int[irq],
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? exynos4_irq_eint0_15);
> + ? ? ? ? ? ? ? } else {
> + ? ? ? ? ? ? ? ? ? ? ? irq_set_handler_data(exynos5_eint0_15_src_int[irq],
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&eint0_15_data[irq]);
> + ? ? ? ? ? ? ? ? ? ? ? irq_set_chained_handler(exynos5_eint0_15_src_int[irq],
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?exynos4_irq_eint0_15);
> + ? ? ? ? ? ? ? }
> ? ? ? ?}

The external interrupt numbers for Exynos4 and Exynos5 have been
swapped. This needs to be fixed.

Thanks,
Thomas.
