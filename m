From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Oct 2015 09:51:04 +0200
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <20151009112418.GN32532@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
 <CACRpkdZhJfsH0wU0VBotT=yomDqBkKWrz3MNFOin=CCz62v_nw@mail.gmail.com>
 <20151009105309.GM26278@arm.com>
 <20151009112418.GN32532@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYDQgRqFgo4Y+_8NytrusNYPCzwcNXAXcGAQXDe00z3MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 1:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Linus, can you try the patch below to see if it resolves the problem
> you're seeing please?
>
>  arch/arm/kernel/smp_tlb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
> index 2e72be4f623e..7cb079e74010 100644
> --- a/arch/arm/kernel/smp_tlb.c
> +++ b/arch/arm/kernel/smp_tlb.c
> @@ -9,6 +9,7 @@
>   */
>  #include <linux/preempt.h>
>  #include <linux/smp.h>
> +#include <linux/uaccess.h>
>
>  #include <asm/smp_plat.h>
>  #include <asm/tlbflush.h>
> @@ -40,8 +41,11 @@ static inline void ipi_flush_tlb_mm(void *arg)
>  static inline void ipi_flush_tlb_page(void *arg)
>  {
>         struct tlb_args *ta = (struct tlb_args *)arg;
> +       unsigned int __ua_flags = uaccess_save_and_enable();
>
>         local_flush_tlb_page(ta->ta_vma, ta->ta_start);
> +
> +       uaccess_restore(__ua_flags);
>  }
>
>  static inline void ipi_flush_tlb_kernel_page(void *arg)
> @@ -54,8 +58,11 @@ static inline void ipi_flush_tlb_kernel_page(void *arg)
>  static inline void ipi_flush_tlb_range(void *arg)
>  {
>         struct tlb_args *ta = (struct tlb_args *)arg;
> +       unsigned int __ua_flags = uaccess_save_and_enable();
>
>         local_flush_tlb_range(ta->ta_vma, ta->ta_start, ta->ta_end);
> +
> +       uaccess_restore(__ua_flags);
>  }

Yes this makes it rock solid again.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

I guess it will only affect ARMv6 SMP (11MPCore) machines and there
are not so many of them AFAICT, so I guess it's a bit annoying to have
that in the ipi_flush_tlb_kernel_page() for all of the ARM CPUs :(
but it does work.

Yours,
Linus Walleij
