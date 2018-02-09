From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 9 Feb 2018 12:19:03 +0000
Subject: [PATCH 4/4] arm64: capabilities: Group handling of features and
 errata workarounds
In-Reply-To: <20180209121605.14091-5-suzuki.poulose@arm.com>
References: <20180208173229.GA5862@e103592.cambridge.arm.com>
 <20180209121605.14091-1-suzuki.poulose@arm.com>
 <20180209121605.14091-5-suzuki.poulose@arm.com>
Message-ID: <038c374e-39db-e5d0-0205-7001c7ffc618@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/18 12:16, Suzuki K Poulose wrote:
> Now that the features and errata workarounds have the same
> rules and flow, group the handling of the tables.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 72 ++++++++++++++++++++++++------------------
>   1 file changed, 41 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 45bac0c4ae91..e97ec8d5fd89 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -504,8 +504,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>   }
>   
>   extern const struct arm64_cpu_capabilities arm64_errata[];
> -static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> -				    u16 scope_mask, const char *info);
> +static void update_cpu_capabilities(u16 scope_mask);
>   
>   void __init init_cpu_features(struct cpuinfo_arm64 *info)
>   {
> @@ -554,10 +553,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>   	 * Run the errata work around and local feature checks on the
>   	 * boot CPU, once we have initialised the cpu feature infrastructure.
>   	 */
> -	update_cpu_capabilities(arm64_errata, SCOPE_LOCAL_CPU,
> -				"enabling workaround for");
> -	update_cpu_capabilities(arm64_features, SCOPE_LOCAL_CPU,
> -				"detected feature:");
> +	update_cpu_capabilities(SCOPE_LOCAL_CPU);
>   }
>   
>   static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
> @@ -1225,7 +1221,7 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
>   	return false;
>   }
>   
> -static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> +static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>   				    u16 scope_mask, const char *info)
>   {
>   	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
> @@ -1240,6 +1236,14 @@ static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>   	}
>   }
>   
> +static void update_cpu_capabilities(u16 scope_mask)
> +{
> +	__update_cpu_capabilities(arm64_features, scope_mask,
> +				  "detected feature:");
> +	__update_cpu_capabilities(arm64_errata, scope_mask,
> +				  "enabling workaround for");
> +}
> +
>   static int __enable_cpu_capability(void *arg)
>   {
>   	const struct arm64_cpu_capabilities *cap = arg;
> @@ -1253,7 +1257,7 @@ static int __enable_cpu_capability(void *arg)
>    * CPUs
>    */
>   static void __init
> -enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_mask)
> +__enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_mask)
>   {
>   	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
>   	for (; caps->matches; caps++) {
> @@ -1277,6 +1281,12 @@ enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps, u16 scope_mas
>   	}
>   }
>   
> +static void __init enable_cpu_capabilities(u16 scope_mask)
> +{
> +	__enable_cpu_capabilities(arm64_features, scope_mask);
> +	__enable_cpu_capabilities(arm64_errata, scope_mask);
> +}
> +
>   /*
>    * Run through the list of capabilities to check for conflicts.
>    * If the system has already detected a capability, take necessary
> @@ -1332,6 +1342,12 @@ static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_li
>   	return true;
>   }
>   
> +static bool verify_local_cpu_caps(u16 scope_mask)
> +{
> +	return __verify_local_cpu_caps(arm64_errata, scope_mask) &&


> +	       __verify_local_cpu_caps(arm64_errata, scope_mask);

Err.. this is arm64_features. Fixed up locally.

Suzuki
