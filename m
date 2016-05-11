From: nkaje@codeaurora.org (Naveen Kaje)
Date: Wed, 11 May 2016 16:09:59 -0600
Subject: [PATCH 1/2] i2c: qup: add ACPI support
In-Reply-To: <000201d1aa82$07b3f680$171be380$@codeaurora.org>
References: <1462317959-11632-1-git-send-email-nkaje@codeaurora.org>
 <000201d1aa82$07b3f680$171be380$@codeaurora.org>
Message-ID: <e31e85f4-93f7-f9ad-295f-76b5dc28b9e2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/10/2016 12:05 AM, Sricharan wrote:
> +additional lists
>
>> Add support to get the device parameters from ACPI. Assume that the clocks
>> are managed by firmware.
>>
>> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
>> ---
> <snip>
>> +	bool input_clk_ctrl = true;
>>
>>   	qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
>>   	if (!qup)
>> @@ -1372,7 +1378,14 @@ static int qup_i2c_probe(struct platform_device
>> *pdev)
>>   	init_completion(&qup->xfer);
>>   	platform_set_drvdata(pdev, qup);
>>
>> -	of_property_read_u32(node, "clock-frequency", &clk_freq);
>> +	ret = device_property_read_u32(qup->dev, "clock-frequency",
>> &clk_freq);
>> +	if (ret) {
>> +		dev_warn(qup->dev, "using default clock-frequency values");
>> +		clk_freq = DEFAULT_CLK_FREQ;
>> +	}
>> +
>> +	if (ACPI_HANDLE(qup->dev) && !node)
>> +		input_clk_ctrl = false;
>>
>>   	if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-
>> v1.1.1")) {
>>   		qup->adap.algo = &qup_i2c_algo;
>> @@ -1454,20 +1467,29 @@ nodma:
>>   		return qup->irq;
>>   	}
>>
>> -	qup->clk = devm_clk_get(qup->dev, "core");
>> -	if (IS_ERR(qup->clk)) {
>> -		dev_err(qup->dev, "Could not get core clock\n");
>> -		return PTR_ERR(qup->clk);
>> -	}
>> +	if (input_clk_ctrl) {
>       The above ACPI_HANDLE check can be directly used here and avoid the
> variable.
Thanks for reviewing. Will do in V2.
>
>> +		qup->clk = devm_clk_get(qup->dev, "core");
>> +		if (IS_ERR(qup->clk)) {
>> +			dev_err(qup->dev, "Could not get core clock\n");
>> +			return PTR_ERR(qup->clk);
>> +		}
>>
>> -	qup->pclk = devm_clk_get(qup->dev, "iface");
>> -	if (IS_ERR(qup->pclk)) {
>> -		dev_err(qup->dev, "Could not get iface clock\n");
>> -		return PTR_ERR(qup->pclk);
>> +		qup->pclk = devm_clk_get(qup->dev, "iface");
>> +		if (IS_ERR(qup->pclk)) {
>> +			dev_err(qup->dev, "Could not get iface clock\n");
>> +			return PTR_ERR(qup->pclk);
>> +		}
>> +		qup_i2c_enable_clocks(qup);
>> +		src_clk_freq = clk_get_rate(qup->clk);
>> +	} else {
>> +		ret = device_property_read_u32(qup->dev,
>> +				"src-clock-hz", &src_clk_freq);
>> +		if (ret) {
>> +			dev_warn(qup->dev, "using default src-clock-hz");
>> +			src_clk_freq = DEFAULT_SRC_CLK;
>> +		}
>>   	}
>>
>> -	qup_i2c_enable_clocks(qup);
>> -
>>   	/*
>>   	 * Bootloaders might leave a pending interrupt on certain QUP's,
>>   	 * so we reset the core before registering for interrupts.
>> @@ -1514,7 +1536,6 @@ nodma:
>>   	size = QUP_INPUT_FIFO_SIZE(io_mode);
>>   	qup->in_fifo_sz = qup->in_blk_sz * (2 << size);
>>
>> -	src_clk_freq = clk_get_rate(qup->clk);
>>   	fs_div = ((src_clk_freq / clk_freq) / 2) - 3;
>>   	hs_div = 3;
>>   	qup->clk_ctl = (hs_div << 8) | (fs_div & 0xff); @@ -1534,6 +1555,8
>> @@ nodma:
>>   	qup->adap.dev.parent = qup->dev;
>>   	qup->adap.dev.of_node = pdev->dev.of_node;
>>   	qup->is_last = true;
>> +	if (ACPI_HANDLE(qup->dev))
>> +		ACPI_COMPANION_SET(&qup->adap.dev,
>> ACPI_COMPANION(qup->dev));
>      Can we move this inside the above check.
Will do in V2.
>>   	strlcpy(qup->adap.name, "QUP I2C adapter", sizeof(qup-
>>> adap.name));
>> @@ -1639,6 +1662,13 @@ static const struct of_device_id
>> qup_i2c_dt_match[] = {  };  MODULE_DEVICE_TABLE(of, qup_i2c_dt_match);
>>
>> +#if IS_ENABLED(CONFIG_ACPI)
>> +static const struct acpi_device_id qup_i2c_acpi_match[] = {
>> +	{ "QCOM8010"},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_ids); #endif
>>   static struct platform_driver qup_i2c_driver = {
>>   	.probe  = qup_i2c_probe,
>>   	.remove = qup_i2c_remove,
>> @@ -1646,6 +1676,7 @@ static struct platform_driver qup_i2c_driver = {
>>   		.name = "i2c_qup",
>>   		.pm = &qup_i2c_qup_pm_ops,
>>   		.of_match_table = qup_i2c_dt_match,
>> +		.acpi_match_table = ACPI_PTR(qup_i2c_acpi_match),
>   Should this also be in #if IS_ENABLED(CONFIG_ACPI) check ?
No, ACPI_PTR (defined in include/linux/acpi.h) takes care of setting the 
pointer value based on the availability of CONFIG_ACPI.
>
> Regards,
>   Sricharan
>
