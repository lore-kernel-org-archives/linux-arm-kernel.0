From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 16 May 2014 09:04:25 -0400
Subject: [PATCH 1/4] arm64: head.S: remove unnecessary function alignment
In-Reply-To: <1400233839-15140-2-git-send-email-mark.rutland@arm.com>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-2-git-send-email-mark.rutland@arm.com>
Message-ID: <53760CD9.1010200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 05/16/2014 05:50 AM, Mark Rutland wrote:
> Currently __turn_mmu_on is aligned to 64 bytes to ensure that it doesn't
> span any page boundary, which simplifies the idmap and spares us
> requiring an additional page table to map half of the function. In
> keeping with other important requirements in architecture code, this
> fact is undocumented.
> 
> Additionally, as the function consists of three instructions totalling
> 12 bytes with no literal pool data, a smaller alignment of 16 bytes
> would be sufficient.
> 
> This patch reduces the alignment to 16 bytes and documents the
> underlying reason for the alignment. This reduces the required alignment
> of the entire .head.text section from 64 bytes to 16 bytes, though it
> may still be aligned to a larger value depending on TEXT_OFFSET.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/head.S | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 0fd5650..e8e9883 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -346,8 +346,13 @@ ENDPROC(__enable_mmu)
>   *  x27 = *virtual* address to jump to upon completion
>   *
>   * other registers depend on the function called upon completion
> + *
> + * We align the entire function to the smallest power of two larger than it to
> + * ensure it fits within a single block map entry. Otherwise were PHYS_OFFSET
> + * close to the end of a 512MB or 1GB block we might require an additional
> + * table to map the entire function.
>   */
> -	.align	6
> +	.align	4
>  __turn_mmu_on:
>  	msr	sctlr_el1, x0
>  	isb

If you're feeling ambitious, this requirement could probably be enforced by
some kind of BUILD_BUG_ON((__turn_mmu_on_end - __turn_mmu_on) / 4 >
TURN_MMU_ON_ALIGN). I don't know if this code will really need to grow in
practice, but if it does, forgetting to update the alignment (in spite of your
helpful comment) seems like an easy mistake to make.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
