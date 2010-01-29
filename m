From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Jan 2010 09:19:02 +0100
Subject: [RFC PATCH 12/12] arm: mm: qsd8x50: Fix incorrect permission
	faults
In-Reply-To: <1264719577-5436-13-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-13-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129081902.GA13333@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Dave Estes <cestes@quicinc.com>
> 
> Handle incorrectly reported permission faults for qsd8650.  On
> permission faults, retry MVA to PA conversion.  If retry detects
> translation fault.  Report as translation fault.
...
> @@ -29,5 +46,26 @@ ENTRY(v7_early_abort)
>  	 * V6 code adjusts the returned DFSR.
>  	 * New designs should not need to patch up faults.
>  	 */
> +
> +#if defined(CONFIG_VERIFY_PERMISSION_FAULT)
> +	/*
> +	 * Detect erroneous permission failures and fix
> +	 */
> +	ldr	r3, =0x40d			@ On permission fault
> +	and	r3, r1, r3
> +	cmp	r3, #0x0d
> +	movne	pc, lr
> +
> +	mcr	p15, 0, r0, c7, c8, 0   	@ Retranslate FAR
> +	isb
> +	mrc	p15, 0, r2, c7, c4, 0   	@ Read the PAR
> +	and	r3, r2, #0x7b   		@ On translation fault
> +	cmp	r3, #0x0b
> +	movne	pc, lr
> +	bic	r1, r1, #0xf			@ Fix up FSR FS[5:0]
> +	and	r2, r2, #0x7e
> +	orr	r1, r1, r2, LSR #1
> +#endif
> +
>  	mov	pc, lr

So you are working around qsd8650 hardware bug? That should probably
go to the comment here.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
