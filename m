From: ccross@android.com (Colin Cross)
Date: Fri, 27 Aug 2010 13:25:25 -0700
Subject: [PATCH] ARM: tegra: register PMU IRQs with PMU framework
In-Reply-To: <1282051903-366-1-git-send-email-will.deacon@arm.com>
References: <1282051903-366-1-git-send-email-will.deacon@arm.com>
Message-ID: <AANLkTimQbNF--t=W7-2PgGfzzraQ1+82KxYGhqF2Ef1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 17, 2010 at 6:31 AM, Will Deacon <will.deacon@arm.com> wrote:
> The Tegra Harmony board contains a dual-core Cortex-A9 and can therefore
> make use of the hardware performance counters on the CPU.
>
> This patch fixes a typo in the PMU IRQ definitions and registers the
> interrupts as a platform_device with the PMU framework.
>
> Cc: Colin Cross <ccross@android.com>
> Cc: Linux Tegra Mailing List <linux-tegra@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> This patch was taken against 2.6.36-rc1 but has not even been compile-tested
> because of the following errors:
>
> arch/arm/mach-tegra/board-harmony.c: In function 'tegra_harmony_fixup':
> arch/arm/mach-tegra/board-harmony.c:116: error: 'struct membank' has no member named 'node'
> arch/arm/mach-tegra/board-harmony.c:116: error: implicit declaration of function 'PHYS_TO_NID'
> arch/arm/mach-tegra/board-harmony.c:119: error: 'struct membank' has no member named 'node'
>
> ?arch/arm/mach-tegra/board-harmony.c ? ? | ? 22 ++++++++++++++++++++++
> ?arch/arm/mach-tegra/include/mach/irqs.h | ? ?2 +-
> ?2 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index 05e78dd..6c6a02b 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -26,6 +26,7 @@
> ?#include <asm/mach-types.h>
> ?#include <asm/mach/arch.h>
> ?#include <asm/mach/time.h>
> +#include <asm/pmu.h>
> ?#include <asm/setup.h>
>
> ?#include <mach/iomap.h>
> @@ -82,8 +83,29 @@ static struct platform_device debug_uart = {
> ? ? ? ?},
> ?};
>
> +static struct resource pmu_resources[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start ?= INT_CPU0_PMU_INTR,
> + ? ? ? ? ? ? ? .end ? ?= INT_CPU0_PMU_INTR,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start ?= INT_CPU1_PMU_INTR,
> + ? ? ? ? ? ? ? .end ? ?= INT_CPU1_PMU_INTR,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
> + ? ? ? },
> +};
> +
> +static struct platform_device pmu_device = {
> + ? ? ? .name ? ? ? ? ? = "arm-pmu",
> + ? ? ? .id ? ? ? ? ? ? = ARM_PMU_DEVICE_CPU,
> + ? ? ? .num_resources ?= ARRAY_SIZE(pmu_resources),
> + ? ? ? .resource ? ? ? = pmu_resources,
> +};
> +
> ?static struct platform_device *harmony_devices[] __initdata = {
> ? ? ? ?&debug_uart,
> + ? ? ? &pmu_device,
> ?};
>
> ?static void __init tegra_harmony_fixup(struct machine_desc *desc,
> diff --git a/arch/arm/mach-tegra/include/mach/irqs.h b/arch/arm/mach-tegra/include/mach/irqs.h
> index 20f640e..0a4ddc8 100644
> --- a/arch/arm/mach-tegra/include/mach/irqs.h
> +++ b/arch/arm/mach-tegra/include/mach/irqs.h
> @@ -87,7 +87,7 @@
> ?#define INT_SYS_STATS_MON ? ? ? ? ? ? ?(INT_SEC_BASE + 22)
> ?#define INT_GPIO5 ? ? ? ? ? ? ? ? ? ? ?(INT_SEC_BASE + 23)
> ?#define INT_CPU0_PMU_INTR ? ? ? ? ? ? ?(INT_SEC_BASE + 24)
> -#define INT_CPU2_PMU_INTR ? ? ? ? ? ? ?(INT_SEC_BASE + 25)
> +#define INT_CPU1_PMU_INTR ? ? ? ? ? ? ?(INT_SEC_BASE + 25)
> ?#define INT_SEC_RES_26 ? ? ? ? ? ? ? ? (INT_SEC_BASE + 26)
> ?#define INT_S_LINK1 ? ? ? ? ? ? ? ? ? ?(INT_SEC_BASE + 27)
> ?#define INT_APB_DMA_COP ? ? ? ? ? ? ? ? ? ? ? ?(INT_SEC_BASE + 28)
> --
> 1.6.3.3
>
>

Thanks Will, I added these to common.c in the linux-tegra tree, and to
the harmony and ventana boards.
