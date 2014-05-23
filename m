From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 14:56:07 +0200
Subject: [PATCH 03/10] irqchip: versatile-fpga: add pass-thru enable
 support
In-Reply-To: <1400620176-7239-4-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-4-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdbarWMjn6cVSeWCFO7v9Qj_np5gL+7=NMB7NHkoMEPovA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:09 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Set the PIC_ENABLES register when the passthru-mask property is present.
> This enables interrupts on the secondary controller to be passed thru
> directly to the primary controller.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>

(...)

> +#define PIC_ENABLES             0x20   /* set interrupt pass through bits */

What register is this? In this hardware register 0x20 is
#define FIQ_STATUS              0x20

Do you mean that this FPGA IRQ controller is an augmented version
with the FIQ portions removed and instead it has some special
routing register at 0x20?

In that case it should have a different compatible-string should it not?

I was under the impression that this was just a simple cascaded
IRQ controller cascaded off bit 31 of the VIC, which is much simpler
to handle, maybe in the manner of commits
e641b987c20832dfaaa51d7792ed928c2b2d2dbf
"irqchip: support cascaded VICs"
f6da9fe45c3074b909084ae9da5f55034ebffeb4
"irqchip: vic: Properly chain the cascaded IRQs"

But for the fpga IRQ driver. Atleast that is how the comments in
the device tree says it should work so something is odd
here :-/

I really want to know how this special register works.

Yours,
Linus Walleij
