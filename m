From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 12 May 2017 13:03:49 +0100
Subject: [PATCHv3] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <1494584120-15208-1-git-send-email-mark.rutland@arm.com>
References: <1494584120-15208-1-git-send-email-mark.rutland@arm.com>
Message-ID: <9f4c7856-5216-0a21-c378-033ba4e972aa@arm.com>
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

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
