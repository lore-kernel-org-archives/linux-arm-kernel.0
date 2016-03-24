From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Mar 2016 16:31:21 +0000
Subject: [PATCH] arm64: mm: allow preemption in copy_to_user_page
In-Reply-To: <1458641488-21455-1-git-send-email-mark.rutland@arm.com>
References: <1458641488-21455-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160324163120.GE9113@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 10:11:28AM +0000, Mark Rutland wrote:
> Currently we disable preemption in copy_to_user_page; a behaviour that
> we inherited from the 32-bit arm code. This was necessary for older
> cores without broadcast data cache maintenance, and ensured that cache
> lines were dirtied and cleaned by the same CPU. On these systems dirty
> cache line migration was not possible, so this was sufficient to
> guarantee coherency.
> 
> On contemporary systems, cache coherence protocols permit (dirty) cache
> lines to migrate between CPUs as a result of speculation, prefetching,
> and other behaviours. To account for this, in ARMv8 data cache
> maintenance operations are broadcast and affect all data caches in the
> domain associated with the VA (i.e. ISH for kernel and user mappings).
> 
> In __switch_to we ensure that tasks can be safely migrated in the middle
> of a maintenance sequence, using a dsb(ish) to ensure prior explicit
> memory accesses are observed and cache maintenance operations are
> completed before a task can be run on another CPU.
> 
> Given the above, it is not necessary to disable preemption in
> copy_to_user_page. This patch removes the preempt_{disable,enable}
> calls, permitting preemption.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

-- 
Catalin
