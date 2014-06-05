From: lv.zheng@intel.com (Zheng, Lv)
Date: Thu, 5 Jun 2014 00:56:51 +0000
Subject: [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI is enabled
In-Reply-To: <1401883796-17841-2-git-send-email-lee.jones@linaro.org>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-2-git-send-email-lee.jones@linaro.org>
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026203D0@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Lee

> From: Lee Jones [mailto:lee.jones at linaro.org]
> Sent: Wednesday, June 04, 2014 8:10 PM
> 
> Any drivers which support ACPI and Device Tree probing need to include
> both respective header files.  Without this patch, if a driver is being
> used on a platform which does not support ACPI and subsequently does not
> have the config option enabled, but includes linux/acpi.h the build
> breaks with:
> 
>   In file included from ../include/acpi/platform/acenv.h:150:0,
>                    from ../include/acpi/acpi.h:56,
>                    from ../include/linux/match.h:2,
>                    from ../drivers/i2c/i2c-core.c:43:
>   ../include/acpi/platform/aclinux.h:73:23:
>    fatal error: asm/acenv.h: No such file or directory
>    #include <asm/acenv.h>
>                        ^
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: linux-acpi at vger.kernel.org
> Cc: devel at acpica.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/acpi/platform/aclinux.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
> index cd1f052..fdf7663 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -70,9 +70,10 @@
>  #ifdef EXPORT_ACPI_INTERFACES
>  #include <linux/export.h>
>  #endif
> -#include <asm/acenv.h>
> 
> -#ifndef CONFIG_ACPI
> +#ifdef CONFIG_ACPI
> +#include <asm/acenv.h>
> +#else

This is exactly what I want to do in the next step.
But you are a bit faster here.
I believe:
The miss-ordered inclusions of <asm/acpi.h> is the culprit of all of the miss-ordered inclusions in arch/x86/include/asm.
You should have noted that <asm/acpi.h> was originally unexpected included by some x86 specific headers.
Simply doing <asm/acenv.h> exlusion in this way might be able to fix your issue for your architecture, but it could be very likely breaking x86 builds.
You might be able to find another way to solve your build issue - for example, creating an empty <asm/acenv.h> for arch/arm.

Thanks and best regards
-Lv

> 
>  /* External globals for __KERNEL__, stubs is needed */
> 
> --
> 1.8.3.2
