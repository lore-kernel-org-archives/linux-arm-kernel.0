From: julien.grall@linaro.org (Julien Grall)
Date: Fri, 13 Feb 2015 15:03:46 +0800
Subject: [PATCH v2] xen/arm: allow console=hvc0 to be omitted for guests
In-Reply-To: <1423740543-6168-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1423740543-6168-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <54DDA1D2.5010001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 12/02/2015 19:29, Ard Biesheuvel wrote:
> This patch registers hvc0 as the preferred console if no console
> has been specified explicitly on the kernel command line.
>
> The purpose is to allow platform agnostic kernels and boot images
> (such as distro installers) to boot in a Xen/ARM domU without the
> need to modify the command line by hand.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>   arch/arm/xen/enlighten.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 0abeefa7dbf8..927be1d1bad7 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -24,6 +24,7 @@
>   #include <linux/cpuidle.h>
>   #include <linux/cpufreq.h>
>   #include <linux/cpu.h>
> +#include <linux/console.h>
>
>   #include <linux/mm.h>
>
> @@ -255,6 +256,9 @@ void __init xen_early_init(void)
>   		xen_start_info->flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
>   	else
>   		xen_start_info->flags &= ~(SIF_INITDOMAIN|SIF_PRIVILEGED);
> +
> +	if (!console_set_on_cmdline && !xen_initial_domain())
> +		add_preferred_console("hvc", 0, NULL);

Unfortunately, this won't work as expected.

console_set_on_cmdline is set when Linux parses the early params. The 
parsing is done after setup_arch (the function which call xen_early_init).

So we will end up to add the HVC console even if a console has been 
passed on the command line.

>   }
>
>   static int __init xen_guest_init(void)
>

Regards,

-- 
Julien Grall
