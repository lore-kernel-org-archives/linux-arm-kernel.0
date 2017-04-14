From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 14 Apr 2017 09:43:21 +0900
Subject: [PATCH 1/2] phy: qcom-usb-hs: Replace the extcon API
In-Reply-To: <ade390be-3104-916c-5fac-780369763411@ti.com>
References: <CGME20170328043830epcas1p4069bda461ad648cfd6598905b7167e9f@epcas1p4.samsung.com>
 <1490675909-2533-1-git-send-email-cw00.choi@samsung.com>
 <ade390be-3104-916c-5fac-780369763411@ti.com>
Message-ID: <58F01B29.10304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 2017? 04? 13? 20:47, Kishon Vijay Abraham I wrote:
> Hi Chanwoo,
> 
> On Tuesday 28 March 2017 10:08 AM, Chanwoo Choi wrote:
>> This patch uses the resource-managed extcon API for extcon_register_notifier()
>> and replaces the deprecated extcon API as following:
>> - (deprecated) extcon_get_cable_state_() -> extcon_get_state()
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> I've missed merging this patch for the next merge window. If you want to take
> this yourself.
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

I already posted the pull-request to GregKH for extcon subsystem.
So, if possible, I hope you handle these patches.
Even if these patches are not merged to 4.12-rc1, I'm ok. 
Just I want to handle them on your tree for next time.

> 
> Thanks
> Kishon
>> ---
>>  drivers/phy/phy-qcom-usb-hs.c | 14 +++-----------
>>  1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/phy/phy-qcom-usb-hs.c b/drivers/phy/phy-qcom-usb-hs.c
>> index 94dfbfd739c3..f630fa553b7d 100644
>> --- a/drivers/phy/phy-qcom-usb-hs.c
>> +++ b/drivers/phy/phy-qcom-usb-hs.c
>> @@ -156,12 +156,12 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
>>  	}
>>  
>>  	if (uphy->vbus_edev) {
>> -		state = extcon_get_cable_state_(uphy->vbus_edev, EXTCON_USB);
>> +		state = extcon_get_state(uphy->vbus_edev, EXTCON_USB);
>>  		/* setup initial state */
>>  		qcom_usb_hs_phy_vbus_notifier(&uphy->vbus_notify, state,
>>  					      uphy->vbus_edev);
>> -		ret = extcon_register_notifier(uphy->vbus_edev, EXTCON_USB,
>> -				&uphy->vbus_notify);
>> +		ret = devm_extcon_register_notifier(&ulpi->dev, uphy->vbus_edev,
>> +				EXTCON_USB, &uphy->vbus_notify);
>>  		if (ret)
>>  			goto err_ulpi;
>>  	}
>> @@ -180,16 +180,8 @@ static int qcom_usb_hs_phy_power_on(struct phy *phy)
>>  
>>  static int qcom_usb_hs_phy_power_off(struct phy *phy)
>>  {
>> -	int ret;
>>  	struct qcom_usb_hs_phy *uphy = phy_get_drvdata(phy);
>>  
>> -	if (uphy->vbus_edev) {
>> -		ret = extcon_unregister_notifier(uphy->vbus_edev, EXTCON_USB,
>> -						 &uphy->vbus_notify);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>  	regulator_disable(uphy->v3p3);
>>  	regulator_disable(uphy->v1p8);
>>  	clk_disable_unprepare(uphy->sleep_clk);
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
