From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 20 Jul 2015 10:56:00 +0100
Subject: [PATCH v2 2/4] drm/tegra: Add VIC support
In-Reply-To: <55ACB6A2.9030906@nvidia.com>
References: <1437378869-10451-1-git-send-email-mperttunen@nvidia.com>
 <1437378869-10451-3-git-send-email-mperttunen@nvidia.com>
 <55ACB134.8010401@nvidia.com> <55ACB6A2.9030906@nvidia.com>
Message-ID: <55ACC5B0.20703@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 20/07/15 09:51, Mikko Perttunen wrote:
> On 07/20/2015 11:28 AM, Jon Hunter wrote:
>> Hi Mikko,
> 
> Hi!
> 
>> ...
>>> +static int vic_runtime_resume(struct device *dev)
>>> +{
>>> +	struct vic *vic = dev_get_drvdata(dev);
>>> +	int err;
>>> +
>>> +	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_VIC,
>>> +						vic->clk, vic->rst);
>>
>> I would like to deprecate use of the above function [1]. I have been
>> trying to migrate driver to use a new API instead of the above.
> 
> Yes, we will need to coordinate the API change here. I kept the old way
> here to not depend on your series for now.
> 
>>
>>> +	if (err < 0)
>>> +		dev_err(dev, "failed to power up device\n");
>>> +
>>> +	return err;
>>> +}
>>> +
>>> ...
>>> +
>>> +	pm_runtime_enable(&pdev->dev);
>>> +	if (!pm_runtime_enabled(&pdev->dev)) {
>>> +		err = vic_runtime_resume(&pdev->dev);
>>> +		if (err < 0)
>>> +			goto unregister_client;
>>> +	}
>>
>> I don't see why pm_runtime_enable() should ever fail to enable
>> pm_runtime here. Hence, the if-statement appears to be redundant. If you
>> are trying to determine whether rpm is supported for the power-domains
>> then you should simply check to see if the DT node for the device has
>> the "power-domains" property. See my series [1].
> 
> The intention is that if runtime PM is not enabled, the power domain is
> still brought up. On a cursory look, it seems like with your patch, this
> should indeed work fine without this check if CONFIG_PM is enabled. Now,
> that might always be enabled? If so, then everything would be fine; if
> this lands after your series, we could even just make the power-domains
> prop mandatory and not implement the legacy mode at all. If not, then
> AFAIU we must still keep this path.

Ok, I see you just wish to test it is enabled in the kernel config. Then
yes that would make sense and the above is fine.

Cheers
Jon
