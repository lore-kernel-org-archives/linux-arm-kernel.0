From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 20 Nov 2018 14:18:10 +0000
Subject: [PATCH v2 1/4] arm64: arm_pmu: remove unnecessary isb instruction
In-Reply-To: <1542723322-42536-2-git-send-email-andrew.murray@arm.com>
References: <1542723322-42536-1-git-send-email-andrew.murray@arm.com>
 <1542723322-42536-2-git-send-email-andrew.murray@arm.com>
Message-ID: <9f93a152-073e-8682-568c-e3482cf64e1a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2018 02:15 PM, Andrew Murray wrote:
> The armv8pmu_enable_event_counter function issues an isb instruction
> after enabling a pair of counters - this doesn't provide any value
> and is inconsistent with the armv8pmu_disable_event_counter.
> 
> In any case armv8pmu_enable_event_counter is always called with the
> PMU stopped. Starting the PMU with armv8pmu_start results in an isb
> instruction being issued.
> 
> Let's remove the unnecessary isb instruction.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   arch/arm64/kernel/perf_event.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 8e38d52..de564ae 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -652,7 +652,6 @@ static inline void armv8pmu_enable_event_counter(struct perf_event *event)
>   	armv8pmu_enable_counter(idx);
>   	if (armv8pmu_event_is_chained(event))
>   		armv8pmu_enable_counter(idx - 1);
> -	isb();
>   }
>   
>   static inline int armv8pmu_disable_counter(int idx)
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
