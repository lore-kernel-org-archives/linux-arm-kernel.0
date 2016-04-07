From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Apr 2016 10:38:53 +0100
Subject: [PATCH 1/8] arm64/kernel: use literal for relocated address of
 __secondary_switched
In-Reply-To: <1459781544-14310-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
 <1459781544-14310-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160407093853.GB1658@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 04:52:17PM +0200, Ard Biesheuvel wrote:
> We can simply use a relocated 64-bit literal to store the address of
> __secondary_switched(), and the relocation code will ensure that it
> holds the correct value at secondary entry time, as long as we make sure
> that the literal value is visible to the secondaries before they enable
> their MMUs. So place the literal next to kimage_vaddr, and set the alignment
> so that it is covered by the same cacheline that we already have to clean
> for a similar purpose.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4203d5f257bc..69b33535911e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -471,7 +471,8 @@ __mmap_switched:
>  	b	0b
>  
>  2:	adr_l	x8, kimage_vaddr		// make relocated kimage_vaddr
> -	dc	cvac, x8			// value visible to secondaries
> +						// and __secondary_switched
> +	dc	cvac, x8			// values visible to secondaries
>  	dsb	sy				// with MMU off
>  #endif
>  
> @@ -506,10 +507,12 @@ ENDPROC(__mmap_switched)
>   * end early head section, begin head code that is also used for
>   * hotplug and needs to have the same protections as the text region
>   */
> -	.section ".text","ax"
> -
> +	.section	".text","ax"
> +	.align		4
>  ENTRY(kimage_vaddr)

Since ENTRY already has a .align 4, can you drop the explicit directive
here?

Will
