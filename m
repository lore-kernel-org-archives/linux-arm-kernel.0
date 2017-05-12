From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 May 2017 11:36:47 +0100
Subject: [PATCHv3] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <1494584120-15208-1-git-send-email-mark.rutland@arm.com>
References: <1494584120-15208-1-git-send-email-mark.rutland@arm.com>
Message-ID: <8d037877-6fac-bf9c-ecf3-74b2e72b97f6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/17 11:15, Mark Rutland wrote:
> Currently, cpus_set_cap() calls static_branch_enable_cpuslocked(), which
> must take the jump_label mutex.
> 
> We call cpus_set_cap() in the secondary bringup path, from the idle
> thread where interrupts are disabled. Taking a mutex in this path "is a
> NONO" regardless of whether it's contended, and something we must avoid.
> Additionally, the secondary CPU doesn't hold the percpu rwsem (as this
> is held by the primary CPU), so this triggers a lockdep splat.
> 
> This patch fixes both issues. The poking of static keys is deferred
> until enable_cpu_capabilities(), which runs in a suitable context on the
> boot CPU. To account for the static keys being set later,
> cpus_have_const_cap() is updated to use another static key to check
> whether the const cap keys have been initialised, falling back to the
> caps bitmap until this is the case.
> 
> This means that users of cpus_have_const_cap() gain should only gain a
> single additional NOP in the fast path once the const caps are
> initialised, but should always see the current cap value.
> 
> The hyp code should never dereference the caps array, since the caps are
> initialized before we run the module initcall to initialise hyp. A check
> is added to the hyp init code to docuemnt this requirement.
> 
> This rework means that we can remove the *_cpuslocked() helpers added in
> commit d54bb72551b999dd ("arm64/cpufeature: Use
> static_branch_enable_cpuslocked()").
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyniger <marc.zyngier@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Sewior <bigeasy@linutronix.de>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 13 ++++++++++---
>  arch/arm64/include/asm/kvm_host.h   |  8 ++++++--
>  arch/arm64/kernel/cpu_errata.c      |  9 +--------
>  arch/arm64/kernel/cpufeature.c      | 25 ++++++++++++++++++++++---
>  4 files changed, 39 insertions(+), 16 deletions(-)
> 
> Catalin, Will, assuming you're happy with the patch, it will need to go via the
> tip tree.
> 
> Since v1 [1]:
> * Kill redundant update_cpu_errata_workarounds() prototype
> * Introduce arm64_const_caps_ready
> Since v2 [2]:
> * Add hyp init check
> * Clean up commit message
> * Drop fixes tag
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/505731.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/505763.html

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
