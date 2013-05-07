From: marek.belisko@streamunlimited.com (Marek Belisko)
Date: Tue, 07 May 2013 12:40:56 +0200
Subject: [PATCH 2/2] clk: si5351: Powerdown output when clock rate is
 0.
In-Reply-To: <5188D26B.6020000@gmail.com>
References: <1367914491-17445-1-git-send-email-marek.belisko@streamunlimited.com>
 <1367914491-17445-2-git-send-email-marek.belisko@streamunlimited.com>
 <5188D26B.6020000@gmail.com>
Message-ID: <5188DA38.9030405@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2013 12:07 PM, Sebastian Hesselbarth wrote:
> On 05/07/2013 10:14 AM, Marek Belisko wrote:
>> When rate is 0 powerdown clock output.
>>
>> Signed-off-by: Marek Belisko<marek.belisko@streamunlimited.com>
>> ---
>>   drivers/clk/clk-si5351.c |   32 +++++++++++++++++++-------------
>>   1 file changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
>> index a8fc0f4..e254e76 100644
>> --- a/drivers/clk/clk-si5351.c
>> +++ b/drivers/clk/clk-si5351.c
>> @@ -1042,20 +1042,22 @@ static int si5351_clkout_set_rate(struct
>> clk_hw *hw, unsigned long rate,
>>       struct si5351_hw_data *hwdata =
>>           container_of(hw, struct si5351_hw_data, hw);
>>       unsigned long new_rate, new_err, err;
>> -    unsigned char rdiv;
>> +    unsigned char rdiv, pdn = 0;
>>
>>       /* round to closed rdiv */
>>       rdiv = SI5351_OUTPUT_CLK_DIV_1;
>> -    new_rate = parent_rate;
>> -    err = abs(new_rate - rate);
>> -    do {
>> -        new_rate>>= 1;
>> -        new_err = abs(new_rate - rate);
>> -        if (new_err>  err || rdiv == SI5351_OUTPUT_CLK_DIV_128)
>> -            break;
>> -        rdiv++;
>> -        err = new_err;
>> -    } while (1);
>> +    if (rate) {
>> +        new_rate = parent_rate;
>
> Marek,
>
> initalizing pdn to SI5351_CLK_POWERDOWN and skip (with goto) to
> powerup/down call on zero rate will save us a level of indention here.
OK will fix and resubmit in v2. Thanks.
>
>> +        err = abs(new_rate - rate);
>> +        do {
>> +            new_rate>>= 1;
>> +            new_err = abs(new_rate - rate);
>> +            if (new_err>  err || rdiv == SI5351_OUTPUT_CLK_DIV_128)
>> +                break;
>> +            rdiv++;
>> +            err = new_err;
>> +        } while (1);
>
> of course, pdn should be set to 0 here.
>
>> +    }
>>
>>       /* write output divider */
>>       switch (hwdata->num) {
>> @@ -1075,9 +1077,13 @@ static int si5351_clkout_set_rate(struct clk_hw
>> *hw, unsigned long rate,
>>                   rdiv<<  SI5351_OUTPUT_CLK_DIV_SHIFT);
>>       }
>>
>> -    /* powerup clkout */
>> +    /* when rate is 0 powerdown output */
>> +    if (rate == 0)
>> +        pdn = SI5351_CLK_POWERDOWN;
>> +
>> +    /* powerup/down clkout */
>>       si5351_set_bits(hwdata->drvdata, SI5351_CLK0_CTRL + hwdata->num,
>> -            SI5351_CLK_POWERDOWN, 0);
>> +            SI5351_CLK_POWERDOWN, pdn);
>>
>>       dev_dbg(&hwdata->drvdata->client->dev,
>>           "%s - %s: rdiv = %u, parent_rate = %lu, rate = %lu\n",
>
>

marek
-- 
Marek Belisko

Software Developer
StreamUnlimited Engineering GmbH
Gutheil Schodergasse 8-12
A-1100 Vienna, Austria

Office: +421 267200087

e-mail: marek.belisko at streamunlimited.com
http://www.streamunlimited.com

Meet us at:

High End - Munich, 09 - 12 May, Hall 4/F05
IFA - Berlin, 6-11 September
CEDIA - Denver, 25-28 September
