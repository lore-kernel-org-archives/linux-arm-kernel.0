From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Nov 2016 11:04:56 +0000
Subject: [PATCH 5/9] arm64: cpufeature: Define helpers for sys_reg id
In-Reply-To: <1479994809-9081-6-git-send-email-suzuki.poulose@arm.com>
References: <1479994809-9081-1-git-send-email-suzuki.poulose@arm.com>
 <1479994809-9081-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20161130110455.GD2724@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 01:40:05PM +0000, Suzuki K Poulose wrote:
> Define helper macros to extract op0, op1, CRn, CRm & op2
> for a given sys_reg id.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6c80b36..488b939 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -34,8 +34,27 @@
>   *	[11-8]  : CRm
>   *	[7-5]   : Op2
>   */
> +#define Op0_shift	19
> +#define Op0_mask	0x3
> +#define Op1_shift	16
> +#define Op1_mask	0x7
> +#define CRn_shift	12
> +#define CRn_mask	0xf
> +#define CRm_shift	8
> +#define CRm_mask	0xf
> +#define Op2_shift	5
> +#define Op2_mask	0x7
> +
>  #define sys_reg(op0, op1, crn, crm, op2) \
> -	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
> +	((((op0) & Op0_mask) << Op0_shift) | \
> +	 ((op1) << Op1_shift) | ((crn) << CRn_shift) | \
> +	 ((crm) << CRm_shift) | ((op2) << Op2_shift))

You're preserving the current behaviour here, but why do we care so much
about masking op0 but then not bother masking any of the other fields?

Will
