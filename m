From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 5 Jan 2018 10:29:20 +0000
Subject: [PATCH 04/11] arm64: cpufeature: Pass capability structure to
 ->enable callback
In-Reply-To: <1515078515-13723-5-git-send-email-will.deacon@arm.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
 <1515078515-13723-5-git-send-email-will.deacon@arm.com>
Message-ID: <707a2690-d41b-1453-65ef-ff8188f254d4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/18 15:08, Will Deacon wrote:
> In order to invoke the CPU capability ->matches callback from the ->enable
> callback for applying local-CPU workarounds, we need a handle on the
> capability structure.
> 
> This patch passes a pointer to the capability structure to the ->enable
> callback.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index e11c11bb5b02..6133c14b9b01 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1151,7 +1151,7 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
>   			 * uses an IPI, giving us a PSTATE that disappears when
>   			 * we return.
>   			 */
> -			stop_machine(caps->enable, NULL, cpu_online_mask);
> +			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
>   		}
>   	}
>   }
> @@ -1194,7 +1194,7 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
>   			cpu_die_early();
>   		}
>   		if (caps->enable)
> -			caps->enable(NULL);
> +			caps->enable((void *)caps);
>   	}
>   }
>   
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
