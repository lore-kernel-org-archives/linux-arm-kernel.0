From: james.morse@arm.com (James Morse)
Date: Fri, 12 Aug 2016 19:07:07 +0100
Subject: [PATCH] arm64: hibernate: reduce TLB maintenance scope
In-Reply-To: <1470651127-18386-1-git-send-email-mark.rutland@arm.com>
References: <1470651127-18386-1-git-send-email-mark.rutland@arm.com>
Message-ID: <57AE104B.7010209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/16 11:12, Mark Rutland wrote:
> In break_before_make_ttbr_switch we perform broadcast TLB maintenance
> for the inner shareable domain, and use a DSB ISH to complete this.
> However, at the point we execute this, secondary CPUs are either
> physically offline, or executing code outside of the kernel. Upon
> entering the kernel, secondary CPUs will invalidate their TLBs before
> enabling their MMUs.
> 
> Thus we do not need to invalidate TLBs of other CPUs, and as with
> idmap_cpu_replace_ttbr1 we can reduce the scope of maintenance to the
> TLBs of the local CPU. This keeps our TLB maintenance code consistent,
> and is a minor optimisation.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/hibernate-asm.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
> index 46f29b6..7734f3e 100644
> --- a/arch/arm64/kernel/hibernate-asm.S
> +++ b/arch/arm64/kernel/hibernate-asm.S
> @@ -36,8 +36,8 @@
>  .macro break_before_make_ttbr_switch zero_page, page_table
>  	msr	ttbr1_el1, \zero_page
>  	isb
> -	tlbi	vmalle1is
> -	dsb	ish
> +	tlbi	vmalle1
> +	dsb	nsh
>  	msr	ttbr1_el1, \page_table
>  	isb
>  .endm
> 


Looks like what I should have done from the beginning!

Acked-by: James Morse <james.morse@arm.com>


Thanks,


James
