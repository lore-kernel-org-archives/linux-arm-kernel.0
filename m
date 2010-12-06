From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 10:11:00 +0000
Subject: [PATCH] ARM: Allow machine to specify it's own IRQ handlers at
	run-time
In-Reply-To: <AANLkTi=5sMZUwu+yhha=CugFwrhqTwYSTvKOHEbu8RE3@mail.gmail.com>
References: <AANLkTi=Unb_08zF8jStBJvbFeo01QprPt=ag0CrE1oLB@mail.gmail.com>
	<20101205092345.GA9138@n2100.arm.linux.org.uk>
	<AANLkTimbFYCxcSU0+c2Q2D2yQ1wRPMmTx1Pdtu3CvM4m@mail.gmail.com>
	<20101206080606.GA29563@n2100.arm.linux.org.uk>
	<AANLkTi=5sMZUwu+yhha=CugFwrhqTwYSTvKOHEbu8RE3@mail.gmail.com>
Message-ID: <20101206101100.GB29563@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 05:31:46PM +0800, Eric Miao wrote:
> Grrrr... wrong copy indeed. Corrected version below, I also made it less
> intrusive by judging on handle_arch_irq being NULL or not so to fall back
> to the original way of handling.
...
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index c09e357..4f446a2 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -30,6 +30,13 @@
>   * Interrupt handling.  Preserves r7, r8, r9
>   */
>  	.macro	irq_handler
> +#ifdef CONFIG_MULTI_IRQ_HANDLER
> +	ldr	r1, =handle_arch_irq
> +	cmp	r1, #0
> +	movne	r0, sp
> +	adrne	lr, BSYM(9997f)
> +	ldrne	pc, [r1]
> +#endif

Except this won't - you're testing the address of handle_arch_irq for
NULL, which it'll never be.
