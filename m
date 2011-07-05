From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 14:58:34 +0800
Subject: [PATCH v2] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <1300219877-32160-1-git-send-email-anarsoul@gmail.com>
References: <AANLkTi=2XH2X53H=3qBhhUbiY_Cnc50u0gg3JM7kRRhk@mail.gmail.com>
	<1300219877-32160-1-git-send-email-anarsoul@gmail.com>
Message-ID: <CAMPhdO97oQETeu5hiiVsxpAS5BC6up7SkLYceAB3Ag+AwJLYtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 4:11 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Applied.

> ---
> v2:
> ?- clear PSPR before going deep sleep
>
> ?arch/arm/mach-pxa/z2.c | ? 17 +++++++++++++++++
> ?1 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index 3d3f019..a9ab8c1 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -40,6 +40,7 @@
> ?#include <mach/pxafb.h>
> ?#include <mach/mmc.h>
> ?#include <plat/pxa27x_keypad.h>
> +#include <mach/pm.h>
>
> ?#include "generic.h"
> ?#include "devices.h"
> @@ -677,6 +678,20 @@ static void __init z2_pmic_init(void)
> ?static inline void z2_pmic_init(void) {}
> ?#endif
>
> +#ifdef CONFIG_PM
> +static void z2_power_off(void)
> +{
> + ? ? ? /* We're using deep sleep as poweroff, so clear PSPR to ensure that
> + ? ? ? ?* bootloader will jump to its entry point in resume handler
> + ? ? ? ?*/
> + ? ? ? PSPR = 0x0;
> + ? ? ? local_irq_disable();
> + ? ? ? pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
> +}
> +#else
> +#define z2_power_off ? NULL
> +#endif
> +
> ?/******************************************************************************
> ?* Machine init
> ?******************************************************************************/
> @@ -698,6 +713,8 @@ static void __init z2_init(void)
> ? ? ? ?z2_leds_init();
> ? ? ? ?z2_keys_init();
> ? ? ? ?z2_pmic_init();
> +
> + ? ? ? pm_power_off = z2_power_off;
> ?}
>
> ?MACHINE_START(ZIPIT2, "Zipit Z2")
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
