From: lyz@rock-chips.com (Yunzhi Li)
Date: Mon, 08 Dec 2014 19:04:20 +0800
Subject: [PATCH v3 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <548575F0.4090909@ti.com>
References: <1418031988-2700-1-git-send-email-lyz@rock-chips.com>
 <1418031988-2700-2-git-send-email-lyz@rock-chips.com>
 <548575F0.4090909@ti.com>
Message-ID: <548585B4.107@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon :

On 2014/12/8 17:57, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Monday 08 December 2014 03:16 PM, Yunzhi Li wrote:
>> This patche to add a generic PHY driver for ROCKCHIP usb PHYs,
> %s/patche/patch
Sorry for this typo.
>> +#include <linux/reset.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +
>> +#define ROCKCHIP_RK3288_UOC(n)	(0x320 + n * 0x14)
>> +
>> +#define SIDDQ_MSK		BIT(13 + 16)
> This doesn't look correct. Won't this mask bit no:29?
The higher 16-bit of this register is used for write-protect, only if 
BIT(13 + 16)
set to 1 the BIT(13) can be written. I will add some comments here in 
the next
version, to prevent others confused. ok ?

>> [...]
>>
>> +static int rockchip_usb_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct rockchip_usb_phy *rk_phy;
>> +	struct rockchip_usb_phy *phy_array;
>> +	struct phy_provider *phy_provider;
>> +	struct regmap *grf;
>> +	char clk_name[16];
>> +	int i;
>> +
>> +	grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
>> +	if (IS_ERR(grf)) {
>> +		dev_err(&pdev->dev, "Missing rockchip,grf property\n");
>> +		return PTR_ERR(grf);
>> +	}
>> +
>> +	phy_array = devm_kzalloc(dev, RK3288_NUM_PHYS * sizeof(*rk_phy),
>> +				 GFP_KERNEL);
>> +	if (!phy_array)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < RK3288_NUM_PHYS; i++) {
> Don't hardcode NUM_PHYS. All this has to come from dt. Model each PHYs as
> subnode of the phy provider node and use it here.
I got it, it should be like this, model each PHYs as sub node and use 
of_get_child_count() to get the number of phys.
