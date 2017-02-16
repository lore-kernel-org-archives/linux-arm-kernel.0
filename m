From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 16 Feb 2017 10:12:33 +0800
Subject: [PATCH v3 23/24] drm/rockchip: dw-mipi-dsi: add reset control
In-Reply-To: <20170215123944.798ae363.john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-24-john@metanate.com> <58A3CD45.9090309@rock-chips.com>
 <20170215123944.798ae363.john@metanate.com>
Message-ID: <58A50A91.6010202@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John

On 02/15/2017 08:39 PM, John Keeping wrote:
> On Wed, 15 Feb 2017 11:38:45 +0800, Chris Zhong wrote:
>
>> On 01/29/2017 09:24 PM, John Keeping wrote:
>>> In order to fully reset the state of the MIPI controller we must assert
>>> this reset.
>>>
>>> This is slightly more complicated than it could be in order to maintain
>>> compatibility with device trees that do not specify the reset property.
>>>
>>> Signed-off-by: John Keeping <john@metanate.com>
>>> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
>>> ---
>>> v3:
>>> - Add Chris' Reviewed-by
>>> Unchanged in v2
>>>
>>>    drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 30 ++++++++++++++++++++++++++++++
>>>    1 file changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>>> index 58cb8ace2fe8..cf3ca6b0cbdb 100644
>>> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>>> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/module.h>
>>>    #include <linux/of_device.h>
>>>    #include <linux/regmap.h>
>>> +#include <linux/reset.h>
>>>    #include <linux/mfd/syscon.h>
>>>    #include <drm/drm_atomic_helper.h>
>>>    #include <drm/drm_crtc.h>
>>> @@ -1124,6 +1125,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>>>    			of_match_device(dw_mipi_dsi_dt_ids, dev);
>>>    	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
>>>    	struct platform_device *pdev = to_platform_device(dev);
>>> +	struct reset_control *apb_rst;
>>>    	struct drm_device *drm = data;
>>>    	struct dw_mipi_dsi *dsi;
>>>    	struct resource *res;
>>> @@ -1162,6 +1164,34 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>>>    		return ret;
>>>    	}
>>>    
>>> +	/*
>>> +	 * Note that the reset was not defined in the initial device tree, so
>>> +	 * we have to be prepared for it not being found.
>>> +	 */
>>> +	apb_rst = devm_reset_control_get(dev, "apb");
>>> +	if (IS_ERR(apb_rst)) {
>>> +		if (PTR_ERR(apb_rst) == -ENODEV) {
>> According to [0], I think it should be -ENOENT here.
> Nice catch, I'll fix this.
>
>> [0]
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=3d81216fde465e76c5eae98f61d3666163634395
>>
>> commit 3d81216fde465e76c5eae98f61d3666163634395
>> Author: Alban Bedel <albeu@free.fr>
>> Date:   Tue Sep 1 17:28:31 2015 +0200
>>
>>       reset: Fix of_reset_control_get() for consistent return values
>>
>>       When of_reset_control_get() is called without connection ID it returns
>>       -ENOENT when the 'resets' property doesn't exists or is an empty entry.
>>       However when a connection ID is given it returns -EINVAL when the
>> 'resets'
>>       property doesn't exists or the requested name can't be found. This is
>>       because the error code returned by of_property_match_string() is just
>>       passed down as an index to of_parse_phandle_with_args(), which then
>>       returns -EINVAL.
>>
>>       To get a consistent return value with both code paths we must return
>>       -ENOENT when of_property_match_string() fails.
>>
>>       Signed-off-by: Alban Bedel <albeu@free.fr>
>>       Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>>
>>> +			apb_rst = NULL;
>>> +		} else {
>>> +			dev_err(dev, "Unable to get reset control: %d\n", ret);
Also, we can not get error number from "ret" here.

>>> +			return PTR_ERR(apb_rst);
>>> +		}
>>> +	}
>>> +
>>> +	if (apb_rst) {
>>> +		ret = clk_prepare_enable(dsi->pclk);
>>> +		if (ret) {
>>> +			dev_err(dev, "%s: Failed to enable pclk\n", __func__);
>>> +			return ret;
>>> +		}
>>> +
>>> +		reset_control_assert(apb_rst);
>>> +		usleep_range(10, 20);
>>> +		reset_control_deassert(apb_rst);
>>> +
>>> +		clk_disable_unprepare(dsi->pclk);
>>> +	}
>>> +
>>>    	ret = clk_prepare_enable(dsi->pllref_clk);
>>>    	if (ret) {
>>>    		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
>>
>
>
