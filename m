From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sat, 30 May 2015 02:53:08 +0530
Subject: [PATCH 06/12] i2c: pxa: Return I2C_RETRY when timeout in pio mode
In-Reply-To: <87vbfbxgb0.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-7-git-send-email-vaibhav.hiremath@linaro.org>
 <87vbfbxgb0.fsf@belgarion.home>
Message-ID: <5568D8BC.1070606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 30 May 2015 02:16 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> From: Shouming Wang <wangshm@marvell.com>
>>
>> In case of timeout in pio mode of operation return I2C_RETRY.
>> This behavior will be same as interrupt mode of operation.
>>
>> Signed-off-by: Shouming Wang <wangshm@marvell.com>
>> [vaibhav.hiremath at linaro.org: Updated changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/i2c/busses/i2c-pxa.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index eb09071..2777d5c 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -841,8 +841,10 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
>>   	ret = i2c->msg_idx;
>>
>>   out:
>> -	if (timeout == 0)
>> +	if (timeout == 0) {
>>   		i2c_pxa_scream_blue_murder(i2c, "timeout");
>> +		ret = I2C_RETRY;
>> +	}
> Ok, looks good to me.
> As it changes the dynamic behavior of i2c_pxa_pio_xfer(), I'd like to know how
> it was tested (on which platform, and what was on the I2C bus).
>

I am testing on PXA1928 based platform, which still not available fully
on Mainline.

I have PMIC 88PM860 connected to I2C bus, with very basic features
enabled. So I do probe/read/write testing.

Having said that, I still did not test RETRY path, to make sure that
RETRY really happens. As I mentioned, everything is under developement,
I just enabled PMIC support on my baseline to validate I2C driver.

Thanks,
Vaibhav
