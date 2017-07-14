From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 14 Jul 2017 13:30:50 -0500
Subject: [PATCH 2/2] pinctrl: qcom: qdf2xxx: add support for new ACPI HID
 QCOM8002
In-Reply-To: <20170714172121.GN20973@minitux>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
 <1499982763-29619-3-git-send-email-timur@codeaurora.org>
 <20170714172121.GN20973@minitux>
Message-ID: <99cc9d6e-da81-82b5-8402-0a471a6c9fb2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2017 12:21 PM, Bjorn Andersson wrote:

>> +enum {
>> +	QDF2XXX_V1,
>> +	QDF2XXX_V2,
>> +};
>> +
>> +static const struct acpi_device_id qdf2xxx_acpi_ids[] = {
>> +	{"QCOM8001", QDF2XXX_V1},
>> +	{"QCOM8002", QDF2XXX_V2},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, qdf2xxx_acpi_ids);
> 
> NB. too bad there doesn't seem to be an equivalent of
> of_device_get_match_data().

There's acpi_match_device(), which I use.

> 
>> +
>>   static int qdf2xxx_pinctrl_probe(struct platform_device *pdev)
>>   {
>> +	const struct acpi_device_id *id =
>> +		acpi_match_device(qdf2xxx_acpi_ids, &pdev->dev);
>> +	struct device *dev = &pdev->dev;
>>   	struct pinctrl_pin_desc *pins;
>>   	struct msm_pingroup *groups;
>>   	char (*names)[NAME_SIZE];
>>   	unsigned int i;
> 
> The result of the patch looks fine, but unfortunately there's some noise
> in the patch due to the transition from &pdev->dev to dev and num_gpios
> to max_gpios.

I did that to shrink the line lengths.  I can put it back if you want.

> 
>> -	u32 num_gpios;
>> +	unsigned int num_gpios; /* The number of GPIOs we support */
>> +	u32 max_gpios; /* The highest number GPIO that exists */
> 
> Could you please keep the "num_gpios" naming and name the new variable
> "avail_gpios" or something similar.

Sure.

> 
>> +	u16 *gpios; /* An array of supported GPIOs */
>>   	int ret;
> 
>>   
>> -	/* Query the number of GPIOs from ACPI */
>> -	ret = device_property_read_u32(&pdev->dev, "num-gpios", &num_gpios);
>> +	/* The total number of GPIOs that exist */
>> +	ret = device_property_read_u32(dev, "num-gpios", &max_gpios);
>>   	if (ret < 0) {
>> -		dev_warn(&pdev->dev, "missing num-gpios property\n");
>> +		dev_err(dev, "missing or invalid 'num-gpios' property\n");
> 
> While this makes sense it's not entirely related to this patch. My
> suggestion is that you prepend a patch transitioning &pdev->dev to dev
> and change these to dev_err in the same.

I'd rather put pdev->dev back.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
