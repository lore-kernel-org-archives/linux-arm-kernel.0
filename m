From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 13:09:48 +0200
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <1317206507-18867-3-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
Message-ID: <CACRpkdYyurmMSF0LnN3Ut8fmQDkjVC5pNCeUWQ=ik8Ete6UYzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 12:41 PM, Jamie Iles <jamie@jamieiles.com> wrote:

> +static void vic_single_handle_irq(struct vic_device *vic, struct pt_regs *regs)
> +{
> + ? ? ? u32 stat, irq;
> + ? ? ? bool handled = false;
> +
> + ? ? ? while (!handled) {
> + ? ? ? ? ? ? ? stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> + ? ? ? ? ? ? ? if (!stat)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> +
> + ? ? ? ? ? ? ? while (stat) {
> + ? ? ? ? ? ? ? ? ? ? ? irq = fls(stat) - 1;

Isn't fls "find last set"?

That means IRQs with higher numbers will be handled first will it not?

For U300 IRQs with lower numbers will be handled first
by iteratively testing bit 0 and shifting right:

-1002:  tst     \irqstat, #1
-       bne     1003f
-       add     \irqnr, \irqnr, #1
-       movs    \irqstat, \irqstat, lsr #1
-       bne     1002b

So I would use ffs() for this to work the same way as before in
U300.

Since this can have some performance impact, if the platforms differ
in whether they handle IRQs from low to high or from high to low
might need to be a flag passed in to vic_init() or so...

Yours,
Linus Walleij
