From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 3 May 2012 13:03:02 +0200
Subject: [PATCHv4 8/8] ARM: OMAP4: PM: Added option for enabling OSWR
In-Reply-To: <1334913591-26312-9-git-send-email-t-kristo@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
 <1334913591-26312-9-git-send-email-t-kristo@ti.com>
Message-ID: <CAORVsuWVMa-_T4JuXTwT6sePhp0mPoE9U_xhwA28AULveeiM+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Fri, Apr 20, 2012 at 11:19 AM, Tero Kristo <t-kristo@ti.com> wrote:
> PM debug now contains a file that can be used to control OSWR support
> enable / disable on OMAP4. Also removed the off_mode_enable file for
> the same platform as it is unsupported.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> ?arch/arm/mach-omap2/pm-debug.c | ? 20 ++++++++++++++++----
> ?arch/arm/mach-omap2/pm.h ? ? ? | ? ?1 +
> ?arch/arm/mach-omap2/pm44xx.c ? | ? 16 ++++++++++++++++
> ?3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 814bcd9..d9a8e42 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -39,6 +39,7 @@
> ?#include "pm.h"
>
> ?u32 enable_off_mode;
> +static u32 enable_oswr_mode;
>
> ?#ifdef CONFIG_DEBUG_FS
> ?#include <linux/debugfs.h>
> @@ -247,10 +248,13 @@ static int option_set(void *data, u64 val)
> ? ? ? ? ? ? ? ? ? ? ? ?omap_pm_enable_off_mode();
> ? ? ? ? ? ? ? ?else
> ? ? ? ? ? ? ? ? ? ? ? ?omap_pm_disable_off_mode();
> - ? ? ? ? ? ? ? if (cpu_is_omap34xx())
> - ? ? ? ? ? ? ? ? ? ? ? omap3_pm_off_mode_enable(val);
> +
> + ? ? ? ? ? ? ? omap3_pm_off_mode_enable(val);
Great since this change removes a non-init cpu_is_xxx check.

> ? ? ? ?}
>
> + ? ? ? if (option == &enable_oswr_mode)
> + ? ? ? ? ? ? ? omap4_pm_oswr_mode_enable(val);
> +
> ? ? ? ?return 0;
> ?}
>
> @@ -274,8 +278,16 @@ static int __init pm_dbg_init(void)
>
> ? ? ? ?pwrdm_for_each(pwrdms_setup, (void *)d);
>
> - ? ? ? (void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&enable_off_mode, &pm_dbg_option_fops);
> + ? ? ? if (cpu_is_omap34xx())
> + ? ? ? ? ? ? ? (void) debugfs_create_file("enable_off_mode",
> + ? ? ? ? ? ? ? ? ? ? ? S_IRUGO | S_IWUSR, d, &enable_off_mode,
> + ? ? ? ? ? ? ? ? ? ? ? &pm_dbg_option_fops);
Is the enable_off_mode entry needed on other OMAP platorms (OMAP<3)?

> +
> + ? ? ? if (cpu_is_omap44xx())
> + ? ? ? ? ? ? ? (void) debugfs_create_file("enable_oswr_mode",
> + ? ? ? ? ? ? ? ? ? ? ? S_IRUGO | S_IWUSR, d, &enable_oswr_mode,
> + ? ? ? ? ? ? ? ? ? ? ? &pm_dbg_option_fops);
> +
> ? ? ? ?pm_dbg_init_done = 1;

Regards,
Jean
