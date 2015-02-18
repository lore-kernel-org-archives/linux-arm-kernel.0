From: robherring2@gmail.com (Rob Herring)
Date: Wed, 18 Feb 2015 09:50:12 -0600
Subject: [PATCH v2 3/3] xen/arm: allow console=hvc0 to be omitted for
 guests
In-Reply-To: <1424267513-15836-4-git-send-email-julien.grall@linaro.org>
References: <1424267513-15836-1-git-send-email-julien.grall@linaro.org>
 <1424267513-15836-4-git-send-email-julien.grall@linaro.org>
Message-ID: <CAL_Jsq+QniOFiVXEhuS+GEEnCkUpkrmtdE5E4ZytwTzoQSDpOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 7:51 AM, Julien Grall <julien.grall@linaro.org> wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> This patch registers hvc0 as the preferred console if no console
> has been specified explicitly on the kernel command line.
>
> The purpose is to allow platform agnostic kernels and boot images
> (such as distro installers) to boot in a Xen/ARM domU without the
> need to modify the command line by hand.

How does this interact with DT chosen stdout-path?

Is there a node for hvc0?

Rob

>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Julien Grall <julien.grall@linaro.org>
> ---
>  arch/arm/xen/enlighten.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 1660432..904bd2d 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -24,6 +24,7 @@
>  #include <linux/cpuidle.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpu.h>
> +#include <linux/console.h>
>
>  #include <linux/mm.h>
>
> @@ -255,6 +256,9 @@ void __init xen_early_init(void)
>                 xen_start_info->flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
>         else
>                 xen_start_info->flags &= ~(SIF_INITDOMAIN|SIF_PRIVILEGED);
> +
> +       if (!console_set_on_cmdline && !xen_initial_domain())
> +               add_preferred_console("hvc", 0, NULL);
>  }
>
>  static int __init xen_guest_init(void)
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
