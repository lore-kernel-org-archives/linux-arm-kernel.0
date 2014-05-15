From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 15 May 2014 15:14:15 +0530
Subject: [PATCH RESEND v4 3/8] phy: sunxi: Rework phy initialization
In-Reply-To: <537303C3.8040503@ti.com>
References: <1399995862-17788-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399995862-17788-4-git-send-email-maxime.ripard@free-electrons.com>
 <537303C3.8040503@ti.com>
Message-ID: <53748C6F.4090801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 14 May 2014 11:18 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 13 May 2014 09:14 PM, Maxime Ripard wrote:
>> Move the phy initialization and variables declaration to the loop itself, since
>> it is where it really belongs. Also remove all the temporary variables, we can
>> use the structure members directly.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> let me know if I have to queue this and the next patch in my PHY tree.

queued this and the next patch in my tree.

Cheers
Kishon

> 
> Cheers
> Kishon
> 
>> ---
>>  drivers/phy/phy-sun4i-usb.c | 42 ++++++++++++++++++------------------------
>>  1 file changed, 18 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>> index e6e6c4ba7145..66a87d50512b 100644
>> --- a/drivers/phy/phy-sun4i-usb.c
>> +++ b/drivers/phy/phy-sun4i-usb.c
>> @@ -224,13 +224,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>>  	struct sun4i_usb_phy_data *data;
>>  	struct device *dev = &pdev->dev;
>>  	struct device_node *np = dev->of_node;
>> -	void __iomem *pmu = NULL;
>>  	struct phy_provider *phy_provider;
>> -	struct reset_control *reset;
>> -	struct regulator *vbus;
>>  	struct resource *res;
>> -	struct phy *phy;
>> -	char name[16];
>>  	int i;
>>  
>>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> @@ -262,42 +257,41 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>>  
>>  	/* Skip 0, 0 is the phy for otg which is not yet supported. */
>>  	for (i = 1; i < data->num_phys; i++) {
>> +		struct sun4i_usb_phy *phy = data->phys + i;
>> +		char name[16];
>> +
>>  		snprintf(name, sizeof(name), "usb%d_vbus", i);
>> -		vbus = devm_regulator_get_optional(dev, name);
>> -		if (IS_ERR(vbus)) {
>> -			if (PTR_ERR(vbus) == -EPROBE_DEFER)
>> +		phy->vbus = devm_regulator_get_optional(dev, name);
>> +		if (IS_ERR(phy->vbus)) {
>> +			if (PTR_ERR(phy->vbus) == -EPROBE_DEFER)
>>  				return -EPROBE_DEFER;
>> -			vbus = NULL;
>> +			phy->vbus = NULL;
>>  		}
>>  
>>  		snprintf(name, sizeof(name), "usb%d_reset", i);
>> -		reset = devm_reset_control_get(dev, name);
>> -		if (IS_ERR(reset)) {
>> +		phy->reset = devm_reset_control_get(dev, name);
>> +		if (IS_ERR(phy->reset)) {
>>  			dev_err(dev, "failed to get reset %s\n", name);
>> -			return PTR_ERR(reset);
>> +			return PTR_ERR(phy->reset);
>>  		}
>>  
>>  		if (i) { /* No pmu for usbc0 */
>>  			snprintf(name, sizeof(name), "pmu%d", i);
>>  			res = platform_get_resource_byname(pdev,
>>  							IORESOURCE_MEM, name);
>> -			pmu = devm_ioremap_resource(dev, res);
>> -			if (IS_ERR(pmu))
>> -				return PTR_ERR(pmu);
>> +			phy->pmu = devm_ioremap_resource(dev, res);
>> +			if (IS_ERR(phy->pmu))
>> +				return PTR_ERR(phy->pmu);
>>  		}
>>  
>> -		phy = devm_phy_create(dev, &sun4i_usb_phy_ops, NULL);
>> -		if (IS_ERR(phy)) {
>> +		phy->phy = devm_phy_create(dev, &sun4i_usb_phy_ops, NULL);
>> +		if (IS_ERR(phy->phy)) {
>>  			dev_err(dev, "failed to create PHY %d\n", i);
>> -			return PTR_ERR(phy);
>> +			return PTR_ERR(phy->phy);
>>  		}
>>  
>> -		data->phys[i].phy = phy;
>> -		data->phys[i].pmu = pmu;
>> -		data->phys[i].vbus = vbus;
>> -		data->phys[i].reset = reset;
>> -		data->phys[i].index = i;
>> -		phy_set_drvdata(phy, &data->phys[i]);
>> +		phy->index = i;
>> +		phy_set_drvdata(phy->phy, &data->phys[i]);
>>  	}
>>  
>>  	dev_set_drvdata(dev, data);
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
