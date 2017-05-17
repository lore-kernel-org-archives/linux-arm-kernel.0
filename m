From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 May 2017 17:05:31 +0100
Subject: [PATCHv5] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <1494944285-12152-1-git-send-email-mark.rutland@arm.com>
References: <1494944285-12152-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170517160530.GB18716@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 03:18:05PM +0100, Mark Rutland wrote:
> Currently, cpus_set_cap() calls static_branch_enable_cpuslocked(), which
> must take the jump_label mutex.
> 
> We call cpus_set_cap() in the secondary bringup path, from the idle
> thread where interrupts are disabled. Taking a mutex in this path "is a
> NONO" regardless of whether it's contended, and something we must avoid.
> We didn't spot this until recently, as ___might_sleep() won't warn for
> this case until all CPUs have been brought up.
> 
> This patch avoids taking the mutex in the secondary bringup path. The
> poking of static keys is deferred until enable_cpu_capabilities(), which
> runs in a suitable context on the boot CPU. To account for the static
> keys being set later, cpus_have_const_cap() is updated to use another
> static key to check whether the const cap keys have been initialised,
> falling back to the caps bitmap until this is the case.
> 
> This means that users of cpus_have_const_cap() gain should only gain a
> single additional NOP in the fast path once the const caps are
> initialised, but should always see the current cap value.
> 
> The hyp code should never dereference the caps array, since the caps are
> initialized before we run the module initcall to initialise hyp. A check
> is added to the hyp init code to document this requirement.
> 
> This change will sidestep a number of issues when the upcoming hotplug
> locking rework is merged.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Marc Zyniger <marc.zyngier@arm.com>
> Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Sewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm64/include/asm/cpufeature.h | 12 ++++++++++--
>  arch/arm64/include/asm/kvm_host.h   |  8 ++++++--
>  arch/arm64/kernel/cpufeature.c      | 23 +++++++++++++++++++++--
>  3 files changed, 37 insertions(+), 6 deletions(-)
> 
> Catalin, can you take this as a fix for v4.12?

I queued it for 4.12-rc2. Thanks.

-- 
Catalin
