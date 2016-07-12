From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 12 Jul 2016 13:27:11 +0200
Subject: [PATCH] RFC: ARM: fix the uaccess crash on PB11MPCore
In-Reply-To: <1468256893-12811-1-git-send-email-linus.walleij@linaro.org>
References: <1468256893-12811-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAA3gFWsZJ3BV+FncGHnHvXSDnxbg_2FnugtgVnanPmmaqKOJAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-11 19:08 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
> The following patch was sketched by Russell in response to my
> crashes on the PB11MPCore after the patch for software-based
> priviledged no access support for ARMv8.1. See this thread:
> http://marc.info/?l=linux-arm-kernel&m=144051749807214&w=2
>
> I am unsure what is going on, I suspect everyone involved in
> the discussion is. I just want to repost this to get the
> discussion restarted, as I still have to apply this patch
> with every kernel iteration to get my PB11MPCore Realview
> running.
>
> I also know that Oxnas has actual, mass-deployed NAS (PogoPlug
> Pro variants) using PB11MPCore, and that they may or may not
> be seeing the same issue so I want their feedback on this: do
> you or do you not see this with mainline, or have you not even
> tested?

Hi Linus,

Actually the last off-tree support of the OX820 is on 4.4, and I do
not personally own a OX820 based device,
but I'm in he process of finding one to achieve upstream support along
the Ox810.

My comment over this patch is like yours, isn't there a way to narrow
such changes to ARMv6+SMP enabled kernels ? It would be a pity to have
such workaround enabled for V7 only kernels.

Neil

>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Fixes: a5e090acbf54 ("ARM: software-based priviledged-no-access support")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
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
>
>  static inline void ipi_flush_tlb_kernel_range(void *arg)
> --
> 2.7.4
>



-- 
Neil Armstrong
Embedded Linux Software Engineer
BayLibre - At the Heart of Embedded Linux
www.baylibre.com
