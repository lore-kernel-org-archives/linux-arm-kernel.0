From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 15 Nov 2017 09:14:27 -0600
Subject: Fwd: [PATCH 4/4] [v3] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <20171115064722.GB22802@codeaurora.org>
References: <1510096056-13765-5-git-send-email-timur@codeaurora.org>
 <133cd447-c5c8-2b3e-1ae2-484307d5e39d@codeaurora.org>
 <20171115064722.GB22802@codeaurora.org>
Message-ID: <54f0056d-7367-92ad-50dd-bdfdaf5c7b6a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2017 12:47 AM, Varadarajan Narayanan wrote:
>> +	if (id->driver_data == QDF2XXX_V1) {
>> +		avail_gpios = num_gpios;
>> +
>> +		gpios = devm_kcalloc(&pdev->dev, avail_gpios, sizeof(gpios[0]),
>> +				     GFP_KERNEL);
> Wouldn't kmalloc suffice since the array gets initialized just below.

Sure.

>> +		if (!gpios)
>> +			return -ENOMEM;
>> +
>> +		for (i = 0; i < avail_gpios; i++)
>> +			gpios[i] = i;
>> +	} else {
>> +		/* The number of GPIOs in the approved list */
>> +		ret = device_property_read_u16_array(&pdev->dev, "gpios",
>> +						     NULL, 0);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "missing 'num-gpios' property\n");
>> +			return ret;
>> +		}
>> +		if (!ret || ret > MAX_GPIOS) {
> Instead of ret > MAX_GPIOS, should we check for ret > num_gpios?

Yes.

> 
>> +			dev_err(&pdev->dev, "invalid 'num-gpios' property\n");
>> +			return -ENODEV;
>> +		}
> In both the above error messages 'num-gpios' should be 'gpios'

Thanks, I not sure how that got messed up.

> 
>> +		avail_gpios = ret;
>> +
>> +		gpios = devm_kcalloc(&pdev->dev, avail_gpios, sizeof(gpios[0]),
>> +				     GFP_KERNEL);
> devm_kmalloc?

Ok.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
