From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Apr 2015 10:59:40 +0100
Subject: [PATCH] arm64: kill flush_cache_all()
In-Reply-To: <1429521875-16893-1-git-send-email-mark.rutland@arm.com>
References: <1429521875-16893-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20150420095940.GB17937@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 10:24:35AM +0100, Mark Rutland wrote:
> The documented semantics of flush_cache_all are not possible to provide
> for arm64 (short of flushing the entire physical address space by VA),
> and there are currently no users; KVM uses VA maintenance exclusively,
> cpu_reset is never called, and the only two users outside of arch code
> cannot be built for arm64.
> 
> While cpu_soft_reset and related functions (which call flush_cache_all)
> were thought to be useful for kexec, their current implementations only
> serve to mask bugs. For correctness kexec will need to perform
> maintenance by VA anyway to account for system caches, line migration,
> and other subtleties of the cache architecture. As the extent of this
> cache maintenance will be kexec-specific, it should probably live in the
> kexec code.
> 
> This patch removes flush_cache_all, and related unused components,
> preventing further abuse.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cacheflush.h  |  5 ---
>  arch/arm64/include/asm/proc-fns.h    |  4 --
>  arch/arm64/include/asm/system_misc.h |  1 -
>  arch/arm64/kernel/process.c          | 12 +-----
>  arch/arm64/mm/cache.S                | 73 ------------------------------------
>  arch/arm64/mm/flush.c                |  1 -
>  arch/arm64/mm/proc.S                 | 46 -----------------------
>  7 files changed, 1 insertion(+), 141 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
