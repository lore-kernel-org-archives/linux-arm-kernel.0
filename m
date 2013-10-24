From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Oct 2013 16:46:22 +0100
Subject: [PATCH 11/14] arm64: big-endian: set correct endianess on
 kernel entry
In-Reply-To: <1381499540-28794-12-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
 <1381499540-28794-12-git-send-email-matthew.leach@arm.com>
Message-ID: <1382629582.7602.42.camel@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-10-11 at 14:52 +0100, Matthew Leach wrote:
> The endianness of memory accesses at EL2 and EL1 are configured by
> SCTLR_EL2.EE and SCTLR_EL1.EE respectively. When the kernel is booted,
> the state of SCTLR_EL{2,1}.EE is unknown, and thus the kernel must
> ensure that they are set before performing any memory accesses.
> 
> This patch ensures that SCTLR_EL{2,1} are configured appropriately at
> boot for kernels of either endianness.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Matthew Leach <matthew.leach@arm.com>
> ---
>  arch/arm64/kernel/head.S |   17 ++++++++++++++---
>  arch/arm64/mm/proc.S     |    4 ++--
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b3fcdf4..cd0ecb1 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -159,12 +159,22 @@ ENTRY(el2_setup)
>  	mrs	x0, CurrentEL
>  	cmp	x0, #PSR_MODE_EL2t
>  	ccmp	x0, #PSR_MODE_EL2h, #0x4, ne
> -	b.eq	1f
> +	b.ne	1f
> +	mrs	x0, sctlr_el2
> +CPU_BE(	orr	x0, x0, #(1 << 25)	)	// Set the EE bit for EL2
> +CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
> +	msr	sctlr_el2, x0
> +	b	2f
> +1:	mrs	x0, sctlr_el1
> +CPU_BE(	orr	x0, x0, #(2 << 24)	)	// Set the EE and E0E bits for EL1
> +CPU_LE(	bic	x0, x0, #(2 << 24)	)	// Clear the EE and E0E bits for EL1

Shouldn't this be (3 << 24)?

-- 
Catalin
