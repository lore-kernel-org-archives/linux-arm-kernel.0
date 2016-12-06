From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 13:50:20 +0000
Subject: [PATCH 1/2] arm64: PMU: Do not use PMSELR_EL0 to access
 PMCCFILTR_EL0
In-Reply-To: <1480693859-27249-2-git-send-email-marc.zyngier@arm.com>
References: <1480693859-27249-1-git-send-email-marc.zyngier@arm.com>
 <1480693859-27249-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20161206135020.GI2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 03:50:58PM +0000, Marc Zyngier wrote:
> The ARMv8 architecture allows the cycle counter to be configured
> by setting PMSELR_EL0.SEL==0x1f and then accessing PMXEVTYPER_EL0,
> hence accessing PMCCFILTR_EL0. But it disallows the use of
> PMSELR_EL0.SEL==0x1f to access the cycle counter itself through
> PMXEVCNTR_EL0.
> 
> Linux itself doesn't violate this rule, but we may end up with
> PMSELR_EL0.SEL being set to 0x1f when we enter a guest. If that
> guest accesses PMXEVCNTR_EL0, the access may UNDEF at EL1,
> despite the guest not having done anything wrong.
> 
> In order to avoid this unfortunate course of events (haha!), let's
> apply the same method armv8pmu_write_counter and co are using,
> explicitely checking for the cycle counter and writing to
> PMCCFILTR_EL0 directly. This prevents writing 0x1f to PMSELR_EL0,
> and saves a Linux guest an extra trap.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 57ae9d9..a65b757 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -632,7 +632,10 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
>  
>  static inline void armv8pmu_write_evtype(int idx, u32 val)
>  {
> -	if (armv8pmu_select_counter(idx) == idx) {
> +	if (idx == ARMV8_IDX_CYCLE_COUNTER) {
> +		val &= ARMV8_PMU_EVTYPE_MASK & ~ARMV8_PMU_EVTYPE_EVENT;
> +		write_sysreg(val, pmccfiltr_el0);
> +	} else if (armv8pmu_select_counter(idx) == idx) {

If we go down this route, then we also have to "fix" the 32-bit code,
which uses PMSELR in a similar way. However, neither of the perf drivers
are actually doing anything wrong here -- the problem comes about because
the architecture doesn't guarantee that PMU accesses trap to EL2 unless
both MDCR.TPM=1 *and* PMSELR_EL0 is valid. So I think that this should
be handled together, in the KVM code that enables PMU traps.

Given that the perf callbacks tend to run with preemption disabled, I
think you should be fine nuking PMSELR_EL0 to zero (i.e. no need to
save/restore).

Will
