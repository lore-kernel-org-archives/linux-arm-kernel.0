From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Oct 2016 17:52:40 +0100
Subject: [PATCH 2/3] arm64: mm: Set PSTATE.PAN from the cpu_enable_pan()
 call
In-Reply-To: <1476786468-2173-3-git-send-email-james.morse@arm.com>
References: <1476786468-2173-1-git-send-email-james.morse@arm.com>
 <1476786468-2173-3-git-send-email-james.morse@arm.com>
Message-ID: <20161019165239.GV9193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 11:27:47AM +0100, James Morse wrote:
> Commit 338d4f49d6f7 ("arm64: kernel: Add support for Privileged Access
> Never") enabled PAN by enabling the 'SPAN' feature-bit in SCTLR_EL1.
> This means the PSTATE.PAN bit won't be set until the next return to the
> kernel from userspace. On a preemptible kernel we may schedule work that
> accesses userspace on a CPU before it has done this.
> 
> Now that cpufeature enable() calls are scheduled via stop_machine(), we
> can set PSTATE.PAN from the cpu_enable_pan() call.
> 
> Add WARN_ON_ONCE(in_interrupt()) to check the PSTATE value we updated
> is not immediately discarded.
> 
> Reported-by: Tony Thompson <anthony.thompson@arm.com>
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> This patch depends on 'arm64: cpufeature: Schedule enable() calls instead
> of calling them via IPI', which doesn't apply to linux-stable versions
> before v4.8.
> 
>  arch/arm64/mm/fault.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 3e9ff9b0c78d..f942ab6cc206 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -29,7 +29,9 @@
>  #include <linux/sched.h>
>  #include <linux/highmem.h>
>  #include <linux/perf_event.h>
> +#include <linux/preempt.h>
>  
> +#include <asm/bug.h>
>  #include <asm/cpufeature.h>
>  #include <asm/exception.h>
>  #include <asm/debug-monitors.h>
> @@ -672,7 +674,14 @@ NOKPROBE_SYMBOL(do_debug_exception);
>  #ifdef CONFIG_ARM64_PAN
>  int cpu_enable_pan(void *__unused)
>  {
> +	/*
> +	 * We modify PSTATE. This won't work from irq context as the PSTATE
> +	 * is discared once we return from the exception.
> +	 */

I fixed the typo in the comment and queued these as fixes. Please take
care of stable once these are in mainline.

Will
