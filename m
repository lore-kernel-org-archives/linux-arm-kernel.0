From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 27 Feb 2014 09:16:39 +0100
Subject: [PATCH v2 2/4] clk: at91: propagate rate change on system clks
In-Reply-To: <20140227004229.12081.25317@quantum>
References: <1391589458-28018-1-git-send-email-jjhiblot@traphandler.com>
 <1391589458-28018-3-git-send-email-jjhiblot@traphandler.com>
 <20140227004229.12081.25317@quantum>
Message-ID: <530EF467.5000504@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 27/02/2014 01:42, Mike Turquette wrote:
> Quoting Jean-Jacques Hiblot (2014-02-05 00:37:36)
>> From: Boris BREZILLON <b.brezillon@overkiz.com>
>>
>> System clks are just gates, and thus do not provide any rate operations.
>> Authorize clk rate change to be propagated to system clk parents.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   drivers/clk/at91/clk-system.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
>> index 8f7c043..a98557b 100644
>> --- a/drivers/clk/at91/clk-system.c
>> +++ b/drivers/clk/at91/clk-system.c
>> @@ -84,7 +84,8 @@ at91_clk_register_system(struct at91_pmc *pmc, const char *name,
>>           * (see drivers/memory) which would request and enable the ddrck clock.
>>           * When this is done we will be able to remove CLK_IGNORE_UNUSED flag.
>>           */
>> -       init.flags = CLK_IGNORE_UNUSED;
>> +       init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT |
> Just wanted to do a quick sanity check here. Do you really need
> CLK_SET_RATE_GATE?

After taking a closer look, I'd say I don't need this flag, because it's
already set on programmable clks, am I right ?

Do you want me to send a new version removing this flag ?

> Otherwise these patches look fine.
>
> Regards,
> Mike
>
>> +                    CLK_IGNORE_UNUSED;
>>   
>>          sys->id = id;
>>          sys->hw.init = &init;
>> -- 
>> 1.8.5.2
>>
