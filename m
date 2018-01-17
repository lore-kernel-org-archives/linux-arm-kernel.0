From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 17 Jan 2018 12:25:49 +0000
Subject: [PATCH] arm64: Run enable method for errata work arounds on late
 CPUs
In-Reply-To: <20180117100556.29270-1-suzuki.poulose@arm.com>
References: <20180117100556.29270-1-suzuki.poulose@arm.com>
Message-ID: <20180117122548.GE22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 10:05:56AM +0000, Suzuki K Poulose wrote:
> When a CPU is brought up after we have finalised the system
> wide capabilities (i.e, features and errata), we make sure the
> new CPU doesn't need a new errata work around which has not been
> detected already. However we don't run enable() method on the new
> CPU for the errata work arounds already detected. This could
> cause the new CPU running without potential work arounds.
> It is upto the "enable()" method to decide if this CPU should
> do something about the errata.
> 
> Fixes: commit 6a6efbb45b7d95c84 ("arm64: Verify CPU errata work arounds on hotplugged CPU")
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 90a9e465339c..54e41dfe41f6 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -373,15 +373,18 @@ void verify_local_cpu_errata_workarounds(void)
>  {
>  	const struct arm64_cpu_capabilities *caps = arm64_errata;
>  
> -	for (; caps->matches; caps++)
> -		if (!cpus_have_cap(caps->capability) &&
> -			caps->matches(caps, SCOPE_LOCAL_CPU)) {
> +	for (; caps->matches; caps++) {
> +		if (cpus_have_cap(caps->capability)) {
> +			if (caps->enable)
> +				caps->enable((void *)caps);

Do we really need this cast?

Can enable() fail, or do we already guarantee that it succeeds (by
having detected the cap in the first place)?

> +		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {

[...]

Cheers
---Dave
