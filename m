From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jun 2015 13:16:38 +0200
Subject: [PATCH v2] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <1432821287-31436-1-git-send-email-michael@smart-africa.com>
References: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
 <1432821287-31436-1-git-send-email-michael@smart-africa.com>
Message-ID: <CACRpkdY4sZQr+VzMKzU2Rtm7sP2zMztBioCPQRJjq=VjyapAEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 3:54 PM, Michael van der Westhuizen
<michael@smart-africa.com> wrote:

> Fixes the TCM initialisation code to handle TCM banks that are
> present but inaccessible due to TrustZone configuration.  This is
> the default case when enabling the non-secure world.  It may also
> be the case that that the user decided to use TCM for TrustZone.
>
> This change has exposed a bug in handling of TCM where no TCM bank
> was usable (the 0 size TCM case).  This change addresses the
> resulting hang.
>
> This code only handles the ARMv6 TCMTR register format, and will not
> work correctly on boards that use the ARMv7 (or any other) format.
> This is handled by performing an early exit from the initialisation
> function when the TCMTR reports any format other than v6.
>
> Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Dave Martin <Dave.Martin@arm.com>
> ---
>
> Changes in v2:
>   - Mark the TCM undefined hook data structure as __initdata, since
>     that's what it is.
>   - Ensure that we're dealing with an ARMv6 TCMTR format.

OK...

> +#define TCMTR_FORMAT_MASK 0xe0000000U
>
>  static struct gen_pool *tcm_pool;
>  static bool dtcm_present;
> @@ -175,6 +178,21 @@ static int __init setup_tcm_bank(u8 type, u8 bank, u8 banks,
>         return 0;
>  }
>
> +static int __init tcm_handler(struct pt_regs *regs, unsigned int instr)
> +{
> +       regs->uregs[(instr >> 12) & 0xf] = 0;
> +       regs->ARM_pc += 4;
> +       return 0;
> +}

Is the action here totally obvious to everyone except me?
I guess it is masking off something and advancing past a
failed instruction but whatdoIknow. Can you put in a small comment
above the function or something?

> +static struct undef_hook tcm_hook __initdata = {
> +       .instr_mask     = 0xffff0fdf,
> +       .instr_val      = 0xee190f11,
> +       .cpsr_mask      = MODE_MASK,
> +       .cpsr_val       = SVC_MODE,
> +       .fn             = tcm_handler
> +};

Likewise here. Why not #define instruction 0xee190f11
so it is a bit more readable? I guess this instruction will
be trapped and handled by the hook but it'd be nice
to know what instruction it is and how it comes to
be issued.

> +               /* This means that the DTCM sizes were 0 or the DTCM banks
> +                * were inaccessible due to TrustZone configuration */

Nitpick:

/*
 * I prefer the comments like so: blank line after the
 * first slash-star, and sole star-slash on the last line.
 */

> +               /* This means that the ITCM sizes were 0 or the ITCM banks
> +                * were inaccessible due to TrustZone configuration */

Dito

Apart from that it looks good to me.

Yours,
Linus Walleij
