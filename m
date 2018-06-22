From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Jun 2018 16:25:37 +0100
Subject: [PATCH] arm64: mm: Ensure writes to swapper are ordered wrt
 subsequent cache maintenance
In-Reply-To: <1529681025-20850-1-git-send-email-will.deacon@arm.com>
References: <1529681025-20850-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180622152537.6ctubjass2widjo3@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 04:23:45PM +0100, Will Deacon wrote:
> When rewriting swapper using nG mappings, we must performance cache
> maintenance around each page table access in order to avoid coherency
> problems with the host's cacheable alias under KVM. To ensure correct
> ordering of the maintenance with respect to Device memory accesses made
> with the Stage-1 MMU disabled, DMBs need to be added between the
> maintenance and the corresponding memory access.
> 
> This patch adds a missing DMB between writing a new page table entry and
> performing a clean+invalidate on the same line.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/mm/proc.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 5f9a73a4452c..03646e6a2ef4 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -217,8 +217,9 @@ ENDPROC(idmap_cpu_replace_ttbr1)
>  
>  	.macro __idmap_kpti_put_pgtable_ent_ng, type
>  	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
> -	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
> -	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
> +	str	\type, [cur_\()\type\()p]	// Update the entry and ensure
> +	dmb	sy				// that it is visible to all
> +	dc	civac, cur_\()\type\()p		// CPUs.
>  	.endm
>  
>  /*
> -- 
> 2.1.4
> 
