From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 8 Jul 2016 17:43:03 -0700
Subject: [PATCH 1/2] tty: amba-pl011: add support for clock frequency
 setting via dt
In-Reply-To: <146802378337.73491.10770797315435166004@resonance>
References: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <146799807004.73491.2602277598493203375@resonance>
 <57801DA6.5010506@linaro.org>
 <146802378337.73491.10770797315435166004@resonance>
Message-ID: <57804897.1080101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 05:23 PM, Michael Turquette wrote:
> Quoting Jorge Ramirez (2016-07-08 14:39:50)
>> On 07/08/2016 07:14 PM, Michael Turquette wrote:
>>> Quoting Jorge Ramirez-Ortiz (2016-07-08 01:11:06)
>>>> Allow to specify the clock frequency for any given port via the
>>>> assigned-clock-rates device tree property.
>>>>
>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>>> Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>>> ---
>>>>   drivers/tty/serial/amba-pl011.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>>>> index 1b7331e..51867ab 100644
>>>> --- a/drivers/tty/serial/amba-pl011.c
>>>> +++ b/drivers/tty/serial/amba-pl011.c
>>>> @@ -55,6 +55,7 @@
>>>>   #include <linux/types.h>
>>>>   #include <linux/of.h>
>>>>   #include <linux/of_device.h>
>>>> +#include <linux/clk/clk-conf.h>
>>>>   #include <linux/pinctrl/consumer.h>
>>>>   #include <linux/sizes.h>
>>>>   #include <linux/io.h>
>>>> @@ -2472,6 +2473,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>>>>          if (IS_ERR(uap->clk))
>>>>                  return PTR_ERR(uap->clk);
>>>>   
>>>> +       ret = of_clk_set_defaults(dev->dev.of_node, false);
>>> Change looks good to me, but with one question: should this change be
>>> put into more generic code instead of in this specific driver? For
>>> instance, we call of_clk_set_defaults from the following files:
>>>
>>> drivers/base/platform.c
>>> drivers/i2c/i2c-core.c
>>> drivers/spi/spi.c
>>>
>>> And Stephen posted a patch to do this for devices on the AMBA bus:
>>>
>>> https://patchwork.kernel.org/patch/6501691/
>>>
>>> Does Stephen's patch mean that you do not need patch #1?
>> I did a quick test (replaced my changes with the patch above) and the 
>> console broke and the BT stack couldn't communicate to the device over 
>> the uart...I guess something else needs doing on top of Stephen's change.
>>
> Let's give Stephen a chance to respond. If he doesn't soon then I'm OK
> to merge your two patches.
>


Yeah we need to restart that patch. It's been in my "pending" list for a
year now it seems.

Curious why it broke things, perhaps device probe is failing when it
didn't fail before?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
