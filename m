From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 14 Jan 2014 09:05:23 +0000
Subject: [PATCH] ARM: asm: __und_usr_thumb need byteswap instructions in
 BE case
In-Reply-To: <1389652251-18298-1-git-send-email-victor.kamensky@linaro.org>
References: <1389652251-18298-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140114090518.GA2222@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 02:30:51PM -0800, Victor Kamensky wrote:
> __und_usr_thumb function deals with thumb2 opcodes. In case of BE
> image, it needs to byteswap half word thumb2 encoded instructions
> before further processing them.
> 
> Without this fix BE image user-land thread executing first VFP
> instruction encoded in thumb2 fails with SIGILL, because kernel
> does not recognize instruction and does not enable VFP.
> 
> Reported-by: Corey Melton <comelton@cisco.com>
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

Good spot.  This looks like the correct fix to me.

Acked-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm/kernel/entry-armv.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index b3fb8c9..1879e8d 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -451,9 +451,11 @@ __und_usr_thumb:
>  	.arch	armv6t2
>  #endif
>  2:	ldrht	r5, [r4]
> +ARM_BE8(rev16	r5, r5)				@ little endian instruction
>  	cmp	r5, #0xe800			@ 32bit instruction if xx != 0
>  	blo	__und_usr_fault_16		@ 16bit undefined instruction
>  3:	ldrht	r0, [r2]
> +ARM_BE8(rev16	r0, r0)				@ little endian instruction
>  	add	r2, r2, #2			@ r2 is PC + 2, make it PC + 4
>  	str	r2, [sp, #S_PC]			@ it's a 2x16bit instr, update
>  	orr	r0, r0, r5, lsl #16
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
