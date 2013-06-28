From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 28 Jun 2013 13:15:55 +0800
Subject: [PATCH] mmp: irq: Don't clear unused interrupt enable bits
In-Reply-To: <20130627175118.8A9FEFAACF@dev.laptop.org>
References: <20130627175118.8A9FEFAACF@dev.laptop.org>
Message-ID: <CAMPhdO_Ccp_JeuNNkqP6Q+ubmG8rah_hkxFJmOBsetysu-+dNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 1:51 AM, Daniel Drake <dsd@laptop.org> wrote:
>
> When enabling/masking interrupts, the existing MMP2 code clears
> a mask of 0x7f in the interrupt enable register.
> The lower 5 bits here are not directly used by Linux:
>  0:3 is interrupt priority
>  4 determines whether the interrupt gets delivered to the Security Processor
>
> In the OLPC case, a special firmware is running on the SP, and we do not
> want to mask it from receiving the interrupts it has already unmasked.
>
> Refine the mask to only deal with the bits that are of specific interest
> to Linux running on the main CPU.

Is there any way to check this at run-time or at least by boot parameters?
Decide whether the interrupt gets delivered to SP seems to be a choice
that the main CPU should be doing, as well as the interrupt priority.

And this is really all about bit 4 right?

>
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  arch/arm/mach-mmp/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
> index ac92433..21cc0b5 100644
> --- a/arch/arm/mach-mmp/irq.c
> +++ b/arch/arm/mach-mmp/irq.c
> @@ -190,7 +190,7 @@ static struct mmp_intc_conf mmp_conf = {
>  static struct mmp_intc_conf mmp2_conf = {
>         .conf_enable    = 0x20,
>         .conf_disable   = 0x0,
> -       .conf_mask      = 0x7f,
> +       .conf_mask      = 0x60,
>  };
>
>  /* MMP (ARMv5) */
> --
> 1.8.1.4
>
