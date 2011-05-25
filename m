From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 25 May 2011 16:15:16 +0800
Subject: [GIT PULL] pxa: for next merge
In-Reply-To: <20110524231916.GD4652@n2100.arm.linux.org.uk>
References: <BANLkTin8tX_kfG_R6To+ktNbOW+B93LiqQ@mail.gmail.com>
	<20110524231916.GD4652@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikG_ySVXWRF5DN8HbBjsieY1pJaxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 7:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> I've just spotted this:
>
> +asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
> +{
> + ? ? ? uint32_t icip, icmr, mask;
> +
> + ? ? ? do {
> + ? ? ? ? ? ? ? icip = __raw_readl(IRQ_BASE + ICIP);
> + ? ? ? ? ? ? ? icmr = __raw_readl(IRQ_BASE + ICMR);
> + ? ? ? ? ? ? ? mask = icip & icmr;
> +
> + ? ? ? ? ? ? ? if (mask == 0)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> +
> + ? ? ? ? ? ? ? asm_do_IRQ(fls(mask) - 1, regs);
> + ? ? ? } while (1);
> +}
>
> This is bad news. ?A function marked as __exception is expected to be
> called from the assembly code. ?The above is fine, but it then goes on
> to call asm_do_IRQ() which is also marked __exception.
>
> This means the unwinder will attempt to dump the saved pt_regs register
> state for both asm_do_IRQ() and icip_handle_irq(), resulting in one of
> them being garbage.
>
> So I think this needs some thought.

Indeed. Do you have any suggestion? Or maybe we can merge this first,
and get it fixed later. There is pxa955 irq handling code waiting for this
feature though.

>
> Second point - can't the USB changes go via the USB people? ?Have USB
> people seen the patch?
>

I asked for Ack but actually no one cared.

One change affects only the Lubbock boards, which is fine to go from
my POV. The other though, indeed made a bit changes to pxa25x_udc.c.
