From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 05 Aug 2015 14:37:50 +0530
Subject: [PATCH 4/4] mfd: 88pm800: Add support for clk subdevice
In-Reply-To: <20150723155008.GS3436@x1>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150723155008.GS3436@x1>
Message-ID: <55C1D266.5090804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 23 July 2015 09:20 PM, Lee Jones wrote:
> On Tue, 21 Jul 2015, Vaibhav Hiremath wrote:
>
>> This patch adds mfd_cell/clk-subdevice for 88PM800 MFD
>> (and family of devices).
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/mfd/88pm800.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
>> index f104a32..9723eac 100644
>> --- a/drivers/mfd/88pm800.c
>> +++ b/drivers/mfd/88pm800.c
>> @@ -173,6 +173,14 @@ static const struct mfd_cell regulator_devs[] = {
>>   	},
>>   };
>>
>> +static struct mfd_cell clk_devs[] = {
>> +	{
>> +	 .name = "88pm80x-clk",
>> +	 .of_compatible = "marvell,88pm800-clk",
>> +	 .id = -1,
>> +	},
>> +};
>
> Why does each device in 88pm800.c have it's own mfd_cell?
>

Probably, the author of the driver can comment on this. I have cc'ed
all of them.

But looking at the driver it looks like, except onkey and regulator all
other devices need per-initialization. For example,

in case of clock,

static int device_clk_init(struct pm80x_chip *chip)
{
         if (chip->type == CHIP_PM800)
                 clk_devs[0].name = "88pm800-clk";
         else if (chip->type == CHIP_PM860)
                 clk_devs[0].name = "88pm860-clk";

         return mfd_add_devices(chip->dev, 0, &clk_devs[0],
                               ARRAY_SIZE(clk_devs), NULL, 0, NULL);
}



> Take the opportunity to correct the tabbing in the remainder of the
> file.  Make that fix-up patch 1 of this set.  Then fixup this patch.
>

Ok, I will.

Thanks,
Vaibhav
