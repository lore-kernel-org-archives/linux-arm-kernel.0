From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 8 Feb 2018 12:04:22 +0000
Subject: [PATCH v2 16/20] arm64: Handle shared capability entries
In-Reply-To: <20180131182807.32134-17-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-17-suzuki.poulose@arm.com>
Message-ID: <20180208120421.GY5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 06:28:03PM +0000, Suzuki K Poulose wrote:
> Some capabilities have different criteria for detection and associated
> actions based on the matching criteria, even though they all share the
> same capability bit. So far we have used multiple entries with the same
> capability bit to handle this. This is prone to errors, as the
> cpu_enable is invoked for each entry, irrespective of whether the
> detection rule applies to the CPU or not. And also this complicates
> other helpers, e.g, __this_cpu_has_cap.
> 
> This patch adds a wrapper entry to cover all the possible variations
> of a capability and ensures :
>  1) The capabilitiy is set when at least one of the entry detects
>  2) Action is only taken for the entries that detects.
> 
> This avoids explicit checks in the call backs. The only constraint
> here is that, all the entries should have the same "type".
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---

[...]

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c

[...]

> @@ -1275,7 +1274,7 @@ static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_li
>  		if (!(caps->type & scope_mask))
>  			continue;
>  
> -		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
> +		cpu_has_cap = caps->matches(caps, SCOPE_LOCAL_CPU);

One other minor thing: the original caps_list argument seems no longer
to be needed in this function after this change.

Can we rename the caps_list argument to "caps" and remove the local
variable of the same name?

Cheers
---Dave
