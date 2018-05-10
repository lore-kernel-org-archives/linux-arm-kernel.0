From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 May 2018 17:41:48 +0100
Subject: [PATCH v7 06/16] arm64/sve: Refactor user SVE trap maintenance
 for external use
In-Reply-To: <1525882385-29181-7-git-send-email-Dave.Martin@arm.com>
References: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
 <1525882385-29181-7-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180510164148.ihcst6o5eau4vlme@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:12:55PM +0100, Dave P Martin wrote:
> In preparation for optimising the way KVM manages switching the
> guest and host FPSIMD state, it is necessary to provide a means for
> code outside arch/arm64/kernel/fpsimd.c to restore the user trap
> configuration for SVE correctly for the current task.
> 
> Rather than requiring external code to duplicate the maintenance
> explicitly, this patch wraps moves the trap maintenenace to
> fpsimd_bind_to_cpu(), since it is logically part of the work of
> associating the current task with the cpu.
> 
> Because fpsimd_bind_to_cpu() is rather a cryptic name to publish
> alongside fpsimd_bind_state_to_cpu(), the former function is
> renamed to fpsimd_bind_task_to_cpu() to make its purpose more
> explicit.
> 
> This patch makes appropriate changes to ensure that
> fpsimd_bind_task_to_cpu() is always called alongside
> task_fpsimd_load(), so that the trap maintenance continues to be
> done in every situation where it was done prior to this patch.
> 
> As a side-effect, the metadata updates done by
> fpsimd_bind_task_to_cpu() now change from conditional to
> unconditional in the "already bound" case of sigreturn.  This is
> harmless, and a couple of extra stores on this slow path will not
> impact performance.  I consider this a reasonable price to pay for
> a slightly cleaner interface.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
