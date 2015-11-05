From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Nov 2015 14:37:23 +0000
Subject: [PATCH] arm64: cmpxchg_dbl: fix return value type
In-Reply-To: <1446732056-31294-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1446732056-31294-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20151105143722.GD26684@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 02:00:56PM +0000, Lorenzo Pieralisi wrote:
> The current arm64 __cmpxchg_double{_mb} implementations carry out the
> compare exchange by first comparing the old values passed in to the
> values read from the pointer provided and by stashing the cumulative
> bitwise difference in a 64-bit register.
> 
> By comparing the register content against 0, it is possible to detect if
> the values read differ from the old values passed in, so that the compare
> exchange detects whether it has to bail out or carry on completing the
> operation with the exchange.
> 
> Given the current implementation, to detect the cmpxchg operation
> status, the __cmpxchg_double{_mb} functions should return the 64-bit
> stashed bitwise difference so that the caller can detect cmpxchg failure
> by comparing the return value content against 0. The current implementation
> declares the return value as an int, which means that the 64-bit
> value stashing the bitwise difference is truncated before being
> returned to the __cmpxchg_double{_mb} callers, which means that
> any bitwise difference present in the top 32 bits goes undetected,
> triggering false positives and subsequent kernel failures.
> 
> This patch fixes the issue by declaring the arm64 __cmpxchg_double{_mb}
> return values as a long, so that the bitwise difference is
> properly propagated on failure, restoring the expected behaviour.
> 
> Fixes: e9a4b795652f ("arm64: cmpxchg_dbl: patch in lse instructions when
> supported by the CPU")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: <stable@vger.kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/atomic_ll_sc.h | 2 +-
>  arch/arm64/include/asm/atomic_lse.h   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks for debugging this :)

Will
