From: wni@nvidia.com (Wei Ni)
Date: Thu, 8 Aug 2013 17:59:28 +0800
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <1375955834.368114617@f197.i.mail.ru>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <520359E9.1000600@roeck-us.net> <52036920.4050808@nvidia.com>
 <1375955834.368114617@f197.i.mail.ru>
Message-ID: <52036C00.20405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 05:57 PM, Alexander Shiyan wrote:
>> On 08/08/2013 04:42 PM, Guenter Roeck wrote:
>>> On 08/07/2013 11:56 PM, Wei Ni wrote:
>>>> The device lm90 can be controlled by the vdd rail.
>>>> Adding the power control support to power on/off the vdd rail.
>>>> And make sure that power is enabled before accessing the device.
>>>>
>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>> ---
>>>>   drivers/hwmon/lm90.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
> [...]
>>> I consider the messages unnecessary and confusing. You are polluting the log
>>> of pretty much every PC user who has one of the supported chips in the system,
>>> and of everyone else not using regulators for this chip.
>>
>> Ok, I will remove these codes.
>> So I will write something like:
>> if (!IS_ERR(data->lm90_reg)) {
>>     ret = regulator_enable(data->lm90_reg);
>>     if (ret < 0) {
>>         dev_err();
>>         return ret;
>>     }
>> } else {
>>     if (PTR_ERR(data->lm90_reg) == -EPROBE_DEFER)
>>         return -EPRPBE_DEFER;
>>
>>         data->lm90_reg = !!IS_ERR(data->lm90_reg);
> 
> No. You do not need this line.
> 
> Just use in remove():
> if (!IS_ERR(data->lm90_reg))
> regulator_disable(data->lm90_reg);

Oh, I see, thank you very much.

> 
> ---
> 
