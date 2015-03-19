From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 19 Mar 2015 16:31:14 +0530
Subject: [PATCH v2 2/6] clk: qcom: gdsc: Prepare common clk probe to
 register gdscs
In-Reply-To: <550AA918.3000604@mm-sol.com>
References: <1426752145-4365-1-git-send-email-rnayak@codeaurora.org>
 <1426752145-4365-3-git-send-email-rnayak@codeaurora.org>
 <550AA918.3000604@mm-sol.com>
Message-ID: <550AAC7A.5010302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 04:16 PM, Stanimir Varbanov wrote:
> Hi Rajendra,
>
> Thanks for the patch!
>
> On 03/19/2015 10:02 AM, Rajendra Nayak wrote:
>> The common clk probe registers a clk provider and a reset controller.
>> Update it to register a genpd provider using the gdsc data provided
>> by each platform.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   drivers/clk/qcom/common.c | 14 +++++++++++++-
>>   drivers/clk/qcom/common.h |  2 ++
>>   drivers/clk/qcom/gdsc.c   | 34 +++++++++++++++++++++++++++++++++-
>>   drivers/clk/qcom/gdsc.h   |  9 ++++++++-
>>   4 files changed, 56 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
>> index a946b48..cc9f56f 100644
>> --- a/drivers/clk/qcom/common.c
>> +++ b/drivers/clk/qcom/common.c
>> @@ -21,6 +21,7 @@
>>   #include "clk-rcg.h"
>>   #include "clk-regmap.h"
>>   #include "reset.h"
>> +#include "gdsc.h"
>>
>>   struct qcom_cc {
>>   	struct qcom_reset_controller reset;
>> @@ -125,8 +126,18 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>>
>>   	ret = reset_controller_register(&reset->rcdev);
>>   	if (ret)
>> -		of_clk_del_provider(dev->of_node);
>> +		goto err_reset;
>>
>> +	ret = gdsc_register(dev, desc->gdscs, desc->num_gdscs, regmap);
>> +	if (ret)
>> +		goto err_pd;
>> +
>> +	return 0;
>> +err_pd:
>> +	dev_err(dev, "Failed to register power domains\n");
>> +	reset_controller_unregister(&reset->rcdev);
>> +err_reset:
>> +	of_clk_del_provider(dev->of_node);
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
>> @@ -145,6 +156,7 @@ EXPORT_SYMBOL_GPL(qcom_cc_probe);
>>
>>   void qcom_cc_remove(struct platform_device *pdev)
>>   {
>> +	of_genpd_del_provider(pdev->dev.of_node);
>
> It would be nice to introduce gdsc_unregister() for symmetry.

yeah I thought about adding it and then realized it would just call
of_genpd_del_provider() internally and not do anything much.
But I guess I can add one if that makes it look more symmetric.

>
>>   	of_clk_del_provider(pdev->dev.of_node);
>>   	reset_controller_unregister(platform_get_drvdata(pdev));
>>   }
>
> <snip>
>
>> +
>> +int gdsc_register(struct device *dev, struct gdsc **scs, size_t num,
>> +		  struct regmap *regmap)
>> +{
>
> Could you squash implementation of this function with the first patch 1/6.

yup, will do.

>
>> +	int i, ret;
>> +	struct genpd_onecell_data *data;
>> +
>> +	if (!num || !scs || !dev || !dev->of_node)
>> +		return 0;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->domains = devm_kzalloc(dev, sizeof(*data->domains) * num,
>> +				     GFP_KERNEL);
>
> Just wondering, are there some obstacles to embed struct
> genpd_onecell_data in struct gdsc, and thus avoid having two memory
> allocations?

Its just that we dont need one genpd_onecell_data per gdsc instance.
We only have one provider and hence just need one instance.

regards,
Rajendra

>
>> +	if (!data->domains)
>> +		return -ENOMEM;
>> +
>> +	data->num_domains = num;
>> +	for (i = 0; i < num; i++) {
>> +		if (!scs[i])
>> +			continue;
>> +		scs[i]->regmap = regmap;
>> +		ret = gdsc_init(scs[i]);
>> +		if (ret)
>> +			return ret;
>> +		data->domains[i] = &scs[i]->pd;
>> +	}
>> +	return of_genpd_add_provider_onecell(dev->of_node, data);
>> +}
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>> index ac6a2d5..14de304 100644
>> --- a/drivers/clk/qcom/gdsc.h
>> +++ b/drivers/clk/qcom/gdsc.h
>> @@ -32,5 +32,12 @@ struct gdsc {
>>
>>   #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
>
> This is used only from gdsc.c, please move it there.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
