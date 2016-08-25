From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Aug 2016 11:14:19 +0100
Subject: [PATCH] arm64: avoid TLB conflict with CONFIG_RANDOMIZE_BASE
In-Reply-To: <1472058128-1216-1-git-send-email-mark.rutland@arm.com>
References: <1472058128-1216-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160825101419.GC20748@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 06:02:08PM +0100, Mark Rutland wrote:
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

Applied to arm64 fixes/core.

-- 
Catalin
