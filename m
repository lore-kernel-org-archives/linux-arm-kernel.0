From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 18:22:57 +0000
Subject: [PATCH 4/7] ARM: Thumb-2: Correct data alignment for
	CONFIG_THUMB2_KERNEL in kernel/head.S
In-Reply-To: <1289913277-8822-4-git-send-email-dave.martin@linaro.org>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
	<1289913277-8822-4-git-send-email-dave.martin@linaro.org>
Message-ID: <20101116182257.GB21926@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 01:14:34PM +0000, Dave Martin wrote:
> Directives such as .long and .word do not magically cause the
> assembler location counter to become aligned in gas.  As a
> result, using these directives in code sections can result in
> misaligned data words when building a Thumb-2 kernel
> (CONFIG_THUMB2_KERNEL).

> @@ -413,6 +416,7 @@ __fixup_smp_on_up:
>  	mov	pc, lr
>  ENDPROC(__fixup_smp)
>  
> +	.align
>  1:	.word	.
>  	.word	__smpalt_begin
>  	.word	__smpalt_end

This one is technically bogus because this feature is disabled (and
incompatible) with Thumb-2 kernels.  So it never gets built for a T2
kernel.
