From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 06 Oct 2015 18:18:12 -0700
Subject: [PATCH v2 03/10] arm64: flush: use local TLB and I-cache
 invalidation
In-Reply-To: <1444153590-24173-4-git-send-email-will.deacon@arm.com>
References: <1444153590-24173-1-git-send-email-will.deacon@arm.com>
 <1444153590-24173-4-git-send-email-will.deacon@arm.com>
Message-ID: <561472D4.4060608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2015 10:46 AM, Will Deacon wrote:
> There are a number of places where a single CPU is running with a
> private page-table and we need to perform maintenance on the TLB and
> I-cache in order to ensure correctness, but do not require the operation
> to be broadcast to other CPUs.
>
> This patch adds local variants of tlb_flush_all and __flush_icache_all
> to support these use-cases and updates the callers respectively.
> __local_flush_icache_all also implies an isb, since it is intended to be
> used synchronously.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

I like this one.  It is similar to what some of my earlier patches did.

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   arch/arm64/include/asm/cacheflush.h | 7 +++++++
>   arch/arm64/include/asm/tlbflush.h   | 8 ++++++++
>   arch/arm64/kernel/efi.c             | 4 ++--
>   arch/arm64/kernel/smp.c             | 2 +-
>   arch/arm64/kernel/suspend.c         | 2 +-
>   arch/arm64/mm/context.c             | 4 ++--
>   arch/arm64/mm/mmu.c                 | 2 +-
>   7 files changed, 22 insertions(+), 7 deletions(-)
>
[...]
