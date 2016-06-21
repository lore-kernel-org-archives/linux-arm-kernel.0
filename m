From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jun 2016 15:48:06 +0100
Subject: [PATCH 2/2] arm64: simplify dump_mem
In-Reply-To: <1465812915-19801-3-git-send-email-mark.rutland@arm.com>
References: <1465812915-19801-1-git-send-email-mark.rutland@arm.com>
 <1465812915-19801-3-git-send-email-mark.rutland@arm.com>
Message-ID: <20160621144806.GC14542@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 11:15:15AM +0100, Mark Rutland wrote:
> Currently dump_mem attempts to dump memory in 64-bit chunks when
> reporting a failure in 64-bit code, or 32-bit chunks when reporting a
> failure in 32-bit code. We added code to handle these two cases
> separately in commit e147ae6d7f908412 ("arm64: modify the dump mem for
> 64 bit addresses").
> 
> However, in all cases dump_mem is called, the failing context is a
> kernel rather than user context. Additionally dump_mem is assumed to
> only be used for kernel contexts, as internally it switches to
> KERNEL_DS, and its callers pass kernel stack bounds.
> 
> This patch removes the redundant 32-bit chunk logic and associated
> compat parameter, largely reverting the aforementioned commit. For the
> call in __die(), the check of in_interrupt() is removed also, as __die()
> is only called in response to faults from the kernel's exception level,
> and thus the !user_mode(regs) check is sufficient. Were this not the
> case, the used of task_stack_page(tsk) to generate the stack bounds
> would be erroneous.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Queued for 4.8. Thanks.

-- 
Catalin
