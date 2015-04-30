From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Thu, 30 Apr 2015 18:26:39 +0300
Subject: [PATCH v5 09/11] clk: qcom: gdsc: Use PM clocks to control gdsc
 clocks
In-Reply-To: <1429017137-20218-10-git-send-email-rnayak@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
 <1429017137-20218-10-git-send-email-rnayak@codeaurora.org>
Message-ID: <554249AF.6070909@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Rajendra,

On 04/14/2015 04:12 PM, Rajendra Nayak wrote:
> The devices within a gdsc power domain, quite often have additional
> clocks to be turned on/off along with the power domain itself.
> Once the drivers for these devices are converted to use runtime PM,
> it would be possible to remove all clock handling from the drivers if
> the gdsc driver can handle it.
> Use PM clocks to add support for this. A list of con_ids[] specified
> per gdsc would be the clocks turned on/off on every device start/stop
> callbacks.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/clk/qcom/gdsc.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  2 ++
>  2 files changed, 45 insertions(+)

<snip>

>  
> +static int gdsc_attach(struct generic_pm_domain *domain, struct device *dev)
> +{
> +	int ret;
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +	char **con_id;
> +
> +	if (!sc->con_ids[0])
> +		return 0;

Did you test this on your side? It panic kernel badly cause the flexible
array is not initialised.

Could you revisit the above check. Or you could add below initialisation
for every gdsc structure in gcc-xxx.c files.

static struct gdsc venus_gdsc = {
	.gdscr = 0x4c018,
	.pd = {
		.name = "venus",
	},
	.con_ids = { NULL },
};


> +
> +	ret = pm_clk_create(dev);
> +	if (ret) {
> +		dev_err(dev, "pm_clk_create failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (con_id = sc->con_ids; *con_id; con_id++) {
> +		ret = pm_clk_add(dev, *con_id);
> +		if (ret) {
> +			dev_err(dev, "pm_clk_add failed %d\n", ret);
> +			goto fail;
> +		}
> +	}
> +	return 0;
> +fail:
> +	pm_clk_destroy(dev);
> +	return ret;
> +};
> +

<snip>


-- 
regards,
Stan
