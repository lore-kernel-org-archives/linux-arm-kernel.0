From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 19 Feb 2013 12:27:34 +0000
Subject: [PATCH 5/9] ARM: pl01x debug code endian fix
In-Reply-To: <1360752927-29331-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1360752927-29331-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360752927-29331-6-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130219122734.GE1978@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 10:55:23AM +0000, Ben Dooks wrote:
> The PL01X debug code needs to take into account which endian mode the
> processor is running in. If it is big-endian, ensure the data is swapped
> appropriately.

Looks reasonable ... has you been able to test this?
 
> Note, we could do this slightly more efficiently if we have an macro to
> do the necessary swap for the bits used by test.

arch/arm/include/asm/opcodes.h has some swabbing macros which work in
assembler.  Would those help?  I'm wondering whether those ought to move
somewhere else, with cpu_to_mem style wrappers.  Currently, the only
wrappers there are tailored for handling opcodes, but the principle is
the same.

Cheers
---Dave

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/include/asm/hardware/debug-pl01x.S |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/hardware/debug-pl01x.S b/arch/arm/include/asm/hardware/debug-pl01x.S
> index f9fd083..6489d1f 100644
> --- a/arch/arm/include/asm/hardware/debug-pl01x.S
> +++ b/arch/arm/include/asm/hardware/debug-pl01x.S
> @@ -18,12 +18,14 @@
>  
>  		.macro	waituart,rd,rx
>  1001:		ldr	\rd, [\rx, #UART01x_FR]
> + ARM_BE8(	rev	\rd, \rd )
>  		tst	\rd, #UART01x_FR_TXFF
>  		bne	1001b
>  		.endm
>  
>  		.macro	busyuart,rd,rx
>  1001:		ldr	\rd, [\rx, #UART01x_FR]
> + ARM_BE8(	rev	\rd, \rd )
>  		tst	\rd, #UART01x_FR_BUSY
>  		bne	1001b
>  		.endm
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
