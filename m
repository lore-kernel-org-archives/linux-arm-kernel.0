From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 29 Mar 2017 11:01:02 +0800
Subject: [Update][PATCH v9.1 15/15] irqchip: mbigen: Add ACPI support
In-Reply-To: <6fb7a454-7829-0147-9b53-2d85e9200ad3@redhat.com>
References: <1490703665-4932-1-git-send-email-hanjun.guo@linaro.org>
 <6fb7a454-7829-0147-9b53-2d85e9200ad3@redhat.com>
Message-ID: <58DB236E.9000006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2017 03:13 AM, Al Stone wrote:
> On 03/28/2017 06:21 AM, Hanjun Guo wrote:
[...]
>>
>> +#ifdef CONFIG_ACPI
>> +static int mbigen_acpi_create_domain(struct platform_device *pdev,
>> +				     struct mbigen_device *mgn_chip)
>> +{
>> +	struct irq_domain *domain;
>> +	u32 num_pins = 0;
>> +	int ret;
>> +
>> +	/*
>> +	 * "num-pins" is the total number of interrupt pins implemented in
>> +	 * this mbigen instance, and mbigen is an interrupt controller
>> +	 * connected to ITS  converting wired interrupts into MSI, so we
>> +	 * use "num-pins" to alloc MSI vectors which are needed by client
>> +	 * devices connected to it.
>> +	 *
>> +	 * Here is the DSDT device node used for mbigen in firmware:
>> +	 *	Device(MBI0) {
>> +	 *		Name(_HID, "HISI0152")
>> +	 *		Name(_UID, Zero)
>> +	 *		Name(_CRS, ResourceTemplate() {
>> +	 *			Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
>> +	 *		})
>> +	 *
>> +	 *		Name(_DSD, Package () {
>> +	 *			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>> +	 *			Package () {
>> +	 *				Package () {"num-pins", 378}
>> +	 *			}
>> +	 *		})
>> +	 *	}
>> +	 */
>
> Excellent.  These comments I really like.  Thanks for doing this!
>
>> +	ret = device_property_read_u32(&pdev->dev, "num-pins", &num_pins);
>> +	if (ret || num_pins == 0)
>> +		return -EINVAL;
>> +
>> +	domain = platform_msi_create_device_domain(&pdev->dev, num_pins,
>> +						   mbigen_write_msg,
>> +						   &mbigen_domain_ops,
>> +						   mgn_chip);
>> +	if (!domain)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +#else
>> +static inline int mbigen_acpi_create_domain(struct platform_device *pdev,
>> +					    struct mbigen_device *mgn_chip)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif
>> +
>>   static int mbigen_device_probe(struct platform_device *pdev)
>>   {
>>   	struct mbigen_device *mgn_chip;
>> @@ -289,9 +342,18 @@ static int mbigen_device_probe(struct platform_device *pdev)
>>   	if (IS_ERR(mgn_chip->base))
>>   		return PTR_ERR(mgn_chip->base);
>>
>> -	err = mbigen_of_create_domain(pdev, mgn_chip);
>> -	if (err)
>> +	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
>> +		err = mbigen_of_create_domain(pdev, mgn_chip);
>> +	else if (ACPI_COMPANION(&pdev->dev))
>> +		err = mbigen_acpi_create_domain(pdev, mgn_chip);
>> +	else
>> +		err = -EINVAL;
>> +
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Failed to create mbi-gen@%p irqdomain",
>> +			mgn_chip->base);
>>   		return err;
>> +	}
>>
>>   	platform_set_drvdata(pdev, mgn_chip);
>>   	return 0;
>> @@ -303,10 +365,17 @@ static int mbigen_device_probe(struct platform_device *pdev)
>>   };
>>   MODULE_DEVICE_TABLE(of, mbigen_of_match);
>>
>> +static const struct acpi_device_id mbigen_acpi_match[] = {
>> +	{ "HISI0152", 0 },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
>> +
>>   static struct platform_driver mbigen_platform_driver = {
>>   	.driver = {
>>   		.name		= "Hisilicon MBIGEN-V2",
>>   		.of_match_table	= mbigen_of_match,
>> +		.acpi_match_table = ACPI_PTR(mbigen_acpi_match),
>>   	},
>>   	.probe			= mbigen_device_probe,
>>   };
>>
>
> All LGTM.
>
> Reviewed-by: Al Stone <ahs3@redhat.com>

Thank you Al :)

Marc, Lorenzo, since it's little bit late and urgent, could we merge
this version?

Thanks
Hanjun
