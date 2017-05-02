From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 2 May 2017 09:25:42 +0100
Subject: [PATCH] arm64: Fix multiple 'asm-operand-widths' warnings
In-Reply-To: <20170501212622.153720-1-mka@chromium.org>
References: <20170501212622.153720-1-mka@chromium.org>
Message-ID: <0f4ccaac-7cb0-6888-4127-e4ef15ebab25@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/17 22:26, Matthias Kaehlcke wrote:
> clang raises 'asm-operand-widths' warnings in inline assembly code when
> the size of an operand is < 64 bits and the operand width is unspecified.
> Most warnings are raised in macros, i.e. the datatype of the operand may
> vary. Forcing the use of an x register through the 'x' operand modifier
> would silence the warning however it involves the risk that for operands
> < 64 bits 'unused' bits may be assigned to 64-bit values (more details at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503816.html).
> Instead we cast the operand to 64 bits, which also forces the use of a
> x register, but without the unexpected behavior.
> 
> In gic_write_bpr1() use write_sysreg_s() to write the register. This
> aligns the functions with others in this header and fixes an
> 'asm-operand-widths' warning.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/include/asm/arch_gicv3.h  | 2 +-
>  arch/arm64/include/asm/barrier.h     | 2 +-
>  arch/arm64/include/asm/uaccess.h     | 2 +-
>  arch/arm64/kernel/armv8_deprecated.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
> index f37e3a21f6e7..9092d612d8c2 100644
> --- a/arch/arm64/include/asm/arch_gicv3.h
> +++ b/arch/arm64/include/asm/arch_gicv3.h
> @@ -166,7 +166,7 @@ static inline void gic_write_sre(u32 val)
>  
>  static inline void gic_write_bpr1(u32 val)
>  {
> -	asm volatile("msr_s " __stringify(ICC_BPR1_EL1) ", %0" : : "r" (val));
> +	write_sysreg_s(val, ICC_BPR1_EL1);
>  }

For the GICv3 part:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
