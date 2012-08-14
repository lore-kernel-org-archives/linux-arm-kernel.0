From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:25:59 +0200
Subject: [PATCH 7/8] mfd: Use the AB8500's IRQ domain to convert hwirq to
 virq
In-Reply-To: <1344527635-6163-8-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbYP3FNNC1nR9c6aYRsqpeaBJjQO4GKeuk05NUBkNcRpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Before the AB8500 had its own IRQ domain, the IRQ handler would take
> the fired local IRQ (hwirq) and add it to the irq_base to convert it
> to an IRQ number which Linux would understand (virq). However, the
> IRQ base is not always used anymore since we can make use of Linear
> domains. It's better to use the AB8500 hwirq -> virq mapping helper
> function to convert them instead. That's what we do here.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This looks better that what was in there before so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

However:

> @@ -501,8 +501,9 @@ static irqreturn_t ab8500_irq(int irq, void *dev)
>                 do {
>                         int bit = __ffs(value);
>                         int line = i * 8 + bit;
> +                       int virq = ab8500_irq_get_virq(ab8500, line);
>
> -                       handle_nested_irq(ab8500->irq_base + line);
> +                       handle_nested_irq(virq);
>                         value &= ~(1 << bit);

Still this ab8500_irq_get_virq() business. But is this a static local function
in the ab8500-core.c now? Then it's fine, it's the kernel-wide interface
that is the problem.

Yours,
Linus Walleij
