From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 2 Nov 2018 14:13:38 +0530
Subject: [PATCH v4 03/10] phy: sun4i-usb: add support for H6 USB2 PHY
In-Reply-To: <9cca3453d646f38793df411c4471d062769b4f72.camel@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
 <20181004122855.22981-4-icenowy@aosc.io>
 <9cca3453d646f38793df411c4471d062769b4f72.camel@aosc.io>
Message-ID: <bf2ec3ca-b823-4861-2d40-04227db61e49@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/11/18 2:11 PM, Icenowy Zheng wrote:
> ? 2018-10-04?? 20:28 +0800?Icenowy Zheng???
>> The USB 2.0 PHY on Allwinner H6 SoC is similar to older Allwinner
>> SoCs,
>> with some USB0 quirk like A83T and PHY index 1/2 missing.
>>
>> Add support for it.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Excuse me.
> 
> Kishon, could you check PATCH 1~3 and queue them?
> 
> Even if USB3 support is pending, USB2 support will still be useful, and
> they're independent.

I'll queue once -rc1 is tagged.

Thanks
Kishon

> 
>> ---
>> No changes in v4.
>>
>> Changes in v3:
>> - Added Chen-Yu's Review tag.
>>
>>  drivers/phy/allwinner/phy-sun4i-usb.c | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c
>> b/drivers/phy/allwinner/phy-sun4i-usb.c
>> index 881078ff73f6..ae16854a770a 100644
>> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
>> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
>> @@ -115,6 +115,7 @@ enum sun4i_usb_phy_type {
>>  	sun8i_r40_phy,
>>  	sun8i_v3s_phy,
>>  	sun50i_a64_phy,
>> +	sun50i_h6_phy,
>>  };
>>  
>>  struct sun4i_usb_phy_cfg {
>> @@ -295,7 +296,8 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>>  		return ret;
>>  	}
>>  
>> -	if (data->cfg->type == sun8i_a83t_phy) {
>> +	if (data->cfg->type == sun8i_a83t_phy ||
>> +	    data->cfg->type == sun50i_h6_phy) {
>>  		if (phy->index == 0) {
>>  			val = readl(data->base + data->cfg-
>>> phyctl_offset);
>>  			val |= PHY_CTL_VBUSVLDEXT;
>> @@ -344,7 +346,8 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
>>  	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
>>  
>>  	if (phy->index == 0) {
>> -		if (data->cfg->type == sun8i_a83t_phy) {
>> +		if (data->cfg->type == sun8i_a83t_phy ||
>> +		    data->cfg->type == sun50i_h6_phy) {
>>  			void __iomem *phyctl = data->base +
>>  				data->cfg->phyctl_offset;
>>  
>> @@ -959,6 +962,17 @@ static const struct sun4i_usb_phy_cfg
>> sun50i_a64_cfg = {
>>  	.phy0_dual_route = true,
>>  };
>>  
>> +static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
>> +	.num_phys = 4,
>> +	.type = sun50i_h6_phy,
>> +	.disc_thresh = 3,
>> +	.phyctl_offset = REG_PHYCTL_A33,
>> +	.dedicated_clocks = true,
>> +	.enable_pmu_unk1 = true,
>> +	.phy0_dual_route = true,
>> +	.missing_phys = BIT(1) | BIT(2),
>> +};
>> +
>>  static const struct of_device_id sun4i_usb_phy_of_match[] = {
>>  	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data =
>> &sun4i_a10_cfg },
>>  	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data =
>> &sun5i_a13_cfg },
>> @@ -972,6 +986,7 @@ static const struct of_device_id
>> sun4i_usb_phy_of_match[] = {
>>  	{ .compatible = "allwinner,sun8i-v3s-usb-phy", .data =
>> &sun8i_v3s_cfg },
>>  	{ .compatible = "allwinner,sun50i-a64-usb-phy",
>>  	  .data = &sun50i_a64_cfg},
>> +	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data =
>> &sun50i_h6_cfg },
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> 
