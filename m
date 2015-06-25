From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 25 Jun 2015 21:01:28 +0530
Subject: [PATCH-v4 2/3] mfd: 88pm800: Set default interrupt clear method
In-Reply-To: <20150625144627.GB23990@x1>
References: <1435217189-19578-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435217189-19578-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150625102618.GC15013@x1> <558BE3D6.2010801@linaro.org>
 <20150625144627.GB23990@x1>
Message-ID: <558C1ED0.4010408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 25 June 2015 08:16 PM, Lee Jones wrote:
> On Thu, 25 Jun 2015, Vaibhav Hiremath wrote:
>> On Thursday 25 June 2015 03:56 PM, Lee Jones wrote:
>>> On Thu, 25 Jun 2015, Vaibhav Hiremath wrote:
>>>
>>>> As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
>>>> (page 0) controls the method of clearing interrupt
>>>> status of 88pm800 family of devices;
>>>>
>>>>    0: clear on read
>>>>    1: clear on write
>>>>
>>>> If pdata is not coming from board file, then set the
>>>> default irq clear method to "irq clear on write"
>>>>
>>>> Also, as suggested by "Lee Jones" renaming variable field
>>>> to appropriate name.
>>>>
>>>> Signed-off-by: Zhao Ye <zhaoy@marvell.com>
>>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>>> ---
>>>>   drivers/mfd/88pm800.c       | 15 ++++++++++-----
>>>>   include/linux/mfd/88pm80x.h |  6 ++++--
>>>>   2 files changed, 14 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
>>>> index 40fd014..e0cd7ad 100644
>>>> --- a/drivers/mfd/88pm800.c
>>>> +++ b/drivers/mfd/88pm800.c
>
> [...]
>
>>>> +		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
>>>> +	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, irq_clr_mode);
>>>>
>>>>   	if (ret < 0)
>>>>   		goto out;
>>>> @@ -514,6 +515,7 @@ static int device_800_init(struct pm80x_chip *chip,
>>>>   	}
>>>>
>>>>   	chip->regmap_irq_chip = &pm800_irq_chip;
>>>> +	chip->irq_clr_on_wr = pdata->irq_clr_on_wr;
>>>
>>> You have protection around pdata everywhere else in the file, I
>>> suggest you supply some here too.
>>>
>>
>> Actually it is not really needed, as the PATCH 1/1 introduces
>>
>>
>>          if (!pdata && !np) {
>>                  dev_err(&client->dev,
>>                          "pm80x requires platform data or of_node\n");
>>                  return -EINVAL;
>>          }
>>
>>          if (!pdata && !np) {
>>                  dev_err(&client->dev,
>>                          "pm80x requires platform data or of_node\n");
>>                  return -EINVAL;
>>          }
>>
>>
>> So there is no way you can have pdata = NULL beyond this point.
>
> I saw that.  I want you to remove that too.
>

You mean, remove existing protection in the driver?
I will create a separate patch for this.

> [...]
>
>>>> --- a/include/linux/mfd/88pm80x.h
>>>> +++ b/include/linux/mfd/88pm80x.h
>>>> @@ -77,6 +77,8 @@ enum {
>>>>   #define PM800_WAKEUP2		(0x0E)
>>>>   #define PM800_WAKEUP2_INV_INT		(1 << 0)
>>>>   #define PM800_WAKEUP2_INT_CLEAR		(1 << 1)
>>>> +#define PM800_WAKEUP2_INT_READ_CLEAR		(0 << 1)
>>>> +#define PM800_WAKEUP2_INT_WRITE_CLEAR		(1 << 1)
>>>>   #define PM800_WAKEUP2_INT_MASK		(1 << 2)
>>>
>>> Use the BIT() macro.
>>>
>>
>> I thought about this, but the whole file doesn't use it, so I also
>> chose not to.
>
> Then the whole file needs moving over.
>
> Patches accepted.
>

Will change the driver and submit the patch.


>>>>   #define PM800_POWER_UP_LOG	(0x10)
>>>> @@ -300,7 +302,7 @@ struct pm80x_chip {
>>>>   	struct regmap_irq_chip_data *irq_data;
>>>>   	int type;
>>>>   	int irq;
>>>> -	int irq_mode;
>>>> +	int irq_clr_on_wr;	/* '1': Clear on write, '0': Clear on read*/
>>>
>>> Whitespace issue.
>>
>> Didn't see any...and I also ran checkpatch.
>
> You have no space before the '*/'.
>
>>> Shouldn't this be a bool?
>>>
>>
>> Just was not sure about any older board file interface.
>> Ideally it should be bool only.
>
> Right.
>
>>> Actually even better, I would define; CLR_ON_WRITE and CLR_ON_READ,
>>> and call the variable irq_clear_method, or something.
>>>
>>> Much clearer that way I think.
>>>
>>
>> We have slowly decided to almost hardcode it to one value if there is
>> no board file. I feel we should just keep it to simple.
>>
>> If you still insist, I can implement.
>
> I like clarity and by your own admission (by warranting an additional
> comment) it's not clear.  Please make it as clear as you can.
>

OK, will change the code for CLEAR_ON_READ and CLEAR_ON_WRITE.

Thanks,
Vaibhav
