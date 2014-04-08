From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Apr 2014 18:09:09 +0200
Subject: [PATCH 05/10] ARM: EXYNOS: Move "regs-pmu" header inclusion in
 common.h
In-Reply-To: <1396425058-4012-6-git-send-email-pankaj.dubey@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1396425058-4012-6-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53441F25.9080801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 02.04.2014 09:50, Pankaj Dubey wrote:
> There are many machine files under "mach-exynos" including "regs-pmu.h"
> as well as "common.h", so better we move this header inclusion in common.h.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   arch/arm/mach-exynos/common.h  |    1 +
>   arch/arm/mach-exynos/cpuidle.c |    1 -
>   arch/arm/mach-exynos/exynos.c  |    1 -
>   arch/arm/mach-exynos/hotplug.c |    1 -
>   arch/arm/mach-exynos/platsmp.c |    1 -
>   arch/arm/mach-exynos/pm.c      |    1 -
>   arch/arm/mach-exynos/pmu.c     |    1 -
>   7 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 277a83e..ff28334 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -14,6 +14,7 @@
>
>   #include <linux/reboot.h>
>   #include <linux/of.h>
> +#include "regs-pmu.h"
>
>   void exynos_init_io(void);
>   void exynos_restart(enum reboot_mode mode, const char *cmd);
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index b530231..b9dd8c3 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -29,7 +29,6 @@
>   #include <mach/map.h>
>
>   #include "common.h"
> -#include "regs-pmu.h"
>
>   #define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
>   			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 57bd1cd..a5e1349 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -30,7 +30,6 @@
>
>   #include "common.h"
>   #include "mfc.h"
> -#include "regs-pmu.h"
>   #include "regs-sys.h"
>
>   #define L2_AUX_VAL 0x7C470001
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 5eead53..33db6ee 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -22,7 +22,6 @@
>   #include <plat/cpu.h>
>
>   #include "common.h"
> -#include "regs-pmu.h"
>
>   static inline void cpu_enter_lowpower_a9(void)
>   {
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index d8d1555..3ebb03f 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -29,7 +29,6 @@
>   #include <plat/cpu.h>
>
>   #include "common.h"
> -#include "regs-pmu.h"
>
>   extern void exynos4_secondary_startup(void);
>
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index 723c988..875151f 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -34,7 +34,6 @@
>   #include <mach/map.h>
>
>   #include "common.h"
> -#include "regs-pmu.h"
>   #include "regs-sys.h"
>
>   /**
> diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
> index 05c7ce1..fb44352 100644
> --- a/arch/arm/mach-exynos/pmu.c
> +++ b/arch/arm/mach-exynos/pmu.c
> @@ -16,7 +16,6 @@
>   #include <plat/cpu.h>
>
>   #include "common.h"
> -#include "regs-pmu.h"
>
>   static const struct exynos_pmu_conf *exynos_pmu_config;
>
>

I don't think this is a good idea. It adds hidden indirect dependencies 
between source files and thus reduces maintainability and readability. 
In addition it causes the file to be included even by files that don't 
need it.

Best regards,
Tomasz
