From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 25 Sep 2014 09:53:15 +0800
Subject: [PATCH] pwm: atmel-pwm: fix calculation of prescale value
In-Reply-To: <542374D3.3080308@atmel.com>
References: <20140924055138.477E540656@mail.steuer-voss.de>
 <542374D3.3080308@atmel.com>
Message-ID: <5423758B.9000808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Correct the PWM maintainer Thierry Reding's e-mail address.

and Add linux-arm-kernel ML.

On 09/25/2014 09:50 AM, Bo Shen wrote:
> Hi Nikolaus Voss,
>
> On 09/23/2014 09:30 PM, Nikolaus Voss wrote:
>> The prescale value used for calculating the period was incremented
>> afterwards, thus the resulting prescale value is by one too high.
>> This resulted in a pwm frequency only half as high as requested.
>>
>> This patch moves the 64 bit division out of the prescale loop to
>> correct the above issue and make the calculation more efficient.
>
> Thanks for your patch.
>
>> Signed-off-by: Nikolaus Voss <n.voss@weinmann-emt.de>
>
> Tested-by: Bo Shen <voice.shen@atmel.com>
> Acked-by: Bo Shen <voice.shen@atmel.com>
>
>> ---
>>   drivers/pwm/pwm-atmel.c | 24 +++++++++++-------------
>>   1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index 6e700a5..ff17b5d 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -102,7 +102,7 @@ static int atmel_pwm_config(struct pwm_chip *chip,
>> struct pwm_device *pwm,
>>                   int duty_ns, int period_ns)
>>   {
>>       struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>> -    unsigned long clk_rate, prd, dty;
>> +    unsigned long prd, dty;
>>       unsigned long long div;
>>       unsigned int pres = 0;
>>       u32 val;
>> @@ -113,20 +113,18 @@ static int atmel_pwm_config(struct pwm_chip
>> *chip, struct pwm_device *pwm,
>>           return -EBUSY;
>>       }
>>
>> -    clk_rate = clk_get_rate(atmel_pwm->clk);
>> -    div = clk_rate;
>> +    /* Calculate the period cycles and prescale value */
>> +    div = (unsigned long long)clk_get_rate(atmel_pwm->clk) * period_ns;
>> +    do_div(div, (int)1e9);
>>
>> -    /* Calculate the period cycles */
>>       while (div > PWM_MAX_PRD) {
>> -        div = clk_rate / (1 << pres);
>> -        div = div * period_ns;
>> -        /* 1/Hz = 100000000 ns */
>> -        do_div(div, 1000000000);
>> -
>> -        if (pres++ > PRD_MAX_PRES) {
>> -            dev_err(chip->dev, "pres exceeds the maximum value\n");
>> -            return -EINVAL;
>> -        }
>> +        div >>= 1;
>> +        ++pres;
>> +    }
>> +
>> +    if (pres > PRD_MAX_PRES) {
>> +        dev_err(chip->dev, "pres exceeds the maximum value\n");
>> +        return -EINVAL;
>>       }
>>
>>       /* Calculate the duty cycles */
>>
>
> Best Regards,
> Bo Shen

Best Regards,
Bo Shen
