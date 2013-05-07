From: marek.belisko@streamunlimited.com (Marek Belisko)
Date: Tue, 07 May 2013 12:17:32 +0200
Subject: [PATCH 1/2] clk: si5351: Fix msynth_recalc_rate return value
 when fOUT is 0.
In-Reply-To: <5188D174.90400@gmail.com>
References: <1367914491-17445-1-git-send-email-marek.belisko@streamunlimited.com>
 <5188D174.90400@gmail.com>
Message-ID: <5188D4BC.8010603@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2013 12:03 PM, Sebastian Hesselbarth wrote:
> On 05/07/2013 10:14 AM, Marek Belisko wrote:
>> When p3 is eual to 0 then result for fOUT is 0. In that case we should
>> return 0 not parent_rate;
>>
>> This issue was causing deadlock in si5351 chip when user set_rate for
>> ms0->clk0 and then set_rate for ms1->clk1 (both ms sourced from plla).
>> After that clk1 was 0 and it wasn't possible to enable it again (try also
>> manually with i2cset commands). Only power cycle helps.
>
> Marek,
>
> does the fix below also affect the behavior above, i.e. not causing
> si5351 to hang?
Yes this fix problems with si5351 hang. Didn't investigate why but I 
assume some wrong register access or something.
>
> Anyway, your fix looks very sane to me and you get my
>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
>> Signed-off-by: Marek Belisko<marek.belisko@streamunlimited.com>
>> ---
>>   drivers/clk/clk-si5351.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
>> index fc215ce..a8fc0f4 100644
>> --- a/drivers/clk/clk-si5351.c
>> +++ b/drivers/clk/clk-si5351.c
>> @@ -607,7 +607,7 @@ static unsigned long
>> si5351_msynth_recalc_rate(struct clk_hw *hw,
>>           si5351_read_parameters(hwdata->drvdata, reg,&hwdata->params);
>>
>>       if (hwdata->params.p3 == 0)
>> -        return parent_rate;
>> +        return 0;
>>
>>       /*
>>        * multisync0-5: fOUT = (128 * P3 * fIN) / (P1*P3 + P2 + 512*P3)
>
>

	~marek

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
