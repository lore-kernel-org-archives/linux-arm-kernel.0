From: ayaka@soulik.info (ayaka)
Date: Wed, 9 Nov 2016 22:08:42 +0800
Subject: [PATCH] drm/rockchip: analogix_dp: add supports for regulators in
 edp IP
In-Reply-To: <16dfbe16-eae7-8da9-4108-07e623210d35@rock-chips.com>
References: <1477163933-13140-1-git-send-email-ayaka@soulik.info>
 <6d050f06-996f-5ecc-20f9-587299ee34c7@rock-chips.com>
 <16dfbe16-eae7-8da9-4108-07e623210d35@rock-chips.com>
Message-ID: <47328a44-617b-b0a8-2006-c5d3c835a0d8@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/28/2016 05:29 PM, Randy Li wrote:
>
>
> On 10/28/2016 05:11 PM, Shawn Lin wrote:
>> On 2016/10/23 3:18, Randy Li wrote:
>>> I found if eDP_AVDD_1V0 and eDP_AVDD_1V8 are not been power at
>>> RK3288, once trying to enable the pclk clock, the kernel would dead.
>>> This patch would try to enable them first. The eDP_AVDD_1V8 more
>>> likely to be applied to eDP phy, but I have no time to confirmed
>>> it yet.
>>
>> Comfirm it or at least someone should be able to answer your
>> question, Mark?
> I just forget to ask the IC department, the TRM didn't cover that.
The IC staff have told me that the AVDD_1V8 is for phy, but AVDD_1V0 is 
for both of them. I should find a way to make the power sequence correctly.
I am a little busy recently, a new patch would not be available in a 
short time.
>>
>> Have you considered to add some details about vcc-supply and vccio-
>> supply for your analogix_dp-rockchip.txt ?
>>
>> From your commit msg, these two properties are more likely to be
>> required but the code itself tell me them should be optional(from the
>> point of backward compatibility, it should also be optinoal).
> Yes, I keep it optional for the same reason. Most of boards won't turn 
> off those power supply and may use some fixed regulators.
>>
>>>
>>> Signed-off-by: Randy Li <ayaka@soulik.info>
>>> ---
>>>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 25
>>> +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>>> b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>>> index 8548e82..6bf0441 100644
>>> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>>> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>>> @@ -17,6 +17,7 @@
>>>  #include <linux/of_device.h>
>>>  #include <linux/of_graph.h>
>>>  #include <linux/regmap.h>
>>> +#include <linux/regulator/consumer.h>
>>>  #include <linux/reset.h>
>>>  #include <linux/clk.h>
>>>
>>> @@ -70,6 +71,7 @@ struct rockchip_dp_device {
>>>      struct clk               *grfclk;
>>>      struct regmap            *grf;
>>>      struct reset_control     *rst;
>>> +    struct regulator_bulk_data supplies[2];
>>>
>>>      struct work_struct     psr_work;
>>>      spinlock_t         psr_lock;
>>> @@ -146,6 +148,13 @@ static int rockchip_dp_poweron(struct
>>> analogix_dp_plat_data *plat_data)
>>>
>>>      cancel_work_sync(&dp->psr_work);
>>>
>>> +    ret = regulator_bulk_enable(ARRAY_SIZE(dp->supplies),
>>> +            dp->supplies);
>>> +    if (ret) {
>>> +        dev_err(dp->dev, "failed to enable vdd supply %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>>      ret = clk_prepare_enable(dp->pclk);
>>>      if (ret < 0) {
>>>          dev_err(dp->dev, "failed to enable pclk %d\n", ret);
>>> @@ -168,6 +177,9 @@ static int rockchip_dp_powerdown(struct
>>> analogix_dp_plat_data *plat_data)
>>>
>>>      clk_disable_unprepare(dp->pclk);
>>>
>>> +    regulator_bulk_disable(ARRAY_SIZE(dp->supplies),
>>> +            dp->supplies);
>>> +
>>>      return 0;
>>>  }
>>>
>>> @@ -323,6 +335,19 @@ static int rockchip_dp_init(struct
>>> rockchip_dp_device *dp)
>>>          return PTR_ERR(dp->rst);
>>>      }
>>>
>>> +    dp->supplies[0].supply = "vcc";
>>> +    dp->supplies[1].supply = "vccio";
>>> +    ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(dp->supplies),
>>> +            dp->supplies);
>>> +    if (ret < 0) {
>>> +        dev_err(dev, "failed to get regulators: %d\n", ret);
>>> +    }
>>> +    ret = regulator_bulk_enable(ARRAY_SIZE(dp->supplies),
>>> +            dp->supplies);
>>> +    if (ret < 0) {
>>> +        dev_err(dev, "failed to enable regulators: %d\n", ret);
>>> +    }
>>> +
>>>      ret = clk_prepare_enable(dp->pclk);
>>>      if (ret < 0) {
>>>          dev_err(dp->dev, "failed to enable pclk %d\n", ret);
>>>
>>
>>
>
