From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Sep 2018 09:59:32 -0700
Subject: [PATCH v2] firmware: arm_scmi: fix divide by zero when
 sustained_perf_level is zero
In-Reply-To: <1536246639-7420-1-git-send-email-sudeep.holla@arm.com>
References: <1536165491-27813-1-git-send-email-sudeep.holla@arm.com>
 <1536246639-7420-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180906165932.csa5b4vlmaekv5y2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 06, 2018 at 04:10:39PM +0100, Sudeep Holla wrote:
> Firmware can provide zero as values for sustained performance level and
> corresponding sustained frequency in kHz in order to hide the actual
> frequencies and provide only abstract values. It may endup with divide
> by zero scenario resulting in kernel panic.
> 
> Let's set the multiplication factor to one if either one or both of them
> (sustained_perf_level and sustained_freq) are set to zero.
> 
> Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Hi ARM SoC team,
> 
> Can you pick this patch directly ?

Applied, however:

> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 721e6c57beae..64342944d917 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -166,7 +166,13 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
>  					le32_to_cpu(attr->sustained_freq_khz);
>  		dom_info->sustained_perf_level =
>  					le32_to_cpu(attr->sustained_perf_level);
> -		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
> +		if (!dom_info->sustained_freq_khz ||
> +		    !dom_info->sustained_perf_level)
> +			/* CPUFreq converts to kHz, hence default 1000 */
> +			dom_info->mult_factor =	1000;
> +		else
> +			dom_info->mult_factor =
> +					(dom_info->sustained_freq_khz * 1000) /
>  					dom_info->sustained_perf_level;
>  		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);

I noticed you do memcpy of these name strings in a few places, and use
it as a string. Any firmware that would return a non-terminated string
would cause problems later on. strlcpy() might be a better approach.



-Olof
