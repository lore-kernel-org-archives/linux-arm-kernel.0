From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jan 2018 10:30:41 +0000
Subject: [PATCH v2 4/9] arm64: kpti: Add ->enable callback to remap
 swapper using nG mappings
In-Reply-To: <1517227200-20412-5-git-send-email-will.deacon@arm.com>
References: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
 <1517227200-20412-5-git-send-email-will.deacon@arm.com>
Message-ID: <20180130103041.GA29693@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 11:59:55AM +0000, Will Deacon wrote:
> Defaulting to global mappings for kernel space is generally good for
> performance and appears to be necessary for Cavium ThunderX. If we
> subsequently decide that we need to enable kpti, then we need to rewrite
> our existing page table entries to be non-global. This is fiddly, and
> made worse by the possible use of contiguous mappings, which require
> a strict break-before-make sequence.
> 
> Since the enable callback runs on each online CPU from stop_machine
> context, we can have all CPUs enter the idmap, where secondaries can
> wait for the primary CPU to rewrite swapper with its MMU off. It's all
> fairly horrible, but at least it only runs once.
> 
> Tested-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/assembler.h |  10 ++
>  arch/arm64/kernel/cpufeature.c     |  25 +++++
>  arch/arm64/mm/proc.S               | 204 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 231 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 3873dd7b5a32..23251eae6e8a 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -523,6 +523,16 @@ alternative_endif
>  #endif
>  	.endm
>  
> +	.macro	pte_to_phys, phys, pte
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +	ror	\phys, \pte, #16
> +	bfi	\phys, \phys, #(16 + 12), #32
> +	lsr	\phys, \phys, #12

I spun this up on a model with 52-bit PA support and it doesn't work,
unfortunately, because the lsr of #12 leaves 4 bits of the OA in the bottom
nybble. Instead, we need the following on top:

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index f311a1ed34d0..f4f3350f697e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -539,9 +539,9 @@ alternative_endif
 
 	.macro	pte_to_phys, phys, pte
 #ifdef CONFIG_ARM64_PA_BITS_52
-	ror	\phys, \pte, #16
-	bfi	\phys, \phys, #(16 + 12), #32
-	lsr	\phys, \phys, #12
+	ubfiz	\phys, \pte, #(48 - 16 - 12), #16
+	bfxil	\phys, \pte, #16, #32
+	lsl	\phys, \phys, #16
 #else
 	and	\phys, \pte, #PTE_ADDR_MASK
 #endif

Will
