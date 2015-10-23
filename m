From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Oct 2015 10:05:06 +0200
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <20151009112418.GN32532@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
 <CACRpkdZhJfsH0wU0VBotT=yomDqBkKWrz3MNFOin=CCz62v_nw@mail.gmail.com>
 <20151009105309.GM26278@arm.com>
 <20151009112418.GN32532@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdb0KavGAQ4XVb1n3P0tZ2Tf9K4EvEtoYCiZ47hKi5MjFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 1:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>  [Will]
>> It's weird that this only seems to happen on 11MPCore
>> though; if this core was one of the guys getting cross-called, then I
>> could understand the bug, but the lr suggests that CPU 2 is initiating
>> the flush, so I'd expect the same problem to appear on any ARMv6 part.
>
> It sounds to me like a CPU bug, but one which we need to work around.
> ipi_flush_tlb_range() will be the function concerned, we need to
> save-and-enable, and then restore the user access state around that
> call.
>
>> Russell, have you tried the s/w PAN stuff on any v6 CPUs?
>
> No.  I have considered having the Realview EB board as part of the test
> farm, but as that board is hassle to get going, I deem the hardware to
> be too unreliable for that.  (I reported the problem at the time.)
>
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
>
>  static inline void ipi_flush_tlb_kernel_range(void *arg)

Do we have a solution for this?

I'm carrying the patch and v4.3-rc6 is broken on upstream
RealView PB11MPCore, at least for me. :(

Yours,
Linus Walleij
