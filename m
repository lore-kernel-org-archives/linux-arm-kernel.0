From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Apr 2015 10:42:23 +0100
Subject: [PATCH] arm64: kill flush_cache_all()
In-Reply-To: <1429521875-16893-1-git-send-email-mark.rutland@arm.com>
References: <1429521875-16893-1-git-send-email-mark.rutland@arm.com>
Message-ID: <5534C9FF.2030703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 20/04/15 10:24, Mark Rutland wrote:
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

I assume you mean that kexec will perform VA maintenance as part of its
private cpu_soft_reset implementation, not that it will reimplement
flush by S/W as a private method...

> This patch removes flush_cache_all, and related unused components,
> preventing further abuse.

Excellent. I'm pleased we're getting rid of this code which could only
be (ab)used by broken code. Hopefully this will send a clear message
that maintenance by VA is the only way we can *safely* deal with caches
on arm64.

> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
