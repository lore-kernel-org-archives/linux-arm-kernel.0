From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sat, 5 Nov 2016 11:18:37 +0530
Subject: [PATCH v2] phy: sun4i: check PMU presence when poking unknown bit
 of pmu
In-Reply-To: <41f43381-c1bb-2f69-5f99-ac5cebf651ea@redhat.com>
References: <20161028162701.4531-1-icenowy@aosc.xyz>
 <41f43381-c1bb-2f69-5f99-ac5cebf651ea@redhat.com>
Message-ID: <f46bb951-021d-21eb-3b5b-467dd182b2c6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 28 October 2016 11:45 PM, Hans de Goede wrote:
> Hi,
> 
> On 28-10-16 18:27, Icenowy Zheng wrote:
>> Allwinner SoC's PHY 0, when used as OTG controller, have no pmu part.
>> The code that poke some unknown bit of PMU for H3/A64 didn't check
>> the PHY, and will cause kernel oops when PHY 0 is used.
>>
>> This patch will check whether the pmu is not NULL before poking.
>>
>> Fixes: b3e0d141ca9f (phy: sun4i: add support for A64 usb phy)
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Patch LGTM too:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

merged, thanks.

-Kishon
> 
> Regards,
> 
> Hans
> 
> 
>> ---
>>  drivers/phy/phy-sun4i-usb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
>> index b9342a2..fec34f5 100644
>> --- a/drivers/phy/phy-sun4i-usb.c
>> +++ b/drivers/phy/phy-sun4i-usb.c
>> @@ -264,7 +264,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>>          return ret;
>>      }
>>
>> -    if (data->cfg->enable_pmu_unk1) {
>> +    if (phy->pmu && data->cfg->enable_pmu_unk1) {
>>          val = readl(phy->pmu + REG_PMU_UNK1);
>>          writel(val & ~2, phy->pmu + REG_PMU_UNK1);
>>      }
>>
