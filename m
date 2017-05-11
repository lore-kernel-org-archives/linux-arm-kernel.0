From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 11 May 2017 16:15:38 +0100
Subject: [PATCHv2] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <1494514878-26878-1-git-send-email-mark.rutland@arm.com>
References: <1494514878-26878-1-git-send-email-mark.rutland@arm.com>
Message-ID: <498b2e16-538a-d5ea-7843-2ebbff2007df@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/17 16:01, Mark Rutland wrote:
> Currently, cpus_set_cap() calls static_branch_enable_cpuslocked(), which
> must take the jump_label mutex.
>
> We call cpus_set_cap() in the secondary bringup path, from the idle
> thread where interrupts are disabled. Taking a mutex in this path "is a
> NONO" regardless of whether it's contended, and something we must avoid.
> Additionally, the secondary CPU doesn't hold the percpu rwsem (as this
> is held by the primary CPU), so this triggers a lockdep splat.
>
> This patch fixes both issues by moving the static_key poking from
> cpus_set_cap() into enable_cpu_capabilities(). To account for the static
> keys being set later, cpus_have_const_cap() is updated to use another
> static key to check whether the const cap keys have been initialised.
>
> This means that users of cpus_have_const_cap() gain should only gain a
> single additional NOP in the fast path once the const caps are
> initialised, but should always see the current cap value.
>
> This rework means that we can remove the *_cpuslocked() helpers added in
> commit d54bb72551b999dd ("arm64/cpufeature: Use
> static_branch_enable_cpuslocked()").
>
> Fixes: efd9e03facd075f5 ("arm64: Use static keys for CPU features")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyniger <marc.zyngier@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Sewior <bigeasy@linutronix.de>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 13 ++++++++++---
>  arch/arm64/kernel/cpu_errata.c      |  9 +--------
>  arch/arm64/kernel/cpufeature.c      | 25 ++++++++++++++++++++++---
>  3 files changed, 33 insertions(+), 14 deletions(-)
>
> Catalin, Will, assuming you're happy with the patch, it will need to go via the
> tip tree.
>
> Since v1 [1]:
> * Kill redundant update_cpu_errata_workarounds() prototype
> * Introduce arm64_const_caps_ready
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/505731.html
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 8a7ff73..428ee1f 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -115,6 +115,7 @@ struct arm64_cpu_capabilities {
>
>  extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>  extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
> +extern struct static_key_false arm64_const_caps_ready;
>
>  bool this_cpu_has_cap(unsigned int cap);
>
> @@ -124,7 +125,7 @@ static inline bool cpu_have_feature(unsigned int num)
>  }
>
>  /* System capability check for constant caps */
> -static inline bool cpus_have_const_cap(int num)
> +static inline bool __cpus_have_const_cap(int num)
>  {
>  	if (num >= ARM64_NCAPS)
>  		return false;
> @@ -138,6 +139,14 @@ static inline bool cpus_have_cap(unsigned int num)
>  	return test_bit(num, cpu_hwcaps);
>  }
>
> +static inline bool cpus_have_const_cap(int num)
> +{
> +	if (static_branch_likely(&arm64_const_caps_ready))
> +		return __cpus_have_const_cap(num);
> +	else
> +		return cpus_have_cap(num);


We use cpus_have_const_cap() from hyp code, via has_vhe() and we could potentially
try to access unmapped kernel data from hyp if we fallback to cpus_have_cap().
However, it looks like we have already set arm64_const_caps_ready, so should not
hit it in practise. May be we could add a stricter version of the helper ?

static inline cpus_have_const_cap_strict(int num)
{
	BUG_ON(!static_branch_likely(&arm64_const_caps_ready);
	return __cpus_have_const_cap(num);
}


Suzuki
