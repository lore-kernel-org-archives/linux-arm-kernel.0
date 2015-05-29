From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sat, 30 May 2015 01:50:12 +0530
Subject: [PATCH 03/12] i2c: pxa: Add reset operation when i2c bus busy
In-Reply-To: <878uc7yxzx.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-4-git-send-email-vaibhav.hiremath@linaro.org>
 <878uc7yxzx.fsf@belgarion.home>
Message-ID: <5568C9FC.7040906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 30 May 2015 01:09 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> From: "Jett.Zhou" <jtzhou@marvell.com>
>>
>> According to some test in emei_dkb, we found some i2c slave device
>> (eg. camera sensor ov2659 power up) introduce noise on sda, so detect
>> i2c controller busy, and assert reset to i2c controller to recover as
>> early as possible to avoid more latency on the entire i2c transaction.
>>
>> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
>> [vaibhav.hiremath at linaro.org: Removed reduction in timeout value, as I
>> do not have goot explanation for it. Logically it is not required.
>> And also Updated changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/i2c/busses/i2c-pxa.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index d4c798a..a76c901 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -314,6 +314,10 @@ static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
>>   {
>>   	int timeout = DEF_TIMEOUT;
>>
>> +	if (readl(_ISR(i2c)) & (ISR_IBB | ISR_UB))
>> +		i2c_pxa_reset(i2c);
>
> The pxa27x manual states in the Developer Manual, chapter 9.4.13 "Reset
> Conditions" :
>              Software must ensure that (1) the I 2 C unit is not busy before it
>              asserts a reset
>
> Given that, I don't agree with this patch.


Hmmm,

Just saw pxa27x manual, and you are right.
In that case I am not sure how to address the issue mentioned in the
changelog.

On the other side,

Check for ISR_IBB, should be ok, as, as per spec it says,

"Set when the TWSI bus is busy but the SoC TWSI is not
involved in the transaction."

Also,
I believe we should be ok, as the first thing we do in i2c_pxa_reset()
is abort the current transaction and then assert reset. Isn't it?

> Moreover, reseting unconditionaly the
> i2c bus on each busy state on a write transaction for one single corner case is
> not something that has my agreement. A quirk might overcome my reluctance.
>

Any condition check you can possibly think of for asserting reset???

Having said that,
Somewhere I do agree with you that we need to further debug on noise
issue in HW rather hacking software. :)

I am ok to drop this patch, do further testing and revisit again if
issue persist.

Thanks,
Vaibhav
