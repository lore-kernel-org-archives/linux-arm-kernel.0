From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 22:41:35 +0200
Subject: [PATCH] arm64: avoid TLB conflict with CONFIG_RANDOMIZE_BASE
In-Reply-To: <1472058128-1216-1-git-send-email-mark.rutland@arm.com>
References: <1472058128-1216-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu_TYRDibDcLr8uhB3nn-=HUFrgRgMxRgJBBqCCf5ObkxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2016 at 19:02, Mark Rutland <mark.rutland@arm.com> wrote:
> When CONFIG_RANDOMIZE_BASE is selected, we modify the page tables to remap the
> kernel at a newly-chosen VA range. We do this with the MMU disabled, but do not
> invalidate TLBs prior to re-enabling the MMU with the new tables. Thus the old
> mappings entries may still live in TLBs, and we risk violating
> Break-Before-Make requirements, leading to TLB conflicts and/or other issues.
>
> We invalidate TLBs when we uninsall the idmap in early setup code, but prior to
> this we are subject to issues relating to the Break-Before-Make violation.
>
> Avoid these issues by invalidating the TLBs before the new mappings can be
> used by the hardware.
>
> Fixes: f80fb3a3d50843a4 ("arm64: add support for kernel ASLR")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: stable at vger.kernel.org

Ah yes, brown paper bag time for me.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/kernel/head.S | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b77f583..3e7b050 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -757,6 +757,9 @@ ENTRY(__enable_mmu)
>         isb
>         bl      __create_page_tables            // recreate kernel mapping
>
> +       tlbi    vmalle1                         // Remove any stale TLB entries
> +       dsb     nsh
> +
>         msr     sctlr_el1, x19                  // re-enable the MMU
>         isb
>         ic      iallu                           // flush instructions fetched
> --
> 2.7.4
>
