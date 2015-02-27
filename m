From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Feb 2015 11:53:47 -0600
Subject: [PATCH 3/8] ARM: make xscale iwmmxt code multiplatform aware
In-Reply-To: <1425043775-3106827-4-git-send-email-arnd@arndb.de>
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
 <1425043775-3106827-4-git-send-email-arnd@arndb.de>
Message-ID: <CAL_JsqJyhKQQ-9SdFkWu_Z1MKzHfxUtDjEPrDg=hYm3rnbsrFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 7:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> In a multiplatform configuration, we may end up building a kernel
> for both Marvell PJ1 and an ARMv4 CPU implementation. In that
> case, the xscale-cp0 code is built with gcc -march=armv4{,t},
> which results in a build error from the coprocessor instructions.
>
> Since we know this code will only have to run on an actual xscale
> processor, we can simply build the entire file for ARMv5TE.
>
> Related to this, we need to handle the iWMMXT initialization sequence
> differently during boot, to ensure we don't try to touch xscale
> specific registers on other CPUs from the xscale_cp0_init initcall.
> cpu_is_xscale() used to be hardcoded to '1' in any configuration
> that enables any XScale-compatible core, but this breaks once
> we can have a combined kernel with MMP1 and something else.
>
> In this patch, I introduce two new macros, cpu_is_xscale()
> and cpu_is_mohawk, so we can test for all three of them in
> the iwmmxt initialization. The two existing users of
> cpu_is_xscale() are modified accordingly, but slightly
> change behavior for kernels that enable CPU_MOHAWK in combination
> with CPU_XSCALE or CPU_XSC3. Previously, these would leave
> clear PMD_BIT4 in the page tables, now they leave it untouched,
> just like we always do for kernels that enable only CPU_MOHAWK.
> Since the previous behavior was inconsistent, I assume it was
> unintentional.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/cputype.h | 27 +++++++++++++++++++++++++--
>  arch/arm/kernel/Makefile       |  1 +
>  arch/arm/kernel/xscale-cp0.c   |  6 ++++++
>  arch/arm/mm/idmap.c            |  3 ++-
>  4 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 819777d0e91f..7bc66e22afd7 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -228,10 +228,33 @@ static inline int cpu_is_xsc3(void)
>  }
>  #endif
>
> -#if !defined(CONFIG_CPU_XSCALE) && !defined(CONFIG_CPU_XSC3)
> +#if !defined(CONFIG_CPU_XSCALE)

You could use IS_ENABLED here.

>  #define        cpu_is_xscale() 0
>  #else
> -#define        cpu_is_xscale() 1
> +static inline int cpu_is_xscale(void)
> +{
> +       unsigned int id;
> +       id = read_cpuid_id() & 0xffffe000;
> +
> +       if ((id == 0x69052000) || (id == 0x69054000))
> +               return 1;
> +
> +       return 0;
> +}
> +#endif
> +
> +#if !defined(CONFIG_CPU_MOHAWK)

And here.

> +#define        cpu_is_mohawk() 0
> +#else
> +static inline int cpu_is_mohawk(void)
> +{
> +       unsigned int id;
> +       id = read_cpuid_id() & 0xffffe000;
> +
> +       if (id == 0x56158000)
> +
> +       return 0;
> +}
>  #endif
>
>  /*
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 902397dd1000..7840acff6cd3 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)      += hw_breakpoint.o
>  obj-$(CONFIG_CPU_XSCALE)       += xscale-cp0.o
>  obj-$(CONFIG_CPU_XSC3)         += xscale-cp0.o
>  obj-$(CONFIG_CPU_MOHAWK)       += xscale-cp0.o
> +CFLAGS_xscale-cp0.o            += -Wa,-march=armv5te
>  obj-$(CONFIG_CPU_PJ4)          += pj4-cp0.o
>  obj-$(CONFIG_CPU_PJ4B)         += pj4-cp0.o
>  obj-$(CONFIG_IWMMXT)           += iwmmxt.o
> diff --git a/arch/arm/kernel/xscale-cp0.c b/arch/arm/kernel/xscale-cp0.c
> index bdbb8853a19b..a23420fab70e 100644
> --- a/arch/arm/kernel/xscale-cp0.c
> +++ b/arch/arm/kernel/xscale-cp0.c
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <asm/thread_notify.h>
> +#include <asm/cputype.h>
>
>  static inline void dsp_save_state(u32 *state)
>  {
> @@ -152,6 +153,11 @@ static int __init xscale_cp0_init(void)
>  {
>         u32 cp_access;
>
> +       /* do not attempt to probe iwmmxt on non-xscale family CPUs */
> +       if (IS_ENABLED(CONFIG_ARCH_MULTIPLATFORM) &&

Do you really need this condition?

> +           !(cpu_is_xscale() || cpu_is_xsc3() || cpu_is_mohawk()))
> +               return 0;
> +
>         cp_access = xscale_cp_access_read() & ~3;
>         xscale_cp_access_write(cp_access | 1);
>
> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index e7a81cebbb2e..40140984db0a 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -86,7 +86,8 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
>
>         prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
>
> -       if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
> +       if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ &&
> +           !cpu_is_xscale() && !cpu_is_xsc3())
>                 prot |= PMD_BIT4;
>
>         pgd += pgd_index(addr);
> --
> 2.1.0.rc2
>
