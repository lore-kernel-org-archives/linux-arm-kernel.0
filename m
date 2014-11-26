From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Nov 2014 16:30:01 +0000
Subject: [PATCH] arm64: jump labels: NOP out NOP -> NOP replacement
In-Reply-To: <1416942242-6587-1-git-send-email-mark.rutland@arm.com>
References: <1416942242-6587-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20141126163001.GL14866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 07:04:02PM +0000, Mark Rutland wrote:
> In the arm64 arch_static_branch implementation we place an A64 NOP into
> the instruction stream and log relevant details to a jump_entry in a
> __jump_table section. Later this may be replaced with an immediate
> branch without link to the code for the unlikely case.
> 
> At init time, the core calls arch_jump_label_transform_static to
> initialise the NOPs. On x86 this involves inserting the optimal NOP for
> a given microarchitecture, but on arm64 we only use the architectural
> NOP, and hence replace each NOP with the exact same NOP. This is
> somewhat pointless.
> 
> Additionally, at module load time we don't call jump_label_apply_nops to
> patch the optimal NOPs in, unlike other architectures, but get away with
> this because we only use the architectural NOP anyway. A later notifier
> will patch NOPs with branches as required.
> 
> Similarly to x86 commit 11570da1c5b1dee1 (x86/jump-label: Do not bother
> updating NOPs if they are correct), we can avoid patching NOPs with
> identical NOPs. Given that we only use a single NOP encoding, this means
> we can NOP-out the body of arch_jump_label_transform_static entirely. As
> the default __weak arch_jump_label_transform_static implementation
> performs a patch, we must use an empty function to achieve this.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jiang Liu <liuj97@gmail.com>
> Cc: Laura Abbott <lauraa@codeaurora.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---

Looks pretty boring:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

>  arch/arm64/kernel/jump_label.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
> index 9ac30bb..4f1fec7 100644
> --- a/arch/arm64/kernel/jump_label.c
> +++ b/arch/arm64/kernel/jump_label.c
> @@ -22,9 +22,8 @@
>  
>  #ifdef HAVE_JUMP_LABEL
>  
> -static void __arch_jump_label_transform(struct jump_entry *entry,
> -					enum jump_label_type type,
> -					bool is_static)
> +void arch_jump_label_transform(struct jump_entry *entry,
> +			       enum jump_label_type type)
>  {
>  	void *addr = (void *)entry->code;
>  	u32 insn;
> @@ -37,22 +36,18 @@ static void __arch_jump_label_transform(struct jump_entry *entry,
>  		insn = aarch64_insn_gen_nop();
>  	}
>  
> -	if (is_static)
> -		__aarch64_insn_patch_text_nosync(addr, insn, true);
> -	else
> -		aarch64_insn_patch_text(&addr, &insn, 1);
> -}
> -
> -void arch_jump_label_transform(struct jump_entry *entry,
> -			       enum jump_label_type type)
> -{
> -	__arch_jump_label_transform(entry, type, false);
> +	aarch64_insn_patch_text(&addr, &insn, 1);
>  }
>  
>  void arch_jump_label_transform_static(struct jump_entry *entry,
>  				      enum jump_label_type type)
>  {
> -	__arch_jump_label_transform(entry, type, true);
> +	/*
> +	 * We use the architected A64 NOP in arch_static_branch, so there's no
> +	 * need to patch an identical A64 NOP over the top of it here. The core
> +	 * will call arch_jump_label_transform from a module notifier if the
> +	 * NOP needs to be replaced by a branch.
> +	 */
>  }
>  
>  #endif	/* HAVE_JUMP_LABEL */
> -- 
> 1.9.1
> 
