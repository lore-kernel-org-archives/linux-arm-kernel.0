From: austinwc@codeaurora.org (Christ, Austin)
Date: Wed, 8 Jun 2016 12:12:55 -0600
Subject: [PATCH 1/2][v3] i2c: qup: add ACPI support
In-Reply-To: <20160605185750.GF13357@hector.attlocal.net>
References: <1464291477-4705-1-git-send-email-austinwc@codeaurora.org>
 <20160605185750.GF13357@hector.attlocal.net>
Message-ID: <a21eddb9-7148-e949-e862-bf426ff1216a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 6/5/2016 12:57 PM, Andy Gross wrote:
> On Thu, May 26, 2016 at 01:37:56PM -0600, Austin Christ wrote:
>
> <snip>
>
>> @@ -1354,14 +1359,13 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
>>   static int qup_i2c_probe(struct platform_device *pdev)
>>   {
>>   	static const int blk_sizes[] = {4, 16, 32};
>> -	struct device_node *node = pdev->dev.of_node;
>>   	struct qup_i2c_dev *qup;
>>   	unsigned long one_bit_t;
>>   	struct resource *res;
>>   	u32 io_mode, hw_ver, size;
>>   	int ret, fs_div, hs_div;
>> -	int src_clk_freq;
>> -	u32 clk_freq = 100000;
>> +	u32 src_clk_freq = 0;
>> +	u32 clk_freq = 0;
>>   	int blocks;
>>   
>>   	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
>> @@ -1372,7 +1376,12 @@ static int qup_i2c_probe(struct platform_device *pdev)
>>   	init_completion(&qup->xfer);
>>   	platform_set_drvdata(pdev, qup);
>>   
>> -	of_property_read_u32(node, "clock-frequency", &clk_freq);
>> +	ret = device_property_read_u32(qup->dev, "clock-frequency", &clk_freq);
> Why do we need a warning if the clock-frequency is not specified?  It is
> optional in the DT documentation, is it not in the ACPI?
I agree a warning is too strong here. The information may still be 
useful about the driver configuration, so I will change it to a 
dev_notify() in v4.
>
>> +	if (ret) {
>> +		dev_warn(qup->dev, "using default clock-frequency %d",
>> +			DEFAULT_CLK_FREQ);
>> +		clk_freq = DEFAULT_CLK_FREQ;
> You could just assign the DEFAULT_CLK_FREQ in the variable declaration instead
> of 0.  read_property does not modify the variable unless it finds it or does the
> ACPI version modify if not found?
You are correct about this function only modifying when it finds a 
value. This will be corrected in v4.
>
>> +	}
>>   
>>   	if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-v1.1.1")) {
>>   		qup->adap.algo = &qup_i2c_algo;
>> @@ -1454,20 +1463,31 @@ nodma:
>>   		return qup->irq;
>>   	}
>>   
> <snip>
>
> Regards,
>
> Andy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Austin
