From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 24 Jun 2010 10:35:27 +0900
Subject: [PATCH 2/3] ARM: S5P: Add System define for arch_reset()
In-Reply-To: <1277332317-30192-3-git-send-email-kgene.kim@samsung.com>
References: <1277332317-30192-1-git-send-email-kgene.kim@samsung.com>
	<1277332317-30192-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTim2s6syCjpl5v_qVloktrzz27JsSrR6kgWqNHUm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 7:31 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Jongpill Lee <boyko.lee@samsung.com>
>
> This patch adds system define for arch_reset() using Watchdog reset.
> And adds IO mapping for using WDT.

Are there any reason to use the WDT to system reset?
As original purpose of WDT. doesn't it better to use system reset?
Since we use the WDT reset at other purpose. but if you add the WDT
reset to system reset.
then we can't control it. bootloader check the reset reason then
report something wrong at previous operation.

So I want to use system reset as original purpose.

Thank you,
Kyungmin Park

>
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/plat-s5p/cpu.c ? ? ? ? ? ? ? ? ? ? ? | ? ?5 +++++
> ?arch/arm/plat-s5p/include/plat/system-reset.h | ? 24 ++++++++++++++++++++++++
> ?2 files changed, 29 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/plat-s5p/include/plat/system-reset.h
>
> diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
> index 75cb8c3..1ab55e8 100644
> --- a/arch/arm/plat-s5p/cpu.c
> +++ b/arch/arm/plat-s5p/cpu.c
> @@ -103,6 +103,11 @@ static struct map_desc s5p_iodesc[] __initdata = {
> ? ? ? ? ? ? ? ?.pfn ? ? ? ? ? ?= __phys_to_pfn(S5P_PA_GPIO),
> ? ? ? ? ? ? ? ?.length ? ? ? ? = SZ_4K,
> ? ? ? ? ? ? ? ?.type ? ? ? ? ? = MT_DEVICE,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S3C_VA_WATCHDOG,
> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S3C_PA_WDT),
> + ? ? ? ? ? ? ? .length ? ? ? ? = SZ_4K,
> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> ? ? ? ?},
> ?};
>
> diff --git a/arch/arm/plat-s5p/include/plat/system-reset.h b/arch/arm/plat-s5p/include/plat/system-reset.h
> new file mode 100644
> index 0000000..7f76a16
> --- /dev/null
> +++ b/arch/arm/plat-s5p/include/plat/system-reset.h
> @@ -0,0 +1,24 @@
> +/* linux/arch/arm/plat-s5p/include/plat/system-reset.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com
> + *
> + * Based on arch/arm/mach-s3c2410/include/mach/system-reset.h
> + *
> + * S5P - System define for arch_reset()
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <plat/watchdog-reset.h>
> +
> +static void arch_reset(char mode, const char *cmd)
> +{
> + ? ? ? /* Perform reset using Watchdog reset.
> + ? ? ? ?* SWRESET support will be added later.
> + ? ? ? ?*/
> +
> + ? ? ? arch_wdt_reset();
> +}
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
