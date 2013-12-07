From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 07 Dec 2013 15:12:24 +0000
Subject: [PATCH] ARM: asm: add readq/writeq methods
In-Reply-To: <52A32C88.9010000@arkona-technologies.de> (Matthias Mann's
 message of "Sat, 07 Dec 2013 15:11:20 +0100")
References: <52A32C88.9010000@arkona-technologies.de>
Message-ID: <yw1xlhzwlmp3.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthias Mann <M.Mann@arkona-technologies.de> writes:

> Add readq/writeq methods for 32 bit ARM to allow transfering 64 bit words over
> PCIe as a single transfer.
>
> Signed-off-by: Matthias Mann <m.mann@arkona-technologies.de>
> ---
> This patch creates checkpatch warnings, but I used the style used for the
> existing functions.
> It is based on branch next/soc of the arm-soc tree.
>
>  arch/arm/include/asm/io.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 3c597c2..0a8d015 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -94,6 +94,13 @@ static inline void __raw_writel(u32 val, volatile void __iomem *addr)
>  		     : "r" (val));
>  }
>
> +static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
> +{
> +	asm volatile("strd %1, %0"

Please use "strd %Q1, %R1, %0" here instead of relying on the
non-standard implicit second register operand.  Although current gcc
versions always allocate 64-bit values in even/odd register pairs, there
is no guarantee that this will always be the case (and llvm has no such
restriction).  In Thumb2, the registers do not need to be consecutive,
so implicitly adding 1 to the first register can silently result in
incorrect code.

For big endian, the register arguments need to be reversed.

> +		     : "+Qo" (*(volatile u64 __force *)addr)

The "o" constraint is not safe here.  The ldrd/strd instructions have a
limited offset range compared to ldr/str, so there is a risk that the
compiler-generated address is invalid.  Using "Q" forces the address to
be a single register, which is always safe.  This is why the 16-bit
versions of these functions use only "Q".  While this is slightly
suboptimal, there is unfortunately no constraint describing the
limitations of ldrd/strd addressing.

> +		     : "r" (val));
> +}

-- 
M?ns Rullg?rd
mans at mansr.com
