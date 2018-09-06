From: quentin.perret@arm.com (Quentin Perret)
Date: Thu, 6 Sep 2018 14:17:54 +0100
Subject: [PATCH] firmware: arm_scmi: fix divide by zero when
 sustained_perf_level is zero
In-Reply-To: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
References: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180906131752.ysubfiufocddpoey@queper01-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Wednesday 05 Sep 2018 at 17:38:11 (+0100), Sudeep Holla wrote:
> @@ -166,7 +166,12 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>  					le32_to_cpu(attr->sustained_freq_khz);
>  		dom_info->sustained_perf_level =
>  					le32_to_cpu(attr->sustained_perf_level);
> -		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
> +		if (!dom_info->sustained_freq_khz ||
> +		    !dom_info->sustained_perf_level)
> +			dom_info->mult_factor =	1;

I'm sorry I missed that the first time I reviewed this patch, but after
discussing with Ionela, we found out that there is actually a case where
this could be a problem. If you have perf levels that are 1,2,3,4 (for
example), then with mult_factor=1 you'll register OPPs at 1Hz, 2Hz, 3Hz,
4Hz into PM_OPP. And that will be turned into 0 KHz for all of them at
the CPUFreq level when divided by 1000 in dev_pm_opp_init_cpufreq_table().

I guess a quick fix would be to have a default mult_factor of 1000 ...

What do you think ?

Thanks,
Quentin
