From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 4 Dec 2015 21:21:39 +0900
Subject: [PATCH v8 2/4] arm64: Modify stack trace and dump for use with
 irq_stack
In-Reply-To: <1449226948-14251-3-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-3-git-send-email-james.morse@arm.com>
Message-ID: <4526BE44-108F-4789-B674-CB1F2FB5E5B0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 4, 2015, at 8:02 PM, James Morse wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> This patch allows unwind_frame() to traverse from interrupt stack to task
> stack correctly. It requires data from a dummy stack frame, created
> during irq_stack_entry(), added by a later patch.
> 
> A similar approach is taken to modify dump_backtrace(), which expects to
> find struct pt_regs underneath any call to functions marked __exception.
> When on an irq_stack, the struct pt_regs is stored on the old task stack,
> the location of which is stored in the dummy stack frame.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> [merged two patches, reworked for per_cpu irq_stacks, and no alignment
> guarantees, added irq_stack definitions]
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> arch/arm64/include/asm/irq.h   | 32 ++++++++++++++++++++++++++++++++
> arch/arm64/kernel/irq.c        |  3 +++
> arch/arm64/kernel/stacktrace.c | 29 +++++++++++++++++++++++++++--
> arch/arm64/kernel/traps.c      | 14 +++++++++++++-
> 4 files changed, 75 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index 8e8d30684392..e2f3f135a3bc 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -1,10 +1,32 @@
> #ifndef __ASM_IRQ_H
> #define __ASM_IRQ_H
> 
> +#define IRQ_STACK_SIZE			THREAD_SIZE

I agree that it is unnecessary to reduce a process stack size at this stage.
But, it would be no issue to set IRQ_STACK_SIZE to 8KB now, which is aligned
with Catalin's comment [1].

Best Regards
Jungseok Lee

[1] http://www.spinics.net/lists/arm-kernel/msg463868.html

Best Regards
Jungseok Lee
