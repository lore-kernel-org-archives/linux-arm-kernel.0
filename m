From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 19 Apr 2017 15:32:39 +0100
Subject: [PATCH v6 6/8] coresight: add support for CPU debug module
In-Reply-To: <20170419142812.GA16160@leoy-linaro>
References: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
 <1491485461-22800-7-git-send-email-leo.yan@linaro.org>
 <5c5cb6f8-1dcb-8a9d-1605-c006656005eb@arm.com>
 <20170419142812.GA16160@leoy-linaro>
Message-ID: <f42088f6-aa53-06b1-b332-22198744ab7a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/17 15:28, Leo Yan wrote:
> Hi Suzuki,
>
> On Wed, Apr 19, 2017 at 02:23:04PM +0100, Suzuki K Poulose wrote:
>> Hi Leo,
>>
>> This version looks good to me. I have two minor comments below.
>
> Thanks for reviewing. Will take the suggestions. Just check a bit for
> last comment.
>
> [...]
>
>>> +static int debug_probe(struct amba_device *adev, const struct amba_id *id)
>>> +{
>>> +	void __iomem *base;
>>> +	struct device *dev = &adev->dev;
>>> +	struct debug_drvdata *drvdata;
>>> +	struct resource *res = &adev->res;
>>> +	struct device_node *np = adev->dev.of_node;
>>> +	int ret;
>>> +
>>> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>> +	if (!drvdata)
>>> +		return -ENOMEM;
>>> +
>>> +	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
>>> +	if (per_cpu(debug_drvdata, drvdata->cpu)) {
>>> +		dev_err(dev, "CPU%d drvdata has been initialized\n",
>>> +			drvdata->cpu);
>>
>> May be we could warn about a possible issue in the DT ?
>
> So can I understand the suggestion is to add warning in function
> of_coresight_get_cpu() when cannot find CPU number, and here directly
> bail out?

No. One could have single CPU DT, where he doesn't need to provide the CPU number.
Hence, it doesn't make sense to WARN  in of_coresight_get_cpu().

But when we hit the case above, we find that the some node was registered for
the given CPU (be it 0 or any other), which is definitely an error in DT. Due to

1) Hasn't specified the CPU number for more than one node

OR

2) CPU number duplicated in the more than one nodes.

Cheers
Suzuki
