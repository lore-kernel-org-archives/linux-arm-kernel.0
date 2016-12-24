From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 24 Dec 2016 15:11:31 +0800
Subject: [PATCH v5 6/6] arm64: arch_timer: acpi: add hisi timer errata data
In-Reply-To: <1482476669-15596-7-git-send-email-dingtianhong@huawei.com>
References: <1482476669-15596-1-git-send-email-dingtianhong@huawei.com>
 <1482476669-15596-7-git-send-email-dingtianhong@huawei.com>
Message-ID: <ad0eea28-3cf9-f114-3619-0c9c05af6110@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/12/23 15:04, Ding Tianhong wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Add hisi timer specific erratum fixes.
> 
> v3: add hisilicon erratum 161601 for ACPI mode.
> 
> v4: update some data structures.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  drivers/clocksource/arm_arch_timer.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 212bfa5..7b15d2a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1089,10 +1089,28 @@ struct gtdt_arch_timer_fixup {
>  	void *context;
>  };
>  
> +#ifdef CONFIG_HISILICON_ERRATUM_161601
> +static void __init erratum_workaround_enable(void *context)
> +{
> +	u64 erratum = (u64) context;
> +
> +	if (erratum & HISILICON_161601) {
> +		timer_unstable_counter_workaround = &arch_timer_hisi_161601;
> +		static_branch_enable(&arch_timer_read_ool_enabled);
> +		pr_info("Enabling workaround for HISILICON ERRATUM 161601\n");
> +	}


Use arch_timer_hisi_161601 for context instead of HISILICON_161601 directly,
we can make erratum_workaround_enable more general.

> +}
> +#endif
> +
>  /* note: this needs to be updated according to the doc of OEM ID
>   * and TABLE ID for different board.
>   */
>  struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
> +#ifdef CONFIG_HISILICON_ERRATUM_161601
> +	{"HISI", "hip05", 0, &erratum_workaround_enable, (void *) HISILICON_161601},
> +	{"HISI", "hip06", 0, &erratum_workaround_enable, (void *) HISILICON_161601},
> +	{"HISI", "hip07", 0, &erratum_workaround_enable, (void *) HISILICON_161601},
> +#endif





>  };
>  
>  void __init arch_timer_acpi_quirks_handler(char *oem_id,
> 
