From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Aug 2013 18:03:46 +0100
Subject: [PATCH 05/19] ARM: pl01x debug code endian fix
In-Reply-To: <1377639509-22778-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-6-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130828170346.GJ3842@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 10:38:15PM +0100, Ben Dooks wrote:
> The PL01X debug code needs to take into account which endian mode the
> processor is running in. If it is big-endian, ensure the data is swapped
> appropriately.
> 
> Note, we could do this slightly more efficiently if we have an macro to
> do the necessary swap for the bits used by test.

Hmm, opcodes.h already has the asm-compatible byteswappers, but the
interface it provides is not correct to allow them to be used cleanly
for data swabbing.

Maybe that would be worth factoring out sometime, but this patch
should work as-is.

Cheers
---Dave

> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>
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
