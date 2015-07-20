From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Jul 2015 14:53:42 +0100
Subject: [PATCH v2 4/6] arm64: kernel: Add min_register_value and use
 '>=' for feature detection
In-Reply-To: <1437154221-5736-5-git-send-email-james.morse@arm.com>
References: <1437154221-5736-1-git-send-email-james.morse@arm.com>
 <1437154221-5736-5-git-send-email-james.morse@arm.com>
Message-ID: <20150720135341.GK20385@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 06:30:19PM +0100, James Morse wrote:
> When a new cpu feature is available, the cpu feature bits will have some
> initial value, which is incremented when the feature is updated.
> This patch changes 'register_value' to be 'min_register_value', and checks
> the feature bits value (interpreted as a signed int) is greater than this
> minimum.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  4 ++--
>  arch/arm64/kernel/cpufeature.c      | 14 +++++++++++---
>  2 files changed, 13 insertions(+), 5 deletions(-)

I think we could move patch 1 into this patch.

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7456fc44bee1..ef38e21ed719 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -42,8 +42,8 @@ struct arm64_cpu_capabilities {
>  		};
>  
>  		struct {	/* Feature register checking */
> -			u64 register_mask;
> -			u64 register_value;
> +			u8 register_shift;
> +			u8 min_register_value;

Nitpick: since they are no longer register values/shifts, can we call
them field_value and field_position (or just field_pos)?

>  		};
>  	};
>  };
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 650ffc28bedc..cc26d6c6520b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -23,12 +23,20 @@
>  #include <asm/cpufeature.h>
>  
>  static bool
> +feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
> +{
> +	int val = cpuid_feature_extract_field(reg, entry->register_shift);
> +
> +	return (val >= entry->min_register_value);
> +}

We should rather use an int type for min_register_value (and
register_shift) to avoid confusion with C comparison of signed vs
unsigned.

Nitpick: no brackets needed after return.

-- 
Catalin
